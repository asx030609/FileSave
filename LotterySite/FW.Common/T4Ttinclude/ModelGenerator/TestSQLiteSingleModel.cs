﻿ 


// This file was automatically generated by the Dapper.SimpleCRUD T4 Template
// Do not make changes directly to this file - edit the template instead
// 
// The following connection settings were used to generate this file
// 
//     Connection String : `Data Source=E:/cc/test/LotterySite/Lib/db/cater.db;`

		 
  

 


using System;
// using Dapper;
// using Dapper.Contrib.Extensions;

namespace FW.Single.TestModel
{
    /// <summary>
    /// A class which represents the LuckDraw table.
    /// </summary>
	// [Table("[LuckDraw]")]
	public partial class LuckDraw
	{
		/*  LdID  LdPrizeName  LdName  LdMobile  LdOpenID  LdIfDraw  LdCreateTime  ExhID  */ 

		// [Key]
		public virtual int LdID { get; set; }
		public virtual string LdPrizeName { get; set; }
		public virtual string LdName { get; set; }
		public virtual string LdMobile { get; set; }
		public virtual string LdOpenID { get; set; }
		public virtual bool? LdIfDraw { get; set; }
		public virtual DateTime? LdCreateTime { get; set; }
		public virtual int? ExhID { get; set; }
	}

}

