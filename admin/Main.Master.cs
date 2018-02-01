using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;

namespace admin
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected Modal.OperatorInfo CurrentUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            CurrentUser = HttpContext.Current.Session["USER"] as Modal.OperatorInfo;
        }

        protected string GetUsername()
        {
            if (CurrentUser != null)
                return CurrentUser.Name;

            return "";
        }
    }
}