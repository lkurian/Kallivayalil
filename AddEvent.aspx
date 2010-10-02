<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AddEvent.aspx.cs" Inherits="AddEvent" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="contents"  style="margin: 15px;">
        <img src="images/title_events.gif" /> <br />
        <p>
        Add new events, announcements or news using the form below. Follow the tips below when filling out the form.
        <ul>
        <li><b>Event Title:</b> Title of the event/announcement. Keep this short yet informative (Example: Wedding of Mr. Kurian Chacko to Ms. Anita Jacob).This will be displayed on the home page and members will click the title to read the details.</li>
        <li><b>Event Type:</b> Select the appropriate event type from the list provided. If your announcement does not fit any of the types listed, select 'Other'.</li>
        <li><b>Event Details:</b> Provide all the details of the event. Description of the event, Venue, Date & Time, contact number and any other important information.</li>
        <li><b>Display Start Date:</b> By Default this field has todays date. If you want the event to start showing on the website on a future date, set the appropriate date else leave the default value. </li>
        <li><b>Event Date:</b> Date of the event.</li>
        <li><b>Contact Person:</b> Who should be contacted if we have any questions on the event. Enter the full name of the person.</li>
        <li><b>Contact Number:</b> Provide the contact Phone number for people to call if they have any questions. Provide the necessary calling codes (ISD/STD codes)</li>
         <li><b>Event Visibility: </b> Can this event be visible to anybody or ONLY Kallivayalil members? </li>
        </ul>
        </p>
        <div id="divAddevent" runat="server">
        <table cellspacing="2" cellpadding="5">
        <tr><td> <asp:Label ID="EvntNameLbl" runat="server"  Text="Event Title:" ></asp:Label></td>
                <td><asp:TextBox ID="EvntNameTbx" runat="server" CssClass="FormTextLong" ></asp:TextBox></td></tr>
         <tr>
                <td> <asp:Label ID="EvntTypeLbl" runat="server" Text="Event Type:" ></asp:Label></td>
                <td> <asp:DropDownList ID="EvntTypeDdl" runat="server"  CssClass="FormSelect" >
                <asp:ListItem Text=""></asp:ListItem>
                <asp:ListItem Text="Birthday"></asp:ListItem>
                <asp:ListItem Text="Wedding"></asp:ListItem>
                <asp:ListItem Text="Graduation"></asp:ListItem>
                <asp:ListItem Text="Award/Achievements"></asp:ListItem>
                <asp:ListItem Text="Kudumayogam"></asp:ListItem>
                <asp:ListItem Text="Death Anniversary"></asp:ListItem>
                <asp:ListItem Text="Death Announcement"></asp:ListItem> 
                <asp:ListItem Text="General Meetings"></asp:ListItem>               
                <asp:ListItem Text="Other"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
         <td><asp:Label ID="EvntDescLbl" runat="server"  Text="Event Details:" ></asp:Label></td>
         <td><asp:TextBox ID="EvntDescTbx" runat="server" TextMode="MultiLine" CssClass="FormTextLong" Rows="6" ></asp:TextBox></td>
        </tr>
        <tr>
         <td><asp:Label ID="StartDateLbl" runat="server"  Text="Display Start Date:" width="61"></asp:Label></td>
         <td><asp:TextBox ID="StartDtTbx" runat="server" CssClass="FormText" ></asp:TextBox>
                 <cc1:CalendarExtender ID="CalendarExtenderD" TargetControlID="StartDtTbx" PopupPosition="Right" runat="server"  Format="MMM dd, yyyy" >
                           </cc1:CalendarExtender></td>
        </tr>
        <tr>
        <td><asp:Label ID="EndDateLbl" runat="server"  Text="Event Date:" width="69"></asp:Label></td>
        <td> <asp:TextBox ID="EndDtTbx" runat="server" CssClass="FormText" ></asp:TextBox>
                           <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="EndDtTbx" PopupPosition="Right" runat="server"  Format="MMM dd, yyyy" >
                           </cc1:CalendarExtender></td>
        </tr>
        <tr>
        <td><asp:Label ID="CntPersLbl" runat="server"  Text="Contact Person:" width="91"></asp:Label></td>
        <td><asp:TextBox ID="ContactPersonTbx" runat="server" CssClass="FormText" ></asp:TextBox></td>
        </tr>
        <tr>
        <td><asp:Label ID="CntNumLabel" runat="server"  Text="Contact Number:" width="91"></asp:Label></td>
        <td><asp:TextBox ID="ContactNumTbx" runat="server" CssClass="FormText" ></asp:TextBox></td>
        </tr>
        <tr>
        <td> <asp:Label ID="EvntVisLbl" runat="server" Text="Event Visibility:" width="86"></asp:Label></td>
        <td> <asp:RadioButton ID="AllRb" runat="server" CausesValidation="True" GroupName="EvntVis"
                Text="All" />
            <asp:RadioButton ID="MemOnlyRb" runat="server" CausesValidation="True" GroupName="EvntVis"              
                Text="Members Only" Checked="true" /></td>
        </tr>
        </table>
               
            <asp:Button ID="AddEvntBtn" runat="server" Text="Add Event" 
                OnClick="AddEvntBtn_Click" />
                </div>
                
            <div id="divSuccessLabel" runat="server" visible="false" style="color:Green;">
            <b>New event has been added to the calendar and can be viewed in the News/Events section.</b>
            </div>    
    </div>
</asp:Content>
