using System;
using System.Collections.Generic;
using System.Web;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// NewReg 的摘要说明
    /// </summary>
    public class NewReg : WechatHandler
    {
        static string[] compTypes = { "FNC", "DNC", "FSCC", "DSCC", "FSSC", "SSC", "LLC", "DLLC" };
        class RegResponseInfo : ResponseInfo
        {
            public int RegId
            {
                get;set;
            }

            public RegResponseInfo(int regId) : base(false, null)
            {
                this.RegId = regId;
            }
        }
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if (CurrentSession == null)
            {
                return new ResponseInfo(true, "登录已经过期");
            }

            //stockCount cfoName secretor
            if (this.CheckRequestParams(context, "USId", "linkmanName", "linkmanTel", "linkmanAddr", "linkmanEmail", "linkmanWechat",
                "compName1", "compName2", "compName3", "compRegAddr", "compProp",
                 "stockHolder", "ceoName") == false)
            {
                return new ResponseInfo(true, "参数不完整");
            }            

            int stockCount = 0, USId;
            if(Int32.TryParse(context.Request.Params["USId"], out USId) == false)
            {
                return new ResponseInfo(true, "参数错误"); 
            }

            SolutionInfo si = Solutions.GetUserSolutionByUSId(USId);
            if(si == null)
            {
                return new ResponseInfo(true, "对应的查询id不存在");
            }

            string compType = compTypes[si.SolutionId];

            if(compType == "FSCC" || compType == "DSCC" || compType == "FSSC" || compType == "SSC")
            {
                if(this.CheckRequestParams(context, "stockCount", "cfoName", "secretor") == false || Int32.TryParse(context.Request.Params["stockCount"], out stockCount) == false)
                {
                    return new ResponseInfo(true, "部分参数不完整或者参数错误");
                }
            }

            if(compType == "FNC" || compType == "DNC")
            {
                if (this.CheckRequestParams(context, "cfoName", "secretor") == false)
                {
                    return new ResponseInfo(true, "部分参数不完整");
                }
            }

            HttpPostedFile uploadFile = context.Request.Files["sign_file"];

            if(uploadFile == null)
            {
                return new ResponseInfo(true, "电子签名文件上传失败");
            }

            String signFile = Guid.NewGuid().ToString("n") + ".png";
            String signFileWithPath = context.Server.MapPath("/sign/") + signFile;
            uploadFile.SaveAs(signFileWithPath);

            RegInfo ri = new RegInfo();
            ri.UserId = CurrentSession.UserId;
            ri.USId = USId;
            ri.LinkmanName = PS("linkmanName");
            ri.LinkmanTel = PS("linkmanTel");
            ri.LinkmanEmail = PS("linkmanEmail");
            ri.LinkmanAddr = PS("linkmanAddr");
            ri.LinkmanWechat = PS("linkmanWechat");

            ri.CompName1 = PS("compName1");
            ri.CompName2 = PS("compName2");
            ri.CompName3 = PS("compName3");
            ri.CompRegAddr = PS("compRegAddr");
            ri.CompProp = PS("compProp");

            ri.StockCount = stockCount;
            ri.StockHolder = PS("StockHolder");
            ri.CEOName = PS("ceoName");
            ri.CFOName = PS("cfoName");
            ri.Secretor = PS("secretor");
            ri.SignFile = signFile;

            int ret = BLL.Regs.NewUserReg(ri);

            if(ret > 0)
            {
                return new RegResponseInfo(ret);
            }
            else
            {
                return new ResponseInfo(false, "生成数据错误" + ret);
            }

        }
    }
}