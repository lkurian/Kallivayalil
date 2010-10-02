<%@ Page Language="C#" MasterPageFile="~/Dummy.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs"
    Inherits="ForgotPassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">
        <div style="height: 262px; margin-bottom: 113px; width: 549px;">
            <p>
                <b>Steps to Retrieve Password</b>
                <ol>
                    <li>Enter the EmailID that you use to login.</li>
                    <li>The system will verify if you are an activated user.</li>
                    <li>You will then receive an email with the requested password.</li>
                    <li>Note: If you do not receive the email, you can contact us.</li></ol>
            <asp:Label ID="usernamelbl" runat="server" 
                style="z-index: 1; left: 312px; top: 246px; position: absolute" 
                Text="UserName :"></asp:Label>
            <asp:TextBox ID="UserNameTbx" runat="server" 
                style="z-index: 1; left: 416px; top: 241px; position: absolute; width: 136px"></asp:TextBox>
            <asp:Button ID="SubmitBtn" runat="server" onclick="SubmitBtn_Click" 
                style="z-index: 1; left: 388px; top: 301px; position: absolute; width: 77px" 
                Text="Submit" />
            <asp:Label ID="VerificationLbl" runat="server" ForeColor="#FF3300" 
                style="z-index: 1; left: 272px; top: 353px; position: absolute" 
                Text="Your password has been sent to your email."></asp:Label>
            </p>
        </div>
    </div>
</asp:Content>
