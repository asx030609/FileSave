using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Text;

namespace FW.Common
{
    /// <summary>
    /// 数据库配置
    /// </summary>
    public class DataBaseConfig
    {
        #region SqlServer链接配置
        /// <summary>
        /// 默认的Sql Server的链接字符串
        /// </summary>
        private static string DefaultSqlConnectionString = @"server=.;user id=sa;password=sa12345;database=ReportServerTempDB;";
        public static IDbConnection GetSqlConnection(string sqlConnectionString = null)
        {
            if (string.IsNullOrWhiteSpace(sqlConnectionString))
            {
                sqlConnectionString = DefaultSqlConnectionString;
            }
            IDbConnection conn = new SqlConnection(sqlConnectionString);
            conn.Open();
            return conn;
        }
        #endregion

        #region SqlLite链接配置


        private static string DefaultSqlLiteConnectionString = "Data Source=E:/cc/test/LotterySite/Lib/db/cater.db;";
        public static IDbConnection GetSqliteConnection(string sqliteConnectionString = null)
        {
            if (string.IsNullOrWhiteSpace(sqliteConnectionString))
            {
                sqliteConnectionString = DefaultSqlLiteConnectionString;
            }
            SQLiteConnection conn = new SQLiteConnection(sqliteConnectionString);
            conn.Open();
            return conn;
        }

        #endregion
    }
}
