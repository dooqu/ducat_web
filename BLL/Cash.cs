using System;
using System.Collections.Generic;
using System.Text;
using DAL;
using Modal;

namespace BLL
{
    public class Cash
    {
        public static int NewCash(CashInfo cash)
        {
            return DataProvider.NewCash(cash);
        }

        public static void UpdateUserCashAccount(int userid, string wchatid, string mobile)
        {
            DataProvider.UpdateUserAccountInfo(userid, wchatid, mobile);
        }

        public static void GetUserCashStatus(int userId, out int incomeTotal, out int cashTotal, out int cashTotalPending, out int cashMoneyLeft, out string wechatId, out string mobile)
        {
            incomeTotal = 0;
            cashTotal = 0;
            cashTotalPending = 0;
            cashMoneyLeft = 0;
            wechatId = null;
            mobile = null;

            DataProvider.GetUserCashStatus(userId, out incomeTotal, out cashTotal, out cashTotalPending, out cashMoneyLeft, out wechatId, out mobile);
        }

        public static List<CashInfo> GetUserCashList(int userId)
        {
            return DataProvider.GetUserCashList(userId);
        }

        public static List<CashInfo> GetCashList(int pageIndex, int pageSize, out int totalCount)
        {
            return DataProvider.GetCashList(pageIndex, pageSize, out totalCount);
        }

        public static void DoCash(int cashid)
        {
            DataProvider.DoCash(cashid);
        }
    }
}
