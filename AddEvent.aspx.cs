using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddEvent : System.Web.UI.Page
{
    AccessDB dbObj;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
  
    protected void AddEvntBtn_Click(object sender, EventArgs e)
    {
        dbObj = new AccessDB();
        dbObj.Open();
        bool isPublic = false;
        if (MemOnlyRb.Checked)
            isPublic = true;
        dbObj.Query = string.Format(@"insert into tblspecialevents(EventName,EventType,EventDetails,StartDate,EventDate,ContactPerson,ContactNumber,IsPublic,CreatedBy,updatedby,updateddate) values
                                    ('{0}','{1}','{2}','{3}','{4}','{5}','{6}',{7},'{8}','{8}',curdate())"
                                   , EvntNameTbx.Text, EvntTypeDdl.SelectedValue, EvntDescTbx.Text, Convert.ToDateTime(StartDtTbx.Text).ToString("yyyy-MM-dd hh:mm:ss"), Convert.ToDateTime(EndDtTbx.Text).ToString("yyyy-MM-dd hh:mm:ss"), ContactPersonTbx.Text, ContactNumTbx.Text,
                                   isPublic, Session["UserName"]);
        dbObj.ExecuteNonQuery();
        dbObj.Close();
        divSuccessLabel.Visible = true;
        divAddevent.Visible = false;
    }
}
