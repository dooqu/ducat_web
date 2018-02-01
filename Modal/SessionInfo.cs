using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class UserInfo
    {
        public int UserId
        {
            get;set;
        }

        public string OpenID
        {
            get; set;
        }

        public DateTime UserCreatedDate
        {
            get;set;
        }

        public int OrderCount
        {
            get;set;
        }

        public int UserPoliciesCount
        {
            get;set;
        }
    }
    public class SessionInfo : UserInfo
    {
        public string SessionId
        {
            get;set;
        }

        public string WechatSessionKey
        {
            get;set;
        }

        public string SessionKey
        {
            get;set;
        }

        public DateTime CreatedDate
        {
            get;set;
        }

        public DateTime ExpireDate
        {
            get;set;
        }
    }
}
