using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class DevolucionVentaRepository : ProfitAdmManager
	{
		public List<RepDevolucionClientexNum_Result> getRefunds(DateTime from, DateTime to, int top)
		{
			List<RepDevolucionClientexNum_Result> result = new List<RepDevolucionClientexNum_Result>();
			var sp = db.RepDevolucionClientexNum(null, null, from, to, null, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}