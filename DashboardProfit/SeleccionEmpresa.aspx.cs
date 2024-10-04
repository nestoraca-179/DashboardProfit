using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DashboardProfit
{
	public partial class SeleccionEmpresa : System.Web.UI.Page
	{
		public List<Empresa> emps;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				emps = Connection.GetAllConns();
			}
			else
				Response.Redirect("/Login.aspx");
		}

		protected void BTN_Send_Click(object sender, EventArgs e)
		{
			string emp = HDD_Connect.Value;
			Response.Redirect("/SeleccionSucursal.aspx?conn=" + emp);
		}
	}
}