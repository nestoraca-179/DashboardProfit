using System;

namespace DashboardProfit
{
	public partial class Dashboard : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				if (Session["CONNECT"] == null)
					Response.Redirect("/Login.aspx?logout=1");
			}
			else
				Response.Redirect("/Login.aspx");
		}
	}
}