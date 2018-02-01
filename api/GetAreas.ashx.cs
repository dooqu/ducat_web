using System;
using System.Collections.Generic;
using System.Web;
using Modal;

namespace api
{
    /// <summary>
    /// GetAreas 的摘要说明
    /// </summary>
    public class GetAreas : WechatHandler
    {
        public class AreaListResponseInfo : ResponseInfo
        {
            public List<AreaInfo> Areas
            {
                get;set;
            }
        }

        public override ResponseInfo OnLoad(HttpContext context)
        {
            List<AreaInfo> areas = BLL.Areas.GetAll();

            AreaListResponseInfo res = new AreaListResponseInfo();
            res.Areas = areas;

            return res;
        }
    }
}