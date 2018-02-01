using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// NewUserAreaSolution 的摘要说明
    /// </summary>
    public class NewUserAreaSolution : WechatHandler
    {
        internal class NewAreaSolutionResponseInfo : ResponseInfo
        {
            public int NewUSId
            {
                get;set;
            }

            public NewAreaSolutionResponseInfo(int usid) : base(false, "操作完成")
            {
                this.NewUSId = usid;
            }
        }
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(this.CurrentSession == null)
            {
                return new ResponseInfo(true, "登录状态已经失效");
            }
            if(CheckRequestParams(context, "areaId", "solutionId", "isSpc") == false)
            {
                return new ResponseInfo(true, "参数错误");
            }

            int areaId = Convert.ToInt32(context.Request.Params["areaId"]);
            int solutionId = Convert.ToInt32(context.Request.Params["solutionId"]);
            bool isSpc = Convert.ToBoolean(context.Request.Params["isSpc"]);

            int solu = BLL.Solutions.NewUserAreaSolution(this.CurrentSession.UserId, areaId, solutionId, isSpc);

           // System.Threading.Thread.Sleep(1000);

            if(solu > 0)
            {
                return new NewAreaSolutionResponseInfo(solu);
            }
            if(solu == -3)
            {
                return new ResponseInfo(true, "同类型的记录已经存在");
            }
            return new ResponseInfo(true, "数据库错误" + solu);
        }
    }
}