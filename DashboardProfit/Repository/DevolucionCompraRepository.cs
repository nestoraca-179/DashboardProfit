using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class DevolucionCompraRepository : ProfitAdmManager
	{
		public List<RepDevolucionProveedorxNum_Result> getRefunds(DateTime from, DateTime to, int top)
		{
			List<RepDevolucionProveedorxNum_Result> result = new List<RepDevolucionProveedorxNum_Result>();
			var sp = db.RepDevolucionProveedorxNum(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}