using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modal;

namespace admin
{
    public partial class Areas : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(RoleBehavior.AreaSetting) == false)
            {
                throw new Exception("暂无设定州矩阵数据的权限");
            }
            List<AreaInfo> areas = BLL.Areas.GetAll();

            this.areaReader.DataSource = areas;
            this.areaReader.DataBind();
        }
    }
}