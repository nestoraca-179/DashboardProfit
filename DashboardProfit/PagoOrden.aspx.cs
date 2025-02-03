using DashboardProfit.Repository;
using Newtonsoft.Json;
using System;

namespace DashboardProfit
{
	public partial class PagoOrden : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				if (Session["CONNECT"] != null)
				{
					var orders = new OrdenPagoRepository().getLastTopOrders(DateTime.Now.AddDays(-30), DateTime.Now, 0);
					string json_orders = JsonConvert.SerializeObject(orders);
					hiddenFieldJsonOrd.Value = json_orders;
				}
				else
					Response.Redirect("/Login.aspx?logout=1");
			}
			else
				Response.Redirect("/Login.aspx");
		}
	}
}