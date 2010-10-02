using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminRegisterUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string UserName = (string)Session["UserLogin"];
        if (UserName == null)
        {
            Session.Add("PageToLoad", "http://www.Kallivayalil.com/AdminRegisterUser.aspx");            
            Response.Redirect("default.aspx");
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session.Add("UserRegID", long.Parse(GridView1.SelectedRow.Cells[1].Text));
        Response.Redirect(string.Format("ActivateUser.aspx?UserRegID = {0}", GridView1.SelectedRow.Cells[1].Text));
    }
}
