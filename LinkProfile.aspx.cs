using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Drawing;

public partial class LinkProfile : System.Web.UI.Page
{
    Double sessionId;
    AccessDB dbObj;

    bool newUser = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        string UserName = (string)Session["UserLogin"];        
        if (UserName == null)
        {
            Session.Add("PageToLoad", "http://www.kallivayalil.com/Kallivayalil/LinkProfile.aspx");
            Response.Redirect("default.aspx");
        }

        if (Session["SelectedProfileID"] == null)
        {
            ProfileDetailslbl.Visible = false;
            RadioButtonList1.Visible = false;
            NewUserLbl.ForeColor = Color.Green;
            NewUserLbl.Visible = true;
        }
        else
        {
            if (Session["Borninto"].ToString() == "B")
            {
                dbObj = new AccessDB();
                dbObj.Dataset.Reset();
                dbObj.Query = string.Format(@"SELECT tbluserprofile.UserProfileID,Salutation, FirstName, MiddleName, 
                                        LastName, PreferredName, Gender, FamilyBranch, HouseName, BornOn, MaritalStatus, 
                                        Occupation, Employer,  AlternateEmailAddress, Address1,Address2, City, State, Pincode,
                                        Country, HomePhone, MobilePhone, Website  FROM tbluserprofile WHERE  
                                        ((UserProfileID = {0}) and IsActive!=1)", Session["SelectedProfileID"]);
                dbObj.ExecuteQuery();
                DetailsView2.DataSource = dbObj.Dataset.Tables[0];
                DetailsView2.DataBind();
                dbObj.Close();

            }
            else
            {
                dbObj = new AccessDB();
                dbObj.Dataset.Reset();
                dbObj.Query = string.Format(@"SELECT tblspouse.spid,tblspouse.Salutation, tblspouse.FirstName,  
                                        tblspouse.LastName, tblspouse.PreferredName, tblspouse.Gender, tblspouse.Familyname, tblspouse.BornOn,  
                                        tbluserprofile.City, tbluserprofile.State, tbluserprofile.Pincode,
                                        tbluserprofile.Country, tbluserprofile.mobilePhone  FROM tblspouse,tbluserprofile WHERE  
                                        ((spid = {0}) and tblspouse.IsActive!=1)", Session["SelectedProfileID"]);
                dbObj.ExecuteQuery();
                DetailsView2.DataSource = dbObj.Dataset.Tables[0];
                DetailsView2.DataBind();
                dbObj.Close();
            }

        }
    }
    protected void ActivateBtn_Click(object sender, EventArgs e)
    {


        string emailID = string.Empty;
        string activatedUser = string.Empty;
        if (Session["SelectedProfileID"] != null)
            registerExistingUser(out emailID, out activatedUser);
        else
            registerNewUser(out emailID, out activatedUser);


        //send mail to activated user.

        SendMailMessage(emailID, "Kallivayalil Account Activated", "Your Account has been activated.");

        //send mail to admin who activated the account.
        SendMailMessage(Session["UserLogin"].ToString(), "Kallivayalil Account Activated"
            , string.Format("Account-{0} has been activated.", Session["SelectedProfileID"]));

        if (newUser)
        {
            //log details of activation.
            dbObj.Query = string.Format(@"Insert into tblEvent(Eventtype, EventDescription,EventOwner,EventTimestamp,UserAccount) 
                                    values ('{0}','New User registered.','{1}',curdate(),'{2}')", "Account Activation",
                                        Session["UserLogin"], activatedUser);
            newUser = false;
        }
        else
            dbObj.Query = string.Format(@"Insert into tblEvent(Eventtype, EventDescription,EventOwner,EventTimestamp,UserAccount) 
                                    values ('{0}','Registered Existing User.','{1}',curdate(),'{2}')", "Account Activation",
                                    Session["UserLogin"], activatedUser);

        dbObj.ExecuteNonQuery();

        dbObj.Close();
        RejectBtn.Enabled = false;
        ActivateBtn0.Enabled = false;
        //Label1.Text = "User has been activated";
        //Label1.ForeColor = Color.Red;
        //Label1.Visible = true;
        ConfirmLbl.Visible = true;
        Session["SelectedProfileID"] = null;
        Response.Redirect("AdminRegisterUser.aspx");

    }

    private void registerNewUser(out string emailID, out string activatedUser)
    {
        newUser = true;
        dbObj = new AccessDB();
        dbObj.Open();
        bool isAdmin = false;
        char ProfileType = 'U';
        if (CheckBox1.Checked)
            isAdmin = true;

        //Fetch the row for the registeration table.
        dbObj.Query = string.Format(@"Select borninto,emailID,passwd,firstName,LastName,FamilyBranch,HomePhone
                                ,Address1,Address2,city,state,country,pincode from tbluserregisteration 
                                    where userregisterationid={0} "
                            , Session["UserRegID"]);
        dbObj.ExecuteQuery();
        emailID = (string)dbObj.Dataset.Tables[0].Rows[0][1];
        string borninto = dbObj.Dataset.Tables[0].Rows[0][0].ToString();
        //Add entry to the profile table and set the selectedProfileID to the new entry's ID.
        
        if (dbObj.Dataset.Tables[0].Rows[0][0].ToString() == "B")
        {
            //insert into the profile table -> borninto is true
            dbObj.Query = string.Format(@"insert into tbluserprofile (firstname,lastname,familyBranch,homephone,address1,address2,city
                                         ,state,country,pincode,createddate,isactive) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}',curdate(),1)"
                                        , dbObj.Dataset.Tables[0].Rows[0][3], dbObj.Dataset.Tables[0].Rows[0][4], dbObj.Dataset.Tables[0].Rows[0][5]
                                        , dbObj.Dataset.Tables[0].Rows[0][6], dbObj.Dataset.Tables[0].Rows[0][7], dbObj.Dataset.Tables[0].Rows[0][8]
                                        , dbObj.Dataset.Tables[0].Rows[0][9], dbObj.Dataset.Tables[0].Rows[0][10], dbObj.Dataset.Tables[0].Rows[0][11]
                                        , dbObj.Dataset.Tables[0].Rows[0][12]);
            dbObj.ExecuteNonQuery();

            //fetch the last inserted userprofileid from tbluserprofile
            dbObj.Dataset.Reset();
            dbObj.Query = "select max(userprofileid) from tbluserprofile";
            dbObj.ExecuteQuery();
            Session.Add("SelectedProfileID", dbObj.Dataset.Tables[0].Rows[0][0]);
        }
        else
        {
            //insert into the spouse table when borninto is false.
            dbObj.Query = string.Format(@"insert into tblspouse (firstname,lastname,mobilephone,emailaddress,activationdate,activatedby,isactive) values ('{0}','{1}','{2}','{3}',curdate(),'{4}',1)"
                                        , dbObj.Dataset.Tables[0].Rows[0][3], dbObj.Dataset.Tables[0].Rows[0][4], dbObj.Dataset.Tables[0].Rows[0][6]
                                        , dbObj.Dataset.Tables[0].Rows[0][1],Session["UserLogin"]);
            dbObj.ExecuteNonQuery();
            //fetchin the spouseid field is an issue here ...
            //fetch the last inserted userprofileid from tbluserprofile
            dbObj.Dataset.Reset();
            dbObj.Query = "select max(spid) from tblspouse";
            dbObj.ExecuteQuery();
            Session.Add("SelectedProfileID", dbObj.Dataset.Tables[0].Rows[0][0]);
            ProfileType = 'S';

        }

       


