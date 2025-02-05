using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class ArticuloRepository : ProfitAdmManager
	{
		public List<RepArticulosMasVentas_Result> getMostSelledArts(DateTime from, DateTime to, int limit)
		{
			List<RepArticulosMasVentas_Result> result = new List<RepArticulosMasVentas_Result>();
			var sp = db.RepArticulosMasVentas(from, to, null, null, null, null, null, null, null, null, null, null, null, null,
				limit, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			return result.OrderByDescending(a => a.monto_unidad).ToList();
		}

		public List<RepArticulosMasCompras_Result> getMostPurchasedArts(DateTime from, DateTime to, int limit)
		{
			List<RepArticulosMasCompras_Result> result = new List<RepArticulosMasCompras_Result>();
			var sp = db.RepArticulosMasCompras(from, to, null, null, null, null, null, null, null, null, null, null, null, null,
				limit, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			return result.OrderByDescending(a => a.monto_unidad).ToList();
		}
	}
}