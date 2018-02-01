using System;
using System.Collections.Generic;
using System.Text;
using Modal;
using DAL;

namespace BLL
{
    public class Operators
    {
        public static List<OperatorInfo> GetAllOperators()
        {
            return DataProvider.GetAllOperators();
        }

        public static OperatorInfo GetOperatorInfo(int operatorId)
        {
            return DataProvider.GetOperatorInfo(operatorId);
        }

        public static int CreateOperator(OperatorInfo userinfo)
        {
            return DataProvider.CreateOperator(userinfo);
        }

        public static void DeleteOperator(int operatorId)
        {
            DataProvider.DeleteOperator(operatorId);
        }

        public static void UpdateRoleOfOperator(int operatorId, int roleId)
        {
            DataProvider.UpdateRoleOfOperator(operatorId, roleId);
        }

        public static OperatorInfo GetOperatorInfoByMobileAndPassword(string mobile, string passwordMD5)
        {
            return DataProvider.GetOperatorInfoByMobileAndPassword(mobile, passwordMD5);
        }

        public static bool ChangePassword(int userId, string oldPassword, string newPassword)
        {
            return DataProvider.ChangePassword(userId, oldPassword, newPassword);
        }
    }
}
