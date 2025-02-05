using DashboardProfit.Data;
using DashboardProfit.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Repository
{
	public class DocumentoVentaRepository : ProfitAdmManager
	{
		public List<RepDocumentoCXCxNumero_Result> getDocsCxC(DateTime from, DateTime to, int top)
		{
			List<RepDocumentoCXCxNumero_Result> result = new List<RepDocumentoCXCxNumero_Result>();
			var sp = db.RepDocumentoCXCxNumero(null, null, null, from, to, null, null, null, null, null, null, null, null, 
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