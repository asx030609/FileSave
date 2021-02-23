using FW.Common.DapperExt;
using FW.Model;
using LotterySystem.lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LotteryWeb.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
          

            string LdPrizeName = "";
            string Level = "";
            string OpenID = Session.SessionID;


            LdPrizeName = CHOUJIANG.getLdPrizeNameByOpenID(OpenID);
            if (LdPrizeName == null || LdPrizeName == "")
            {
                LdPrizeName = CHOUJIANG.getJIANGPIN();
                //CHOUJIANG.InsertLuckDraw(LdPrizeName, OpenID);

                DapperUtil.Insert<LuckDraw>(new LuckDraw() { LdPrizeName = LdPrizeName, LdOpenID = OpenID, ExhID = 6 });
            }

            //SIBT		            得奖数   成本小计
            //现金200元               3      1200      0.2%    0.002
            //豪恩礼品价值119元       15               1.5%    0.015
            //现金50元                20     2000      3%      0.03
            //纪念奖(二合一数据线)    300    2400      95.3%   0.953
            if (LdPrizeName == "现金200元")
            {
                Level = "特等奖";
                LdPrizeName = "现金<span>200</span>元";
            }
            else if (LdPrizeName == "豪恩礼品价值119元")
            {
                Level = "二等奖";
                LdPrizeName = "豪恩礼品价值119元";
            }
            else if (LdPrizeName == "现金50元")
            {
                Level = "三等奖";
                LdPrizeName = "现金50元";
            }
            else if (LdPrizeName == "精美礼品")
            {
                Level = "四等奖";
                LdPrizeName = "精美礼品";
            }
            else
            {
                Level = "谢谢参与";
            }


            ViewBag.Level = Level;
            ViewBag.LdPrizeName = LdPrizeName;

            return View();
        }

         
    }
}
