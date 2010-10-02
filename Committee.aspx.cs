using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Committee : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            loadGridView(DateTime.Now.Year.ToString());
         
        }

        AccessDB dbObj = new AccessDB();
            
        if (Session["Userlogin"] != null && Session["Userlogin"].ToString() != string.Empty)
        {

            dbObj.Open();
            dbObj.Query = "select emailaddress from tbluserlogin,tblcommittee where memberprofileid=userprofileid";
            dbObj.ExecuteQuery();
            Session["Committee"] = 0;
            for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
            {
                if (Session["Userlogin"].Equals(dbObj.Dataset.Tables[0].Rows[i][0]))
                    Session["Committee"] = 1;
            }

            if ((short)Session["IsAdmin"] == 1 || (int)Session["Committee"] == 1)
                uploadDiv.Visible = true;

            dbObj.Dataset.Reset();
            dbObj.Query = "select filename from tblfiles where visible=true";
            dbObj.ExecuteQuery();
            if (!Page.IsPostBack)
            {
                downloadList.Items.Clear();
                for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
                {
                    downloadList.Items.Add(dbObj.Dataset.Tables[0].Rows[i][0].ToString());
                }
            }
            dbObj.Close();

        }
        else
        {
            dbObj.Open();
            dbObj.Dataset.Reset();
            dbObj.Query = "select filename from tblfiles where visible=true and membersonly=false";
            dbObj.ExecuteQuery();
            if (!Page.IsPostBack)
            {
                downloadList.Items.Clear();
                for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
                {
                    downloadList.Items.Add(dbObj.Dataset.Tables[0].Rows[i][0].ToString());
                }
            }
            dbObj.Close();

        }
        if (downloadList.Items.Count == 0)
        {
            downloadList.Visible = false;
            Button2.Visible = false;
        }
        else
        {
            downloadList.Visible = true;
            Button2.Visible = true;
        }
    }

    protected void cmdUploadFile_Click(object sender, EventArgs e)
    {
        int index = uplTheFile.PostedFile.FileName.LastIndexOf('\\');
        string strFileNameOnServer = uplTheFile.PostedFile.FileName.Substring(index + 1, uplTheFile.PostedFile.FileName.Length - 1 - index);
        string appDataPath = HttpContext.Current.Server.MapPath("~/App_Data");
        if (string.IsNullOrEmpty(strFileNameOnServer))
        { lblInformation.Visible = true; lblInformation.Text = "Error - a file name must be specified."; return; }
        if (uplTheFile.PostedFile != null)
        {
            try
            {
                uplTheFile.PostedFile.SaveAs(appDataPath + "\\" + strFileNameOnServer);
                //write the name of the file in to  the DB
                AccessDB dbObj = new AccessDB();
                dbObj.Open();
                dbObj.Dataset.Reset();
                bool members = false;
                if(membersOnly.SelectedValue =="Yes")
                    members=true;
                dbObj.Query = string.Format(@"insert into tblfiles (filename,membersonly,uploaddate,owner) values ('{0}',{1},curdate(),'{2}')"
                    , strFileNameOnServer, members, Session["Userlogin"].ToString());
                dbObj.ExecuteNonQuery();
                dbObj.Close();
                lblInformation.Visible = false;
                downloadList.Items.Add(strFileNameOnServer);
            }
            catch (Exception ex)
            {
                lblInformation.Visible = true;
                lblInformation.Text = "Error saving <b>" + strFileNameOnServer + "</b><br>.  " + ex.Message;
            }
            uplTheFile = null;
        }
    }


    protected void cmddownloadFile_Click(object sender, EventArgs e)
    {
        string downloadFileName = @"~\App_Data\" + downloadList.SelectedValue;
        DownloadFile(downloadFileName, true);
    }

    private void DownloadFile(string fname, bool forceDownload)
    {
        string path = Server.MapPath(fname);
        System.IO.FileInfo file = new FileInfo(path);
        if (fname != string.Empty)
        {
            if (file.Exists)
            {
                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                Response.AddHeader("Content-Length", file.Length.ToString());
                Response.ContentType = "application/octet-stream";
                Response.WriteFile(file.FullName);
                Response.End();
            }
            else
                Response.Write("This file does not exist.");
        }
        else
            Response.Write("Please provide a file to download.");
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

    private void loadGridView(string Year)
    {

        AccessDB dbObj = new AccessDB();
        dbObj.Open();
        dbObj.Query = "select memberprofileid,isborninto from tblcommittee";
        dbObj.ExecuteQuery();

        DataSet committeeDS = dbObj.Dataset.Copy();

        DataSet ds = new DataSet();
        ds.Tables.Add(new DataTable());

        DataTable dt = new DataTable("Committee");
        dt.Columns.Add("Position");
        dt.Columns.Add("Name");
        dt.Columns.Add("Email");
        dt.Columns.Add("Phone");
        for (int i = 0; i < committeeDS.Tables[0].Rows.Count; i++)
        {
            dbObj.Dataset.Reset();
            //spousetbl
            if ((short)committeeDS.Tables[0].Rows[i][1] == 0)
            {
                dbObj.Query = string.Format(@"Select position as Position,CONCAT(salutation,' ',firstname,' ',lastname) as Name ,emailaddress as Email,mobilephone as Phone from tblcommittee , 
                     tblspouse where tblspouse.Spid = tblcommittee.memberprofileid and (YEAR(startdate) < {0} and YEAR(enddate)>={0}) and tblspouse.SpID={1}", Year, committeeDS.Tables[0].Rows[i][0]);
                dbObj.ExecuteQuery();
                if (dbObj.Dataset.Tables[0].Rows.Count > 0)
                {
                    dt.ImportRow(dbObj.Dataset.Tables[0].Rows[0]);
                }
            }
            else if ((short)committeeDS.Tables[0].Rows[i][1] == 1)
            {
                dbObj.Query = string.Format(@"Select position as Position,CONCAT(salutation,' ',firstname,' ',lastname) as Name ,emailaddress as Email,homephone as Home from tblcommittee ,
                     tbluserprofile left outer join tbluserlogin  on tbluserprofile.userprofileid = tbluserlogin.userprofileid where tbluserprofile.userprofileid = tblcommittee.memberprofileid and (YEAR(startdate)< {0} and YEAR(enddate)>= {0}) and tbluserprofile.userprofileid={1}", Year, committeeDS.Tables[0].Rows[i][0]);
                dbObj.ExecuteQuery();
                if (dbObj.Dataset.Tables[0].Rows.Count > 0)
                    dt.ImportRow(dbObj.Dataset.Tables[0].Rows[0]);

            }

        }


        GridView1.DataSource = dt;
        GridView1.DataBind();


    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadGridView(DropDownList1.SelectedValue);
    }

}
