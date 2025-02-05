using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class CajaRepository : ProfitAdmManager
	{
		public saCaja getByID(string id)
		{
			return db.saCaja.AsNoTracking().SingleOrDefault(b => b.cod_caja.Trim() == id);
		}

		public List<saCaja> getAll()
		{
			return db.saCaja.AsNoTracking().ToList();
		}

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