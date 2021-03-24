using BaseClassUtils;
namespace FW.Common.T4Ttinclude
{
	class Class1
	{
		public static void Fun()
		{
			string ConnectionString = "";
			SQLiteHelper.ConnectionString = ConnectionString;
			var tbData = SQLiteHelper.ExecuteDataSet("SELECT * FROM ReplaceString");
		}
	}
}
