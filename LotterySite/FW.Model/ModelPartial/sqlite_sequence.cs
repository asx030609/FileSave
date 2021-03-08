
using System;
using Dapper;
using Dapper.Contrib.Extensions;

namespace FW.Model
{

    /// <summary>
    /// A class which represents the sqlite_sequence table.
    /// </summary>
	[Table("[sqlite_sequence]")]
	public partial class sqlitesequence
	{
	   /*  name  seq  */ 

		public virtual string name { get; set; }
		public virtual string seq { get; set; }
	}

} // namespace
