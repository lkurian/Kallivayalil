<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Search.aspx.cs" Inherits="Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contents" style="margin: 15px;">
        <img src="images/title_search.gif" />
        <div>
            <p>
                You can search and view information about any Kallivayalil family member using the
                search form below.</p>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="FamilyBranchLbl" runat="server" Style="z-index: 1;" Text="Family Branch :"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlFamilyBranch" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem Value="Kallivayalil">Kallivayalil Kallivayalil</asp:ListItem>
                            <asp:ListItem Value="Anavalaril">Kallivayalil Anavalaril</asp:ListItem>
                            <asp:ListItem Value="Kondooparambil">Kallivayalil Kondooparambil</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 30px;">
                    </td>
                    <td>
                        <asp:Label ID="lblPlace" runat="server" Style="z-index: 1;" Text="Place (City/State/Country) :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPlace" runat="server" Style="z-index: 1;"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="NameLbl" runat="server" Style="z-index: 1;" Text="Name :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Style="z-index: 1;"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Style="z-index: 1;" Text="Search Rule:"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rdlMatchOption" runat="server">
                            <asp:ListItem Value="AND" Selected="True">Match ALL the above criteria</asp:ListItem>
                            <asp:ListItem Value="OR">Match ANY of the above criteria</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="SearchButton" runat="server" ImageUrl="~/images/button_search.gif"
                            Style="margin-left: 0px;" OnClick="SearchBtn_Click" />
                    </td>
                    <td>
                        <input type="image" src="images/print2.gif"  id="print" runat="server" onclick="getPrint('divSearch','Kallivayalil - Search Results');return false;">
                       </input>
                    </td>
                </tr>
               
            </table>
            <div id="divSearch">
            <asp:GridView ID="grdSearch" runat="server" AllowPaging="True" Width="90%" 
                    AllowSorting="True" CssClass="appList" CellPadding="5" EmptyDataText="Sorry! No matching results. Please change your search criteria and try again."
                EmptyDataRowStyle-Font-Bold="true" AutoGenerateColumns="false" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-Position="TopAndBottom" >
                <HeaderStyle CssClass="gridHeader" />
<PagerSettings Mode="NumericFirstLast" Position="TopAndBottom"></PagerSettings>

<EmptyDataRowStyle Font-Bold="True"></EmptyDataRowStyle>
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="Page,UserProfileID" Text="View" DataNavigateUrlFormatString="{0}?ID={1}" />
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="lblFirstName" Text='<%# Bind("FirstName") %>' runat="server"></asp:Label>
                            <asp:Label ID="lblLastName" Text='<%# Bind("LastName") %>' runat="server"></asp:Label>
                            (<asp:Label ID="lblPName" Text='<%# Bind("PreferredName") %>' runat="server"></asp:Label>)
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="emailaddress" HeaderText="Email" />
                    <asp:BoundField DataField="FamilyBranch" HeaderText="Family Branch" />
                    <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" />
                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <%#Eval("Address1") %>,<%#Eval("Address2") %><br />
                            <%#Eval("City") %>,<%#Eval("State") %>,<%#Eval("Country") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
                        <asp:Label ID="Label2" runat="server" Visible="False" 
                Text="* All family members who have passed away are indicated in Red" 
                ForeColor ="Red"></asp:Label>
        </div>
</asp:Content>
