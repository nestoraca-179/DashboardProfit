using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class OrdenPagoRepository : ProfitAdmManager
	{
		public saOrdenPago getByID(string doc_num)
		{
			saOrdenPago order = db.saOrdenPago.AsNoTracking().Include("saOrdenPagoReng").Include("saBeneficiario").SingleOrDefault(o => o.ord_num.Trim() == doc_num);
			order.saBeneficiario.saOrdenPago = null;
			order.saOrdenPagoReng.ToList().ForEach((r) => { 
				r.saOrdenPago = null;
				r.saCuentaIngEgr = db.saCuentaIngEgr.AsNoTracking().Single(c => c.co_cta_ingr_egr == r.co_cta_ingr_egr);
			});

			return order;
		}

		public List<RepOrdenPagoxNumero_Result> getLastTopOrders(DateTime from, DateTime to, int top)
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
	}
}