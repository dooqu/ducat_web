using System;
using System.Collections.Generic;
using System.Text;
using Modal;
using DAL;

namespace BLL
{
    public class Users
    {
        public static List<UserInfo> GetAll(int pageIndex, int pageSize, out int pageTotal)
        {
            return DataProvider.GetUsers(pageIndex, pageSize, out pageTotal);
        }
    }
}
