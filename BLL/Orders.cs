using System;
using System.Collections.Generic;
using System.Text;
using Modal;
using DAL;

namespace BLL
{
    public class Orders
    {
        public static int GetUserPayedOrdersCount(int userid)
        {
            return DataProvider.GetUserPayedOrdersCount(userid);
        }

        public static int NewOrder(OrderInfo order)
        {
            return DataProvider.NewOrder(order);
        }

        public static OrderInfo GetOrderInfoByRegId(int regid)
        {
            return DataProvider.GetOrderInfoByRegId(regid);
        }

        public static List<OrderInfo> GetUserShareOrders(int userid)
        {
            return DataProvider.GetUserShareOrders(userid);
        }

        public static List<OrderInfo> GetOrderList(int pageIndex, int pageSize, out int totalCount)
        {
            return DataProvider.GetOrders(pageIndex, pageSize, out totalCount);
        }

        public static bool PayOrder(int orderid)
        {
            return DataProvider.PayOrder(orderid);
        }
    }
}
