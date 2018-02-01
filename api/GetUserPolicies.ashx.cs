using System;
using System.Collections.Generic;
using System.Web;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// GetUserPolicies 的摘要说明
    /// </summary>
    public class GetUserPolicies : WechatHandler
    {
        public class UserPoliciesResponseInfo : ResponseInfo
        {
            public List<UserPolicyInfo> UserPolicies
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

            List<UserPolicyInfo> ups = Policies.GetUserPolicies(CurrentSession.UserId);

            UserPoliciesResponseInfo res = new UserPoliciesResponseInfo();
            res.UserPolicies = ups;

            return res;
        }
    }
}