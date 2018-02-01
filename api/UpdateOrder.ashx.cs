using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Xml;

namespace api
{
    /// <summary>
    /// UpdateOrder 的摘要说明
    /// </summary>
    public class UpdateOrder : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            using (StreamReader reader = new StreamReader(context.Request.InputStream, System.Text.Encoding.UTF8))
            {
                string content = reader.ReadToEnd();
                System.Diagnostics.Trace.WriteLine("---------------------------------------------------");
                System.Diagnostics.Trace.WriteLine(content);
                ReadResult(content);
                System.Diagnostics.Trace.WriteLine("---------------------------------------------------");
            }
        }

        public void ReadResult(string xmlNotify)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xmlNotify);

            XmlNode tradeNode = xmlDoc.DocumentElement.SelectSingleNode("/xml/out_trade_no");

            if(tradeNode != null)
            {
                int orderId;

                if(Int32.TryParse(tradeNode.InnerText, out orderId))
                {
                    bool r = BLL.Orders.PayOrder(orderId);

                    if(r)
                    {
                        ResponseUpdateOK();
                        System.Diagnostics.Trace.WriteLine("支付updateok");
                    }
                }
            }
        }

        public void ResponseUpdateOK()
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Write(@"<xml>
  <return_code><![CDATA[SUCCESS]]></return_code>
  <return_msg><![CDATA[OK]] ></return_msg>
</xml> ");
            HttpContext.Current.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}