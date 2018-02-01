using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetUserCashList 的摘要说明
    /// </summary>
    public class GetUserCashList : WechatHandler
    {
        public class CashListResponseInfo : ResponseInfo
        {
            public List<CashInfo> CashList
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

            CashListResponseInfo res = new CashListResponseInfo();
            res.CashList = BLL.Cash.GetUserCashList(CurrentSession.UserId);

            return res;
        }
    }
}