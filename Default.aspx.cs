using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Default : System.Web.UI.Page
{
    AccessDB dbObj;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserLogin"] == null)
            {

                lnkAddEvent.Visible = false;
                lnkModifyEvent.Visible = false;
                lnkViewAll.Visible = false;
            }
            Repeater1.DataSource = GetData();
            Repeater1.DataBind();
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["UserLogin"] != null )
        {
            this.Page.MasterPageFile = "MasterPage.master";            
               
        }
        
    }

    public DataSet GetData()
    {
        string eventQuery = string.Empty;
        if (Session["UserLogin"] != null)
        {
            eventQuery = "Select eventname, eventdate, eventtype, eventdetails from tblspecialevents ";
        }
        else
        {
            eventQuery = "Select eventname, eventdate, eventtype, eventdetails from tblspecialevents where IsPublic=1";
        }

        dbObj = new AccessDB();
        dbObj.Open();

        dbObj.Query = eventQuery;
        dbObj.ExecuteQuery();

        DataSet ds = new DataSet();
        DataTable dt = new DataTable("News");
        DataRow dr;
        dt.Columns.Add(new DataColumn("Id", typeof(Int32)));
        dt.Columns.Add(new DataColumn("Url", typeof(string)));
        dt.Columns.Add(new DataColumn("Desc", typeof(string)));
        string eventImage="images/celebration.gif";
        string eventTitle = string.Empty;
        string eventDetails = string.Empty;
        string eventType = string.Empty;
        DateTime dtobj = DateTime.Now;
        for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
        {
            

            dr = dt.NewRow();
            dr[0] = i + 1;
            dtobj = (DateTime)dbObj.Dataset.Tables[0].Rows[i][1];
            eventTitle = String.Format("{0} on {1}/{2}/{3}<br/>", dbObj.Dataset.Tables[0].Rows[i][0], dtobj.Day, dtobj.Month, dtobj.Year);
            eventDetails = String.Format("<u>Event Details</u>:<br/> {0}", dbObj.Dataset.Tables[0].Rows[i][3]);
            eventType = dbObj.Dataset.Tables[0].Rows[i][2].ToString();
            eventImage=GetEventImage(eventType);
            dr[1] = string.Format("javascript:openQuickAddDialog(1000, 101, '{0}','{1}','{2}');", eventTitle, eventDetails, eventImage);
            //dr[1] = string.Format("Event.aspx?EventName={0}&EventDate={3}-{2}-{1}", dbObj.Dataset.Tables[0].Rows[i][0], dtobj.Day, dtobj.Month, dtobj.Year);

            dr[2] = eventTitle;
            dt.Rows.Add(dr);
        }
        ds.Tables.Add(dt);
        Session["dt"] = dt;
        dbObj.Close();
        return ds;
    }

    private string GetEventImage(string eventType)
    {
        string eventImage = "images/celebration.gif";
        if (eventType == "Graduation")
            eventImage = "images/Grad-Cap.png";
        else if (eventType == "Wedding/Engagement")
            eventImage = "images/wedding.jpg";
        else if (eventType == "Award/Achievements")
            eventImage = "images/Awards.gif";
        else if (eventType == "Kudumayogam")
            eventImage = "images/icon_k.gif";
        else if (eventType == "Death Anniversary" || eventType == "Death Announcement")
            eventImage = "images/cross_01.jpg";
        else if (eventType == "General Meetings")
            eventImage = "images/annual-meeting.png";   
        else if (eventType == "House Warming")
            eventImage = "images/house.png";
        else if (eventType == "Birthday")
            eventImage = "images/birthday-cake2.png";
        return eventImage;
    }
}
