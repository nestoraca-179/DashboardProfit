using System.Collections.Generic;
using System.Linq;
using DashboardProfit.Data;

namespace DashboardProfit.Models
{
	public class Connection
	{
		private static readonly DashboardProfitEntities db = new DashboardProfitEntities();

		public static Empresa GetConnByID(int id)
		{
			return db.Empresa.AsNoTracking().SingleOrDefault(c => c.ID == id);
		}

		public static List<Empresa> GetAllConns()
		{
			return db.Empresa.AsNoTracking().ToList(); ;
		}
	}
}