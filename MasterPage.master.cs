using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected string UserName = string.Empty;
    protected int ID;
    protected string PType = string.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["UserName"] != null)
        {
            UserName = Session["UserLogin"].ToString();
            ID = Convert.ToInt32(Session["ID"].ToString());
            PType = Session["PType"].ToString();
            if ((short)Session["IsAdmin"]==1)
                LinkButtonRegUser.Visible = true;            

        }
        else
            Response.Redirect("default.aspx", true);       
    }

    protected void lnkProfile_Click(object sender, EventArgs e)
    {
       if(Session["PType"].ToString()=="U")
           Response.Redirect("UserProfile.aspx", true);  
       else
           Response.Redirect("MySProfile.aspx", true);  
    }

    protected void lnkLogout_LoggingOut(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Default.aspx", true);
    }

    protected void LinkButtonRegUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminRegisterUser.aspx", true);  
    }
}
