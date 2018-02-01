using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Modal;

namespace admin
{
    public partial class OrderManager : BasePage
    {
        protected int pageIndex;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CanDo(RoleBehavior.OrderSetting) == false)
            {
                throw new Exception("您暂无权限访问订单管理");
            }
            if (Int32.TryParse(Request.Params["pageIndex"], out pageIndex) == false)
            {
                pageIndex = 0;
            }

            BindOrderList();
        }

        protected void BindOrderList()
        {
            int totalCount = 0;
            List<OrderInfo> orders = Orders.GetOrderList(pageIndex, 20, out totalCount);
            orderRepeater.DataSource = orders;
            orderRepeater.DataBind();


            PageControl c = new PageControl(pageIndex, 20, (int)Math.Ceiling((float)totalCount / (float)20));
            pageNumRepeater.DataSource = c.Numbers;
            pageNumRepeater.DataBind();
        }
    }
}