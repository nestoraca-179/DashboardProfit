using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class CobroRepository : ProfitAdmManager
	{
		public List<RepCobrosxFecha_Result> getLastTopCollects(DateTime from, DateTime to, int top)
		{
			List<RepCobrosxFecha_Result> result = new List<RepCobrosxFecha_Result>();
			var sp = db.RepCobrosxFecha(null, null, from, to, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fecha).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fecha).ToList();
		}
	}
}