using DashboardProfit.Data;
using DashboardProfit.Models;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class SucursalRepository : ProfitAdmManager
	{
		public saSucursal getBranchByID(string id)
		{
			return db.saSucursal.AsNoTracking().Single(c => c.co_sucur == id);
		}

		public List<saSucursal> getAllBranchs()
		{
			return db.saSucursal.AsNoTracking().ToList();
		}

		public bool useBranchs()
		{
			return db.par_emp.AsNoTracking().First().v_maneja_sucursales;
		}
	}
}