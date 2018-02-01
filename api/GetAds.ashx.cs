using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetAds 的摘要说明
    /// </summary>
    public class GetAds : WechatHandler
    {
        class AdsResponseInfo : ResponseInfo
        {
            public List<AdInfo> Ads
            {
                get;set;
            }
        }
        public override ResponseInfo OnLoad(HttpContext context)
        {
            List<AdInfo> ads = BLL.Ads.GetAds();
            AdsResponseInfo ari = new AdsResponseInfo();
            ari.Ads = ads;

            return ari;
        }
    }
}