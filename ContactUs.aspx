<%@ Page Title="" Language="C#" MasterPageFile="~/External.master" AutoEventWireup="true"
    CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">
        <img src="images/title_contact.gif" />
        <p>
            Please use the form below to get in touch with the Website administrators or the
            Committee Members.
            <br />
            We look forward to suggestions and feedback from you.
        </p>
        <asp:ValidationSummary ID="ctlSummary" runat="server" DisplayMode="BulletList" />
        <asp:Label ID="ConfMsgLbl" runat="server" ForeColor="#09176d" Style="z-index: 1;
            font-weight: bold;" Text="Thank you for contacting us. Your message has been sent to the Administrative team. <br/>They will get back to you at the earliest."
            Visible="False"></asp:Label><br />
        <br />
        <table>
            <tr>
                <td>
                    <asp:Label ID="ReasonLbl" runat="server" Text="Reason :" Style="z-index: 1;"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ReasonDDL" runat="server" Style="z-index: 1;">
                        <asp:ListItem>Trouble Registering </asp:ListItem>
                        <asp:ListItem>Trouble Signing In </asp:ListItem>
                        <asp:ListItem>Suggestions or recommendations</asp:ListItem>
                        <asp:ListItem>Other Problems</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="CommentLbl" runat="server" Text="Message :" Style="z-index: 1;"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="CommentTB" runat="server" Style="z-index: 1;" TextMode="MultiLine"
                        Columns="60" Rows="15" Height="241px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="MessageRequired" runat="server" ControlToValidate="CommentTB"
                        ErrorMessage="Message is required." ToolTip="Message is required.">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:ImageButton ID="SendButton" runat="server" ImageUrl="~/images/button_send.gif"
                        Style="margin-left: 0px;" OnClick="SubmitBtn_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
