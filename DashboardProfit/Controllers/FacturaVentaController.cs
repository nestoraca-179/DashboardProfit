using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class FacturaVentaController : ProfitAdmManager
	{
		public List<RepFacturaVentaxFecha_Result> getLastTopInvoices(DateTime from, DateTime to, int top)
		{
			List<RepFacturaVentaxFecha_Result> result = new List<RepFacturaVentaxFecha_Result>();
			var sp = db.RepFacturaVentaxFecha(null, null, from, to, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}