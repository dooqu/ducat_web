using System;
using System.Collections.Generic;
using System.Web;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// NewUserPolicy 的摘要说明
    /// </summary>
    public class NewUserPolicy : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(CurrentSession == null)
            {
                return new ResponseInfo(true, "登录状态已经过期");
            }

            if(CheckRequestParams(context, "checkCode", "policyid") == false)
            {
                return new ResponseInfo(true, "参数不完整");
            }

            int policyid;

            if(Int32.TryParse(PS("policyid"), out policyid) == false)
            {
                return new ResponseInfo(true, "策略id错误");
            }

            PolicyInfo pi = Policies.GetPolicyInfoById(policyid);

            if(pi == null)
            {
                return new ResponseInfo(true, "该推广策略不存在");
            }

            if(pi.EndTime < DateTime.Now)
            {
                return new ResponseInfo(true, "推广策略已经过期");
            }

            UserPolicyInfo upi = new UserPolicyInfo();
            upi.UserId = CurrentSession.UserId;
            upi.CheckCode = PS("checkCode").ToLower();
            upi.PolicyId = policyid;

            int upid = Policies.CreateUserPolicy(upi);

            if(upid == -1)
            {
                return new ResponseInfo(true, "相同的推广码已经存在");
            }
            else if(upid < 1)
            {
                return new ResponseInfo(true, "推广码创建失败,数据错误");
            }
            else
            {
                return new ResponseInfo(false, upid.ToString());
            }
        }
    }
}