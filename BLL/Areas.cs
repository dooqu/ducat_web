using System;
using System.Collections.Generic;
using System.Text;
using Modal;

namespace BLL
{
    public class Areas
    {
        public static List<AreaInfo> GetAll()
        {
            return DAL.DataProvider.GetAreas();
        }
    }
}
