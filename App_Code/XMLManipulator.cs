using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;



public class NewUser
{
    public string userName;
    public string email;
    public string phNum;
    public string familyBranch;
    public string familyRelation;

    NewUser()
    {
        userName = string.Empty;
        email = string.Empty;
        phNum = string.Empty;
        familyBranch = string.Empty;
        familyRelation = string.Empty;
    }
}

/// <summary>
/// Summary description for XMLManipulator
/// </summary>
public class XMLManipulator
{
    XmlDocument doc;

	public XMLManipulator()
	{
		//
		// TODO: Add constructor logic here
		//
        doc = new XmlDocument();        
	}

    public void Create_NewUserTemplate()
    {
        doc.LoadXml(@"<NewUser>
                      <UserName></UserName>
                      <Email></Email>
                      <PhNum></PhNum>
                      <FamilyBranch></FamilyBranch>
                      <FamilyRelation></FamilyRelation>
                    </NewUser>
                    ");        
    }

    public void InsertNewUserDetails(NewUser user)
    {
        XmlNode node = null;
        node = doc.SelectSingleNode("//NewUser/UserName");
        node.InnerText = user.userName;
        node = doc.SelectSingleNode("//NewUser/Email");
        node.InnerText = user.email;
        node = doc.SelectSingleNode("//NewUser/PhNum");
        node.InnerText = user.phNum;
        node = doc.SelectSingleNode("//NewUser/FamilyBranch");
        node.InnerText = user.familyBranch;
        node = doc.SelectSingleNode("//NewUser/FamilyRelation");
        node.InnerText = user.familyRelation;
    }

}
