using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ViewEvents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            refreshGrid();
    }

    protected void d3_TextChanged(object sender, EventArgs e)
    {
        refreshGrid();
    }
    protected void GridView1_OnPageIndexChanging(object sender, EventArgs e)
    {
        refreshGrid();
    }
    protected void d4_TextChanged(object sender, EventArgs e)
    {
        refreshGrid();
    }


    private void refreshGrid()
    {
        DataSet ds = new DataSet();
        ds.Tables.Add(new DataTable());

        DataTable dt = new DataTable();
        dt.Columns.Add("EventName");
        dt.Columns.Add("EventType");
        dt.Columns.Add("EventDetails");
        dt.Columns.Add("EventDate");
        dt.Columns.Add("ContactPerson");
        dt.Columns.Add("ContactNumber");

        AccessDB dbobj = new AccessDB();
        dbobj.Open();
        //if (d3.Text == string.Empty)
        //    d3.Text = "01.01.2000";
        //if (d4.Text == string.Empty)
        //    d4.Text = "12.31.2030";
        string whereclause = string.Empty;
        if (d3.Text != string.Empty && d4.Text != string.Empty)
            whereclause = string.Format(" where eventdate between STR_TO_DATE('{0}','%M %d, %Y')  and STR_TO_DATE('{1}','%M %d, %Y')", d3.Text, d4.Text);
        dbobj.Dataset.Reset();

        dbobj.Query = string.Format("Select SocialEventID,eventname as EventName,eventtype as EventType,eventdetails as EventDetails,startdate as StartDate,DATE_FORMAT(eventdate, '%a %d %b, %Y') as EventDate,contactperson as ContactPerson,contactnumber as ContactNumber,ispublic,updatedby,DATE_FORMAT(updateddate,'%d/%m/%y') as updateddate from tblspecialevents" + whereclause);
        dbobj.ExecuteQuery();

        for (int i = 0; i < dbobj.Dataset.Tables[0].Rows.Count; i++)
        {
            dt.ImportRow(dbobj.Dataset.Tables[0].Rows[i]);
        }

        GridView1.DataSource = dt;
        GridView1.DataBind();
        dbobj.Close();
    }
}
