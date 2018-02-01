using System;
using System.Collections.Generic;
using System.Text;

namespace Modal
{
    public class OptionsInfo : ResponseInfo
    {
        public string[] Titles
        {
            get;set;
        }

        public int[] Metrix
        {
            get;set;
        }

        public int[] Prices
        {
            get;set;
        }

        public string[] Comments
        {
            get;set;
        }
    }
}
