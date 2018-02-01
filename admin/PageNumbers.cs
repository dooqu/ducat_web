using System;
using System.Collections.Generic;
using System.Web;

namespace admin
{
    public class PageControl
    {
        public class PageNumber
        {
            public int PageIndex
            {
                get; set;
            }


            public string PageText
            {
                get; set;
            }

            public bool IsCurrPage
            {
                get; set;
            }

            public bool Enabled
            {
                get; set;
            }

            public string Url
            {
                get;set;
            }
        }

        protected int pageIndex;
        protected int pageSize;
        protected int pageTotal;
        protected List<PageNumber> pageNums = new List<PageNumber>();

        public PageControl( int pageIndex, int pageSize, int pageTotal)
        {
            this.pageIndex = pageIndex;
            this.pageSize = pageSize;
            this.pageTotal = pageTotal;
            Init();
        }

        public List<PageNumber> Numbers
        {
            get
            {
                return pageNums;
            }
        }

        public void Init()
        {

            //最大的页次数量
            int maxPageNum = 11;
            int startIndex = ((pageIndex - maxPageNum / 2) < 0) ? 0 : pageIndex - maxPageNum / 2;

            int endIndex = ((startIndex + maxPageNum) > pageTotal) ? pageTotal - 1 : (startIndex + maxPageNum - 1);


            int frontAdd = maxPageNum / 2 - (endIndex - pageIndex);

            if (frontAdd > 0 && frontAdd <= maxPageNum / 2)
            {
                //如果结尾的不够5个， 那么尝试吧这个余额加载前面
                for (int i = 0; i < frontAdd; i++)
                {
                    if ((startIndex - 1) >= 0)
                        startIndex -= 1;
                }
            }

            

            PageNumber firstNumber = new PageNumber();
            firstNumber.PageText = "首页";
            firstNumber.PageIndex = 0;
            firstNumber.Enabled = pageIndex != 0;
            firstNumber.IsCurrPage = !firstNumber.Enabled;

            pageNums.Add(firstNumber);

            for (int i = startIndex; i <= endIndex; i++)
            {
                PageNumber number = new PageNumber();
                number.PageIndex = i;
                number.PageText = (i + 1).ToString();
                number.Enabled = (i != pageIndex);
                number.IsCurrPage = !number.Enabled;
                pageNums.Add(number);
            }

            PageNumber lastPage = new PageNumber();
            lastPage.PageText = "末页";
            lastPage.PageIndex = (pageTotal - 1);
            lastPage.Enabled = pageIndex < (pageTotal - 1);
            lastPage.IsCurrPage = !lastPage.Enabled;
            pageNums.Add(lastPage);
        }
    }
}