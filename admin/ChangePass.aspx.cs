using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin
{
    public partial class ChangePass : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.Form["func"] == "change" )
            {
                if (string.IsNullOrEmpty(Request.Form["oldPass"]))
                {
                    throw new Exception("请输入旧有的密码");
                }

                if (string.IsNullOrEmpty(Request.Form["newPass"]))
                {
                    throw new Exception("请输入新设置的密码");
                }

                if (string.IsNullOrEmpty(Request.Form["newPassConfirm"]))
                {
                    throw new Exception("请输入确认的新密码");
                }


                if(Request.Form["newPass"] != Request.Form["newPassConfirm"])
                {
                    throw new Exception("新密码和新密码确认不一致");
                }
                bool r = BLL.Operators.ChangePassword(CurrentUser.OperatorId, FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form["oldPass"], "MD5"),
                    FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form["newPass"], "MD5"));

                throw new Exception(r ? "修改密码成功" : "修改密码失败");
            }
        }
    }
}