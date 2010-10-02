using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RejectUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        confirmRejectLbl.Visible = false;
    }
    protected void rejectBtn_Click(object sender, EventArgs e)
    {
        Mail mailObj = new Mail();
        AccessDB dbObj = new AccessDB();
        dbObj.Open();


        //Fetch the row for the registeration table.
        dbObj.Query = string.Format(@"Select emailID from tbluserregisteration 
                                    where userregisterationid={0} "
                            , Session["UserRegID"]);
        dbObj.ExecuteQuery();

        mailObj.To = dbObj.Dataset.Tables[0].Rows[0][0].ToString();
        mailObj.Subject = "Kallivayalil Account Activation Failed.";
        mailObj.MailBody = string.Format(@"Dear Ma'am/Sir , {0} The request you placed to activate 
                                        your Kallivayalil account has been reject by the admn team.
                                        {0} The reason is as follows : {1}{0} For any further queries 
                                        contact the admin team.{0} Reagards,{0} Admin Team", "\n", rejectReasonTbx.Text);
        mailObj.SendMailMessage();


        dbObj.Query = string.Format(@"select emailID from tbluserregisteration where userregisterationid={0} "
                            , Session["UserRegID"]);
        dbObj.ExecuteQuery();

        string activatedUser = dbObj.Dataset.Tables[0].Rows[0][0].ToString();

        //delete entry from the registeration table.
        dbObj.Query = string.Format(@"delete from tbluserregisteration 
                                    where userregisterationid={0} "
                                    , Session["UserRegID"]);
        dbObj.ExecuteNonQuery();


        //log details of activation.
        dbObj.Query = string.Format(@"Insert into tblEvent(Eventtype, EventDescription,EventOwner,EventTimestamp,UserAccount) 
                                    values ('{0}','{3}','{1}',curdate(),'{2}')", "Account Activation - Denied",
                                    Session["UserLogin"], activatedUser, rejectReasonTbx.Text);
        dbObj.ExecuteNonQuery();

        dbObj.Close();

        rejectReasonTbx.Text = string.Empty;
        confirmRejectLbl.Visible = true;

    }
}
