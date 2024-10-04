using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DashboardProfit.Controllers
{
	public class SucursalController : ProfitAdmManager
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