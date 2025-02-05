using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class PagoRepository : ProfitAdmManager
	{
		public List<RepPagosxProveedor_Result> getLastTopPayments(DateTime from, DateTime to, int top)
		{
			List<RepPagosxProveedor_Result> result = new List<RepPagosxProveedor_Result>();
			var sp = db.RepPagosxProveedor(null, null, from, to, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fecha).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fecha).ToList();
		}
	}
}