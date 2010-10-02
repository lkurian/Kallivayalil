using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

public partial class Search : System.Web.UI.Page
{

    Dictionary<int, Color> gridCol = new Dictionary<int, Color>();
    static int rowcnt = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        grdSearch.PageIndexChanging += new GridViewPageEventHandler(grdSearch_PageIndexChanging);
        if (!Page.IsPostBack)
        {
            if (grdSearch.Rows.Count > 0)
                Label2.Visible = true;
            else
                Label2.Visible = false;
            rowcnt = -1;
        }
    }


    void grdSearch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //if (grdSearch.PageIndex > e.NewPageIndex)
        //  rowcnt -= (grdSearch.PageIndex - e.NewPageIndex) * grdSearch.PageSize;

        grdSearch.PageIndex = e.NewPageIndex;
        BindData();
        if (grdSearch.Rows.Count > 0)
        {
            int j = 0;
            int i = 0;
            rowcnt = (grdSearch.PageIndex) * grdSearch.PageSize;
            for (i = rowcnt; i < rowcnt + grdSearch.PageSize; i++, j++)
            {
                if (i < gridCol.Count)
                    grdSearch.Rows[j].ForeColor = gridCol[i];
                else
                    break;

            }
            rowcnt = i;
        }
    }


    private void BindData()
    {
        string spouseQuery = "Select 'SProfile.aspx' Page, s.SpID UserProfileID,s.FirstName,s.LastName,s.PreferredName,l.EmailAddress,u.FamilyBranch,s.MobilePhone,u.Address1, u.Address2,u.City,u.State,u.Country from tblspouse s left outer join tbluserlogin l on s.SpID=l.UserProfileID left outer join tbluserprofile u on s.SpouseID=u.UserProfileID where ";
        AccessDB dbObj = new AccessDB();
        dbObj.Open();
        dbObj.Query = "Select 'ViewProfile.aspx' Page,u.UserProfileID UserProfileID,u.FirstName,u.LastName,u.PreferredName,l.EmailAddress,u.FamilyBranch,u.HomePhone,u.Address1, u.Address2,u.City,u.State,u.Country from tbluserprofile u left outer join tbluserlogin l on u.UserProfileID=l.UserProfileID where ";
        string searchOperator = rdlMatchOption.SelectedValue;
        if (ddlFamilyBranch.SelectedValue != string.Empty)
        {
            dbObj.Query += string.Format(" FamilyBranch= '{0}' {1}"
                                               , ddlFamilyBranch.SelectedValue, searchOperator);
            spouseQuery += string.Format(" FamilyBranch= '{0}' {1}"
                                               , ddlFamilyBranch.SelectedValue, searchOperator);
        }
        if (txtName.Text != string.Empty)
        {
            dbObj.Query += string.Format(" (u.FirstName like '%{0}%' OR u.LastName like '%{0}%' OR u.PreferredName like '%{0}%') {1}"
                                               , txtName.Text, searchOperator);
            spouseQuery += string.Format(" (s.FirstName like '%{0}%' OR s.LastName like '%{0}%' OR s.PreferredName like '%{0}%') {1}"
                                               , txtName.Text, searchOperator);
        }


        if (txtPlace.Text != string.Empty)
        {
            dbObj.Query += string.Format(" (Country like '%{0}%' OR State like '%{0}%' OR City like '%{0}%' OR Address1 like '%{0}%' OR Address2 like '%{0}%') {1}", txtPlace.Text, searchOperator);
            spouseQuery += string.Format(" (Country like '%{0}%' OR State like '%{0}%' OR City like '%{0}%' OR Address1 like '%{0}%' OR Address2 like '%{0}%') {1}", txtPlace.Text, searchOperator);
        }


        if (dbObj.Query.EndsWith(searchOperator))
            dbObj.Query = dbObj.Query.Substring(0, dbObj.Query.Length - searchOperator.Length);
        else
            dbObj.Query = dbObj.Query.Substring(0, dbObj.Query.Length - 6);

        if (spouseQuery.EndsWith(searchOperator))
            spouseQuery = spouseQuery.Substring(0, spouseQuery.Length - searchOperator.Length);
        else
            spouseQuery = spouseQuery.Substring(0, spouseQuery.Length - 6);

        dbObj.Query = dbObj.Query + " union " + spouseQuery;
        dbObj.ExecuteQuery();

        grdSearch.DataSource = dbObj.Dataset;
        grdSearch.DataBind();

        //setting the color for the ppl who have passed away
        dbObj.Dataset.Reset();
        dbObj.Query = "select isdead from tbluserprofile where";
        searchOperator = rdlMatchOption.SelectedValue;
        if (ddlFamilyBranch.SelectedValue != string.Empty)
        {
            dbObj.Query += string.Format(" FamilyBranch= '{0}' {1}"
                                               , ddlFamilyBranch.SelectedValue, searchOperator);
        }
        if (txtName.Text != string.Empty)
        {
            dbObj.Query += string.Format(" (FirstName like '%{0}%' OR LastName like '%{0}%' OR PreferredName like '%{0}%') {1}"
                                               , txtName.Text, searchOperator);
        }


        if (txtPlace.Text != string.Empty)
        {
            dbObj.Query += string.Format(" (Country like '%{0}%' OR State like '%{0}%' OR City like '%{0}%' OR Address1 like '%{0}%' OR Address2 like '%{0}%') {1}", txtPlace.Text, searchOperator);
        }


        if (dbObj.Query.EndsWith(searchOperator))
            dbObj.Query = dbObj.Query.Substring(0, dbObj.Query.Length - searchOperator.Length);
        else
            dbObj.Query = dbObj.Query.Substring(0, dbObj.Query.Length - 6);
        dbObj.ExecuteQuery();

        for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
        {
            if ((short)dbObj.Dataset.Tables[0].Rows[i][0] == 1)
                gridCol.Add(i, Color.Red);
            else
                gridCol.Add(i, Color.Black);
        }
        if (grdSearch.Rows.Count > 0)
            Label2.Visible = true;
        else
            Label2.Visible = false;
    }

    protected void SearchBtn_Click(object sender, ImageClickEventArgs e)
    {
        gridCol.Clear();
        BindData();
        if (grdSearch.Rows.Count > 0)
        {
            int j = 0;
            int i = 0;
            rowcnt = (grdSearch.PageIndex) * grdSearch.PageSize;
            for (i = rowcnt; i < rowcnt + grdSearch.PageSize; i++,j++)
            {
                if(i < gridCol.Count)
                grdSearch.Rows[j].ForeColor = gridCol[i];
               
            }
            rowcnt = i;
        }
    }


   
}
