using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ForgotPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        VerificationLbl.Visible = false;
    }
    protected void SubmitBtn_Click(object sender, EventArgs e)
    {
        AccessDB dbObj = new AccessDB();
        dbObj.Open();
        dbObj.Query = string.Format("Select emailaddress,CAST( AES_DECRYPT( passwd, 'kalli' ) AS CHAR( 100 ) ) from tbluserlogin where emailaddress ='{1}'", Constants.AESKey, UserNameTbx.Text);
        dbObj.ExecuteQuery();

        if (dbObj.Dataset.Tables[0].Rows.Count > 0)
        {
            Mail mailObj = new Mail();
            mailObj.To = UserNameTbx.Text;
            mailObj.Subject = "Reply: Forgot Password Request";
            mailObj.MailBody = string.Format("Dear Ma'am/Sir, \r\n Username:{0} \r\n Password:{1} \r\n Regards, \r\n Admin team.", UserNameTbx.Text, dbObj.Dataset.Tables[0].Rows[0][1]);
            mailObj.SendMailMessage();

            VerificationLbl.Text = "Your password has been sent to your email.";
            VerificationLbl.Visible = true;
        }
        else
        {
            VerificationLbl.Text = "The UserName provided is not valid.Kindly verify and retry / contact the Admin Team.";
            VerificationLbl.Visible = true;
        }
        dbObj.Close();
    }
}
