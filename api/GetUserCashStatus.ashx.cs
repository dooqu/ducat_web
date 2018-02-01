using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetUserCashStatus 的摘要说明
    /// </summary>
    public class GetUserCashStatus : WechatHandler
    {
        public class UserCashStatusResponseInfo : ResponseInfo
        {
            public int IncomeTotal
            {
                get;set;
            }

            public int CashMoneyTotal
            {
                get;set;
            }

            public int CashMoneyTotalPending
            {
                get;set;
            }

            public int CashMoneyLeft
            {
                get;set;
            }

            public string WechatId
            {
                get;set;
            }

            public string Mobile
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

            int incomeTotal = 0;
            int cashMoneyTotal = 0;
            int cashMoneyTotalPending = 0;
            int cashMoneyLeft = 0;
            string wechatId;
            string mobile;
            BLL.Cash.GetUserCashStatus(CurrentSession.UserId, out incomeTotal, out cashMoneyTotal, out cashMoneyTotalPending, out cashMoneyLeft, out wechatId, out mobile);

            UserCashStatusResponseInfo res = new UserCashStatusResponseInfo();
            res.IncomeTotal = incomeTotal;
            res.CashMoneyTotal = cashMoneyTotal;
            res.CashMoneyTotalPending = cashMoneyTotalPending;
            res.CashMoneyLeft = cashMoneyLeft;
            res.WechatId = wechatId;
            res.Mobile = mobile;

            return res;
        }
    }
}