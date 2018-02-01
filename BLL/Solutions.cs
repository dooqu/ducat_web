using System;
using System.Collections.Generic;
using System.Text;
using Modal;
using DAL;

namespace BLL
{
    public class Solutions
    {
        public static bool UpdateAreaSolution(AreaSolution solution)
        {
            bool allRet = true;
            for(int i = 0; i < 8; i++)
            {
                bool ret = DataProvider.UpdateSolutionInfo(solution.AreaId, i, solution[i]);

                if (ret == false)
                    allRet = false;
            }

            return allRet;
        }

        public static AreaSolution GetAreaSolution(int areaId)
        {
            return DataProvider.GetAreaSolution(areaId);
        }

        public static int NewUserAreaSolution(int userId, int areaId, int soluId, bool isSpc)
        {
            return DataProvider.NewUserAreaSolution(userId, areaId, soluId, isSpc);
        }

        public static UserSolution GetUserSolutionByUSId(int usid)
        {
            return DataProvider.GetUserSolutionByUSId(usid);
        }

        public static List<UserSolution> GetUserSolutionsByUserId(int userid)
        {
            return DataProvider.GetUserSolutionsByUserId(userid);
        }
    }
}
