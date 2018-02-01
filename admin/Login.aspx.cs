using System;
using System.Collections.Generic;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Modal;

namespace admin
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(Request.Form["userMobile"]) == false ||
                string.IsNullOrEmpty(Request.Form["userPassword"]) == false)
            {
                string mobile = Request.Form["userMobile"];
                string passwordMD5 = FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form["userPassword"], "MD5");

                OperatorInfo oi = Operators.GetOperatorInfoByMobileAndPassword(mobile, passwordMD5);
               
                if(oi != null)
                {
                    Session.Add("USER", oi);

                    if((oi.AuthValue & (int)RoleBehavior.AreaSetting) > 0)
                    {
                        Response.Redirect("AreaManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.UserView) > 0)
                    {
                        Response.Redirect("UserManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.OrderSetting) > 0)
                    {
                        Response.Redirect("OrderManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.CashManager) > 0)
                    {
                        Response.Redirect("CashManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.PolicyManager) > 0)
                    {
                        Response.Redirect("PoliciesManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.AdSetting) > 0)
                    {
                        Response.Redirect("AdManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.RoleSetting) > 0)
                    {
                        Response.Redirect("RoleManager.aspx");
                    }
                    else if ((oi.AuthValue & (int)RoleBehavior.OperatorSetting) > 0)
                    {
                        Response.Redirect("OperatorManager.aspx");
                    }

                }
                else
                {
                    loginMessage.InnerText = "用户名或者密码错误";
                }
            }
        }
    }
}