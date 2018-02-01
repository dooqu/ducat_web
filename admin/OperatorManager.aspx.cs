using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Modal;
using System.Web.Security;

namespace admin
{
    public partial class OperatorManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           if (CanDo(RoleBehavior.OperatorSetting) == false)
                throw new Exception("您没有权限管理用户和角色");

            if(string.IsNullOrEmpty(Request.Form["method"]) == false)
            {
                if(Request.Form["method"] == "update_role")
                {
                    int userId = Convert.ToInt32(Request.Form["userId"]);
                    int roleId = Convert.ToInt32(Request.Form["roleId"]);

                    Operators.UpdateRoleOfOperator(userId, roleId);
                    Response.Redirect("OperatorManager.aspx");
                }

                else if(Request.Form["method"] == "create_user")
                {

                    string username = Request.Form["username"];
                    string password = FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form["password"], "MD5");
                    string mobile = Request.Form["mobile"];
                    int roleId = Convert.ToInt32(Request.Form["newRoleOfUser"]);
                    int departmentId = Convert.ToInt32(Request.Form["newDepartmentOfUser"]);

                    OperatorInfo userinfo = new OperatorInfo();
                    userinfo.Name = username;
                    userinfo.Mobile = mobile;
                    userinfo.Password = password;
                    userinfo.RoleId = roleId;

                    try
                    {
                        int n = Operators.CreateOperator(userinfo);

                        if(n == -1)
                        {
                            throw new Exception("相同手机登录id的操作员已经存在");
                        }
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }                    

                    Response.Redirect("OperatorManager.aspx");
                }
                else if(Request.Form["method"] == "delete_user")
                {
                    int userId = Convert.ToInt32(Request.Form["userId"]);

                    OperatorInfo userinfo = Operators.GetOperatorInfo(userId);

                    if(userinfo != null && userinfo.Name.Trim() != System.Configuration.ConfigurationManager.AppSettings.Get("rootUser"))
                    {
                        Operators.DeleteOperator(userId);
                    }                   

                    Response.Redirect("OperatorManager.aspx");
                }
            }

            //绑定所有的用户列表
            List<OperatorInfo> users = Operators.GetAllOperators();
            usersRepeater.DataSource = users;
            usersRepeater.DataBind();

            //绑定所有的角色列表
            List<RoleInfo> roles = BLL.Roles.GetAllRoles();
            roleRepeater.DataSource = roles;
            roleRepeater.DataBind();
            roleRepeater2.DataSource = roles;
            roleRepeater2.DataBind();

        }
    }
}