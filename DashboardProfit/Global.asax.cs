using System;
using System.Web;
using System.Web.Http;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.SessionState;

namespace DashboardProfit
{
	public class Global : HttpApplication
	{
		void Application_Start(object sender, EventArgs e)
		{
			// Código que se ejecuta al iniciar la aplicación
			GlobalConfiguration.Configure(WebApiConfig.Register);
			RouteConfig.RegisterRoutes(RouteTable.Routes);
			BundleConfig.RegisterBundles(BundleTable.Bundles);
		}

		protected void Application_PostAuthorizeRequest()
		{
			if (IsWebApiRequest())
			{
				HttpContext.Current.SetSessionStateBehavior(SessionStateBehavior.Required);
			}
		}

		private bool IsWebApiRequest()
		{
			return HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.StartsWith(WebApiConfig.UrlPrefixRelative);
		}
	}
}