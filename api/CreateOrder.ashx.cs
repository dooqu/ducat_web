using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using Modal;
using BLL;

namespace api
{
    /// <summary>
    /// CreateOrder 的摘要说明
    /// </summary>
    public class CreateOrder : WechatHandler
    {
        class OrderResponseInfo : ResponseInfo
        {
            public string AppId
            {
                get;set;
            }

            public long TimeStamp
            {
                get
                {
                    TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
                    return Convert.ToInt64(ts.TotalSeconds);
                }
            }

            public string NonceString
            {
                get;set;
            }

            public string PrePayId
            {
                get;set;
            }

            public string Key
            {
                get;set;
            }

            public string PaySign
            {
                get
                {
                    return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(string.Format("appId={0}&nonceStr={1}&package=prepay_id={2}&signType=MD5&timeStamp={3}&key={4}", this.AppId, this.NonceString, this.PrePayId, this.TimeStamp.ToString(),this.Key), "MD5");
                }
            }
        }
        public override ResponseInfo OnLoad(HttpContext context)
        {
            if(CurrentSession == null)
            {
                return new ResponseInfo(true, "登录状态已经过期");
            }
            if(CheckRequestParams(context, "regid") == false)
            {
                return new ResponseInfo(true, "参数缺失");
            }

            int regid;

            string checkcode;

            if(Int32.TryParse(PS("regid"), out regid) == false)
            {
                return new ResponseInfo(true, "注册id错误");
            }


            RegInfo reg = Regs.GetRegInfoById(regid);

            if (reg == null)
            {
                return new ResponseInfo(true, "注册信息未找到");
            }

            if(reg.UserId != CurrentSession.UserId)
            {
                return new ResponseInfo(true, "该注册信息不属于当前登录用户");
            }

            if(reg.IsPayed)
            {
                return new ResponseInfo(true, "该注册信息已经支付完成");
            }

            OrderInfo order = new OrderInfo();
            order.UserId = CurrentSession.UserId;
            order.RegId = reg.RegId;
            order.BaseMoney = reg.BasePrice;
            order.GovMoney = reg.GovPrice;
            order.SpcMoney = (reg.IsSpc) ? reg.SpcPrice : 0;
            order.UPId = 0;
            order.IsSpc = reg.IsSpc;
            
            if(string.IsNullOrEmpty(PS("checkcode")) == false)
            {
                UserPolicyInfo upi = Policies.GetUserPolicyInfoByCheckCode(PS("checkcode"));

                if (upi != null)
                {
                    if (upi.EndTime < DateTime.Now)
                    {
                        return new ResponseInfo(true, "您的选择的优惠码已经过期");
                    }

                    if (upi.IsOffline)
                    {
                        return new ResponseInfo(true, "您选择的优惠码已经下线");
                    }

                    if (upi.AreaIds.Contains(reg.AreaId) == false)
                    {
                        return new ResponseInfo(true, "您选择的优惠码所覆盖的州区不包含您当前注册的州区");
                    }

                    if (upi.LimitCountPerUser > 0)
                    {
                        if (Policies.GetUserPoliciesCount(CurrentSession.UserId, upi.PolicyId) >= upi.LimitCountPerUser)
                        {
                            return new ResponseInfo(true, "该优惠策略限制单用户至多使用" + upi.LimitCountPerUser + "次");
                        }
                    }
                    else if (upi.LimitNewUser)
                    {
                        if (Orders.GetUserPayedOrdersCount(CurrentSession.UserId) > 0)
                        {
                            return new ResponseInfo(true, "该优惠码对应的优惠活动只针对新用户开放");
                        }
                    }
                    else if (upi.LimitOldUser)
                    {
                        if (Orders.GetUserPayedOrdersCount(CurrentSession.UserId) <= 0)
                        {
                            return new ResponseInfo(true, "该优惠码对应的优惠活动只针对老用户开放");
                        }
                    }
                    else if (upi.MinPrice > 0)
                    {
                        if ((reg.BasePrice + reg.GovPrice + (reg.IsSpc ? reg.SpcPrice : 0)) < upi.MinPrice)
                        {
                            return new ResponseInfo(true, "该优惠码对应的优惠活动要求该笔订单金额不小于" + upi.MinPrice + "元");
                        }
                    }

                    int price = (order.BaseMoney);
                    order.OrderDisMoney = (upi.IsDisPercent) ? (int)Math.Floor(price * (((float)upi.DisMoney) / (float)1)) : upi.DisMoney;
                    order.OrderShareMoney = (upi.IsSharePercent) ? (int)Math.Floor(price * (((float)upi.ShareMoney) / (float)1)) : upi.ShareMoney;

                    order.UPId = upi.UPId;
                }
                else
                {
                    return new ResponseInfo(true, "您输入的优惠码未找到");
                }
            }

           
            int orderid = Orders.NewOrder(order);
            if(orderid > 0)
            {
                WechatOrderInfo wechatOrder = new WechatOrderInfo();
                wechatOrder.AppId = System.Configuration.ConfigurationManager.AppSettings["wechat_appid"];
                wechatOrder.MchId = System.Configuration.ConfigurationManager.AppSettings["wechat_mchid"];
                wechatOrder.TradeNO = orderid.ToString();
                wechatOrder.NotifyUrl = "http://xiaochengxu.ducat.vip/api/UpdateOrder.ashx";
                wechatOrder.Body = "杜凯特商务自助费用";
                wechatOrder.Price = 100 *  ((order.BaseMoney + order.GovMoney + (order.IsSpc ? order.SpcMoney : 0)) - order.OrderDisMoney);
                wechatOrder.ClientIp = context.Request.UserHostAddress;
                wechatOrder.OpenId = CurrentSession.OpenID;
                wechatOrder.Secret = System.Configuration.ConfigurationManager.AppSettings["wechat_paykey"];
                WeixinServiceProvider provider = new WeixinServiceProvider();
                string resp = provider.CreateWechatOrder(wechatOrder);              
                //System.Diagnostics.Trace.WriteLine(resp);

                XmlDocument xmlResp = new XmlDocument();
                xmlResp.LoadXml(resp);

                if(xmlResp.DocumentElement.SelectSingleNode("/xml/return_code").InnerText == "FAIL")
                {
                    return new ResponseInfo(true, xmlResp.DocumentElement.SelectSingleNode("/xml/return_msg").InnerText);
                }
                else if(xmlResp.DocumentElement.SelectSingleNode("/xml/return_code").InnerText == "SUCCESS")
                {
                    OrderResponseInfo orderResp = new OrderResponseInfo();
                    orderResp.AppId = System.Configuration.ConfigurationManager.AppSettings["wechat_appid"];
                    orderResp.Key = System.Configuration.ConfigurationManager.AppSettings["wechat_paykey"];
                    orderResp.NonceString = wechatOrder.NonceString;
                    orderResp.PrePayId = xmlResp.DocumentElement.SelectSingleNode("/xml/prepay_id").InnerText;
                    return orderResp;
                }

                return new ResponseInfo(true, "未知错误");
            }
            else
            {
                return new ResponseInfo(true, "订单创建失败");
            }
        }
    }
}