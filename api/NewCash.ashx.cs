using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// NewCash 的摘要说明
    /// </summary>
    public class NewCash : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(CurrentSession == null)
            {
                return new ResponseInfo(true, "登录状态已经过期");
            }
            if(CheckRequestParams(context, "cashMoney", "wechatid", "mobile") == false)
            {
                return new ResponseInfo(true, "参数不完整");
            }

            int cashMoney;

            if(Int32.TryParse(PS("cashMoney"), out cashMoney) == false)
            {
                return new ResponseInfo(true, "提现金额错误");
            }

            if(cashMoney < 2500)
            {
                return new ResponseInfo(true, "单笔提现金额不能小于2500元");
            }

            if(cashMoney > 10000)
            {
                return new ResponseInfo(true, "单笔提现金额不能超过10000元");
            }

            CashInfo cash = new CashInfo();
            cash.UserId = CurrentSession.UserId;
            cash.CashMoney = cashMoney;
            int cashid = BLL.Cash.NewCash(cash);

            if(cashid > 0)
            {
                BLL.Cash.UpdateUserCashAccount(CurrentSession.UserId, PS("wechatid"), PS("mobile"));
                return new ResponseInfo(false, "提现成功");
            }
            else if(cashid == -2)
            {
                return new ResponseInfo(true, "您有一个待处理的提现申请还未完成");
            }
            else if(cashid == -1)
            {
                return new ResponseInfo(true, "金额不足，无法提现");
            }
            else
            {
                return new ResponseInfo(false, "提现失败");
            }
        }
    }
}