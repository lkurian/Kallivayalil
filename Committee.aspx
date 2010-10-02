<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Committee.aspx.cs" Inherits="Committee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #uploadDiv
        {
            width: 629px;
        }
        #downloadDiv
        {
            width: 203px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contents">
        <div id="print_area">
            <img src="images/title_Committee.png" />
            <br />
            <table>
                <tr>
                    <td colspan="2">
                        <p>
                            Committee members are selected every other year. The eldest member of the Kallivayalil
                            family is elected as the President. A representative is selected from each of the
                            3 branches of the Kallivayalil family.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <b>Commitee Members for the Year - </b>
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                            DataTextField="(YEAR(startdate))" DataValueField="(YEAR(startdate))" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" Width="90%"
                            PagerSettings-Mode="NumericFirstLast" PagerSettings-Position="TopAndBottom">
                            <HeaderStyle CssClass="gridHeader" />
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom"></PagerSettings>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="downloadDiv" runat="server">
                            <hr />
                            <br />
                            <b>Download Files</b>
                            <p>
                                You can download files using the section below.
                            </p>
                            <br />
                            Select file to download:
                            <asp:DropDownList ID="downloadList" runat="server" AutoPostBack="true">
                            </asp:DropDownList>
                            <asp:Button ID="Button2" value="Upload" runat="server" Text="Download" OnClick="cmddownloadFile_Click" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="uploadDiv" runat="server" visible="false">
                            <hr />
                            <br />
                            <b>Upload Files</b>
                            <p>
                                As an Administrator, you can upload files like the 'Presidents message', 'Annual
                                Report' etc. using the section below. If you want only registered members to view
                                the file, please mark it as 'Members Only'.
                            </p>
                            Select File to Upload:
                            <input id="uplTheFile" type="file" runat="server" style="width: 476px;" />
                            <br />
                            <br />
                            Members Only:
                            <asp:RadioButtonList ID="membersOnly" runat="server" RepeatDirection="Horizontal"
                                RepeatLayout="Flow">
                                <asp:ListItem Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:Button ID="cmdUploadFile" value="Upload" runat="server" Text="Upload" OnClick="cmdUploadFile_Click" />
                            <br />
                            <asp:Label ID="lblInformation" Visible="false" value="Error" runat="server" ForeColor="Red" />
                            <br />
                        </div>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="select distinct(YEAR(startdate)) from tblcommittee;">
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
