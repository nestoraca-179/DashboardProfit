using DashboardProfit.Data;
using System;

namespace DashboardProfit.Controllers
{
	public class LogController
	{
		public static void CreateLog(string user, string item, string id_item, string action, string campos)
		{
			using (DashboardProfitEntities context = new DashboardProfitEntities())
			{
				Log log = new Log();

				log.fecha = DateTime.Now;
				log.usuario = user;
				log.item = item;
				log.id_item = id_item;
				log.accion = action;
				log.campos = campos;

				context.Log.Add(log);
				context.SaveChanges();
			}
		}
	}
}