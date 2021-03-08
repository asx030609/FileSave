
using System;
using Dapper;
using Dapper.Contrib.Extensions;

namespace FW.Model
{

    /// <summary>
    /// A class which represents the ReplaceString table.
    /// </summary>
	[Table("[ReplaceString]")]
	public partial class ReplaceString
	{
	   /*  id  ActionCode  ActionName  ActionParamJson  GroupCode  TabCode  ReplaceDate  InputText  ResultText  */ 

		[Key]
		public virtual int id { get; set; }
		public virtual string ActionCode { get; set; }
		public virtual string ActionName { get; set; }
		public virtual string ActionParamJson { get; set; }
		public virtual string GroupCode { get; set; }
		public virtual string TabCode { get; set; }
		public virtual string ReplaceDate { get; set; }
		public virtual string InputText { get; set; }
		public virtual string ResultText { get; set; }
	}

} // namespace
