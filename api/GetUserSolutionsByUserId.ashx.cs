using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetUserSolutionsByUserId 的摘要说明
    /// </summary>
    public class GetUserSolutionsByUserId : WechatHandler
    {
        public class UserSolutionsResponse : ResponseInfo
        {
            public List<UserSolution> Items
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

            List<UserSolution> list = BLL.Solutions.GetUserSolutionsByUserId(CurrentSession.UserId);

            UserSolutionsResponse usr = new UserSolutionsResponse();
            usr.Items = list;

            return usr;
        }
    }
}