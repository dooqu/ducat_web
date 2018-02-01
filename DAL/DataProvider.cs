using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Modal;
using Microsoft.ApplicationBlocks.Data;
using System.Configuration;

namespace DAL
{
    public class DataProvider
    {
        static string connection_string;
        static DataProvider()
        {
            connection_string = ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString;
        }
        public static int NewSession(SessionInfo si)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "NewSession",
                new SqlParameter("@SessionId", new Guid(si.SessionKey)),
                new SqlParameter("@WechatSessionKey", si.WechatSessionKey),
                new SqlParameter("@WechatOpenId", si.OpenID),
                new SqlParameter("@DateCreated", si.CreatedDate),
                new SqlParameter("@DateExpired", si.ExpireDate)));
        }

        public static SessionInfo GetSessionInfoById(string sessionId)
        {
            SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "GetSessionInfoById",
                new SqlParameter("@SessionId", new Guid(sessionId)));

            if (reader.Read())
            {
                SessionInfo si = new SessionInfo();
                si.UserId = Convert.ToInt32(reader["UserId"]);
                si.SessionKey = Convert.ToString(reader["SessionId"]);
                si.WechatSessionKey = Convert.ToString(reader["WechatSessionKey"]);
                si.OpenID = Convert.ToString(reader["WechatOpenId"]);
                si.CreatedDate = Convert.ToDateTime(reader["DateCreated"]);
                si.ExpireDate = Convert.ToDateTime(reader["DateExpired"]);

                return si;
            }
            return null;
        }

        public static bool UpdateSolutionInfo(int areaId, int solutionId, SolutionInfo si)
        {
            return SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "UpdateSolutionInfo",
                new SqlParameter("@AreaId", areaId),
                new SqlParameter("@SolutionId", solutionId),
                new SqlParameter("@BasePrice", si.BasePrice),
                new SqlParameter("@GovPrice", si.GovPrice),
                new SqlParameter("@SpcPrice", si.SpcPrice),
                new SqlParameter("@Day", si.Days),
                new SqlParameter("@SpcDays", si.SpcDays)) > 0;
        }

        public static AreaSolution GetAreaSolution(int areaId)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "GetAreaSolution",
                new SqlParameter("@AreaId", areaId)))
            {

                AreaSolution solution = new AreaSolution();
                solution.AreaId = areaId;

                int solutionId = 0;
                while (reader.Read())
                {
                    SolutionInfo si = new SolutionInfo();
                    si.SolutionId = solutionId;
                    si.BasePrice = Convert.ToInt32(reader["BasePrice"]);
                    si.GovPrice = Convert.ToInt32(reader["GovPrice"]);
                    si.SpcPrice = Convert.ToInt32(reader["SpcPrice"]);
                    si.Days = Convert.ToInt32(reader["Days"]);
                    si.SpcDays = Convert.ToInt32(reader["SpcDays"]);
                    solution[solutionId] = si;
                }
                return (solutionId == 7) ? solution : null;
            }
        }

        public static List<AreaInfo> GetAreas()
        {
            List<AreaInfo> areas = new List<AreaInfo>();
            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, CommandType.Text, "SELECT * FROM Areas"))
            {
                while (reader.Read())
                {
                    AreaInfo ai = new AreaInfo();
                    ai.AreaId = Convert.ToInt32(reader["AreaId"]);
                    ai.AreaName = Convert.ToString(reader["AreaName"]);
                    ai.AreaNameEN = Convert.ToString(reader["AreaNameEN"]);

                    areas.Add(ai);
                }
            }

            return areas;
        }

        public static int NewUserAreaSolution(int userId, int areaId, int solutionId, bool isSpc)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "NewUserAreaSolution",
                 new SqlParameter("@UserId", userId),
                 new SqlParameter("@AreaId", areaId),
                 new SqlParameter("@SolutionId", solutionId),
                 new SqlParameter("@IsSpc", isSpc)));
        }

        public static int NewUserReg(RegInfo ri)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "NewReg",
                new SqlParameter("@UserId", ri.UserId),
                new SqlParameter("@USId", ri.USId),
                new SqlParameter("@LinkmanName", ri.LinkmanName),
                new SqlParameter("@LinkmanTel", ri.LinkmanTel),
                new SqlParameter("@LinkmanEmail", ri.LinkmanEmail),
                new SqlParameter("@LinkmanAddr", ri.LinkmanAddr),
                new SqlParameter("@LinkmanWechat", ri.LinkmanWechat),
                new SqlParameter("@CompName1", ri.CompName1),
                new SqlParameter("@CompName2", ri.CompName2),
                new SqlParameter("@CompName3", ri.CompName3),
                new SqlParameter("@CompRegAddr", ri.CompRegAddr),
                new SqlParameter("@CompProp", ri.CompProp),
                new SqlParameter("@StockCount", ri.StockCount),
                new SqlParameter("@StockHolder", ri.StockHolder),
                new SqlParameter("@CEOName", ri.CEOName),
                new SqlParameter("@CFOName", ri.CFOName),
                new SqlParameter("@Secretor", ri.Secretor),
                new SqlParameter("@SignFile", ri.SignFile)))
            {
                if (reader.Read())
                {
                    return Convert.ToInt32(reader[0]);
                }

                return -1;
            }
        }

        public static UserSolution GetUserSolutionByUSId(int usid)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "GetUserSolutionByUSId",
                new SqlParameter("@USId", usid)))
            {
                if (reader.Read())
                {
                    UserSolution us = new UserSolution();
                    ReadUserSolution(reader, us);

                    return us;
                }
                return null;
            }
        }

        public static List<UserSolution> GetUserSolutionsByUserId(int userId)
        {
            List<UserSolution> list = new List<UserSolution>();
            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "GetUserSolutionsByUserId",
                new SqlParameter("@UserId", userId)))
            {
                while (reader.Read())
                {
                    UserSolution us = new UserSolution();
                    ReadUserSolution(reader, us);

                    list.Add(us);
                }

                return list;
            }
        }

        public static void ReadUserSolution(SqlDataReader reader, UserSolution us)
        {
            us.USId = Convert.ToInt32(reader["USId"]);
            us.UserId = Convert.ToInt32(reader["UserId"]);
            us.SolutionId = Convert.ToInt32(reader["SolutionId"]);
            us.IsSpc = Convert.ToBoolean(reader["IsSpc"]);
            us.AreaId = Convert.ToInt32(reader["AreaId"]);
            us.AreaName = Convert.ToString(reader["AreaName"]);
            us.AreaNameEN = Convert.ToString(reader["AreaNameEN"]);
            us.BasePrice = Convert.ToInt32(reader["BasePrice"]);
            us.GovPrice = Convert.ToInt32(reader["GovPrice"]);
            us.SpcPrice = Convert.ToInt32(reader["SpcPrice"]);
            us.Days = Convert.ToInt32(reader["Days"]);
            us.SpcDays = Convert.ToInt32(reader["SpcDays"]);
            us.DateCreated = Convert.ToDateTime(reader["DateCreated"]);

        }

        public static void ReadRegInfo(SqlDataReader reader, RegInfo ri)
        {
            ri.RegId = Convert.ToInt32(reader["RegId"]);
            ri.LinkmanName = Convert.ToString(reader["LinkmanName"]);
            ri.LinkmanTel = Convert.ToString(reader["LinkmanTel"]);
            ri.LinkmanEmail = Convert.ToString(reader["LinkmanEmail"]);
            ri.LinkmanAddr = Convert.ToString(reader["LinkmanAddr"]);
            ri.LinkmanWechat = Convert.ToString(reader["LinkmanWechat"]);
            //
            ri.StockCount = Convert.ToInt32(reader["StockCount"]);
            ri.StockHolder = Convert.ToString(reader["StockHolder"]);
            ri.CEOName = Convert.ToString(reader["CEOName"]);
            ri.CFOName = Convert.ToString(reader["CFOName"]);
            ri.Secretor = Convert.ToString(reader["Secretor"]);
            //
            ri.CompName1 = Convert.ToString(reader["CompName1"]);
            ri.CompName2 = Convert.ToString(reader["CompName2"]);
            ri.CompName3 = Convert.ToString(reader["CompName3"]);
            ri.CompRegAddr = Convert.ToString(reader["CompRegAddr"]);
            ri.CompProp = Convert.ToString(reader["CompProp"]);

            ri.SignFile = Convert.ToString(reader["SignFile"]);
            ri.IsPayed = Convert.ToBoolean(reader["IsPayed"]);
            ri.DateCreated = Convert.ToDateTime(reader["DateCreated"]);
            ri.DatePayed = Convert.ToDateTime(reader["DatePayed"]);

        }

        public static RegInfo GetRegInfoById(int regid)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "GetRegInfoById",
    new SqlParameter("@RegId", regid)))
            {
                if (reader.Read())
                {
                    RegInfo ri = new RegInfo();

                    ReadUserSolution(reader, ri);
                    ReadRegInfo(reader, ri);

                    return ri;
                }
            }
            return null;
        }

        public static List<RegInfo> GetUserRegs(int userid)
        {
            List<RegInfo> regs = new List<RegInfo>();

            using (SqlDataReader reader = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "GetUserRegs",
    new SqlParameter("@UserId", userid)))
            {
                while (reader.Read())
                {
                    RegInfo ri = new RegInfo();

                    ReadUserSolution(reader, ri);
                    ReadRegInfo(reader, ri);

                    regs.Add(ri);
                }
            }

            return regs;
        }

        public static bool DeleteUserReg(int userid, int regid)
        {
            return SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["sqlconn"].ConnectionString, "DeleteUserReg", new SqlParameter("@UserId", userid), new SqlParameter("@RegId", regid)) > 0;
        }

        public static OperatorInfo GetOperatorInfoByMobileAndPassword(string mobile, string passwordMD5)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetOperatorInfoByMobileAndPassword",
                new SqlParameter("@Mobile", mobile), new SqlParameter("@PasswordMD5", passwordMD5)))
            {
                if (reader.Read())
                {
                    OperatorInfo oi = new OperatorInfo();

                    oi.OperatorId = Convert.ToInt32(reader["OperatorId"]);
                    oi.Name = Convert.ToString(reader["Name"]).TrimEnd();
                    oi.RoleId = Convert.ToInt32(reader["RoleId"]);
                    oi.RoleName = Convert.ToString(reader["RoleName"]).TrimEnd();
                    oi.AuthValue = Convert.ToInt32(reader["AuthValue"]);
                    oi.Mobile = Convert.ToString(reader["Mobile"]).TrimEnd();
                    oi.CreateDate = Convert.ToDateTime(reader["CreateDate"]);
                    oi.LastLoginDate = Convert.ToDateTime(reader["LoginDate"]);

                    return oi;
                }
            }

            return null;
        }

        public static List<RoleInfo> GetAllRoles()
        {
            List<RoleInfo> roles = new List<RoleInfo>();

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, CommandType.Text, "SELECT RoleId, RoleName, AuthValue FROM Roles"))
            {
                while (reader.Read())
                {
                    RoleInfo role = new RoleInfo();

                    role.RoleId = Convert.ToInt32(reader["RoleId"]);
                    role.RoleName = Convert.ToString(reader["RoleName"]).TrimEnd();
                    role.AuthValue = Convert.ToInt32(reader["AuthValue"]);

                    roles.Add(role);
                }
            }

            return roles;
        }

        public static List<AuthorityInfo> GetAllAuthorities()
        {
            List<AuthorityInfo> authorities = new List<AuthorityInfo>();


            AuthorityInfo ai = new AuthorityInfo();
            ai.AuthorityId = 2;
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

            return authorities;
        }

        public static void UpdateAuthValueOfRole(int roleId, int authValue)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "UpdateAuthValueOfRole", new SqlParameter("@RoleId", roleId), new SqlParameter("@AuthValue", authValue));
        }

        public static void DeleteRole(int roleId)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "DeleteRole", new SqlParameter("@RoleId", roleId));
        }

        public static int CreateRole(string roleName, int authValue)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(connection_string, "CreateRole", new SqlParameter("@RoleName", roleName), new SqlParameter("@AuthValue", authValue)));
        }

        public static List<OperatorInfo> GetAllOperators()
        {
            List<OperatorInfo> users = new List<OperatorInfo>();

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetAllOperators"))
            {
                while (reader.Read())
                {
                    OperatorInfo userinfo = new OperatorInfo();

                    userinfo.OperatorId = Convert.ToInt32(reader["OperatorId"]);
                    userinfo.Name = Convert.ToString(reader["Name"]).TrimEnd();
                    userinfo.RoleId = Convert.ToInt32(reader["RoleId"]);
                    userinfo.RoleName = Convert.ToString(reader["RoleName"]).TrimEnd();
                    userinfo.AuthValue = Convert.ToInt32(reader["AuthValue"]);
                    userinfo.Mobile = Convert.ToString(reader["Mobile"]).TrimEnd();
                    userinfo.CreateDate = Convert.ToDateTime(reader["CreateDate"]);
                    userinfo.LastLoginDate = Convert.ToDateTime(reader["LoginDate"]);

                    users.Add(userinfo);
                }
            }

            return users;
        }

        public static OperatorInfo GetOperatorInfo(int operatorId)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetOperatorInfo", new SqlParameter("@OperatorId", operatorId)))
            {
                if (reader.Read())
                {
                    OperatorInfo user = new OperatorInfo();
                    user.OperatorId = Convert.ToInt32(reader["OperatorId"]);
                    user.Name = Convert.ToString(reader["Name"]);
                    user.Mobile = Convert.ToString(reader["Mobile"]).Trim();
                    user.RoleId = Convert.ToInt32(reader["RoleId"]);
                    user.RoleName = Convert.ToString(reader["RoleName"]).Trim();
                    user.AuthValue = Convert.ToInt32(reader["AuthValue"]);
                    user.CreateDate = Convert.ToDateTime(reader["CreateDate"]);
                    user.LastLoginDate = Convert.ToDateTime(reader["LoginDate"]);

                    return user;
                }
            }

            return null;
        }

        public static int CreateOperator(OperatorInfo userinfo)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(connection_string, "CreateOperator", new SqlParameter("@Username", userinfo.Name),
                new SqlParameter("@Mobile", userinfo.Mobile),
                new SqlParameter("@Password", userinfo.Password),
                new SqlParameter("@RoleId", userinfo.RoleId)));
        }

        public static void UpdateRoleOfOperator(int operatorId, int roleId)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "UpdateRoleOfOperator", new SqlParameter("@OperatorId", operatorId),
                           new SqlParameter("@RoleId", roleId));
        }

        public static void DeleteOperator(int operatorID)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "DeleteOperator", new SqlParameter("@OperatorId", operatorID));
        }


        public static int NewAd(string imagePath)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "NewAd", new SqlParameter("@ImagePath", imagePath)))
            {
                if (reader.Read())
                {
                    return Convert.ToInt32(reader["AdId"]);
                }
                return 0;
            }
        }

        public static void DeleteAd(int adid)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "DeleteAd", new SqlParameter("@AdId", adid));
        }

        public static List<AdInfo> GetAds()
        {
            List<AdInfo> ads = new List<AdInfo>();

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetAds"))
            {
                while (reader.Read())
                {
                    AdInfo ai = new AdInfo();
                    ai.AdId = Convert.ToInt32(reader["AdId"]);
                    ai.ImagePath = Convert.ToString(reader["ImagePath"]);

                    ads.Add(ai);
                }
            }

            return ads;
        }

        public static AdInfo GetAdInfoById(int adid)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetAdInfoById", new SqlParameter("@AdId", adid)))
            {
                if (reader.Read())
                {
                    AdInfo ai = new AdInfo();
                    ai.AdId = Convert.ToInt32(reader["AdId"]);
                    ai.ImagePath = Convert.ToString(reader["ImagePath"]);
                    return ai;
                }
                return null;
            }
        }

        public static void ReadPolicyInfo(PolicyInfo pi, SqlDataReader reader)
        {
            pi.PolicyId = Convert.ToInt32(reader["PolicyId"]);
            pi.Title = Convert.ToString(reader["Title"]);
            pi.Comment = Convert.ToString(reader["Comment"]);
            pi.LimitCountPerUser = Convert.ToInt32(reader["LimitCountPerUser"]);
            pi.MinPrice = Convert.ToInt32(reader["LimitMinPrice"]);
            pi.LimitNewUser = Convert.ToBoolean(reader["LimitNewUser"]);
            pi.LimitOldUser = Convert.ToBoolean(reader["LimitOldUser"]);
            pi.IsDisPercent = Convert.ToBoolean(reader["IsDisPercent"]);
            pi.DisMoney = Convert.ToInt32(reader["DisMoney"]);
            pi.IsSharePercent = Convert.ToBoolean(reader["IsSharePercent"]);
            pi.ShareMoney = Convert.ToInt32(reader["ShareMoney"]);
            pi.RefCount = Convert.ToInt32(reader["RefCount"]);
            pi.GenCount = Convert.ToInt32(reader["GenCount"]);
            pi.RegCount = Convert.ToInt32(reader["RegCount"]);
            pi.PayCount = Convert.ToInt32(reader["PayCount"]);
            pi.IsOffline = Convert.ToBoolean(reader["IsOffline"]);
            pi.StartTime = Convert.ToDateTime(reader["StartTime"]);
            pi.EndTime = Convert.ToDateTime(reader["EndTime"]);

            string[] areas = Convert.ToString(reader["AreaIds"]).Trim().Split(',');
            pi.AreaIds = new List<int>();
            for(int i = 0; i < areas.Length; i++)
            {
                int areaId;
                if(Int32.TryParse(areas[i], out areaId))
                {
                    pi.AreaIds.Add(Convert.ToInt32(areas[i]));
                }                
            }
        }

        public static void ReadUserPolicyInfo(UserPolicyInfo upi, SqlDataReader reader)
        {
            upi.UserId = Convert.ToInt32(reader["UserId"]);
            upi.UPId = Convert.ToInt32(reader["UPId"]);
            upi.CheckCode = Convert.ToString(reader["CheckCode"]).TrimEnd();
            upi.DateCreated = Convert.ToDateTime(reader["DateCreated"]);
        }

        public static int CreatePolicy(PolicyInfo pi)
        {
            string areaIds = "";

            for(int i = 0; i < pi.AreaIds.Count; i++)
            {
                areaIds += ((i == 0) ? pi.AreaIds[i].ToString() : ("," + pi.AreaIds[i].ToString()));
            }

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "NewPolicy",
                new SqlParameter("@Title", pi.Title),
                new SqlParameter("@Comment", pi.Comment),
                new SqlParameter("@LimitCountPerUser", pi.LimitCountPerUser),
                new SqlParameter("@MinPrice", pi.MinPrice),
                new SqlParameter("@LimitNewUser", pi.LimitNewUser),
                new SqlParameter("@LimitOldUser", pi.LimitOldUser),
                new SqlParameter("@IsDisPercent", pi.IsDisPercent),
                new SqlParameter("@DisMoney", pi.DisMoney),
                new SqlParameter("@IsSharePercent", pi.IsSharePercent),
                new SqlParameter("@ShareMoney", pi.ShareMoney),
                new SqlParameter("@AreaIds", areaIds),
                new SqlParameter("@RefCount", pi.RefCount),
                new SqlParameter("@GenCount", pi.GenCount),
                new SqlParameter("@RegCount", pi.RegCount),
                new SqlParameter("@PayCount", pi.PayCount),
                new SqlParameter("@StartTime", pi.StartTime),
                new SqlParameter("@EndTime", pi.EndTime)))
            {
                if (reader.Read())
                {
                    return Convert.ToInt32(reader["PolicyId"]);
                }
                return 0;
            }
        }

        public static int CreateUserPolicy(UserPolicyInfo userPi)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string,
                "NewUserPolicy",
    new SqlParameter("@PolicyId", userPi.PolicyId),
     new SqlParameter("@UserId", userPi.UserId),
      new SqlParameter("@CheckCode", userPi.CheckCode)))
            {
                if (reader.Read())
                {
                    return Convert.ToInt32(reader["UPId"]);
                }

                return 0;
            }
        }

        public static List<PolicyInfo> GetPolicies(int pageIndex, int pageSize, out int pageTotal)
        {
            List<PolicyInfo> ps = new List<PolicyInfo>();
            SqlParameter p = new SqlParameter("@PageTotal", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;
            p.Value = 0;

            SqlConnection conn = new SqlConnection(connection_string);
            SqlCommand cmd = new SqlCommand("GetPolicies", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter sp1 = new SqlParameter("@PageIndex", SqlDbType.Int);
            sp1.Value = pageIndex;

            SqlParameter sp2 = new SqlParameter("@PageSize", SqlDbType.Int);
            sp2.Value = pageSize;

            SqlParameter sp3 = new SqlParameter("@PageTotal", SqlDbType.Int);
            sp3.Direction = ParameterDirection.Output;
            sp3.Value = 0;

            cmd.Parameters.Add(sp1);
            cmd.Parameters.Add(sp2);
            cmd.Parameters.Add(sp3);

            conn.Open();

            using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    PolicyInfo pi = new PolicyInfo();
                    ReadPolicyInfo(pi, reader);
                    ps.Add(pi);
                }
            }

            pageTotal = Convert.ToInt32(sp3.Value);
            return ps;
        }

        public static List<PolicyInfo> GetAvaiablePolicies()
        {
            List<PolicyInfo> ps = new List<PolicyInfo>();

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetAvaiablePolicies"))
            {
                while(reader.Read())
                {
                    PolicyInfo pi = new PolicyInfo();
                    ReadPolicyInfo(pi, reader);
                    ps.Add(pi);
                }
            }

            return ps;
        }

        public static PolicyInfo GetPolicyInfoById(int policyId)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetPolicyInfoById", new SqlParameter("@PolicyId", policyId)))
            {
                if(reader.Read())
                {
                    PolicyInfo pi = new PolicyInfo();
                    ReadPolicyInfo(pi, reader);
                    return pi;
                }
                return null;
            }
        }

        public static UserPolicyInfo GetUserPolicyInfoByCheckCode(string checkCode)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetUserPolicyInfoByCheckCode", new SqlParameter("@CheckCode", checkCode)))
            {
                if (reader.Read())
                {
                    UserPolicyInfo pi = new UserPolicyInfo();
                    ReadPolicyInfo(pi, reader);
                    ReadUserPolicyInfo(pi, reader);
                    return pi;
                }
                return null;
            }
        }

        public static UserPolicyInfo GetUserPolicyInfoById(int upid)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetUserPolicyInfoById", new SqlParameter("@UPId", upid)))
            {
                if (reader.Read())
                {
                    UserPolicyInfo pi = new UserPolicyInfo();
                    ReadPolicyInfo(pi, reader);
                    ReadUserPolicyInfo(pi, reader);
                    return pi;
                }
                return null;
            }
        }

        public static int GetUserPoliciesCount(int userid, int policyid)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(connection_string, "GetUserPoliciesCount", new SqlParameter("@UserId", userid), new SqlParameter("@PolicyId", policyid)));
        }

        public static List<UserPolicyInfo> GetUserPolicies(int userId)
        {
            List<UserPolicyInfo> ps = new List<UserPolicyInfo>();

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetUserPolicies", new SqlParameter("@UserId", userId)))
            {
                while (reader.Read())
                {
                    UserPolicyInfo pi = new UserPolicyInfo();
                    ReadPolicyInfo(pi, reader);
                    ReadUserPolicyInfo(pi, reader);

                    ps.Add(pi);
                }
            }

            return ps;
        }

        public static List<UserInfo> GetUsers(int pageIndex, int pageSize, out int pageTotal)
        {
            List<UserInfo> users = new List<UserInfo>();

            SqlConnection conn = new SqlConnection(connection_string);
            SqlCommand cmd = new SqlCommand("GetUsers", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter sp1 = new SqlParameter("@PageIndex", SqlDbType.Int);
            sp1.Value = pageIndex;

            SqlParameter sp2 = new SqlParameter("@PageSize", SqlDbType.Int);
            sp2.Value = pageSize;

            SqlParameter sp3 = new SqlParameter("@PageTotal", SqlDbType.Int);
            sp3.Direction = ParameterDirection.Output;
            sp3.Value = 0;

            cmd.Parameters.Add(sp1);
            cmd.Parameters.Add(sp2);
            cmd.Parameters.Add(sp3);

            conn.Open();

            using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    UserInfo ui = new UserInfo();
                    ui.UserId = Convert.ToInt32(reader["UserId"]);
                    ui.OpenID = Convert.ToString(reader["OpenId"]);
                    ui.UserCreatedDate = Convert.ToDateTime(reader["DateCreated"]);
                    ui.OrderCount = Convert.ToInt32(reader["OrderCount"]);
                    ui.UserPoliciesCount = Convert.ToInt32(reader["UserPoliciesCount"]);

                    users.Add(ui);
                }
            }

            pageTotal = Convert.ToInt32(sp3.Value);
            return users;
        }

        public static int GetUserPayedOrdersCount(int userid)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(connection_string, "GetUserPayedOrdersCount", new SqlParameter("@UserId", userid)));
        }

        public static int NewOrder(OrderInfo order)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "NewOrder",
                new SqlParameter("@UserId", order.UserId),
                new SqlParameter("@RegId", order.RegId),
                new SqlParameter("@UPId", order.UPId),
                new SqlParameter("@BaseMoney", order.BaseMoney),
                new SqlParameter("@GovMoney", order.GovMoney),
                new SqlParameter("@SpcMoney", order.SpcMoney),
                new SqlParameter("@OrderDisMoney", order.OrderDisMoney),
                new SqlParameter("@OrderShareMoney", order.OrderShareMoney)))
            {

                if(reader.Read())
                {
                    return Convert.ToInt32(reader["OrderId"]);
                }

                return 0;
            }            
        }

        public static void ReadOrderInfo(OrderInfo order, SqlDataReader reader)
        {
            order.OrderId = Convert.ToInt32(reader["OrderId"]);
            order.UserId = Convert.ToInt32(reader["UserId"]);
            order.RegId = Convert.ToInt32(reader["RegId"]);
            order.UPId = Convert.ToInt32(reader["UPId"]);
            order.BaseMoney = Convert.ToInt32(reader["BaseMoney"]);
            order.GovMoney = Convert.ToInt32(reader["GovMoney"]);
            order.SpcMoney = Convert.ToInt32(reader["SpcMoney"]);
            order.IsSpc = Convert.ToBoolean(reader["IsSpc"]);
            order.OrderDisMoney = Convert.ToInt32(reader["OrderDisMoney"]);
            order.OrderShareMoney = Convert.ToInt32(reader["OrderShareMoney"]);
            order.IsPayed = Convert.ToBoolean(reader["IsPayed"]);
            order.DatePayed = Convert.ToDateTime(reader["DatePayed"]);
        }

        public static OrderInfo GetOrderInfoByRegId(int regid)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetOrderInfoByRegId", new SqlParameter("@RegId", regid)))
            {
                if(reader.Read())
                {
                    OrderInfo order = new OrderInfo();
                    ReadOrderInfo(order, reader);

                    return order;
                }

                return null;
            }
        }

        public static List<OrderInfo> GetOrders(int pageIndex, int pageSize, out int totalCount)
        {
            List<OrderInfo> orders = new List<OrderInfo>();
            SqlConnection conn = new SqlConnection(connection_string);
            SqlCommand cmd = new SqlCommand("GetOrders", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter sp1 = new SqlParameter("@PageIndex", SqlDbType.Int);
            sp1.Value = pageIndex;

            SqlParameter sp2 = new SqlParameter("@PageSize", SqlDbType.Int);
            sp2.Value = pageSize;

            SqlParameter sp3 = new SqlParameter("@TotalCount", SqlDbType.Int);
            sp3.Direction = ParameterDirection.Output;
            sp3.Value = 0;

            cmd.Parameters.Add(sp1);
            cmd.Parameters.Add(sp2);
            cmd.Parameters.Add(sp3);

            conn.Open();

            using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    OrderInfo order = new OrderInfo();
                    ReadOrderInfo(order, reader);
                    order.Reg = new RegInfo();
                    order.Reg.RegId = Convert.ToInt32(reader["RegId"]);
                    order.Reg.CompName1 = Convert.ToString(reader["CompName1"]);
                    order.IsSpc = Convert.ToBoolean(reader["IsSpc"]);
                    order.User = new UserInfo();
                    order.User.OpenID = Convert.ToString(reader["OpenId"]);

                    orders.Add(order);
                }
            }

            totalCount = Convert.ToInt32(sp3.Value);
            return orders;
        }

        public static List<OrderInfo> GetUserShareOrders(int userid)
        {
            List<OrderInfo> orders = new List<OrderInfo>();
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetUserShareOrders", new SqlParameter("@UserId", userid)))
            {
                while (reader.Read())
                {
                    OrderInfo order = new OrderInfo();
                    ReadOrderInfo(order, reader);
                    order.UserPolicy = new UserPolicyInfo();
                    order.UserPolicy.Title = Convert.ToString(reader["PolicyTitle"]);

                    order.UserPolicy.CheckCode = Convert.ToString(reader["CheckCode"]);

                    orders.Add(order);
                }

                return orders;
            }
        }

        public static int NewCash(CashInfo cash)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "NewCash",
                new SqlParameter("@UserId", cash.UserId),
                new SqlParameter("@CashMoney", cash.CashMoney)))
            {
                if (reader.Read())
                {
                    return Convert.ToInt32(reader["CashId"]);
                }

                return -1;
            }
        }

        public static void GetUserCashStatus(int userId, out int incomeTotal, out int cashTotal, out int cashTotalPending, out int cashMoneyLeft, out string wechatId, out string mobile)
        {
            incomeTotal = 0;
            cashTotal = 0;
            cashTotalPending = 0;
            cashMoneyLeft = 0;
            wechatId = null;
            mobile = null;

            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetUserCashStatus",
                new SqlParameter("@UserId", userId)))
            {
                if (reader.Read())
                {
                    incomeTotal = Convert.ToInt32(reader["IncomeTotal"]);
                    cashTotal = Convert.ToInt32(reader["CashTotal"]);
                    cashTotalPending = Convert.ToInt32(reader["CashTotalPending"]);
                    cashMoneyLeft = Convert.ToInt32(reader["CashMoneyLeft"]);
                    wechatId = Convert.ToString(reader["WechatId"]);
                    mobile = Convert.ToString(reader["Mobile"]);
                }
            }
        }

        public static List<CashInfo> GetUserCashList(int userId)
        {
            List<CashInfo> cashlist = new List<CashInfo>();
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "GetUserCashList", new SqlParameter("@UserId", userId)))
            {
                while (reader.Read())
                {
                    CashInfo cash = new CashInfo();
                    cash.CashId = Convert.ToInt32(reader["CashId"]);
                    cash.CashMoney = Convert.ToInt32(reader["CashMoney"]);
                    cash.UserId = Convert.ToInt32(reader["UserId"]);
                    cash.DateCreated = Convert.ToDateTime(reader["DateCreated"]);
                    cash.DatePayed = Convert.ToDateTime(reader["DatePayed"]);
                    cash.IsPayed = Convert.ToBoolean(reader["IsPayed"]);

                    cashlist.Add(cash);
                }               
            }

            return cashlist;
        }

        public static List<CashInfo> GetCashList(int pageIndex, int pageSize, out int totalCount)
        {
            List<CashInfo> cashlist = new List<CashInfo>();

            SqlConnection conn = new SqlConnection(connection_string);
            SqlCommand cmd = new SqlCommand("GetCashList", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter sp1 = new SqlParameter("@PageIndex", SqlDbType.Int);
            sp1.Value = pageIndex;

            SqlParameter sp2 = new SqlParameter("@PageSize", SqlDbType.Int);
            sp2.Value = pageSize;

            SqlParameter sp3 = new SqlParameter("@TotalCount", SqlDbType.Int);
            sp3.Direction = ParameterDirection.Output;
            sp3.Value = 0;

            cmd.Parameters.Add(sp1);
            cmd.Parameters.Add(sp2);
            cmd.Parameters.Add(sp3);

            conn.Open();

            using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    CashInfo cash = new CashInfo();
                    cash.CashId = Convert.ToInt32(reader["CashId"]);
                    cash.CashMoney = Convert.ToInt32(reader["CashMoney"]);
                    cash.UserId = Convert.ToInt32(reader["UserId"]);
                    cash.DateCreated = Convert.ToDateTime(reader["DateCreated"]);
                    cash.DatePayed = Convert.ToDateTime(reader["DatePayed"]);
                    cash.IsPayed = Convert.ToBoolean(reader["IsPayed"]);

                    //
                    cash.OpenId = Convert.ToString(reader["OpenId"]);
                    cash.WechatId = Convert.ToString(reader["WechatId"]);
                    cash.Mobile = Convert.ToString(reader["Mobile"]);

                    cashlist.Add(cash);
                }
            }

            totalCount = Convert.ToInt32(sp3.Value);
            return cashlist;
        }

        public static void UpdateUserAccountInfo(int userId, string wechatId, string mobile)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "UpdateUserAccount", new SqlParameter("@UserId", userId), new SqlParameter("@WechatId", wechatId), new SqlParameter("@Mobile", mobile));
        }

        public static void DoCash(int cashid)
        {
            SqlHelper.ExecuteNonQuery(connection_string, "DoCash", new SqlParameter("@CashId", cashid));
        }

        public static bool ChangePassword(int userId, string oldPass, string newPass)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "ChangePass", new SqlParameter("@UserId", userId), new SqlParameter("@OldPassword", oldPass), new SqlParameter("@NewPassword", newPass)))

            {
                if(reader.Read())
                {
                    return Convert.ToBoolean(reader[0]);
                }
            }
            return false;
        }

        public static bool PayOrder(int orderId)
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(connection_string, "PayOrder", new SqlParameter("@OrderId", orderId)))
            {
                if(reader.Read())
                {
                    return Convert.ToInt32(reader[0]) > 0;
                }
            }
            return false;
        }

        public static bool DeletePolicy(int policyId)
        {
            return SqlHelper.ExecuteNonQuery(connection_string, "DeletePolicy", new SqlParameter("@PolicyId", policyId)) > 0;
        }
    }
}
