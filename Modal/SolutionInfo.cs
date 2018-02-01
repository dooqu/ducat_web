using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class SolutionInfo : ResponseInfo
    {
        public int SolutionId
        {
            get; set;
        }

        public int BasePrice
        {
            get; set;
        }

        public int GovPrice
        {
            get; set;
        }

        public int SpcPrice
        {
            get; set;
        }

        public int Days
        {
            get; set;
        }

        public int SpcDays
        {
            get; set;
        }
    }

    public class UserSolution : SolutionInfo
    {
        public int UserId
        {
            get;set;
        }

        public int USId
        {
            get;set;
        }

        public int AreaId
        {
            get;set;
        } 

        public string AreaName
        {
            get;set;
        }

        public string AreaNameEN
        {
            get;set;
        }

        public bool IsSpc
        {
            get;set;
        }

        public DateTime DateCreated
        {
            get;set;
        }
    }

    public class AreaSolution
    {
        public int AreaId
        {
            get;set;
        }
        protected SolutionInfo[] solutions;

        public AreaSolution()
        {
            this.solutions = new SolutionInfo[8];
        }

        public SolutionInfo this[int index]
        {
            get
            {
                if (index >= 0 && index < 8)
                    return this.solutions[index];
                return null;
            }
            set
            {
                if (index >= 0 && index < 8)
                    this.solutions[index] = value;
            }
        }
    }
}
