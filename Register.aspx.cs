using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void SendMailMessage(string To, string subject, string mailBody)
    {
        //Builed The MSG
        System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
        msg.To.Add(To);
        msg.From = new MailAddress("kallivayalil.family@gmail.com", "Kallivayalil_Family_Website - Admin Team", System.Text.Encoding.UTF8);
        msg.Subject = subject;
        msg.SubjectEncoding = System.Text.Encoding.UTF8;
        msg.Body = mailBody;
        msg.BodyEncoding = System.Text.Encoding.UTF8;
        msg.IsBodyHtml = false;
        msg.Priority = MailPriority.High;

        //Add the Creddentials
        SmtpClient client = new SmtpClient();
        client.Credentials = new System.Net.NetworkCredential
            ("kallivayalil.family@gmail.com", "anavalaril");
        client.Port = 587;//or use 587            
        client.Host = "smtp.gmail.com";
        client.EnableSsl = true;
        object userState = msg;
        try
        {
            //you can also call client.Send(msg)
            client.Send(msg);
        }
        catch (System.Net.Mail.SmtpException ex)
        {

        }
    }


    protected void RegisterButton_Click(object sender, EventArgs e)
    {
        AccessDB dbObj = new AccessDB();
        dbObj.Open();
        //verify if registration record already exists
        dbObj.Query = string.Format("select userregisterationid from tbluserregisteration where EmailID='{0}'", Email.Text); ;
        dbObj.ExecuteQuery();
        if (dbObj.Dataset.Tables[0].Rows.Count > 0)
        {
            ConfirmationLabel.Style.Add("color", "Red");
            ConfirmationLabel.Text = string.Format("Sorry! Our system shows an account is already registered with this email -{0}. If you have forgotten your password, use the 'Forgot Password' link to get your password.", Email.Text);
            ConfirmationLabel.Visible = true;
        }
        else
        {
            dbObj.Dataset.Reset();
            //Insert details into the db
            dbObj.Query = string.Format(@"insert into tblUserRegisteration (FirstName,LastName,FamilyBranch,BornInto,HomePhone,EmailID,Passwd,Address1,Address2,City,State,Country,Pincode,RegistrationDate)
                                    values('{0}','{1}','{2}','{3}','{4}','{5}',AES_ENCRYPT('{6}','{7}'),'{8}','{9}','{10}','{11}','{12}',{13},current_timestamp()); "
                                        , FirstName.Text, LastName.Text, FamilyBranch.SelectedValue, rdlConnection.SelectedValue, PhoneNumber.Text, Email.Text, Password.Text, Constants.AESKey, Address1.Text, Address2.Text, CityDitrict.Text, State.Text
                                        , Country.Text, int.Parse(PinCode.Text));
            dbObj.ExecuteNonQuery();

            //Get the current users' userregisterationid
            dbObj.Dataset.Reset();
            dbObj.Query = string.Format("select userregisterationid, registrationDate from tbluserregisteration where EmailID='{0}' and FirstName='{1}' and LastName='{2}'", Email.Text, FirstName.Text, LastName.Text); ;
            dbObj.ExecuteQuery();
            long UserRegID = (long)dbObj.Dataset.Tables[0].Rows[0][0];
            DateTime dtReg = (DateTime)dbObj.Dataset.Tables[0].Rows[0][1];
            //Mail to admin
            string mailBody = string.Format(Constants.AdminMailText) + Environment.NewLine + string.Format("\n\nFirstName:{0}\nLastName:{1}\nFamily:{2}\nAddress:{3}\nEmail:{4}\nHomePhone:{5}\nRegisteration Date:{6}"
                                                        , FirstName.Text, LastName.Text, FamilyBranch.Text, string.Concat(Address1.Text, ",", Address2.Text, ",", CityDitrict.Text, "-", PinCode.Text, ",", State.Text, ",", Country.Text, ","), Email.Text, PhoneNumber.Text, dtReg)
                                                        + Environment.NewLine + "http://www.Kallivayalil.com/ActivateUser.aspx?UserRegID=" + UserRegID.ToString();

            dbObj.Dataset.Reset();
            dbObj.Query = string.Format(@"Select emailaddress from tbluserlogin where isadmin=true");
            dbObj.ExecuteQuery();

            for (int i = 0; i < dbObj.Dataset.Tables[0].Rows.Count; i++)
            {
                SendMailMessage(dbObj.Dataset.Tables[0].Rows[i][0].ToString(), "RegistrationMail@Kallivayalil.com", mailBody);
            }

            //mail to user.
            mailBody = string.Empty;
            mailBody = string.Format(Constants.UserMailText) + Environment.NewLine + string.Format("\n\nFirstName:{0}\nLastName:{1}\nFamily:{2}\nAddress:{3}\nEmail:{4}\nHomePhone:{5}\nRegistration Date:{6}"
                                                        , FirstName.Text, LastName.Text, FamilyBranch.Text, string.Concat(Address1.Text, ",", Address2.Text, ",", CityDitrict.Text, "-", PinCode.Text, ",", State.Text, ",", Country.Text, ","), Email.Text, PhoneNumber.Text, dtReg);
            SendMailMessage(Email.Text, "RegistrationMail @ Kallivayalil.com", mailBody);

            ConfirmationLabel.Style.Add("color", "Green");
            ConfirmationLabel.Text = "Thank You for registering. A confirmation email has been sent to the emailaddress you provided. We will review your information and your account will be activated at the earliest.";
            ConfirmationLabel.Visible = true;
            UserRegistration.Visible = false;
        }
        dbObj.Close();
    }
}
