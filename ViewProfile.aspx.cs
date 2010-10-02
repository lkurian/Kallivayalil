using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((short)Session["IsAdmin"] == 1)
            Response.Redirect(string.Format("userprofile.aspx?ID={0}", Request.QueryString["ID"]));
        
        if(!Page.IsPostBack)
            Page.DataBind();
    }

    protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        multiTabs.ActiveViewIndex = Int32.Parse(menuTabs.SelectedValue);
    }

  
}
