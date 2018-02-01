using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class PolicyInfo
    {
        public int PolicyId
        {
            get;set;
        }

        public string Title
        {
            get;set;
        }

        public string Comment
        {
            get;set;
        }

        public int MinPrice
        {
            get;set;
        }

        public int LimitCountPerUser
        {
            get;set;
        }

        public bool LimitNewUser
        {
            get;set;
        }

        public bool LimitOldUser
        {
            get;set;
        }

        public bool IsDisPercent
        {
            get;set;
        }

        public int DisMoney
        {
            get;set;
        }

        public bool IsSharePercent
        {
            get;set;
        }

        public int ShareMoney
        {
            get;set;
        }

        public int RefCount
        {
            get;set;
        }

        public int GenCount
        {
            get;set;
        }

        public int RegCount
        {
            get;set;
        }

        public int PayCount
        {
            get;set;
        }

        public DateTime StartTime
        {
            get;set;
        }

        public DateTime EndTime
        {
            get;set;
        }

        public string StartDate
        {
            get
            {
                return this.StartTime.ToString("yyyy年MM月dd日");

            }
        }

        public string EndDate
        {
            get
            {
                return this.EndTime.ToString("yyyy年MM月dd日");
            }
        }

        public bool IsOffline
        {
            get;set;
        }

        public List<int> AreaIds
        {
            get;set;
        }

        public string Rule
        {
            get
            {
                if (this.LimitCountPerUser > 0)
                {
                    return "单用户最多使用" + this.LimitCountPerUser.ToString() + "次";
                }

                if (this.MinPrice > 0)
                {
                    return "单笔订单满" + this.MinPrice.ToString() + "可使用";
                }

                if (this.LimitNewUser)
                {
                    return "新用户使用";
                }

                if (this.LimitOldUser)
                {
                    return "老用户使用";
                }

                return "";
            }
        }

    }

    public class UserPolicyInfo : PolicyInfo
    {
        public int UPId
        {
            get;set;
        }

        public int UserId
        {
            get;set;
        }

        public string CheckCode
        {
            get;set;
        }

        public DateTime DateCreated
        {
            get;set;
        }

        public int MoneyCount
        {
            get;set;
        }
    }
}
