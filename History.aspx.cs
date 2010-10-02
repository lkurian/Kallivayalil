using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class History : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["UserLogin"] != null)
        {
            this.Page.MasterPageFile = "MasterPage.master";
        }
        else
        {
            this.Page.MasterPageFile = "External.master";
        }
    }
}
