using System.Web.Http;

namespace DashboardProfit
{
	public static class WebApiConfig
	{
		public static string UrlPrefix { get { return "api"; } }
		public static string UrlPrefixRelative { get { return "~/api"; } }

		public static void Register(HttpConfiguration config)
		{
			// Configuración y servicios de Web API

			// Rutas de Web API
			config.MapHttpAttributeRoutes();

			config.Routes.MapHttpRoute(
				name: "DefaultApi",
				routeTemplate: "api/{controller}/{id}",
				defaults: new { id = RouteParameter.Optional }
			);
		}
	}
}
