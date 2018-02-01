using System;
using System.Collections.Generic;
using System.Text;
using DAL;
using Modal;

namespace BLL
{
    public class Policies
    {
        public static int CreatePolicy(PolicyInfo pi)
        {
            return DataProvider.CreatePolicy(pi);
        }

        public static int CreateUserPolicy(UserPolicyInfo userPi)
        {
            return DataProvider.CreateUserPolicy(userPi);
        }

        public static List<PolicyInfo> GetPolicies(int pageIndex, int pageSize, out int pageTotal)
        {
            return DataProvider.GetPolicies(pageIndex, pageSize, out  pageTotal);
        }

        public static List<PolicyInfo> GetAvailablePolicies()
        {
            return DataProvider.GetAvaiablePolicies();
        }

        public static List<UserPolicyInfo> GetUserPolicies(int userId)
        {
            return DataProvider.GetUserPolicies(userId);
        }

        public static PolicyInfo GetPolicyInfoById(int policyId)
        {
            return DataProvider.GetPolicyInfoById(policyId);
        }

        public static UserPolicyInfo GetUserPolicyInfoById(int upid)
        {
            return DataProvider.GetUserPolicyInfoById(upid);
        }

        public static UserPolicyInfo GetUserPolicyInfoByCheckCode(string checkCode)
        {
            return DataProvider.GetUserPolicyInfoByCheckCode(checkCode);
        }

        public static int GetUserPoliciesCount(int userid, int policyid)
        {
            return DataProvider.GetUserPoliciesCount(userid, policyid);
        }

        public static bool DeletePolicy(int policyId)
        {
            return DataProvider.DeletePolicy(policyId);
        }
    }
}
