<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ViewEvents.aspx.cs" Inherits="ViewEvents" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contents" style="margin: 15px;">
        <img src="images/title_events.gif" />
        <div id="divEvents">
            <p>
                Here is a list of latest happenings in our Kallivayalil Family. If you have any
                questions on the events, please speak to the contact person listed for the particular
                event.
                <br />
                <br />
                <b>Add an event:</b> Click <a href="AddEvent.aspx">here</a> to add a new event/announcement/message</p>
            <br />
            <asp:ScriptManager ID="ScriptMgr1" runat="server">
            </asp:ScriptManager>
            <div>
                To look for events between specific dates, use the <b>From</b> and <b>To</b> boxes
                below. Select dates in each of these boxes using the calendar that opens up when
                you are in the box.
            </div>
            <br />
            <br />
            <div style="font-weight: bold">
                Filter Events between the dates below:
            </div>
            <asp:Label ID="Label1" runat="server" Text="From" Font-Bold="true"></asp:Label>
            <asp:TextBox ID="d3" runat="server" OnTextChanged="d3_TextChanged" AutoPostBack="True"></asp:TextBox>
            <ajaxtoolkit:CalendarExtender TargetControlID="d3" Format="MMM dd, yyyy" ID="CalenderExtender2"
                PopupPosition="TopRight" runat="server">
            </ajaxtoolkit:CalendarExtender>
            <asp:Label ID="Label2" runat="server" Text="To" Font-Bold="true"></asp:Label>
            <asp:TextBox ID="d4" runat="server" OnTextChanged="d4_TextChanged" AutoPostBack="True"></asp:TextBox>
            <ajaxtoolkit:CalendarExtender TargetControlID="d4" Format="MMM dd, yyyy" ID="CalendarExtender2"
                PopupPosition="TopRight" runat="server">
            </ajaxtoolkit:CalendarExtender>
            <br />
            <br />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="True" AllowPaging="True"
                PageSize="20" OnPageIndexChanging="GridView1_OnPageIndexChanging" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-Position="TopAndBottom">
                <HeaderStyle CssClass="gridHeader" />
                <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom"></PagerSettings>
            </asp:GridView>
        </div>
        <input type="image" src="images/print2.gif" id="print" runat="server" onclick="getPrint('divEvents','Kallivayalil - Events');return false;">
        </input>
    </div>
</asp:Content>
