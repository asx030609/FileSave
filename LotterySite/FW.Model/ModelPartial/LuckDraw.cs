
using System;
using Dapper;
using Dapper.Contrib.Extensions;

namespace FW.Model
{

    /// <summary>
    /// A class which represents the LuckDraw table.
    /// </summary>
	[Table("[LuckDraw]")]
	public partial class LuckDraw
	{
	   /*  LdPrizeName  LdOpenID  ExhID  */ 

		public virtual string LdPrizeName { get; set; }
		public virtual string LdOpenID { get; set; }
		public virtual int? ExhID { get; set; }
	}


} // namespace
