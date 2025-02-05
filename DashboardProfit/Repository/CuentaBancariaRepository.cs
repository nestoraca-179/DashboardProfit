using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class CuentaBancariaRepository : ProfitAdmManager
	{
		public saCuentaBancaria getByID(string id)
		{
			return db.saCuentaBancaria.AsNoTracking().SingleOrDefault(a => a.cod_cta.Trim() == id);
		}

		public List<saCuentaBancaria> getAll()
		{
			return db.saCuentaBancaria.AsNoTracking().ToList();
		}

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