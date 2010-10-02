<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AdminRegisterUser.aspx.cs" Inherits="AdminRegisterUser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">
        <div style="height: 452px;width:100%">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" 
                onselectedindexchanged="GridView1_SelectedIndexChanged" 
                  EmptyDataText="No users pending activation"
                   EmptyDataRowStyle-Font-Bold="true"
                style="z-index: 1; left: 20px; top: 123px; position: relative;"  >
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="UserRegisterationID" 
                        HeaderText="RegID" InsertVisible="False" 
                        SortExpression="UserRegisterationID" />
                    <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
                        SortExpression="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="LastName" 
                        SortExpression="LastName" />
                    <asp:BoundField DataField="FamilyBranch" HeaderText="FamilyBranch" 
                        SortExpression="FamilyBranch" />
                    <asp:BoundField DataField="BornInto" HeaderText="BornInto" 
                        SortExpression="BornInto" />
                    <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" 
                        SortExpression="HomePhone" />
                    <asp:BoundField DataField="EmailID" HeaderText="EmailID" 
                        SortExpression="EmailID" />
                    <asp:BoundField DataField="Address1" HeaderText="Address" 
                        SortExpression="Address1" />
                    <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                    <asp:BoundField DataField="Country" HeaderText="Country" 
                        SortExpression="Country" />
                    <asp:BoundField DataField="Pincode" HeaderText="Pincode" 
                        SortExpression="Pincode" />
                    <asp:BoundField DataField="RegistrationDate" HeaderText="RegDate" 
                        SortExpression="RegistrationDate" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>" 
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" 
                SelectCommand="select * from tbluserregisteration"></asp:SqlDataSource>
            <asp:Label ID="Label1" runat="server" 
                style="z-index: 1; left: 305px; top: 165px; position: absolute" 
                Text="List of Non-Registered Users"></asp:Label>
        </div>
    </div>
</asp:Content>