        //Fetch the row for the registeration table.
        dbObj.Dataset.Reset();
        dbObj.Query = string.Format(@"Select borninto,emailID,passwd,firstName,LastName,FamilyBranch,HomePhone
                                ,Address1,Address2,city,state,country,pincode from tbluserregisteration 
                                    where userregisterationid={0} "
                               , Session["UserRegID"]);
        dbObj.ExecuteQuery();

        //insert a row into the tbluserlogin table.Link the profile ID to the Login table.
        string temp = string.Format(@"Insert into tbluserlogin (userprofileid,profileType,emailaddress,passwd,
                                        creationdate,updationdate,updatedby,activationdate,activatedby
                                    ,isadmin) values({0},'{6}','{1}',(select passwd as pass from tbluserregisteration where userregisterationid = {5}),curdate(),curdate(),'{2}',curdate(),'{3}',{4})",
                                    Session["SelectedProfileID"], dbObj.Dataset.Tables[0].Rows[0][1]
                                    , Session["UserLogin"], Session["UserLogin"], isAdmin, Session["UserRegID"], ProfileType);
        
        dbObj.Query = temp;
        dbObj.ExecuteNonQuery();
        isAdmin = false;
        if (borninto == "B")
        {
            if (RadioButtonList1.Items[0].Selected)
            {

                //update isactive,updation date,updated by in tbluserprofile.
                dbObj.Query = string.Format(@"Update tbluserprofile set Isactive=true,createddate=curdate()
                                    ,updateddate=curdate(),updatedby='{0}',firstName='{2}',lastName='{3}',FamilyBranch='{4}',HomePhone='{5}'
                                    ,Address1='{6}',Address2='{7}',city='{8}',state='{9}',country='{10}',pincode='{11}' where UserProfileID = {1}"
                                            , Session["UserLogin"], Session["SelectedProfileID"], dbObj.Dataset.Tables[0].Rows[0][2]
                                            , dbObj.Dataset.Tables[0].Rows[0][3], dbObj.Dataset.Tables[0].Rows[0][4], dbObj.Dataset.Tables[0].Rows[0][5]
                                            , dbObj.Dataset.Tables[0].Rows[0][6], dbObj.Dataset.Tables[0].Rows[0][7], dbObj.Dataset.Tables[0].Rows[0][8]
                                            , dbObj.Dataset.Tables[0].Rows[0][9], dbObj.Dataset.Tables[0].Rows[0][10], dbObj.Dataset.Tables[0].Rows[0][11]);
                dbObj.ExecuteNonQuery();
            }
            else if (RadioButtonList1.Items[1].Selected)
            {
                //update isactive,updation date,updated by in tbluserprofile.
                dbObj.Query = string.Format(@"Update tbluserprofile set Isactive=true,createddate=curdate()
                                    ,updateddate=curdate(),updatedby='{0}' where UserProfileID = {1}"
                                            , Session["UserLogin"], Session["SelectedProfileID"]);
                dbObj.ExecuteNonQuery();

            }
        }
        else if (borninto == "M")
        {

            if (RadioButtonList1.Items[0].Selected)
            {

                //update isactive,updation date,updated by in tbluserprofile.
                dbObj.Query = string.Format(@"Update tblspouse set Isactive=true
                                    ,updateddate=curdate(),updatedby='{0}',firstName='{2}',lastName='{3}',mobilePhone='{4}'
                                    emailID='{5}' where UserProfileID = {1}"
                                            , Session["UserLogin"], Session["SelectedProfileID"], dbObj.Dataset.Tables[0].Rows[0][2]
                                            , dbObj.Dataset.Tables[0].Rows[0][3], dbObj.Dataset.Tables[0].Rows[0][5], dbObj.Dataset.Tables[0].Rows[0][0]
                                          );
                dbObj.ExecuteNonQuery();
            }
            else if (RadioButtonList1.Items[1].Selected)
            {
                //update isactive,updation date,updated by in tbluserprofile.
                dbObj.Query = string.Format(@"Update tblspouse set Isactive=true,activationdate=curdate(),activatedby = '{0}'
                                    ,updateddate=curdate(),updatedby='{0}' where UserProfileID = {1}"
                                            , Session["UserLogin"], Session["SelectedProfileID"]);
                dbObj.ExecuteNonQuery();

            }
        }

        dbObj.Dataset.Reset();
        dbObj.Query = string.Format(@"select emailID from tbluserregisteration where userregisterationid={0} "
                                    , Session["UserRegID"]);
        dbObj.ExecuteQuery();

        activatedUser = dbObj.Dataset.Tables[0].Rows[0][0].ToString();

        //delete entry from the registeration table.
        dbObj.Query = string.Format(@"delete from tbluserregisteration 
                                    where userregisterationid={0} "
                                    , Session["UserRegID"]);
        dbObj.ExecuteNonQuery();


    }

    private void registerExistingUser(out string emailID, out string activatedUser)
    {

        dbObj = new AccessDB();
        dbObj.Open();
        bool isAdmin = false;
        char ProfileType = 'U';
        //Fetch the row for the registeration table.
        dbObj.Query = string.Format(@"Select borninto,emailID,passwd,firstName,LastName,FamilyBranch,HomePhone
                                ,Address1,Address2,city,state,country,pincode from tbluserregisteration 
                                    where userregisterationid={0} "
                            , Session["UserRegID"]);
        dbObj.ExecuteQuery();


        if (CheckBox1.Checked)
            isAdmin = true;

        if (dbObj.Dataset.Tables[0].Rows[0][0].ToString() == "M")
            ProfileType = 'S';

        //insert a row into the tbluserlogin table.Link the profile ID to the Login table.
        string temp = string.Format(@"Insert into tbluserlogin (userprofileid,profiletype,emailaddress,passwd,
                                        creationdate,updationdate,updatedby,activationdate,activatedby
                                    ,isadmin) values({0},'{6}','{1}',(select passwd as pass from tbluserregisteration where userregisterationid = {5}),curdate(),curdate(),'{2}',curdate(),'{3}',{4})",
                                    Session["SelectedProfileID"], dbObj.Dataset.Tables[0].Rows[0][1]
                                    , Session["UserLogin"], Session["UserLogin"], isAdmin, Session["UserRegID"],ProfileType);
        emailID = (string)dbObj.Dataset.Tables[0].Rows[0][1];
        dbObj.Query = temp;
        dbObj.ExecuteNonQuery();
        isAdmin = false;

        if (RadioButtonList1.Items[0].Selected)
        {

            //update isactive,updation date,updated by in tbluserprofile.
            dbObj.Query = string.Format(@"Update tbluserprofile set Isactive=true,createddate=curdate()
                                    ,updateddate=curdate(),updatedby='{0}',firstName='{2}',lastName='{3}',FamilyBranch='{4}',HomePhone='{5}'
                                    ,Address1='{6}',Address2='{7}',city='{8}',state='{9}',country='{10}',pincode='{11}' where UserProfileID = {1}"
                                        , Session["UserLogin"], Session["SelectedProfileID"], dbObj.Dataset.Tables[0].Rows[0][4]
                                        , dbObj.Dataset.Tables[0].Rows[0][5], dbObj.Dataset.Tables[0].Rows[0][6], dbObj.Dataset.Tables[0].Rows[0][7]
                                        , dbObj.Dataset.Tables[0].Rows[0][8], dbObj.Dataset.Tables[0].Rows[0][9], dbObj.Dataset.Tables[0].Rows[0][10]
                                        , dbObj.Dataset.Tables[0].Rows[0][11], dbObj.Dataset.Tables[0].Rows[0][12], dbObj.Dataset.Tables[0].Rows[0][13]);
            dbObj.ExecuteNonQuery();
        }
        else if (RadioButtonList1.Items[1].Selected)
        {
            //update isactive,updation date,updated by in tbluserprofile.
            dbObj.Query = string.Format(@"Update tbluserprofile set Isactive=true,createddate=curdate()
                                    ,updateddate=curdate(),updatedby='{0}' where UserProfileID = {1}"
                                        , Session["UserLogin"], Session["SelectedProfileID"]);
            dbObj.ExecuteNonQuery();

        }

        dbObj.Query = string.Format(@"select emailID from tbluserregisteration where userregisterationid={0} "
                                    , Session["UserRegID"]);
        dbObj.ExecuteQuery();

        activatedUser = dbObj.Dataset.Tables[0].Rows[0][0].ToString();

        //delete entry from the registeration table.
        dbObj.Query = string.Format(@"delete from tbluserregisteration 
                                    where userregisterationid={0} "
                                    , Session["UserRegID"]);
        dbObj.ExecuteNonQuery();


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


    protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
    {

    }
    protected void RejectBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("RejectUser.aspx");
    }
    protected void DetailsView2_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
    {

    }
}
