using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class ProveedorRepository : ProfitAdmManager
	{
		public saProveedor getByID(string id)
		{
			return db.saProveedor.AsNoTracking().SingleOrDefault(s => s.co_prov.Trim() == id);
		}

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