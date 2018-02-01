using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Security;

namespace Modal
{
    public class WechatOrderInfo
    {
        protected string guid;
        public WechatOrderInfo()
        {
            guid = Guid.NewGuid().ToString("N");
        }

        public string AppId
        {
            get;set;
        }

        public string MchId
        {
            get;set;
        }

        public string NonceString
        {
            get
            {
                return guid;
            }
        }



        public string Body
        {
            get;set;
        }


        public string Attach
        {
            get;set;
        }

        public string TradeNO
        {
            get;set;
        }

        public int Price
        {
            get;set;
        }

        public string ClientIp
        {
            get;set;
        }

        public string NotifyUrl
        {
            get;set;
        }

        public string OpenId
        {
            get;set;
        }

        public string Secret
        {
            get;set;
        }

        public string Sign
        {
            get
            {
                string str = string.Format("appid={0}&body={1}&mch_id={2}&nonce_str={3}&notify_url={4}&openid={5}&out_trade_no={6}&spbill_create_ip={7}&total_fee={8}&trade_type=JSAPI",
                    this.AppId,
                    this.Body,
                    this.MchId,
                    this.NonceString,
                    this.NotifyUrl,
                    this.OpenId.Trim(),
                    this.TradeNO,
                    this.ClientIp,
                    this.Price.ToString());

                str = str + "&key=" + this.Secret;

                System.Diagnostics.Trace.WriteLine(str);

                return FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5").ToUpper();
            }
        }

        public string ToXmlString()
        {
            return string.Format(@"<xml>
   <appid>{0}</appid>
   <body>{1}</body>
   <mch_id>{2}</mch_id>
   <nonce_str>{3}</nonce_str>
   <notify_url>{4}</notify_url>
   <openid>{5}</openid>
   <out_trade_no>{6}</out_trade_no>
   <spbill_create_ip>{7}</spbill_create_ip>
   <total_fee>{8}</total_fee>
   <trade_type>JSAPI</trade_type>
   <sign>{9}</sign>
</xml>", this.AppId, this.Body, this.MchId, this.NonceString, this.NotifyUrl, this.OpenId.Trim(), this.TradeNO, this.ClientIp, this.Price.ToString(), this.Sign);

        }            
    }
}
