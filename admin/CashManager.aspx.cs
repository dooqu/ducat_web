using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modal;
using BLL;

namespace admin
{
    public partial class CashManager : BasePage
    {
        protected int pageIndex;
        protected int pageSize;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(RoleBehavior.CashManager) == false)
            {
                throw new Exception("您暂无权限访问提现管理");
            }
            if(Int32.TryParse(Request.Params["pageIndex"], out pageIndex) == false)
            {
                pageIndex = 0;
            }

            int docashid;
            if(Request.Form["func"] == "docash" && Int32.TryParse(Request.Form["cashid"], out docashid))
            {
                DoCash(docashid);

                int pageIndex2 = 0;

                Int32.TryParse(Request.Form["pageIndex2"], out pageIndex2);
                Response.Redirect("CashManager.aspx?pageIndex=" + pageIndex2);
                return;
            }

            BindCashList();

        }

        protected void DoCash(int cashid)
        {
            Cash.DoCash(cashid);
        }


        protected void BindCashList()
        {
            int totalCount = 0;
            List<CashInfo> cashlist = Cash.GetCashList(pageIndex, 30, out totalCount);

            cashRepeater.DataSource = cashlist;
            cashRepeater.DataBind();

            PageControl c = new PageControl(pageIndex, 30, (int)Math.Ceiling((float)totalCount / (float)30));
            pageNumRepeater.DataSource = c.Numbers;
            pageNumRepeater.DataBind();
        }
    }
}