using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;

namespace DashboardProfit.Controllers
{
	public class CuentaBancariaRepository : ProfitAdmManager
	{
		public List<RepSaldoCuentaBancariaMultimoneda_Result> getBalances(DateTime from, DateTime to)
		{
			List<RepSaldoCuentaBancariaMultimoneda_Result> result = new List<RepSaldoCuentaBancariaMultimoneda_Result>();
			var sp = db.RepSaldoCuentaBancariaMultimoneda(null, null, null, null, null, null, from, to, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			return result;
		}
	}
}