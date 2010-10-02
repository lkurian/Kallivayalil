<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="LinkProfile.aspx.cs" Inherits="LinkProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contents">        
        <div style="height: 526px">
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>" 
            ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" 
            SelectCommand="SELECT FirstName,LastName,FamilyBranch,HomePhone,Address1,Address2, City,Pincode,State, Country, EmailID,registrationdate,userregisterationid FROM tbluserregisteration WHERE (UserRegisterationID =?)">
            <SelectParameters>
                <asp:SessionParameter Name="?" SessionField="UserRegID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="ProfileDetailslbl" runat="server" 
            style="z-index: 1; left: 572px; top: 128px; position: absolute; height: 15px;" 
            Text="Selected Profile Details"></asp:Label>
    
        <asp:Label ID="NewUserLbl" runat="server" 
            style="z-index: 1; left: 307px; top: 413px; position: absolute; height: 15px;" 
            Text="New entry will be made to the Profile Table" Visible="False"></asp:Label>
    
        <asp:Label ID="UserDetailslbl" runat="server" 
            style="position: absolute; z-index: 7; left: 329px; top: 129px; height: 17px;" 
            Text="User Details"></asp:Label>
        <asp:CheckBox ID="CheckBox1" runat="server" 
            
            style="position: absolute; z-index: 2; left: 302px; top: 478px; height: 19px;" 
            Text="Admin" />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
            DataSourceID="SqlDataSource1" Height="50px" 
            
                style="position: absolute; top: 183px; left: 295px; z-index: 6; height: 196px; width: 172px;" 
                Width="125px" onpageindexchanging="DetailsView1_PageIndexChanging">
            <Fields>
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
                    SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" 
                    SortExpression="LastName" />
                <asp:BoundField DataField="FamilyBranch" HeaderText="FamilyBranch" 
                    SortExpression="FamilyBranch" />
                <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" 
                    SortExpression="HomePhone" />
                <asp:BoundField DataField="Address1" HeaderText="Address1" 
                    SortExpression="Address1" />
                <asp:BoundField DataField="Address2" HeaderText="Address2" 
                    SortExpression="Address2" />
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                <asp:BoundField DataField="Pincode" HeaderText="Pincode" 
                    SortExpression="Pincode" />
                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                <asp:BoundField DataField="Country" HeaderText="Country" 
                    SortExpression="Country" />
                <asp:BoundField DataField="EmailID" HeaderText="EmailID" 
                    SortExpression="EmailID" />
                <asp:BoundField DataField="registrationdate" HeaderText="registrationdate" 
                    SortExpression="registrationdate" />
                <asp:BoundField DataField="userregisterationid" 
                    HeaderText="userregisterationid" InsertVisible="False" 
                    SortExpression="userregisterationid" />
            </Fields>
        </asp:DetailsView>
        <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="true" 
                style="z-index: 5; left: 292px; top: 58px; position: relative; height: 197px; width: 277px" 
                onpageindexchanging="DetailsView2_PageIndexChanging">
        </asp:DetailsView>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
            
                style="position: absolute; top: 430px; left: 300px; z-index: 3; height: 50px; width: 118px;">
            <asp:ListItem>Link And Update</asp:ListItem>
            <asp:ListItem>Link</asp:ListItem>
        </asp:RadioButtonList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>" 
            ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" 
            
            SelectCommand="SELECT tbluserprofile.UserProfileID,Salutation, FirstName, MiddleName, LastName, PreferredName, Gender, FamilyBranch, HouseName, BornOn, MaritalStatus, Occupation, Employer,  AlternateEmailAddress, Address1,Address2, City, State, Pincode,Country, HomePhone, MobilePhone, Website  FROM tbluserprofile WHERE  ((UserProfileID = ?) and IsActive!=1)">
            <SelectParameters>
                <asp:SessionParameter Name="?" SessionField="SelectedProfileID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="ActivateBtn0" runat="server" onclick="ActivateBtn_Click" 
            style="position: absolute; top: 570px; left: 471px; height: 21px; width: 89px; z-index: 4;" 
            Text="Activate" />
        <asp:Button ID="RejectBtn" runat="server"  
            style="position: absolute; top: 569px; left: 588px; height: 21px; width: 89px; z-index: 4;" 
            Text="Reject" onclick="RejectBtn_Click" />
        <asp:Label ID="ConfirmLbl" runat="server" style="position: absolute; top: 600px; left: 471px; height: 15px; width: 130px; z-index: 4;" 
        Text="Activation Complete" Visible ="False" ForeColor="Red" />
    
    </div>
  </div>
  </asp:Content>