using DashboardProfit.Controllers;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DashboardProfit
{
	public partial class CambiarClave : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Usuario user = Session["USER"] as Usuario;
			TB_Username.Text = user.username;
		}

		protected void BTN_CambiarClave_Click(object sender, EventArgs e)
		{
			string username = TB_Username.Text;
			string old_pass = TB_OldPassword.Text;
			string new_pass = TB_NewPassword.Text;

			string message = AccountController.ChangePass(username, old_pass, new_pass);

			if (message == "OK")
			{
				Response.Redirect("/SeleccionEmpresa.aspx");
			}
			else
			{
				LBL_Error.Visible = true;
				LBL_Error.Text = message;
			}
		}
	}
}