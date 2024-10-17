using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class ProveedorRepository : ProfitAdmManager
	{
		public List<RepProveedorMasCompra_Result> getMostActiveSuppliers(DateTime from, DateTime to, int limit)
		{
			List<RepProveedorMasCompra_Result> result = new List<RepProveedorMasCompra_Result>();
			var sp = db.RepProveedorMasCompra(from, to, null, null, limit, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			return result.OrderByDescending(a => a.Compra).ToList();
		}
	}
}