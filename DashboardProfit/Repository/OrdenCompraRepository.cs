using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class OrdenCompraRepository : ProfitAdmManager
	{
		public List<RepOrdenCompraxNum_Result> getLastTopOrders(DateTime from, DateTime to, int top)
		{
			List<RepOrdenCompraxNum_Result> result = new List<RepOrdenCompraxNum_Result>();
			var sp = db.RepOrdenCompraxNum(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}