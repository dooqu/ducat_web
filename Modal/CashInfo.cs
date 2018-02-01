using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class CashInfo
    {
        public int CashId
        {
            get;set;
        }
        public int UserId
        {
            get;set;
        }

        public string OpenId
        {
            get;set;
        }

        public string WechatId
        {
            get;set;
        }

        public string Mobile
        {
            get;set;
        }

        public int CashMoney
        {
            get;set;
        }

        public DateTime DatePayed
        {
            get;set;
        }

        public DateTime DateCreated
        {
            get; set;
        }

        public bool IsPayed
        {
            get;set;
        }
    }
}
