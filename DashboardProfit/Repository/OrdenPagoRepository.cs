using DashboardProfit.Controllers;
using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class OrdenPagoRepository : ProfitAdmManager
	{
		public saOrdenPago GetByID(string doc_num)
		{
			saOrdenPago order = db.saOrdenPago.AsNoTracking().Include("saOrdenPagoReng").Include("saBeneficiario").SingleOrDefault(o => o.ord_num.Trim() == doc_num);
			order.saBeneficiario.saOrdenPago = null;
			order.saOrdenPagoReng.ToList().ForEach((r) => { 
				r.saOrdenPago = null;
				r.saCuentaIngEgr = db.saCuentaIngEgr.AsNoTracking().Single(c => c.co_cta_ingr_egr == r.co_cta_ingr_egr);
			});

			return order;
		}

        public List<saOrdenPago> GetAllOrderPayCurrencies(DateTime from, DateTime to)
		{
            List<saOrdenPago> orders = db.saOrdenPago.AsNoTracking().Include("saOrdenPagoReng").Where(o => o.campo1.Trim() == "COMPRA DIVISAS" && 
                o.fecha >= from && o.fecha <= to).ToList();
			
            foreach (saOrdenPago order in orders)
                order.saOrdenPagoReng.ToList().ForEach((r) => { r.saOrdenPago = null; });

            return orders;
		}

		public List<RepOrdenPagoxNumero_Result> GetLastTopOrders(DateTime from, DateTime to, int top)
		{
			List<RepOrdenPagoxNumero_Result> result = new List<RepOrdenPagoxNumero_Result>();
			var sp = db.RepOrdenPagoxNumero(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fecha).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fecha).ToList();
		}

        public saOrdenPago Add(saOrdenPago order, string user, string sucur, int conn)
        {
            saOrdenPago new_order = new saOrdenPago();

            using (ProfitAdmEntities context = new ProfitAdmEntities(entity.ToString()))
            {
                using (DbContextTransaction tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        // RENGLON DE LA OP
                        saOrdenPagoReng reng = order.saOrdenPagoReng.ToList()[0];
                        reng.tipo_imp = "7";

                        // DATOS
                        string code = "";
                        string co_mone = "";
                        decimal amount_usd = reng.monto_d;
                        decimal amount_bsd = amount_usd * order.tasa;
                        bool isBox = order.cod_caja != null;

                        // CORRELATIVOS
                        string n_ord = "";
                        string n_movc_o = null;
                        string n_movb_o = null;
                        string n_movc_d = null;
                        string n_movb_d = null;
                        string forma_pag = isBox ? "EF" : "TR";

                        string sucur_aux = "";
                        var sp_usa_cons = context.pSeleccionarUsoSucursalConsecutivoTipo("ORDP_NUM").GetEnumerator();
                        if (sp_usa_cons.MoveNext())
						{
                            if (sp_usa_cons.Current.UsoSucursal)
                                sucur_aux = sucur;
						}
                        sp_usa_cons.Dispose();

                        var sp_n_ord = context.pConsecutivoProximo(sucur_aux, "ORDP_NUM").GetEnumerator();
                        if (sp_n_ord.MoveNext())
                            n_ord = sp_n_ord.Current;
                        sp_n_ord.Dispose();

                        // ORIGEN (-)
                        if (isBox)
						{
                            code = order.cod_caja;
                            co_mone = context.saCaja.AsNoTracking().Single(c => c.cod_caja == code).co_mone;
                            if (!co_mone.StartsWith("BS"))
                                throw new Exception("La caja de origen debe ser en BSD");

                            // AGREGAR MOVIMIENTO DE CAJA
                            saMovimientoCaja move_c = new saMovimientoCaja()
                            {
                                cod_caja = code,
                                descrip = string.Format("COMPRA DIVISAS (-) ({0})", n_ord.Trim()),
                                tasa = order.tasa,
                                tipo_mov = "E",
                                forma_pag = "EF",
                                co_cta_ingr_egr = reng.co_cta_ingr_egr,
                                monto_d = amount_bsd,
                                origen = "OPA"
                            };

                            var sp_n_movc_o = context.pConsecutivoProximo(sucur, "MOVC_NUM").GetEnumerator();
                            if (sp_n_movc_o.MoveNext())
                                n_movc_o = sp_n_movc_o.Current;
                            sp_n_movc_o.Dispose();

                            // ACTUALIZANDO SALDOS
                            context.pActualizarSaldoCaja(code, code, "EF", "EF", move_c.monto_d * -1, Guid.NewGuid());
                            context.pActualizarSaldoCaja(code, code, "TF", "TF", move_c.monto_d * -1, Guid.NewGuid());

                            // MOVIMIENTO DE CAJA
                            var sp_move_c = context.pInsertarMovimientoCaja(n_movc_o, DateTime.Now, move_c.descrip, code, move_c.tasa, move_c.tipo_mov, move_c.forma_pag, null, 
                                null, null, null, move_c.co_cta_ingr_egr, move_c.monto_d, false, move_c.origen, n_ord, null, false, false, false, false, null, DateTime.Now, 
                                null, null, null, null, null, null, null, null, null, null, null, null, null, user, sucur, "DASHBOARD PROFIT", null, null);
                            sp_move_c.Dispose();
                        }
						else
						{
                            code = order.cod_cta;
                            co_mone = context.saCuentaBancaria.AsNoTracking().Single(c => c.cod_cta == code).co_mone;
                            if (!co_mone.StartsWith("BS"))
                                throw new Exception("La cuenta bancaria de origen debe ser en BSD");

                            // AGREGAR MOVIMIENTO DE BANCO
                            saMovimientoBanco move_b = new saMovimientoBanco()
                            {
                                cod_cta = code,
                                descrip = string.Format("COMPRA DIVISAS (-) ({0})", n_ord.Trim()),
                                tasa = order.tasa,
                                tipo_op = "TR",
                                doc_num = order.doc_num, // CAMBIAR
                                co_cta_ingr_egr = reng.co_cta_ingr_egr,
                                monto_d = amount_bsd,
                                origen = "OPA",
                                fecha_che = DateTime.Now // CAMBIAR
                            };

                            var sp_n_movb_o = context.pConsecutivoProximo(sucur, "MOVB_NUM").GetEnumerator();
                            if (sp_n_movb_o.MoveNext())
                                n_movb_o = sp_n_movb_o.Current;
                            sp_n_movb_o.Dispose();

                            // ACTUALIZANDO SALDO
                            context.pActualizarSaldoBanco(code, code, "TF", "TF", move_b.monto_d * -1, Guid.NewGuid());

                            // MOVIMIENTO DE BANCO
                            var sp_move_b = context.pInsertarMovimientoBanco(n_movb_o, move_b.descrip, move_b.cod_cta, DateTime.Now, move_b.tasa, 
                                move_b.tipo_op, move_b.doc_num, move_b.monto_d, move_b.co_cta_ingr_egr, move_b.origen, n_ord, 0, null, false, false, false, false, 0, 
                                null, null, move_b.fecha_che, null, null, null, null, null, null, null, null, null, null, user, sucur, "DASHBOARD PROFIT", null, null);
                            sp_move_b.Dispose();
                        }

                        // DESTINO (+)
                        if (Convert.ToBoolean(order.campo7))
                        {
                            code = order.campo8;
                            co_mone = context.saCaja.AsNoTracking().Single(c => c.cod_caja == code).co_mone;
                            if (!co_mone.StartsWith("US"))
                                throw new Exception("La caja de destino debe ser en USD");

                            // AGREGAR MOVIMIENTO DE CAJA
                            saMovimientoCaja move_c = new saMovimientoCaja()
                            {
                                cod_caja = code,
                                descrip = string.Format("COMPRA DIVISAS (+) ({0})", n_ord.Trim()),
                                tasa = order.tasa,
                                tipo_mov = "I",
                                forma_pag = "EF",
                                co_cta_ingr_egr = reng.co_cta_ingr_egr,
                                monto_h = amount_usd,
                                origen = "OPA"
                            };

                            var sp_n_movc_d = context.pConsecutivoProximo(sucur, "MOVC_NUM").GetEnumerator();
                            if (sp_n_movc_d.MoveNext())
                                n_movc_d = sp_n_movc_d.Current;
                            sp_n_movc_d.Dispose();

                            // ACTUALIZANDO SALDOS
                            context.pActualizarSaldoCaja(code, code, "EF", "EF", move_c.monto_h, Guid.NewGuid());
                            context.pActualizarSaldoCaja(code, code, "TF", "TF", move_c.monto_h, Guid.NewGuid());

                            // MOVIMIENTO DE CAJA
                            var sp_move_c = context.pInsertarMovimientoCaja(n_movc_d, DateTime.Now, move_c.descrip, code, move_c.tasa, move_c.tipo_mov, move_c.forma_pag, null,
                                null, null, null, move_c.co_cta_ingr_egr, move_c.monto_h, false, move_c.origen, n_ord, null, false, false, false, false, null, DateTime.Now,
                                null, null, null, null, null, null, null, null, null, null, null, null, null, user, sucur, "DASHBOARD PROFIT", null, null);
                            sp_move_c.Dispose();
                        }
                        else
                        {
                            code = order.campo8;
                            co_mone = context.saCuentaBancaria.AsNoTracking().Single(c => c.cod_cta == code).co_mone;
                            if (!co_mone.StartsWith("US"))
                                throw new Exception("La cuenta bancaria de destino debe ser en USD");

                            // AGREGAR MOVIMIENTO DE BANCO
                            saMovimientoBanco move_b = new saMovimientoBanco()
                            {
                                cod_cta = code,
                                descrip = string.Format("COMPRA DIVISAS (+) ({0})", n_ord.Trim()),
                                tasa = order.tasa,
                                tipo_op = "TP",
                                doc_num = "000", // CAMBIAR
                                co_cta_ingr_egr = reng.co_cta_ingr_egr,
                                monto_h = amount_usd,
                                origen = "OPA",
                                fecha_che = DateTime.Now // CAMBIAR
                            };

                            var sp_n_movb_d = context.pConsecutivoProximo(sucur, "MOVB_NUM").GetEnumerator();
                            if (sp_n_movb_d.MoveNext())
                                n_movb_d = sp_n_movb_d.Current;
                            sp_n_movb_d.Dispose();

                            // ACTUALIZANDO SALDO
                            context.pActualizarSaldoBanco(code, code, "TF", "TF", move_b.monto_h, Guid.NewGuid());

                            // MOVIMIENTO DE BANCO
                            var sp_move_b = context.pInsertarMovimientoBanco(n_movb_d, move_b.descrip, move_b.cod_cta, DateTime.Now, move_b.tasa, 
                                move_b.tipo_op, move_b.doc_num, move_b.monto_h, move_b.co_cta_ingr_egr, move_b.origen, n_ord, 0, null, false, false, false, false, 0, 
                                null, null, move_b.fecha_che, null, null, null, null, null, null, null, null, null, null, user, sucur, "DASHBOARD PROFIT", null, null);
                            sp_move_b.Dispose();
                        }

                        // ORDEN PAGO
                        var sp = context.pInsertarOrdenPago(n_ord, "C", DateTime.Now, order.cod_ben, order.descrip, forma_pag, DateTime.Now, order.cod_cta, order.doc_num,
                            order.cod_caja, n_movc_o, n_movb_o, null, order.tasa, co_mone, false, false, 0, null, null, "COMPRA DIVISAS", n_movc_d, n_movb_d, null, 
                            null, null, null, null, user, sucur, "DASHBOARD PROFIT", null, null);
                        sp.Dispose();

                        // RENGLON
                        var sp_r = context.pInsertarRenglonesOrdenPago(1, n_ord, reng.co_cta_ingr_egr, null, amount_bsd, 0, 0, 0, 0, 0, reng.tipo_imp, null, null, sucur,
                            user, null, null, "DASHBOARD PROFIT");
                        sp_r.Dispose();

                        tran.Commit();
                        new_order = GetByID(n_ord);
                        // new_order.campo1 = move.BoxID.ToString();
                        // new_order.campo2 = move.ID.ToString();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        IncidentController.CreateIncident("ERROR INTERNO AGREGANDO ORDEN DE PAGO", ex);

                        throw ex;
                    }
                }
            }

            return new_order;
        }
    }
}