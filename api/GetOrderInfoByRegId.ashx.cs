using System;
using System.Collections.Generic;
using System.Web;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// GetOrderInfoByRegId 的摘要说明
    /// </summary>
    public class GetOrderInfoByRegId : WechatHandler
    {
        public class OrderResponseInfo : ResponseInfo
        {
            public OrderInfo Order
            {
                get;set;
            }
        }
        public override ResponseInfo OnLoad(HttpContext context)
        {
            int regid;
            if(CheckRequestParams(context, "regid") == false || Int32.TryParse(PS("regid"), out regid) == false)
            {
                return new ResponseInfo(true, "regid参数错误");
            }

            OrderInfo order = Orders.GetOrderInfoByRegId(regid);

            if(order == null)
            {
                return new ResponseInfo(true, "订单信息未找到");
            }

            OrderResponseInfo res = new OrderResponseInfo();
            res.Order = order;

            return res;

        }
    }
}