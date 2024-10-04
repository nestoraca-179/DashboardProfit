namespace DashboardProfit.Models
{
	public abstract class Repository
	{
		public readonly static DashboardProfitEntities db = new DashboardProfitEntities();
	}
}