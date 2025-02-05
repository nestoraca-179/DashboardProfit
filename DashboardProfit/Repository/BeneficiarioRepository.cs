using DashboardProfit.Data;
using DashboardProfit.Models;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class BeneficiarioRepository : ProfitAdmManager
	{
		public saBeneficiario getByID(string id)
		{
			return db.saBeneficiario.AsNoTracking().SingleOrDefault(b => b.cod_ben.Trim() == id);
		}

		public List<saBeneficiario> getAll()
		{
			return db.saBeneficiario.AsNoTracking().ToList();
		}
	}
}