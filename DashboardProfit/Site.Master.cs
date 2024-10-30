using DashboardProfit.Data;
using System;
using System.Web.UI;

namespace DashboardProfit
{
	public partial class SiteMaster : MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				Usuario user = Session["USER"] as Usuario;
				LBL_User.Text = user.des_usuario;
				LBL_Emp.Text = "Empresa: " + Session["NAME_CONN"].ToString();
				
				if (Session["BRANCH"] != null)
					LBL_Suc.Text = "Sucursal: " + (Session["BRANCH"] as saSucursal).sucur_des;
			}
		}
	}
}