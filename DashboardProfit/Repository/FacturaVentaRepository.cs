using DashboardProfit.Data;
using DashboardProfit.Models;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class FacturaVentaRepository : ProfitAdmManager
	{
		public saFacturaVenta getByID(string doc_num)
		{
			saFacturaVenta invoice = db.saFacturaVenta.AsNoTracking().Include("saFacturaVentaReng").Include("saCliente").Include("saCondicionPago")
				.Include("saVendedor").SingleOrDefault(i => i.doc_num.Trim() == doc_num);

			invoice.saCliente.saFacturaVenta = null;
			invoice.saCondicionPago.saFacturaVenta = null;
			invoice.saVendedor.saFacturaVenta = null;
			invoice.saFacturaVentaReng.ForEach((r) => {
				r.saFacturaVenta = null;
				r.des_art = db.saArticulo.AsNoTracking().First(a => a.co_art == r.co_art).art_des;
			});

			return invoice;
		}

		public List<RepFacturaVentaxFecha_Result> getLastTopInvoices(DateTime from, DateTime to, int top)
		{
			List<RepFacturaVentaxFecha_Result> result = new List<RepFacturaVentaxFecha_Result>();
			var sp = db.RepFacturaVentaxFecha(null, null, from, to, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}