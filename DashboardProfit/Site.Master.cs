using DashboardProfit.Models;
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
			}
		}
	}
}