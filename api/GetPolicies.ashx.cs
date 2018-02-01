using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetPolicies 的摘要说明
    /// </summary>
    public class GetPolicies : WechatHandler
    {
        class PoliciesResponseInfo : ResponseInfo
        {
            public List<PolicyInfo> Policies
            {
                get; set;
            }
        }
        public override ResponseInfo OnLoad(HttpContext context)
        {
            List<PolicyInfo> ps = BLL.Policies.GetAvailablePolicies();

            PoliciesResponseInfo res = new PoliciesResponseInfo();
            res.Policies = ps;

            return res;
        }
    }
}
