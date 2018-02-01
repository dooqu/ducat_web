using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// DeleteUserReg 的摘要说明
    /// </summary>
    public class DeleteUserReg : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(CurrentSession == null)
            {
                return new ResponseInfo(true, "登录已经过期");
            }

            int regid = 0;
            if(CheckRequestParams(context, "regid") == false || Int32.TryParse(PS("regid"), out regid) == false)
            {
                return new ResponseInfo(true, "regid错误");
            }

            RegInfo ri = BLL.Regs.GetRegInfoById(regid);

            if(ri != null)
            {
                BLL.Regs.DeleteUserReg(CurrentSession.UserId, regid);
                System.IO.File.Delete(context.Server.MapPath("/") + "/sign/" + ri.SignFile);
                {
                    
                    return new ResponseInfo(false, "删除成功");
                }
            }

            return new ResponseInfo(true, "删除失败");
        }
    }
}