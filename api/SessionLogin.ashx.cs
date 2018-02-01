﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// Code2Session 的摘要说明
    /// </summary>
    public class SessionLogin : WechatHandler
    {
        class SessionKeyResponseInfo : ResponseInfo
        {
            public string SessionId
            {
                get;set;
            }
            public SessionKeyResponseInfo(string sessionid)
            {
                this.SessionId = sessionid;
            }
        }

        public override Modal.ResponseInfo OnLoad(HttpContext context)
        {
            if (string.IsNullOrEmpty(context.Request.Params["jscode"]) == false)
            {
                WeixinServiceProvider provider = new WeixinServiceProvider();
                WechatSessionInfo info = provider.GetSessionInfoByJscode(context.Request.Params["jscode"]); ;

                if(info == null)
                {
                    return new ResponseInfo(true, "微信返回信息格式异常");
                }                
                if(info.errcode != 0)
                {
                    return new ResponseInfo(true, "微信请求错误，错误号:" + info.errcode + "，错误信息:" + info.errmsg);
                }

                SessionInfo si = SessionManager.Current.CreateSessionInfo(info.session_key, info.openid);

                if(si != null)
                {
                    return new SessionKeyResponseInfo(si.SessionKey);
                }
                return new ResponseInfo(true, "创建session失败");
            }
            return new ResponseInfo(true, "参数不完整");
        }
    }
}