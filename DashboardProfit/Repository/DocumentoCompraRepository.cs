using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class DocumentoCompraRepository : ProfitAdmManager
	{
		public List<RepDocumentoCXPxNumero_Result> getDocsCxP(DateTime from, DateTime to, int top)
		{
			List<RepDocumentoCXPxNumero_Result> result = new List<RepDocumentoCXPxNumero_Result>();
			var sp = db.RepDocumentoCXPxNumero(null, null, null, from, to, null, null, null, null, null, null, 
				null, null, null, null, null, null, null).GetEnumerator();

			while (sp.MoveNext())
				result.Add(sp.Current);

			if (top > 0)
				return result.OrderByDescending(o => o.fec_emis).Take(top).ToList();
			else
				return result.OrderByDescending(o => o.fec_emis).ToList();
		}
	}
}