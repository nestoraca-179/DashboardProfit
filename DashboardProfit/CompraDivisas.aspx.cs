using DashboardProfit.Data;
using DashboardProfit.Repository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace DashboardProfit
{
	public partial class CompraDivisas : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["USER"] != null)
			{
				if (Session["CONNECT"] != null)
				{
					List<saBeneficiario> benefs = new BeneficiarioRepository().getAll();
					List<saCaja> boxes = new CajaRepository().getAll();
					List<saCuentaBancaria> bankAccounts = new CuentaBancariaRepository().getAll();
					List<saCuentaIngEgr> accounts = new CuentaIngrEgrRepository().getAll();

					hiddenFieldJsonBen.Value = JsonConvert.SerializeObject(benefs);
					hiddenFieldJsonBox.Value = JsonConvert.SerializeObject(boxes);
					hiddenFieldJsonAcc.Value = JsonConvert.SerializeObject(bankAccounts);
					hiddenFieldJsonAie.Value = JsonConvert.SerializeObject(accounts);
				}
				else
					Response.Redirect("/Login.aspx?logout=1");
			}
			else
				Response.Redirect("/Login.aspx");
		}
	}
}