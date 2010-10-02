<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SProfile.aspx.cs" Inherits="SProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">
        <img src="images/title_SDetails.gif" />
        <p>
            <a href="Search.aspx">Return to Search Page</a></p>
        <asp:Menu runat="server" ID="menuTabs" Orientation="Horizontal" CssClass="menuTabs"
            OnMenuItemClick="menuTabs_MenuItemClick" ForeColor="#000" StaticHoverStyle-CssClass="hoverTab"
            StaticMenuItemStyle-ItemSpacing="3" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab">
            <Items>
                <asp:MenuItem Enabled="true" Text="Personal Information" Value="0" Selected="true">
                </asp:MenuItem>
            </Items>
        </asp:Menu>
        <div class="tabBody">
            <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server">
                <asp:View ID="PersonalView" runat="server">
                    <table width="100%">
                        <tr>
                            <td valign="top" width="50%">
                                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="SpID"
                                    DataSourceID="SqlDataSourceSpouse" Width="100%" AllowPaging="true" CellPadding="4"
                                    GridLines="None">
                                    <FieldHeaderStyle Font-Bold="true" />
                                    <Fields>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <%# string.Format("{0} {1} {2} {3} ({4})", Eval("Salutation"), Eval("FirstName"), Eval("MiddleName"), Eval("LastName"), (Eval("PreferredName").ToString().Length==0?Eval("FirstName"):Eval("PreferredName")))%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Born On">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBornOn" Text='<%# string.Format("{0:MMM dd}", Eval("BornOn")) %>'
                                                    runat="Server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
                                        <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"
                                            ReadOnly="true" />
                                        <asp:BoundField DataField="AlternateEmailAddress" HeaderText="Alternate Email" SortExpression="AlternateEmailAddress" />
                                        <asp:BoundField DataField="Occupation" HeaderText="Occupation" SortExpression="Occupation" />
                                        <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                    </Fields>
                                </asp:DetailsView>
                            </td>
                            <td valign="top" width="50%">
                                <asp:Repeater ID="rptrSpouse" runat="server" DataSourceID="SqlDataSource1">
                                    <HeaderTemplate>
                                        <b>Married to</b><br />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <a href="<%# string.Format("ViewProfile.aspx?ID={0}", Eval("UserProfileID"))%>">
                                            <%# string.Format("{0} {1} {2} {3} ({4})", Eval("Salutation"), Eval("FirstName"), Eval("MiddleName"), Eval("LastName"), (Eval("PreferredName").ToString().Length==0?Eval("FirstName"):Eval("PreferredName")))%>
                                        </a>
                                        <br />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
            <asp:SqlDataSource ID="SqlDataSourceSpouse" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT SpID, Salutation, FirstName, MiddleName, LastName, PreferredName, FamilyName, BornOn, EmailAddress,AlternateEmailAddress, MobilePhone,Occupation, Employer  FROM tblSpouse WHERE (SpID = ?)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT  u.UserProfileID, u.Salutation, u.FirstName, u.MiddleName, u.LastName, u.PreferredName, u.FamilyBranch, u.HouseName, u.BornOn, u.MaritalStatus, u.Occupation, u.Employer, l.EmailAddress, u.AlternateEmailAddress, u.Address1, u.Address2, u.City, u.State, u.Pincode,u.Country, u.HomePhone, u.MobilePhone, u.Website  FROM tbluserprofile u left outer join tbluserlogin l on u.UserProfileID=l.UserProfileID WHERE u.UserProfileID in (Select SpouseID FROM tblSpouse WHERE (SpID = ?)) ">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
