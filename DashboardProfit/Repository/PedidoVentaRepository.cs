using DashboardProfit.Data;
using DashboardProfit.Models;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DashboardProfit.Controllers
{
	public class PedidoVentaRepository : ProfitAdmManager
	{
		public saPedidoVenta getByID(string doc_num)
		{
			saPedidoVenta order = db.saPedidoVenta.AsNoTracking().Include("saPedidoVentaReng").Include("saCliente").Include("saCondicionPago")
				.Include("saVendedor").SingleOrDefault(i => i.doc_num.Trim() == doc_num);

			order.saCliente.saPedidoVenta = null;
			order.saCondicionPago.saPedidoVenta = null;
			order.saVendedor.saPedidoVenta = null;
			order.saPedidoVentaReng.ForEach((r) => {
				r.saPedidoVenta = null;
				r.des_art = db.saArticulo.AsNoTracking().First(a => a.co_art == r.co_art).art_des;
			});

			return order;
		}

		public List<RepPedidoVentaxNum_Result> getLastTopOrders(DateTime from, DateTime to, int top)
		{
			List<RepPedidoVentaxNum_Result> result = new List<RepPedidoVentaxNum_Result>();
			var sp = db.RepPedidoVentaxNum(null, null, from, to, null, null, null, null, null, null, null, null,
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