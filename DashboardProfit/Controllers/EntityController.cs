using System.Data.Entity.Core.EntityClient;

namespace DashboardProfit.Controllers
{
	public class EntityController
	{
		public static EntityConnectionStringBuilder GetEntity(string conn)
		{
			EntityConnectionStringBuilder entity = new EntityConnectionStringBuilder();

			entity.Provider = "System.Data.SqlClient";
			entity.ProviderConnectionString = conn + ";MultipleActiveResultSets=True;App=EntityFramework;";
			entity.Metadata = @"res://*/Data.ProfitAdmModel.csdl|res://*/Data.ProfitAdmModel.ssdl|res://*/Data.ProfitAdmModel.msl";
			// entity.Metadata = @"res://*/Models.ProfitAdmModel.csdl|res://*/Models.ProfitAdmModel.ssdl|res://*/Models.ProfitAdmModel.msl";

			return entity;
		}
	}
}