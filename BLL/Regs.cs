using System;
using System.Collections.Generic;
using System.Text;
using Modal;
namespace BLL
{
    public class Regs
    {
        public static int NewUserReg(RegInfo ri)
        {
            return DAL.DataProvider.NewUserReg(ri);
        }

        public static RegInfo GetRegInfoById(int regid)
        {
            return DAL.DataProvider.GetRegInfoById(regid);
        }

        public static List<RegInfo> GetUserRegs(int userid)
        {
            return DAL.DataProvider.GetUserRegs(userid);
        }

        public static bool DeleteUserReg(int userid, int regid)
        {
            return DAL.DataProvider.DeleteUserReg(userid, regid);
        }
    }
}
