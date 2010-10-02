using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Image : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int ID=-1;
            bool isSpouse=false;
            if(Request.Params["ID"]!=null)
                ID = Convert.ToInt32(Request.Params["ID"].ToString());
            else if (Request.Params["SID"] != null)
            {
                ID = Convert.ToInt32(Request.Params["SID"].ToString());
                isSpouse=true;
            }
            else if (Session["ID"]!=null)
                ID = Convert.ToInt32(Session["ID"].ToString());
            CreateImage(ID,isSpouse);
        }

    }

    void CreateImage(int ID,bool isSpouse)
    {
        try
        {
            AccessDB dbObj = new AccessDB();
            dbObj.Open();
            if(isSpouse)
                dbObj.Query = "Select Photo from tblSpouse where SpID=" + ID;            
            else
            dbObj.Query = "Select Photo from tblUserProfile where userprofileID="+ ID;            
            byte[] _buf = (byte[])dbObj.ExecuteScalar();

            //stream it back in the HTTP response
            Response.BinaryWrite(_buf);


        }
        catch (Exception ex)
        { }
       
    }
}
