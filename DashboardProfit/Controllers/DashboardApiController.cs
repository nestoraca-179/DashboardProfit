using DashboardProfit.Data;
using DashboardProfit.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace DashboardProfit.Controllers
{
	public class DashboardApiController : ApiController
	{
		// VENTAS

		[HttpGet]
		[Route("api/GetStatsSales/{from}/{to}")]
		public object GetStatsSales(DateTime from, DateTime to)
		{
			int total_i = 0, total_o = 0, total_c = 0, total_r = 0;
			decimal amount_i = 0, amount_o = 0, amount_c = 0, amount_r = 0;

			List<RepFacturaVentaxFecha_Result> data_i = new FacturaVentaRepository().getLastTopInvoices(from, to, 0);
			foreach (RepFacturaVentaxFecha_Result item in data_i)
			{
				total_i++;
				if (!item.anulado)
					amount_i += item.total_neto.Value;
			}

			List<RepPedidoVentaxNum_Result> orders = new PedidoVentaRepository().getLastTopOrders(from, to, 0);
			List<RepCobrosxFecha_Result> collects = new CobroRepository().getLastTopCollects(from, to, 0);
			List<RepDevolucionClientexNum_Result> refunds = new DevolucionVentaRepository().getRefunds(from, to, 0);

			total_o = orders.Count;
			amount_o = orders.Select(o => o.total_neto.Value).Sum();
			total_c = collects.Count;
			amount_c = collects.Select(c => c.mont_doc).Sum();
			total_r = refunds.Count;
			amount_r = refunds.Select(c => c.total_neto.Value).Sum();

			return new { total_i, amount_i, total_o, amount_o, total_c, amount_c, total_r, amount_r };
		}

		[HttpGet]
		[Route("api/GetInfoDocSale/{type}/{doc}")]
		public object GetInfoDoc(string type, string doc)
		{
			switch (type)
			{
				case "FACT":
					return new FacturaVentaRepository().getByID(doc);
				case "PEDV":
					return new PedidoVentaRepository().getByID(doc);
				default:
					return null;
			}
		}

		[HttpGet]
		[Route("api/GetSaleInvoices/{from}/{to}/{top}")]
		public List<RepFacturaVentaxFecha_Result> GetSaleInvoices(DateTime from, DateTime to, int top)
		{
			return new FacturaVentaRepository().getLastTopInvoices(from, to, top);
		}

		[HttpGet]
		[Route("api/GetSaleOrders/{from}/{to}/{top}")]
		public List<RepPedidoVentaxNum_Result> GetOrders(DateTime from, DateTime to, int top)
		{
			return new PedidoVentaRepository().getLastTopOrders(from, to, top);
		}

		[HttpGet]
		[Route("api/GetMostSelledArts/{from}/{to}/{limit}")]
		public List<RepArticulosMasVentas_Result> GetMostSelledArts(DateTime from, DateTime to, int limit)
		{
			return new ArticuloRepository().getMostSelledArts(from, to, limit);
		}

		[HttpGet]
		[Route("api/GetMostActiveClients/{from}/{to}/{limit}")]
		public List<RepClienteMasVenta_Result> GetMostActiveClients(DateTime from, DateTime to, int limit)
		{
			return new ClienteRepository().getMostActiveClients(from, to, limit);
		}

		// COMPRAS

		[HttpGet]
		[Route("api/GetStatsPurchases/{from}/{to}")]
		public object GetStatsPurchases(DateTime from, DateTime to)
		{
			int total_i = 0, total_o = 0, total_c = 0, total_r = 0;
			decimal amount_i = 0, amount_o = 0, amount_c = 0, amount_r = 0;

			List<RepCompraxFecha_Result> data = new FacturaCompraRepository().getLastTopInvoices(from, to, 0);
			foreach (RepCompraxFecha_Result item in data)
			{
				total_i++;
				if (!item.anulado)
					amount_i += item.total_neto.Value;
			}

			List<RepOrdenCompraxNum_Result> orders = new OrdenCompraRepository().getLastTopOrders(from, to, 0);
			List<RepPagosxProveedor_Result> collects = new PagoRepository().getLastTopPayments(from, to, 0);
			List<RepDevolucionProveedorxNum_Result> refunds = new DevolucionCompraRepository().getRefunds(from, to, 0);

			total_o = orders.Count;
			amount_o = orders.Select(o => o.total_neto.Value).Sum();
			total_c = collects.Count;
			amount_c = collects.Where(c => !string.IsNullOrEmpty(c.forma_pag)).Select(c => c.abono.Value).Sum();
			total_r = refunds.Count;
			amount_r = refunds.Select(c => c.total_neto.Value).Sum();

			return new { total_i, amount_i, total_o, amount_o, total_c, amount_c, total_r, amount_r };
		}

		[HttpGet]
		[Route("api/GetPurchaseInvoices/{from}/{to}/{top}")]
		public List<RepCompraxFecha_Result> GetPurchaseInvoices(DateTime from, DateTime to, int top)
		{
			return new FacturaCompraRepository().getLastTopInvoices(from, to, top);
		}

		[HttpGet]
		[Route("api/GetPurchaseOrders/{from}/{to}/{top}")]
		public List<RepOrdenCompraxNum_Result> GetPurchaseOrders(DateTime from, DateTime to, int top)
		{
			return new OrdenCompraRepository().getLastTopOrders(from, to, top);
		}

		[HttpGet]
		[Route("api/GetMostPurchasedArts/{from}/{to}/{limit}")]
		public List<RepArticulosMasCompras_Result> GetMostPurchasedArts(DateTime from, DateTime to, int limit)
		{
			return new ArticuloRepository().getMostPurchasedArts(from, to, limit);
		}

		[HttpGet]
		[Route("api/GetMostActiveSuppliers/{from}/{to}/{limit}")]
		public List<RepProveedorMasCompra_Result> GetMostActiveSuppliers(DateTime from, DateTime to, int limit)
		{
			return new ProveedorRepository().getMostActiveSuppliers(from, to, limit);
		}

		// CAJA Y BANCO
		[HttpGet]
		[Route("api/GetStatsBalances/{from}/{to}")]
		public object GetStatsBalances(DateTime from, DateTime to)
		{
			decimal total_b_bsd = 0, total_b_usd = 0, total_a_bsd = 0, total_a_usd = 0;
			decimal total_cxc = 0, total_cxp = 0;

			List<RepSaldoCaja_Result> boxes = new CajaRepository().getBalances(from, to);
			List<RepSaldoCuentaBancariaMultimoneda_Result> accounts = new CuentaBancariaRepository().getBalances(from, to);
			List<RepDocumentoCXCxNumero_Result> cxcs = new DocumentoVentaRepository().getDocsCxC(from, to, 0);
			List<RepDocumentoCXPxNumero_Result> cxps = new DocumentoCompraRepository().getDocsCxP(from, to, 0);

			total_b_bsd = boxes.Where(b => !b.inactivo && b.co_mone.StartsWith("BS")).Select(b => (b.monto_h.Value - b.monto_d.Value)).Sum();
			total_b_usd = boxes.Where(b => !b.inactivo && b.co_mone.StartsWith("US")).Select(b => Math.Round((b.monto_h.Value - b.monto_d.Value) / b.tasa_fec)).Sum();
			total_a_bsd = accounts.Where(a => !a.inactivo && a.co_mone.StartsWith("BS")).Select(a => (a.monto_h - a.monto_d)).Sum();
			total_a_usd = accounts.Where(a => !a.inactivo && a.co_mone.StartsWith("US")).Select(a => (a.monto_h - a.monto_d)).Sum();
			total_cxc = cxcs.Where(c => !c.anulado).Select(c => c.tipo_mov == "CR" ? c.saldo.Value * -1 : c.saldo.Value).Sum();
			total_cxp = cxps.Where(c => !c.anulado).Select(c => c.tipo_mov == "CR" ? c.saldo.Value * -1 : c.saldo.Value).Sum();

			return new { total_b_bsd, total_b_usd, total_a_bsd, total_a_usd, total_cxc, total_cxp };
		}
	}
}