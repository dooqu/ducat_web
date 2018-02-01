using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modal;
using BLL;

namespace admin
{
    public partial class PoliciesManager : BasePage
    {
        int pageIndex;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(RoleBehavior.PolicyManager) == false)
            {
                throw new Exception("暂无设定优惠策略的权限");
            }

            if (Int32.TryParse(Request.Params["pageIndex"], out pageIndex) == false)
                pageIndex = 0;

            if(Request.Params["method"] == "newPolicy")
            {
                NewPolicy();
            }

            if(Request.Params["method"] == "delPolicy")
            {
                int policyId;

                if(Int32.TryParse(Request.Params["policyid"], out policyId) == false)
                {
                    throw new Exception("policyid错误");
                }

                {
                    DelPolicy(policyId);
                    Response.Redirect("PoliciesManager.aspx");
                    return;
                }
            }

            GetPolicies();
            GetAreas();
        }

        public void DelPolicy(int policyid)
        {
            Policies.DeletePolicy(policyid);
        }

        public void GetAreas()
        {
            List<AreaInfo> areas = BLL.Areas.GetAll();
            this.areasRepeater.DataSource = areas;
            this.areasRepeater.DataBind();

            this.areasObjectRepeater.DataSource = areas;
            this.areasObjectRepeater.DataBind();
        }

        public string GetRule(PolicyInfo pi)
        {
            if(pi.LimitCountPerUser > 0)
            {
                return "单用户最多使用" + pi.LimitCountPerUser.ToString() + "次";
            }
            
            if(pi.MinPrice > 0)
            {
                return "单笔订单满" + pi.MinPrice.ToString() + "可使用";
            }

            if(pi.LimitNewUser)
            {
                return "新用户使用";
            }

            if(pi.LimitOldUser)
            {
                return "老用户使用";
            }

            return "";
        }

        public void GetPolicies()
        {
            int pageTotal;
            List<Modal.PolicyInfo> ps = BLL.Policies.GetPolicies(pageIndex, 5, out pageTotal);
            this.policiesRepeater.DataSource = ps;
            this.policiesRepeater.DataBind();

            PageControl pc = new PageControl(pageIndex, 2, pageTotal);
            pageNumRepeater.DataSource = pc.Numbers;
            pageNumRepeater.DataBind();
        }

        public string GetAreas(List<int> areaIds)
        {
            string areaString = "";

            for(int i = 0; i < areaIds.Count; i++)
            {
                areaString += ((i == 0) ? areaIds[i].ToString() : ("," + areaIds[i].ToString()));
            }

            return areaString;
        }

        public void NewPolicy()
        {
            Modal.PolicyInfo pi = new Modal.PolicyInfo();

            if (String.IsNullOrEmpty(Request.Params["title"]))
                return;

            pi.Title = Request.Params["title"];

            if (String.IsNullOrEmpty(Request.Params["comment"]))
                return;

            pi.Comment = Request.Params["comment"];

            bool isDisPercent;
            if(String.IsNullOrEmpty(Request.Params["isDisPercent"]) || Boolean.TryParse(Request.Params["isDisPercent"], out isDisPercent) == false)
            {
                return;
            }
            pi.IsDisPercent = isDisPercent;

            int disMoney;
            if (String.IsNullOrEmpty(Request.Params["disMoney"]) || Int32.TryParse(Request.Params["disMoney"], out disMoney) == false || disMoney <= 0)
            {
                return;
            }
            pi.DisMoney = disMoney;

            int shareMoney;
            if (String.IsNullOrEmpty(Request.Params["shareMoney"]) || Int32.TryParse(Request.Params["shareMoney"], out shareMoney) == false || shareMoney <= 0)
            {
                return;
            }
            pi.ShareMoney = shareMoney;

            bool isSharePercent;
            if (String.IsNullOrEmpty(Request.Params["isSharePercent"]) || Boolean.TryParse(Request.Params["isSharePercent"], out isSharePercent) == false)
            {
                return;
            }

            pi.IsSharePercent = isSharePercent;

            int usage;
            int minPrice = 0;
            int limitCountPerUser = 0;

            DateTime startDate;
            if(string.IsNullOrEmpty(Request.Params["startDate"]) || DateTime.TryParse(Request.Params["startDate"], out startDate) == false)
            {
                return;
            }

            pi.StartTime = startDate;

            DateTime endDate;
            if (string.IsNullOrEmpty(Request.Params["endDate"]) || DateTime.TryParse(Request.Params["endDate"], out endDate) == false)
            {
                return;
            }

            pi.EndTime = endDate;


            if (String.IsNullOrEmpty(Request.Params["usage"]) || Int32.TryParse(Request.Params["usage"], out usage) == false)
            {
                return;
            }

            if(String.IsNullOrEmpty(Request.Params["areas"]))
            {
                return;
            }

            string[] areas = Request.Params["areas"].Trim().Split(',');

            if(areas.Length == 0)
            {
                return;
            }
            pi.AreaIds = new List<int>();

            for(int i = 0; i < areas.Length; i++)
            {
                int areaId;
                if(Int32.TryParse(areas[i], out areaId) == false)
                {
                    return;
                }
                pi.AreaIds.Add(areaId);
            }
                       

            switch(usage)
            {
                case 0:
                    if (String.IsNullOrEmpty(Request.Params["limitCountPerUser"]) || Int32.TryParse(Request.Params["limitCountPerUser"], out limitCountPerUser) == false || limitCountPerUser <= 0)
                    {
                        return;
                    }
                    pi.LimitCountPerUser = limitCountPerUser;
                    break;

                case 1:
                    if (String.IsNullOrEmpty(Request.Params["minPrice"]) || Int32.TryParse(Request.Params["minPrice"], out minPrice) == false || minPrice <= 0)
                    {
                        return;
                    }
                    pi.MinPrice = minPrice;
                    break;

                case 2:
                    pi.LimitNewUser = true;
                    break;
                case 3:
                    pi.LimitOldUser = true;
                    break;
            }

            int pid = BLL.Policies.CreatePolicy(pi);

            Response.Redirect("PoliciesManager.aspx");
        }
    }
}