<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Event.aspx.cs" Inherits="Event" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">        
        <div>
            <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="True"
                OnLoad="DetailsView1_Load" DataSourceID="Event1">
            </asp:DetailsView>
            <asp:SqlDataSource ID="Event1" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="Select * from tblspecialevents where eventname =? and eventdate=?">
                <SelectParameters>
                    <asp:SessionParameter Name="?" SessionField="EventName" />
                    <asp:SessionParameter Name="?" SessionField="EventDate" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
