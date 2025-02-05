using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DashboardProfit.Repository
{
	public class CuentaIngrEgrRepository : ProfitAdmManager
	{
		public saCuentaIngEgr getByID(string id)
		{
			return db.saCuentaIngEgr.AsNoTracking().SingleOrDefault(a => a.co_cta_ingr_egr.Trim() == id);
		}

		public List<saCuentaIngEgr> getAll()
		{
			return db.saCuentaIngEgr.AsNoTracking().ToList();
		}
	}
}