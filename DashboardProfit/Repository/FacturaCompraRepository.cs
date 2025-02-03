using DashboardProfit.Data;
using DashboardProfit.Models;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class FacturaCompraRepository : ProfitAdmManager
	{
		public saFacturaCompra getByID(string doc_num)
		{
			saFacturaCompra invoice = db.saFacturaCompra.AsNoTracking().Include("saFacturaCompraReng").Include("saProveedor")
				.Include("saCondicionPago").SingleOrDefault(i => i.doc_num.Trim() == doc_num);

			invoice.saProveedor.saFacturaCompra = null;
			invoice.saCondicionPago.saFacturaCompra = null;
			invoice.saFacturaCompraReng.ForEach((r) => {
				r.saFacturaCompra = null;
				r.des_art = db.saArticulo.AsNoTracking().First(a => a.co_art == r.co_art).art_des;
			});

			return invoice;
		}

		public List<RepCompraxFecha_Result> getLastTopInvoices(DateTime from, DateTime to, int top)
		{
			List<RepCompraxFecha_Result> result = new List<RepCompraxFecha_Result>();
			var sp = db.RepCompraxFecha(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}

		public List<RepCompraxArt2_Result> getInvoicesByArt(DateTime from, DateTime to, int top)
		{
			List<RepCompraxArt2_Result> result = new List<RepCompraxArt2_Result>();
			var sp = db.RepCompraxArt2(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			ProveedorRepository supplierRep = new ProveedorRepository();
			while (sp.MoveNext())
			{
				sp.Current.prov_des = supplierRep.getByID(sp.Current.co_prov).prov_des;
				result.Add(sp.Current);
			}

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}