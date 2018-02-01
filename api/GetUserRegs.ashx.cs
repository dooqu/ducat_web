using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetUserRegs 的摘要说明
    /// </summary>
    public class GetUserRegs : WechatHandler
    {
        public class UserRegsResponse : ResponseInfo
        {
            public List<RegInfo> Items
            {
                get;set;
            }
        }

        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(CurrentSession == null)
            {
                return new ResponseInfo(true, "登录状态已经过期");
            }

            UserRegsResponse urRsp = new UserRegsResponse();
            urRsp.Items = BLL.Regs.GetUserRegs(CurrentSession.UserId);

            return urRsp;
        }
    }
}