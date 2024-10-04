using DashboardProfit.Models;
using System;
using System.Collections.Generic;

namespace DashboardProfit.Controllers
{
	public class CajaController : ProfitAdmManager
	{
		public List<RepSaldoCaja_Result> getBalances(DateTime from, DateTime to)
		{
			List<RepSaldoCaja_Result> result = new List<RepSaldoCaja_Result>();
			var sp = db.RepSaldoCaja(null, null, null, null, null, null, from, to, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			return result;
		}
	}
}