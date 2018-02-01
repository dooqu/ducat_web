﻿using System;
using System.Collections.Generic;
using System.Text;
using DAL;
using Modal;
using System.Web;

namespace BLL
{
    public class Ads
    {
        public static int NewAd(string imagePath)
        {
            return DataProvider.NewAd(imagePath);
        }

        public static void DeleteAd(int adid)
        {
            AdInfo ai = GetAdInfoById(adid);

            if(ai != null)
            {
                try
                {
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("/") + "/ads/" + ai.ImagePath);
                }
                finally
                {
                    DataProvider.DeleteAd(adid);
                }
            }
            
        }

        public static List<AdInfo> GetAds()
        {
            return DataProvider.GetAds();
        }

        public static AdInfo GetAdInfoById(int adid)
        {
            return DataProvider.GetAdInfoById(adid);
        }
    }
}
