using System;
using System.Web.UI;

namespace DashboardProfit
{
	public partial class _Default : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Response.Redirect("/Login.aspx");
		}
	}
}