using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class External : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        AccessDB dbObj = new AccessDB();
        string userName = string.Empty;
        string paswd = string.Empty;

        //Retrieving the Username and Password entered by the user.
        userName = Login1.UserName;
        paswd = Login1.Password;

        dbObj.Open();
        dbObj.Query = string.Format("Select * from tbluserlogin where EmailAddress='{0}' and Passwd=AES_ENCRYPT('{1}','{2}')"
          , userName, paswd, Constants.AESKey);
        dbObj.ExecuteQuery();

        if (dbObj.Dataset.Tables[0].Rows.Count > 0)
        {
            //Username and pasword exists for this user.            
            Session.Add("UserLogin", userName);
            Session.Add("ID", dbObj.Dataset.Tables[0].Rows[0]["UserProfileID"]);
            Session.Add("IsAdmin", dbObj.Dataset.Tables[0].Rows[0][7]);
            Session.Add("PType", dbObj.Dataset.Tables[0].Rows[0]["ProfileType"]);
            dbObj.Dataset.Clear();
            dbObj.Close();

            dbObj.Query = string.Format("Select * from tbluserprofile where UserProfileID={0}", Session["ID"]);
            dbObj.ExecuteQuery();
            if (dbObj.Dataset.Tables[0].Rows.Count > 0)
            {
                Session.Add("UserName", dbObj.Dataset.Tables[0].Rows[0]["FirstName"] + " " + dbObj.Dataset.Tables[0].Rows[0]["LastName"]);
            }
            if (Session["PageToLoad"] != null)
            {
                Response.Redirect(Session["PageToLoad"].ToString());
                Session.Remove("PageToLoad");
            }
            else
                Response.Redirect("Default.aspx");
        }
        else
        {
            dbObj.Query = string.Format("Select * from tbluserlogin where EmailAddress='{0}'", userName);
            dbObj.ExecuteQuery();
            if (dbObj.Dataset.Tables[0].Rows.Count > 0)
            {
                //Username exists but not activated.
                dbObj.Dataset.Clear();
                dbObj.Close();
                Login1.FailureText = "Login Failed. Incorrect Login Information.";
                Login1.FailureAction = LoginFailureAction.Refresh;
            }
            else
            {
                dbObj.Query = string.Format("Select * from tbluserregisteration where EmailId='{0}'", userName);
                dbObj.ExecuteQuery();
                if (dbObj.Dataset.Tables[0].Rows.Count > 0)
                {
                    //Username exists but not activated.
                    dbObj.Dataset.Clear();
                    dbObj.Close();
                    Login1.FailureText = "Your account has not been activated by the Administrator. Sorry for the delay.";
                    Login1.FailureAction = LoginFailureAction.Refresh;
                }
                else
                {
                    Login1.FailureText = "Invalid User Name and Password.";
                    Login1.FailureAction = LoginFailureAction.Refresh;
                }
            }

        }
    }
   

    protected void LoginButton_Click(object sender, ImageClickEventArgs e)
    {
        AccessDB dbObj = new AccessDB();
        string userName = string.Empty;
        string paswd = string.Empty;



        //Retrieving the Username and Password entered by the user.
        userName = Login1.UserName;
        paswd = Login1.Password;

        dbObj.Open();
        dbObj.Query = string.Format("Select * from tbluserlogin where EmailAddress='{0}' and Passwd=AES_ENCRYPT('{1}','{2}')"
            , userName, paswd,Constants.AESKey);
        dbObj.ExecuteQuery();

        if (dbObj.Dataset.Tables[0].Rows.Count > 0)
        {
            //Username and pasword exists for this user.            
            Session.Add("UserLogin", userName);
            Session.Add("ID", dbObj.Dataset.Tables[0].Rows[0]["UserProfileID"]);
            Session.Add("IsAdmin", dbObj.Dataset.Tables[0].Rows[0][7]);
            Session.Add("PType", dbObj.Dataset.Tables[0].Rows[0]["ProfileType"]);
            dbObj.Dataset.Clear();
            dbObj.Close();

            dbObj.Query = string.Format("Select * from tbluserprofile where UserProfileID={0}", Session["ID"]);
            dbObj.ExecuteQuery();
            if (dbObj.Dataset.Tables[0].Rows.Count > 0)
            {
                Session.Add("UserName", dbObj.Dataset.Tables[0].Rows[0]["FirstName"] + " " + dbObj.Dataset.Tables[0].Rows[0]["LastName"]);
            }
            if (Session["PageToLoad"] != null)
            {
                Response.Redirect(Session["PageToLoad"].ToString());
                Session.Remove("PageToLoad");
            }
            else
                Response.Redirect("Default.aspx");
        }
        else
        {
            dbObj.Query = string.Format("Select * from tbluserlogin where EmailAddress='{0}'", userName);
            dbObj.ExecuteQuery();
            if (dbObj.Dataset.Tables[0].Rows.Count > 0)
            {
                //Username exists but not activated.
                dbObj.Dataset.Clear();
                dbObj.Close();
                Login1.FailureText = "Login Failed. Incorrect Login Information.";
                Login1.FailureAction = LoginFailureAction.Refresh;
            }
            else
            {
                dbObj.Query = string.Format("Select * from tbluserregisteration where EmailId='{0}'", userName);
                dbObj.ExecuteQuery();
                if (dbObj.Dataset.Tables[0].Rows.Count > 0)
                {
                    //Username exists but not activated.
                    dbObj.Dataset.Clear();
                    dbObj.Close();
                    Login1.FailureText = "Your account has not been activated by the Administrator. Sorry for the delay.";
                    Login1.FailureAction = LoginFailureAction.Refresh;
                }
                else
                {
                    Login1.FailureText = "Invalid User Name and Password.";
                    Login1.FailureAction = LoginFailureAction.Refresh;
                }
            }

        }
    }
}
