using DashboardProfit.Controllers;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DashboardProfit
{
	public partial class SeleccionSucursal : System.Web.UI.Page
	{
		public List<saSucursal> sucs;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				if (Request.QueryString["conn"] != null)
				{
					int connect = int.Parse(Request.QueryString["conn"].ToString());
					Empresa conn = Connection.GetConnByID(connect);

					if (conn != null)
					{
						string connectionString = string.Format("Server={0};Database={1};User Id={2};Password={3}",
						conn.server, conn.database, conn.username, conn.password);
						SqlConnection connection = new SqlConnection(connectionString);

						Session["CONNECT"] = connectionString;
						Session["DB"] = connection.Database;
						Session["NAME_CONN"] = conn.des_con;
						Session["ID_CONN"] = conn.ID;

						bool useBranchs = new SucursalController().useBranchs();
						if (!useBranchs)
							Response.Redirect("/Dashboard.aspx");

						sucs = new SucursalController().getAllBranchs();
					}
					else
						Response.Redirect("/Login.aspx?logout=1");
				}
				else
					Response.Redirect("/Login.aspx?logout=1");
			}
			else
				Response.Redirect("/Login.aspx");
		}

		protected void BTN_Send_Click(object sender, EventArgs e)
		{
			Session["BRANCH"] = new SucursalController().getBranchByID(HDD_Connect.Value);
			Response.Redirect("/Dashboard.aspx");
		}
	}
}