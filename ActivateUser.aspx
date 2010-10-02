<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="~/ActivateUser.aspx.cs" Inherits="ActivateUser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div  id="print_area" class="contents">
        <div style="height: 471px">
            <br />
            </br/>
            <br />
            </br/>
            <asp:Label ID="noMatchLbl" runat="server" ForeColor="Red" 
                style="position: absolute; z-index: 2; left: 288px; top: 397px; width: 205px" 
                Text="No Matching Profiles found"></asp:Label>
            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Style="position: relative"
                Width="847px">
                <EditItemTemplate>
                    <b>FirstName:</b>
                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
                    <br />
                    <b>LastName:</b>
                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
                    <br />
                    <b>FamilyBranch:</b>
                    <asp:TextBox ID="FamilyBranchTextBox" runat="server" Text='<%# Bind("FamilyBranch") %>' />
                    <br />
                    <b>HomePhone:</b>
                    <asp:TextBox ID="HomePhoneTextBox" runat="server" Text='<%# Bind("HomePhone") %>' />
                    <br />
                    <b>Address1:</b>
                    <asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' />
                    <br />
                    <b>Address2:</b>
                    <asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' />
                    <br />
                    <b>City:</b>
                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
                    <br />
                    <b>Pincode:</b>
                    <asp:TextBox ID="PincodeTextBox" runat="server" Text='<%# Bind("Pincode") %>' />
                    <br />
                    <b>State:</b>
                    <asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
                    <br />
                    <b>Country:</b>
                    <asp:TextBox ID="CountryTextBox" runat="server" Text='<%# Bind("Country") %>' />
                    <br />
                    <b>Registrationdate:</b>
                    <asp:TextBox ID="registrationdateTextBox" runat="server" Text='<%# Bind("registrationdate") %>' />
                    <br />
                    <b>Userregisterationid:</b>
                    <asp:Label ID="userregisterationidLabel1" runat="server" Text='<%# Eval("userregisterationid") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Update" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                        CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    FirstName:
                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
                    <br />
                    LastName:
                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
                    <br />
                    FamilyBranch:
                    <asp:TextBox ID="FamilyBranchTextBox" runat="server" Text='<%# Bind("FamilyBranch") %>' />
                    <br />
                    HomePhone:
                    <asp:TextBox ID="HomePhoneTextBox" runat="server" Text='<%# Bind("HomePhone") %>' />
                    <br />
                    Address1:
                    <asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' />
                    <br />
                    Address2:
                    <asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' />
                    <br />
                    City:
                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
                    <br />
                    Pincode:
                    <asp:TextBox ID="PincodeTextBox" runat="server" Text='<%# Bind("Pincode") %>' />
                    <br />
                    State:
                    <asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
                    <br />
                    Country:
                    <asp:TextBox ID="CountryTextBox" runat="server" Text='<%# Bind("Country") %>' />
                    <br />
                    Registrationdate:
                    <asp:TextBox ID="registrationdateTextBox" runat="server" Text='<%# Bind("registrationdate") %>' />
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                        Text="Insert" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
                        CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <b>FirstName:</b>
                    <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                    <br />
                    <b>LastName:</b>
                    <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                    <br />
                    <b>FamilyBranch:</b>
                    <asp:Label ID="FamilyBranchLabel" runat="server" Text='<%# Bind("FamilyBranch") %>' />
                    <br />
                    <b>HomePhone:</b>
                    <asp:Label ID="HomePhoneLabel" runat="server" Text='<%# Bind("HomePhone") %>' />
                    <br />
                    <b>Address1:</b>
                    <asp:Label ID="Address1Label" runat="server" Text='<%# Bind("Address1") %>' />
                    <br />
                    <b>Address2:</b>
                    <asp:Label ID="Address2Label" runat="server" Text='<%# Bind("Address2") %>' />
                    <br />
                    <b>City:</b>
                    <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
                    <br />
                    <b>Pincode:</b>
                    <asp:Label ID="PincodeLabel" runat="server" Text='<%# Bind("Pincode") %>' />
                    <br />
                    <b>State:</b>
                    <asp:Label ID="StateLabel" runat="server" Text='<%# Bind("State") %>' />
                    <br />
                    <b>Country:</b>
                    <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
                    <br />
                    <b>Registrationdate:</b>
                    <asp:Label ID="registrationdateLabel" runat="server" Text='<%# Bind("registrationdate") %>' />
                    <br />
                    <b>Userregisterationid:</b>
                    <asp:Label ID="userregisterationidLabel" runat="server" Text='<%# Eval("userregisterationid") %>' />
                    <br />
                </ItemTemplate>
            </asp:FormView>
            <asp:GridView ID="GridView1" runat="server"
                Width="85%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" Style="position: relative;
                top: 3px; left: 0px;" ondatabound="GridView1_DataBound" OnRowCreated="GridView1_RowCreated" DataKeyNames="UserProfileID">
                <Columns>
                    <asp:TemplateField>
                     <ItemTemplate>
                         <asp:Literal runat="server" ID="RadioButtonMarkup" ></asp:Literal>
                     </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <SelectedRowStyle BackColor="#990000" />
            </asp:GridView>
            <asp:Button ID="Activatebtn" runat="server" OnClick="Activatebtn_Click" Style="z-index: 1;
                left: 784px; top: 527px; position: absolute" Text="Activate" CausesValidation="False"
                Height="20px" Width="60px" />
            <asp:Button ID="Rejectbtn" runat="server" Style="z-index: 1;
                left: 874px; top: 527px; position: absolute" Text="Reject" CausesValidation="False"
                Height="20px" Width="60px" onclick="Rejectbtn_Click" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT FirstName,LastName,FamilyBranch,HomePhone,Address1,Address2, City,Pincode,State, Country,registrationdate,userregisterationid FROM tbluserregisteration WHERE (UserRegisterationID =?)">
                <SelectParameters>
                    <asp:SessionParameter Name="?" SessionField="UserRegID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT tbluserprofile.UserProfileID,Salutation, FirstName, MiddleName, LastName, PreferredName, Gender, FamilyBranch, HouseName, BornOn, MaritalStatus, Occupation, Employer,  AlternateEmailAddress, Address1,Address2, City, State, Pincode,Country, HomePhone, MobilePhone, Website  FROM tbluserprofile WHERE ((tbluserprofile.FirstName = ?) AND (tbluserprofile.LastName = ?) AND (tbluserprofile.FamilyBranch = ?) and IsActive!=1) ">
                <SelectParameters>
                    <asp:SessionParameter Name="?" SessionField="FirstName" />
                    <asp:SessionParameter Name="?" SessionField="LastName" />
                    <asp:SessionParameter Name="?" SessionField="Branch" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
