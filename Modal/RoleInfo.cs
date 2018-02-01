using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    [Flags]
    public enum RoleBehavior
    {
        None = 0,
        AreaSetting = 2,
        UserView = 4,
        OrderSetting = 8,
        CashManager = 16,
        PolicyManager = 32,
        AdSetting = 64,
        RoleSetting  = 128,
        OperatorSetting = 512
            /*
             *            ai.AuthorityId = 2;
            ai.AuthorityName = "50州矩阵数据管理";
            authorities.Add(ai);

            ai = new AuthorityInfo();
            ai.AuthorityId = 4;
            ai.AuthorityName = "查看用户数据";
            authorities.Add(ai);

            ai = new AuthorityInfo();
            ai.AuthorityId = 8;
            ai.AuthorityName = "订单管理";
            authorities.Add(ai);

            ai = new AuthorityInfo();
            ai.AuthorityId = 16;
            ai.AuthorityName = "提现管理";
            authorities.Add(ai);



            ai = new AuthorityInfo();
            ai.AuthorityId = 32;
            ai.AuthorityName = "优惠策略管理";
            authorities.Add(ai);

            ai = new AuthorityInfo();
            ai.AuthorityId = 64;
            ai.AuthorityName = "广告管理";
            authorities.Add(ai);

            ai = new AuthorityInfo();
            ai.AuthorityId = 128;
            ai.AuthorityName = "角色和权限管理";
            authorities.Add(ai);

            ai = new AuthorityInfo();
            ai.AuthorityId = 256;
            ai.AuthorityName = "操作员管理";
            authorities.Add(ai);
        */
    }

    public class AuthorityInfo
    {
        public int AuthorityId
        {
            get; set;
        }

        public string AuthorityName
        {
            get; set;
        }
    }


    public class RoleInfo
    {
        public string RoleName
        {
            get; set;
        }

        public int RoleId
        {
            get; set;
        }

        public int AuthValue
        {
            get; set;
        }
    }
}
