using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Event : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Add("EventName", Request.Params["EventName"]);
        Session.Add("EventDate", Request.Params["EventDate"]);
    }

    private void BindData()
    {
        AccessDB dbObj = new AccessDB();
        dbObj.Open();
        dbObj.Query = string.Format("Select * from tblspecialevents where eventname ={0} and eventdate='{1}'", Session["EventName"], Session["EventDate"]);
        dbObj.ExecuteQuery();
        DetailsView1.DataSource = dbObj.Dataset;        
        DetailsView1.DataBind();
        dbObj.Close();
       
    }

    protected void DetailsView1_Load(object sender, EventArgs e)
    {
        Session.Add("EventName", Request.Params["EventName"]);
        Session.Add("EventDate", Request.Params["EventDate"]);
        //BindData();
    }
}
