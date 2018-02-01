using System;
using System.Collections.Generic;
using System.Text;
using Modal;
using DAL;

namespace BLL
{
    public class Roles
    {
        public static List<RoleInfo> GetAllRoles()
        {
            return DataProvider.GetAllRoles();
        }

        public static List<AuthorityInfo> GetAllAuthorities()
        {
            return DataProvider.GetAllAuthorities();
        }

        public static void UpdateAuthValueOfRole(int roleId, int authValue)
        {
            DataProvider.UpdateAuthValueOfRole(roleId, authValue);
        }

        public static void DeleteRole(int roleId)
        {
            DataProvider.DeleteRole(roleId);
        }

        public static int CreateRole(string roleName, int authValue)
        {
            return DataProvider.CreateRole(roleName, authValue);
        }

        public static bool CanOperatorDo(OperatorInfo oi, RoleBehavior behavior)
        {
            if (oi == null)
                return false;

            if (String.IsNullOrEmpty(System.Configuration.ConfigurationManager.AppSettings.Get("rootUser")) == false && oi.Name.Trim().ToString() == System.Configuration.ConfigurationManager.AppSettings.Get("rootUser"))
            {
                return true;
            }

            return ((oi.AuthValue & (int)behavior) > 0);
        }
    }
}
