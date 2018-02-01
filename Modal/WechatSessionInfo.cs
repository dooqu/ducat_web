using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class WechatSessionInfo
    {
        public string session_key
        {
            get;set;
        }

        public string openid
        {
            get;set;
        }

        public int expires_in
        {
            get;set;
        }

        public int errcode
        {
            get;set;
        }

        public string errmsg
        {
            get;set;
        }

        public DateTime date_created
        {
            get;set;
        }

        public DateTime date_expired
        {
            get
            {
                return date_created.AddSeconds(expires_in);
            }
        }
    }
}
