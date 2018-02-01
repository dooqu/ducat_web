using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modal;

namespace admin
{
    public partial class AdManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(RoleBehavior.AdSetting) == false)
            {
                throw new Exception("您暂无设定广告投放的权限");
            }

            if (Request.Params["method"] == "delImg")
            {
                int adid;

                if (Int32.TryParse(Request.Params["adid"], out adid))
                {
                    BLL.Ads.DeleteAd(adid);
                    Response.Redirect("AdManager.aspx");
                    return;
                }
            }

            HttpPostedFile postedFile = Request.Files["adImage"];           

            if(postedFile != null)
            {
                string newFilename = Guid.NewGuid().ToString("n") + System.IO.Path.GetExtension(postedFile.FileName);//  + ;
                string newFilenameWithPath = Server.MapPath("/ads/") + newFilename;
                postedFile.SaveAs(newFilenameWithPath);
                int adid = BLL.Ads.NewAd(newFilename);
                Response.Redirect("AdManager.aspx");
                return;
            }

            List<AdInfo> ads = BLL.Ads.GetAds();
            adsRepeater.DataSource = ads;
            adsRepeater.DataBind();
        }
    }
}