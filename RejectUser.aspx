<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="~/RejectUser.aspx.cs" Inherits="RejectUser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contents">
        <asp:Label ID="rejectReasonLbl" runat="server" 
            style="position: absolute; z-index: 1; left: 328px; top: 214px" 
            Text="Reason of Reject :"></asp:Label>
        <asp:TextBox ID="rejectReasonTbx" runat="server" 
            style="z-index: 1; left: 474px; top: 217px; position: absolute; height: 118px; width: 273px" 
            TextMode="MultiLine"></asp:TextBox>
        <asp:Button ID="rejectBtn" runat="server" Height="30px" 
            style="position: relative; top: 297px; left: 183px" 
            Text="Sent Reject Mail" Width="150px" onclick="rejectBtn_Click" />
        <asp:Label ID="confirmRejectLbl" runat="server" ForeColor="Red" 
            style="z-index: 1; left: 446px; top: 457px; position: absolute" 
            Text="Reject Mail has been sent to the user"></asp:Label>
    </div>
</asp:Content>
