using DashboardProfit.Data;
using DashboardProfit.Controllers;
using System.Data.Entity.Core.EntityClient;
using System.Web;
using System;

namespace DashboardProfit.Models
{
	public class ProfitAdmManager
	{
		// CADENA DE CONEXION
		private static string connect;

		// ENTIDAD PARA EF
		public static EntityConnectionStringBuilder entity;

		// CONTEXTO EF
		public static ProfitAdmEntities db;

		public ProfitAdmManager()
		{
			if (HttpContext.Current.Session["CONNECT"] == null)
				throw new InvalidOperationException("SESSION EXPIRED");

			connect = HttpContext.Current.Session["CONNECT"].ToString();
			entity = EntityController.GetEntity(connect);
			db = new ProfitAdmEntities(entity.ToString());
		}
	}
}