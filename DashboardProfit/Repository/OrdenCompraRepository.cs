using DashboardProfit.Data;
using DashboardProfit.Models;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class OrdenCompraRepository : ProfitAdmManager
	{
		public saOrdenCompra getByID(string doc_num)
		{
			saOrdenCompra order = db.saOrdenCompra.AsNoTracking().Include("saOrdenCompraReng").Include("saProveedor")
				.Include("saCondicionPago").SingleOrDefault(i => i.doc_num.Trim() == doc_num);

			order.saProveedor.saOrdenCompra = null;
			order.saCondicionPago.saOrdenCompra = null;
			order.saOrdenCompraReng.ForEach((r) => {
				r.saOrdenCompra = null;
				r.des_art = db.saArticulo.AsNoTracking().First(a => a.co_art == r.co_art).art_des;
			});

			return order;
		}

		public List<RepOrdenCompraxNum_Result> getLastTopOrders(DateTime from, DateTime to, int top)
		{
			List<RepOrdenCompraxNum_Result> result = new List<RepOrdenCompraxNum_Result>();
			var sp = db.RepOrdenCompraxNum(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
			{
				RepOrdenCompraxNum_Result item = sp.Current;
				if (!item.anulado && item.status == "2")
					result.Add(item);
			}

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}

		public List<RepOrdenCompraxReng_Result> getLastTopOrdersLine(DateTime from, DateTime to, int top)
		{
			List<RepOrdenCompraxReng_Result> result = new List<RepOrdenCompraxReng_Result>();
			var sp = db.RepOrdenCompraxReng(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
			{
				RepOrdenCompraxReng_Result item = sp.Current;
				if (!item.anulado && item.status == "2")
				{
					item.campo1 = db.saLineaArticulo.AsNoTracking().Single(l => l.co_lin == item.co_lin).lin_des;
					result.Add(item);
				}
			}

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}