using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetUserSolutionByUSId 的摘要说明
    /// </summary>
    public class GetUserSolutionByUSId : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            int usid;
            if(CheckRequestParams(context, "usid") == false ||Int32.TryParse(PS("usid"), out usid) == false)
            {
                return new ResponseInfo(true, "usid参数错误");
            }

            UserSolution us = BLL.Solutions.GetUserSolutionByUSId(usid);

            if(us != null)
            {
                return us;
            }
            return new ResponseInfo(true, "Solution未找到");
        }
    }
}