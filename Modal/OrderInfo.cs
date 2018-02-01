using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class OrderInfo
    {
        public int OrderId
        {
            get;set;
        }
        public RegInfo Reg
        {
            get;set;
        }

        public UserPolicyInfo UserPolicy
        {
            get;set;
        }

        public int UserId
        {
            get;set;
        }

        public UserInfo User
        {
            get;set;
        }

        public int RegId
        {
            get;set;
        }

        public int UPId
        {
            get;set;
        }

        public int BaseMoney
        {
            get;set;
        }

        public int GovMoney
        {
            get;set;
        }

        public int SpcMoney
        {
            get;set;
        }

        public bool IsSpc
        {
            get;set;
        }

        public int OrderShareMoney
        {
            get;set;
        }

        public int OrderDisMoney
        {
            get;set;
        }

        public bool IsPayed
        {
            get;set;
        }

        public DateTime DatePayed
        {
            set;
            get;
        }

        public DateTime DateCreated
        {
            get;set;
        }
    }
}
