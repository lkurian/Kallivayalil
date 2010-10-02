using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;

/// <summary>
/// Summary description for Mail
/// </summary>
public class Mail
{
    private string to;
    private string subject;
    private string mailBody;
    private string from;

    #region properties

    public string From
    {
        get { return from; }
        set { from = value; }
    }

    public string MailBody
    {
        get { return mailBody; }
        set { mailBody = value; }
    }

    public string Subject
    {
        get { return subject; }
        set { subject = value; }
    }

    public string To
    {
        get { return to; }
        set { to = value; }
    }

    #endregion

    public Mail()
    {
        //
        // TODO: Add constructor logic here
        //
        to = string.Empty;
        subject = string.Empty;
        from = string.Empty;
        mailBody = string.Empty;

    }
    public void SendMailMessage()
    {
        //Builed The MSG
        System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
        msg.To.Add(To);
        if (from.Equals(string.Empty))
            msg.From = new MailAddress("kallivayalil.family@gmail.com", "Kallivayalil_Family_Website - Admin Team", System.Text.Encoding.UTF8);
        else
            msg.From = new MailAddress(from, "Kallivayalil_Family_Website - Admin Team", System.Text.Encoding.UTF8);
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


}
