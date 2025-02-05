using DashboardProfit.Repository;
using Newtonsoft.Json;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace DashboardProfit
{
	public partial class PagoFactura : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				if (Session["CONNECT"] != null) 
				{
					var invoices = new FacturaCompraRepository().getInvoicesByArt(DateTime.Now.AddDays(-30), DateTime.Now, 0);
					var sorted = invoices.GroupBy(i => i.art_des).Select(g => new { name = g.Key.Trim(), count = g.Count() }).OrderByDescending(g => g.count).ToList();
					string json_invoices = JsonConvert.SerializeObject(invoices);
					string json_sorted = JsonConvert.SerializeObject(sorted);
					hiddenFieldJsonInv.Value = json_invoices;
					hiddenFieldJsonSorted.Value = json_sorted;
				}
				else
					Response.Redirect("/Login.aspx?logout=1");
			}
			else
				Response.Redirect("/Login.aspx");
		}
	}
}