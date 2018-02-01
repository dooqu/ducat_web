using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetUserShareOrders 的摘要说明
    /// </summary>
    public class GetUserShareOrders : WechatHandler
    {
        public class UserShareOrdersResponseInfo : ResponseInfo
        {
            public List<OrderInfo> ShareOrders
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

            UserShareOrdersResponseInfo info = new UserShareOrdersResponseInfo();
            info.ShareOrders = BLL.Orders.GetUserShareOrders(CurrentSession.UserId);

            return info;
        }
    }
}