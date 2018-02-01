using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using Modal;

namespace api
{
    /// <summary>
    /// LoadOptions 的摘要说明
    /// </summary>
    public class LoadOptions : WechatHandler
    {
        public override ResponseInfo OnLoad(HttpContext context)
        {
            OptionsInfo oi = ReadOptions(context);
            return oi;
        }

        public OptionsInfo ReadOptions(HttpContext context)
        {
            int areaid = 0;
            if (int.TryParse(context.Request.Params["areaid"], out areaid) == false)
            {
                throw new Exception("areaid 错误");
            }
            OptionsInfo oi = new OptionsInfo();

            using (StreamReader sr = new StreamReader(context.Server.MapPath("/") + "configs/" + areaid + ".cfg", System.Text.Encoding.UTF8))
            {
                string titlesLine = sr.ReadLine();
                oi.Titles = titlesLine.Split(',');

                string metrixLine = sr.ReadLine();
                string[] ms = metrixLine.Split(',');
                oi.Metrix = new int[ms.Length];
                for(int i = 0; i < ms.Length; i++)
                {
                    if(Int32.TryParse(ms[i], out oi.Metrix[i]) == false)
                    {
                        oi.Metrix[i] = 0;
                    }
                }

                string pricesLine = sr.ReadLine();
                if(pricesLine != null)
                {
                    string[] ps = pricesLine.Split(',');
                    oi.Prices = new int[ps.Length];
                    for (int i = 0; i < ps.Length; i++)
                    {
                        if (Int32.TryParse(ps[i], out oi.Prices[i]) == false)
                        {
                            oi.Prices[i] = 0;
                        }
                    }
                }

                string commentsLine = sr.ReadLine();
                if(commentsLine != null)
                {
                    oi.Comments = commentsLine.Split(',');
                }
            }
            return oi;
        }

    }
}