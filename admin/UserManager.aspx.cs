using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin
{
    public partial class UserManager : BasePage
    {
        protected int pageIndex;
        protected int pageTotal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(Modal.RoleBehavior.UserView) == false)
            {
                throw new Exception("暂无浏览用户数据的权限");
            }
            if(Int32.TryParse(Request.Params["pageIndex"], out pageIndex) == false)
            {
                pageIndex = 0;
            }

            List<Modal.UserInfo> user = BLL.Users.GetAll(pageIndex, 20, out pageTotal);

            usersRepeater.DataSource = user;
            usersRepeater.DataBind();

            PageControl pages = new PageControl(pageIndex, 20, pageTotal);
            pageNumRepeater.DataSource = pages.Numbers;
            pageNumRepeater.DataBind();
        }
    }
}