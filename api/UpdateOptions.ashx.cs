using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// UpdateOptions 的摘要说明
    /// </summary>
    public class UpdateOptions : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(string.IsNullOrEmpty(context.Request.Params["titles"]) ||
                string.IsNullOrEmpty(context.Request.Params["metrix"]) ||
                string.IsNullOrEmpty(context.Request.Params["prices"]) || 
                string.IsNullOrEmpty(context.Request.Params["areaid"])|| 
                string.IsNullOrEmpty(context.Request.Params["comments"]))
            {
                return new ResponseInfo(true, "参数不完整");
            }

            SaveConfigs(context);
            return new ResponseInfo(false, "操作成功");

        }

        public void SaveConfigs(HttpContext context)
        {
            int areaId = Convert.ToInt32(context.Request.Params["areaid"]);
            using (StreamWriter sw = new StreamWriter(context.Server.MapPath("/") + "/configs/" + areaId.ToString() + ".cfg", false, System.Text.Encoding.UTF8))
            {
                sw.WriteLine(context.Request.Params["titles"]);
                sw.WriteLine(context.Request.Params["metrix"]);
                sw.WriteLine(context.Request.Params["prices"]);
                sw.WriteLine(context.Request.Params["comments"]);

                string[] pricesStringArr = context.Request.Params["prices"].Split(',');                

                if(pricesStringArr.Length == 40)
                {
                    AreaSolution solution = new AreaSolution();
                    solution.AreaId = areaId;

                    for(int i = 0; i < 8; i++)
                    {
                        SolutionInfo si = new SolutionInfo();
                        int currSolutionId = i;
                        si.BasePrice = Convert.ToInt32(pricesStringArr[(i * 5) + 0]);
                        si.GovPrice = Convert.ToInt32(pricesStringArr[(i * 5) + 1]);
                        si.SpcPrice = Convert.ToInt32(pricesStringArr[(i * 5) + 2]);
                        si.Days = Convert.ToInt32(pricesStringArr[(i * 5) + 3]);
                        si.SpcDays = Convert.ToInt32(pricesStringArr[(i * 5) + 4]);

                        solution[i] = si;
                    }
                    Solutions.UpdateAreaSolution(solution);
                }
            }
        }
    }
}