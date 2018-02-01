using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetRegInfoById 的摘要说明
    /// </summary>
    public class GetRegInfoById : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            int regid = 0;
            if(this.CheckRequestParams(context, "regId") == false || Int32.TryParse(context.Request.Params["regid"], out regid) == false)
            {
                return new ResponseInfo(true, "regid参数错误");
            }

            RegInfo ri = BLL.Regs.GetRegInfoById(regid);

            if(ri != null)
            {
                return ri;
            }

            return new ResponseInfo(true, "未找到对应记录");
        }
    }
}