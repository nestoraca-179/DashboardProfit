using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class FacturaCompraController : ProfitAdmManager
	{
		public List<RepCompraxFecha_Result> getLastTopInvoices(DateTime from, DateTime to, int top)
		{
			List<RepCompraxFecha_Result> result = new List<RepCompraxFecha_Result>();
			var sp = db.RepCompraxFecha(null, null, from, to, null, null, null, null, null, null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}