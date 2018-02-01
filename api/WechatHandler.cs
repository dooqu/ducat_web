using System;
using System.Web;
using Modal;
using Newtonsoft.Json;

namespace api
{
    public abstract class WechatHandler : IHttpHandler
    {
        /// <summary>
        /// 您将需要在网站的 Web.config 文件中配置此处理程序 
        /// 并向 IIS 注册它，然后才能使用它。有关详细信息，
        /// 请参见下面的链接: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpHandler Members

        public bool IsReusable
        {
            // 如果无法为其他请求重用托管处理程序，则返回 false。
            // 如果按请求保留某些状态信息，则通常这将为 false。
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                if (string.IsNullOrEmpty(context.Request.Params["sessionid"]) == false)
                {
                    string sessionid = context.Request.Params["sessionid"];
                    Modal.SessionInfo si = BLL.SessionManager.Current.GetSessionInfoById(sessionid);

                    if (si != null)
                    {
                        this.CurrentSession = si;
                    }
                }
                ResponseInfo ri = this.OnLoad(context);
                ResponseMessage(ri);
            }
            catch (Exception ex)
            {
                this.OnError(ex);
            }
        }

        public abstract Modal.ResponseInfo OnLoad(HttpContext context);

        public virtual void OnError(Exception ex)
        {
            ResponseMessage(new Modal.ResponseInfo(true, ex.Message));
        }

        internal void ResponseMessage(Modal.ResponseInfo ri)
        {
            HttpContext.Current.Response.Clear();
            if (ri != null)
            {
                HttpContext.Current.Response.Write(JsonConvert.SerializeObject(ri));
            }
        }

        protected Modal.SessionInfo CurrentSession
        {
            get;
            set;
        }

        protected bool CheckRequestParams(HttpContext context, params string[] ps)
        {
            for(int i = 0;i < ps.Length; i++)
            {
                if(String.IsNullOrEmpty(context.Request.Params[ps[i]]))
                {
                    return false;
                }
            }
            return true;
        }

        public string PS(string key)
        {
            return HttpContext.Current.Request.Params[key];
        }

        #endregion
    }
}
