using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Modal;

namespace admin
{
    public partial class RoleManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(RoleBehavior.RoleSetting) == false)
            {
                throw new Exception("暂无设定角色的权限");
            }
            if(Page.IsPostBack == false)
            {
                List<AuthorityInfo> auths = Roles.GetAllAuthorities();

                authRepeater.DataSource = auths;
                authRepeater.DataBind();
            }
            else
            {
                if(Request.Form["method"] == "update")
                {
                    int authValue = Convert.ToInt32(Request.Form["authValue"]);
                    int roleId = Convert.ToInt32(Request.Form["rolelist"]);

                    Roles.UpdateAuthValueOfRole(roleId, authValue);

                    Response.Redirect("RoleManager.aspx?roleId=" + roleId.ToString());
                }
                else if(Request.Form["method"] == "delete")
                {
                    if(string.IsNullOrEmpty(Request.Form["rolelist"]) == false)
                    {
                        int roleid = Convert.ToInt32(Request.Form["rolelist"]);
                        Roles.DeleteRole(roleid);

                        Response.Redirect("RoleManager.aspx");
                    }
                }
                else if(Request.Form["method"] == "create")
                {
                    if(string.IsNullOrEmpty(Request.Form["roleName"]) == false)
                    {
                        int roleId = Roles.CreateRole(Request.Form["roleName"], 0);
                        Response.Redirect("RoleManager.aspx?roleId=" + roleId.ToString());
                    }
                }
            }

            List<RoleInfo> roles = Roles.GetAllRoles();
            rolesRepeater.DataSource = roles;
            rolesRepeater.DataBind();
        }


        protected int GetIntRequestFormValue(string val)
        {
            return Convert.ToInt32(Request.Form[val]);
        }
    }
}