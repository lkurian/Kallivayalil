using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class ContactUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ConfMsgLbl.Visible = false;
        
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

    protected void SubmitBtn_Click(object sender, ImageClickEventArgs e)
    {

        Mail mailObj = new Mail();
        mailObj.MailBody = CommentTB.Text;

        //Will by default have the from address as 'kallivayalil.family@gmail.com'
        mailObj.From = Session["UserLogin"].ToString();

        mailObj.Subject = string.Format("{0}:{1}", Session["UserLogin"].ToString(), ReasonDDL.SelectedValue);
        mailObj.To = ConfigurationManager.AppSettings["AdminEmail"];
        mailObj.SendMailMessage();

        #region mailToAllAdmins
        //Send to all Admins ..
        //      AccessDB dbObj = new AccessDB();
        //      dbObj.Open();

        /*dbObj.Dataset.Reset();
        dbObj.Query = string.Format(@"Select emailaddress from tbluserlogin where isadmin=true");
        dbObj.ExecuteQuery();

        for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
        {
            mailObj.To = dbObj.Dataset.Tables[0].Rows[i][0].ToString();
            mailObj.SendMailMessage();    
        }*/
        #endregion

        ConfMsgLbl.Visible = true;

    }
}
