using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

public partial class ActivateUser : System.Web.UI.Page
{
    Double sessionId;
    AccessDB dbObj;
    static int selRowIndex;
    protected void Page_Load(object sender, EventArgs e)
    {
        noMatchLbl.Visible = false;
        string UserName = (string)Session["UserLogin"];
        if (UserName == null)
        {
            Session.Add("PageToLoad", "http://www.Kallivayalil.com/ActivateUser.aspx");
            Session.Add("UserRegID", long.Parse(Request.Params["UserRegID"]));
            Response.Redirect("default.aspx");
        }
        else
        {
            if (Request.Params["UserRegID"] != null)
                Session.Add("UserRegID", long.Parse(Request.Params["UserRegID"]));

            // get the user at the profileID from the tbluserregisteration.
            dbObj = new AccessDB();
            dbObj.Open();

            dbObj.Query = string.Format(@"select firstname,lastname,familybranch,borninto from tbluserregisteration 
                                        where userregisterationid={0}"
                                        , Session["UserRegID"]);
            dbObj.ExecuteQuery();
            Session.Add("FirstName", dbObj.Dataset.Tables[0].Rows[0][0].ToString());
            Session.Add("LastName", dbObj.Dataset.Tables[0].Rows[0][1].ToString());
            Session.Add("Branch", dbObj.Dataset.Tables[0].Rows[0][2].ToString());
            Session.Add("Borninto", dbObj.Dataset.Tables[0].Rows[0][3].ToString());
            dbObj.Close();

            if (Session["Borninto"].ToString() == "B")
            {
                dbObj.Open();
                dbObj.Dataset.Reset();
                dbObj.Query = string.Format(@"SELECT Salutation, FirstName, LastName, 
                                             PreferredName, FamilyBranch,  City, State, Pincode,Country, 
                                             HomePhone,UserProfileID  FROM tbluserprofile WHERE (((tbluserprofile.FirstName like '%{0}%') 
                                            or (tbluserprofile.LastName like '%{1}%') or (tbluserprofile.FamilyBranch = '{2}')) and IsActive!=1) "
                                            , Session["FirstName"], Session["LastName"], Session["Branch"]);
                dbObj.ExecuteQuery();
                GridView1.DataSource = dbObj.Dataset.Tables[0];
                GridView1.DataBind();
                dbObj.Close();
            }
            else
            {
                dbObj.Open();
                dbObj.Dataset.Reset();
                dbObj.Query = string.Format(@"SELECT tblspouse.Salutation, tblspouse.FirstName, tblspouse.LastName, 
                                             tblspouse.PreferredName, tblspouse.Familyname,  tbluserprofile.City, tbluserprofile.State, tbluserprofile.Pincode,tbluserprofile.Country, 
                                             tblspouse.mobilePhone,SpID as UserProfileID  FROM tblspouse,tbluserprofile WHERE (tbluserprofile.userprofileid=tblspouse.spouseid and ((tblspouse.FirstName like '%{0}%') 
                                            or (tblspouse.LastName like '%{1}%') ) and (tblspouse.IsActive!=1 or tblspouse.IsActive is null )) "
                                            , Session["FirstName"], Session["LastName"]);
                dbObj.ExecuteQuery();
                GridView1.DataSource = dbObj.Dataset.Tables[0];
                GridView1.DataBind();
                dbObj.Close();
            }


        }

    }


    protected void Activatebtn_Click(object sender, EventArgs e)
    {
        //sets the selected profile ID and proceeds to the confirmActivation Page.

        string temp = string.Empty;
        string s = System.Configuration.ConfigurationSettings.AppSettings["temp"];
        if (UsersSelectedIndex != -1)
        {
            int selectedProfileID =Convert.ToInt32(GridView1.DataKeys[UsersSelectedIndex].Values["UserProfileID"]);
            
            Session.Add("SelectedProfileID", selectedProfileID);
            Response.Redirect("LinkProfile.aspx");
        }
       else
        {
//            Session.Add("SelectedProfileID", GridView1.SelectedRow.Cells[1].Text);
            Response.Redirect("LinkProfile.aspx");
        }

    }

    private int UsersSelectedIndex
    {
        get
        {
            if (string.IsNullOrEmpty(Request.Form["rsGroup"]))
                return -1;
            else
                return Convert.ToInt32(Request.Form["rsGroup"]);
        }
    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Grab a reference to the Literal control
            Literal output = (Literal)e.Row.FindControl("RadioButtonMarkup");

            // Output the markup except for the "checked" attribute
            output.Text = string.Format(@"<input type='radio' name='rsGroup' id='RowSelector{0}' value='{0}'", e.Row.RowIndex);

            // See if we need to add the "checked" attribute
            if (UsersSelectedIndex == e.Row.RowIndex)
                output.Text += @" checked='checked'";

            // Add the closing tag
            output.Text += " />";
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (selRowIndex == -1)
            selRowIndex = GridView1.SelectedIndex;
        else
            GridView1.Rows[selRowIndex].BackColor = Color.White;
        GridView1.SelectedRow.BackColor = Color.Gold;
    }
    protected void Rejectbtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("RejectUser.aspx");
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count == 0)
        {
            noMatchLbl.Visible = true;
        }
    }
}