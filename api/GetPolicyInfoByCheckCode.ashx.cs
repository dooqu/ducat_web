using System;
using System.Collections.Generic;
using System.Web;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// GetPolicyInfoByCheckCode 的摘要说明
    /// </summary>
    public class GetPolicyInfoByCheckCode : WechatHandler
    {
        public class PolicyResponseInfo : ResponseInfo
        {
            public PolicyInfo Policy
            {
                get;set;
            }
        }
          
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(CheckRequestParams(context, "checkcode") == false)
            {
                return new ResponseInfo(true, "推广码缺失");
            }

            UserPolicyInfo pi = Policies.GetUserPolicyInfoByCheckCode(PS("checkcode"));

            if(pi == null)
            {
                return new ResponseInfo(true, "推广码不存在");
            }

            if(pi.EndTime < DateTime.Now)
            {
                return new ResponseInfo(true, "推广码已经过期");
            }

            PolicyResponseInfo res = new PolicyResponseInfo();
            res.Policy = pi;

            return res;
        }
    }
}