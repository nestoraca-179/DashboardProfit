using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class ClienteController : ProfitAdmManager
	{
		public List<RepClienteMasVenta_Result> getMostActiveClients(DateTime from, DateTime to, int limit)
		{
			List<RepClienteMasVenta_Result> result = new List<RepClienteMasVenta_Result>();
			var sp = db.RepClienteMasVenta(from, to, null, null, null, null, null, null, null, limit, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			return result.OrderByDescending(a => a.Venta).ToList();
		}
	}
}