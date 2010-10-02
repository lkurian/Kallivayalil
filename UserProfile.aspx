<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UserProfile.aspx.cs" Inherits="UserProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/jquery.Jcrop.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="scripts/jquery-1.3.2.js"></script>

    <script type="text/javascript" src="scripts/jquery.Jcrop.js"></script>

    <script type="text/javascript" src="scripts/jquery.Jcrop.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function() {

            $("img[name = 'imgCrop']").Jcrop({

                onSelect: storeCoords

            });

        });



        function storeCoords(c) {

            $("input[name = 'ctl00$ContentPlaceHolder1$X']").val(c.x);

            $("input[name = 'ctl00$ContentPlaceHolder1$Y']").val(c.y);

            $("input[name = 'ctl00$ContentPlaceHolder1$W']").val(c.w);

            $("input[name = 'ctl00$ContentPlaceHolder1$H']").val(c.h);

        };

 

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">
        <img src="images/title_myprofile.gif" />
        <div>
            You can view and update your personal information. Please ensure that your information
            is accurate.<br />
            <br />
        </div>
        <asp:Menu runat="server" ID="menuTabs" Orientation="Horizontal" CssClass="menuTabs"
            OnMenuItemClick="menuTabs_MenuItemClick" ForeColor="#000" StaticHoverStyle-CssClass="hoverTab"
            StaticMenuItemStyle-ItemSpacing="3" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab">
            <Items>
                <asp:MenuItem Enabled="true" Text="Personal" Value="0" Selected="true"></asp:MenuItem>
                <asp:MenuItem Enabled="true" Text="Family (Spouse/Children)" Value="2"></asp:MenuItem>
                <asp:MenuItem Enabled="true" Text="Contact Information" Value="1"></asp:MenuItem>
                <asp:MenuItem Enabled="true" Text="Account" Value="3"></asp:MenuItem>
            </Items>
        </asp:Menu>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="tabBody">
            <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server">
                <asp:View ID="PersonalView" runat="server">
                    <table width="100%">
                        <tr valign="top">
                            <td width="40%">
                                <asp:ValidationSummary ID="vldPersonalSummary" DisplayMode="BulletList" runat="server" />
                                 <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="UserProfileID"
                                    DataSourceID="SqlDataSource1" Width="100%" AllowPaging="true" CellPadding="4"
                                    GridLines="None">
                                    <FieldHeaderStyle Font-Bold="true" />
                                    <Fields>
                                        <asp:TemplateField HeaderText="Salutation">
                                            <ItemTemplate>
                                                <%#Eval("Salutation")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlSalutation" runat="server" SelectedValue='<%# Bind("Salutation") %>'
                                                    DataValueField="Salutation">
                                                    <asp:ListItem Text=""></asp:ListItem>
                                                    <asp:ListItem Text="Mr." Value="Mr."></asp:ListItem>
                                                    <asp:ListItem Text="Ms." Value="Ms."></asp:ListItem>
                                                    <asp:ListItem Text="Miss" Value="Miss"></asp:ListItem>
                                                    <asp:ListItem Text="Mrs." Value="Mrs."></asp:ListItem>
                                                    <asp:ListItem Text="Dr." Value="Dr."></asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="First Name">
                                            <ItemTemplate>
                                                <%#Eval("FirstName") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName"
                                                    ErrorMessage="FirstName is required." ToolTip="FirstName is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" SortExpression="MiddleName" />
                                        <asp:TemplateField HeaderText="Last Name">
                                            <ItemTemplate>
                                                <%#Eval("LastName") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName"
                                                    ErrorMessage="LastName is required." ToolTip="LastName is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PreferredName" HeaderText="Preferred Name(Known As)" SortExpression="PreferredName" />
                                        <asp:TemplateField HeaderText="Gender">
                                            <ItemTemplate>
                                                <asp:RadioButtonList RepeatDirection="Horizontal" Enabled="false" ID="rdlRGender"
                                                    runat="server" SelectedValue='<%# Bind("Gender") %>' DataValueField="Gender">
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:RadioButtonList ID="rdlGender" runat="server" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Gender") %>'
                                                    DataValueField="Gender">
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Family Branch">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFamilyBranch" Text='<%# Eval("FamilyBranch") %>' runat="Server"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlFamilyBranch" runat="server" SelectedValue='<%# Bind("FamilyBranch") %>'
                                                    DataTextField="FamilyBranch" DataValueField="FamilyBranch">
                                                    <asp:ListItem Value="Kallivayalil">Kallivayalil Kallivayalil</asp:ListItem>
                                                    <asp:ListItem Value="Anavalaril">Kallivayalil Anavalaril</asp:ListItem>
                                                    <asp:ListItem Value="Kondooparambil">Kallivayalil Kondooparambil</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="HouseName" HeaderText="House Name" SortExpression="HouseName" />
                                        <asp:TemplateField HeaderText="Born On">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBornOn" Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("BornOn")) %>'
                                                    runat="Server"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="BornOn" runat="server" Text='<%# Bind("BornOn", "{0:MMM dd, yyyy}")%>'></asp:TextBox>
                                                <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="BornOn" PopupPosition="Right"
                                                    runat="server"  Format="MMM dd, yyyy">
                                                </cc1:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Marital Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMaritalStatus" Text='<%# Eval("MaritalStatus") %>' runat="Server"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlMaritalStatus" runat="server" SelectedValue='<%# Bind("MaritalStatus") %>'
                                                    DataTextField="MaritalStatus" DataValueField="MaritalStatus">
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                    <asp:ListItem Value="Single">Single</asp:ListItem>
                                                    <asp:ListItem Value="Married">Married</asp:ListItem>
                                                    <asp:ListItem Value="Divorced">Divorced</asp:ListItem>
                                                    <asp:ListItem Value="Widowed">Widowed</asp:ListItem>
                                                    <asp:ListItem Value="Divorced">Re-Married</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Occupation" HeaderText="Occupation" SortExpression="Occupation" />
                                        <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                        <asp:CommandField ShowEditButton="True" />
                                    </Fields>
                                </asp:DetailsView>
                            </td>
                            <td width="10%">
                            </td>
                            <td>
                                <asp:Panel ID="pnlCrop" runat="server" Visible="false">
                                    <asp:Image name="imgCrop" ID="imgCrop" runat="server" src='<%# string.Format("Image.aspx?ID={0}",Session["queryID"])%>' />
                                    <br />
                                    <input type="hidden" name="X" id="X" runat="server" />
                                    <input type="hidden" name="Y" id="Y" runat="server" />
                                    <input type="hidden" name="W" id="W" runat="server" />
                                    <input type="hidden" name="H" id="H" runat="server" />
                                    <asp:Button ID="btnCrop" runat="server" Text="Crop" OnClick="btnCrop_Click" />
                                    <asp:Button ID="btnCancelCrop" runat="server" Text="Cancel" OnClick="btnCancelCrop_Click" />
                                </asp:Panel>
                                <asp:Panel ID="pnlCropped" runat="server" Visible="true">
                                    <asp:Image ID="imgCropped" runat="server" src='<%# string.Format("Image.aspx?ID={0}",Session["queryID"])%>' Height="120px"
                                        Width="100px" /><br />
                                    <asp:LinkButton ID="lnkAddPhoto" runat="server" Text=">>Upload New Photo"></asp:LinkButton><br />
                                    <asp:LinkButton ID="lnkCropPhoto" runat="server" Text=">>Crop Above Photo" OnClick="btnCropPhoto_Click" />
                                    <asp:Panel ID="pnlUpload" runat="server" Visible="false">
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                        <asp:Button runat="server" OnClick="btnUpload_Click" ID="btnUpload" Text="Upload" />
                                    </asp:Panel>
                                </asp:Panel>
                                <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:View>
 <asp:View ID="ContactView" runat="server">
                    <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="False" DataKeyNames="UserProfileID"
                        DataSourceID="SqlDataSource2" Width="55%" AllowPaging="true" CellPadding="3"
                        GridLines="None">
                        <FieldHeaderStyle Font-Bold="true" />
                        <Fields>
                            <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"
                                ReadOnly="true" />
                            <asp:BoundField DataField="AlternateEmailAddress" HeaderText="Alternate Email" SortExpression="AlternateEmailAddress" />
                            <asp:BoundField DataField="Address1" HeaderText="Address" SortExpression="Address1" />
                            <asp:BoundField DataField="Address2" HeaderText="" SortExpression="Address2" />
                            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                            <asp:BoundField DataField="Pincode" HeaderText="Zip/Pincode" SortExpression="Pincode" />
                            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                            <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" SortExpression="HomePhone" />
                            <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
                            <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website" />
                            <asp:CommandField ShowEditButton="True" />
                        </Fields>
                    </asp:DetailsView>
                </asp:View>
                <asp:View ID="FamilyView" runat="server">
                    <table width="100%">
                        <tr valign="top">
                            <td width="40%">
                                Spouse Information
                            </td>
                            <td width="10%">
                            </td>
                            <td width="50%">
                                Children
                            </td>
                        </tr>
                        <tr valign="top">
                            <td width="40%">
                                <asp:ValidationSummary ID="ValidationSummarySpouse" DisplayMode="BulletList" runat="server"
                                    ValidationGroup="VldSpouse" />
                                <asp:DetailsView ID="DetailsView4" runat="server" AutoGenerateRows="False" DataKeyNames="SpID"
                                    DataSourceID="SqlDataSource4" Width="100%" AllowPaging="true" CellPadding="4"
                                    GridLines="None" EmptyDataText="No spouse information available">
                                    <FieldHeaderStyle Font-Bold="true" />
                                    <EmptyDataTemplate>
                                        <asp:LinkButton ID="lnkInsert" Text="Add Spouse" OnClick="lnkInsert_Click" runat="server"></asp:LinkButton>
                                    </EmptyDataTemplate>
                                    <Fields>
                                        <asp:TemplateField HeaderText="Salutation">
                                            <ItemTemplate>
                                                <%#Eval("Salutation")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlSalutation" runat="server" SelectedValue='<%# Bind("Salutation") %>'
                                                    DataValueField="Salutation">
                                                    <asp:ListItem Text=""></asp:ListItem>
                                                    <asp:ListItem Text="Mr." Value="Mr."></asp:ListItem>
                                                    <asp:ListItem Text="Ms." Value="Ms."></asp:ListItem>
                                                    <asp:ListItem Text="Miss" Value="Miss"></asp:ListItem>
                                                    <asp:ListItem Text="Mrs." Value="Mrs."></asp:ListItem>
                                                    <asp:ListItem Text="Dr." Value="Dr."></asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="First Name">
                                            <ItemTemplate>
                                                <%#Eval("FirstName") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="FirstNameRequired" ValidationGroup="VldSpouse" runat="server"
                                                    ControlToValidate="FirstName" ErrorMessage="FirstName is required." ToolTip="FirstName is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" SortExpression="MiddleName" />
                                        <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                        <asp:BoundField DataField="PreferredName" HeaderText="Preferred Name(Known As)" SortExpression="PreferredName" />
                                        <asp:BoundField DataField="FamilyName" HeaderText="Family Name" SortExpression="FamilyName" />
                                        <asp:TemplateField HeaderText="Gender">
                                            <ItemTemplate>
                                                <asp:RadioButtonList RepeatDirection="Horizontal" Enabled="false" ID="rdlRGender"
                                                    runat="server" SelectedValue='<%# Bind("Gender") %>' DataValueField="Gender">
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:RadioButtonList ID="rdlGender" runat="server" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Gender") %>'
                                                    DataValueField="Gender">
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <asp:RequiredFieldValidator ID="GenderRequired" runat="server" ValidationGroup="VldSpouse"
                                                    ControlToValidate="rdlGender" ErrorMessage="Gender is required." ToolTip="Gender is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress" />
                                        <asp:BoundField DataField="AlternateEmailAddress" HeaderText="Alternate Email" />
                                        <asp:BoundField DataField="MobilePhone" HeaderText="Mobile Phone" SortExpression="MobilePhone" />
                                        <asp:BoundField DataField="Occupation" HeaderText="Occupation" SortExpression="Occupation" />
                                        <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                        <asp:TemplateField HeaderText="Born On">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBornOn" Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("BornOn")) %>'
                                                    runat="Server"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="BornOn" runat="server" Text='<%# Bind("BornOn", "{0:MMM dd, yyyy}")%>'></asp:TextBox>
                                                <cc1:CalendarExtender ID="CalendarExtenderB" TargetControlID="BornOn" PopupPosition="Right"
                                                    runat="server" Format="MMM dd, yyyy">
                                                </cc1:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Married On">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMarriedOn" Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("MarriedOn")) %>'
                                                    runat="Server"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="MarriedOn" runat="server" Text='<%# Bind("MarriedOn", "{0:MMM dd, yyyy}")%>'></asp:TextBox>
                                                <cc1:CalendarExtender ID="CalendarExtenderM" TargetControlID="MarriedOn" PopupPosition="Right"
                                                    runat="server" Format="MMM dd, yyyy">
                                                </cc1:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Died On">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDiedOn" Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("DiedOn")) %>'
                                                    runat="Server"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="DiedOn" runat="server" Text='<%# Bind("DiedOn", "{0:MMM dd, yyyy}")%>'></asp:TextBox>
                                                <cc1:CalendarExtender ID="CalendarExtenderD" TargetControlID="DiedOn" PopupPosition="Right"
                                                    runat="server"  Format="MMM dd, yyyy">
                                                </cc1:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" ValidationGroup="VldSpouse" ShowInsertButton="true"
                                            InsertText="Save" NewText="Add Spouse" EditText="Edit" ControlStyle-BorderStyle="Solid"
                                            ControlStyle-BackColor="LightGray" ControlStyle-BorderColor="Black" ControlStyle-BorderWidth="1"
                                            ControlStyle-CssClass="margin" />
                                    </Fields>
                                </asp:DetailsView>
                            </td>
                            <td width="10%">
                            </td>
                            <td width="50%">
                                <asp:ValidationSummary ID="ValidationSummaryChild" DisplayMode="BulletList" runat="server"
                                    ValidationGroup="VldChild" />
                                <asp:DetailsView ID="DetailsView5" runat="server" AutoGenerateRows="False" DataKeyNames="UserProfileID"
                                    DataSourceID="SqlDataSource5" Width="100%" AllowPaging="true" CellPadding="4"
                                    GridLines="None" EmptyDataText="No information available">
                                    <FieldHeaderStyle Font-Bold="true" />
                                    <EmptyDataTemplate>
                                        <asp:LinkButton ID="lnkInsertChild" Text="Add Children" OnClick="lnkInsertChild_Click"
                                            runat="server"></asp:LinkButton>
                                    </EmptyDataTemplate>
                                    <Fields>
                                        <asp:TemplateField HeaderText="Salutation">
                                            <ItemTemplate>
                                                <%#Eval("Salutation")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlSalutation" runat="server" SelectedValue='<%# Bind("Salutation") %>'
                                                    DataValueField="Salutation">
                                                    <asp:ListItem Text=""></asp:ListItem>
                                                    <asp:ListItem Text="Mr." Value="Mr."></asp:ListItem>
                                                    <asp:ListItem Text="Ms." Value="Ms."></asp:ListItem>
                                                    <asp:ListItem Text="Miss" Value="Miss"></asp:ListItem>
                                                    <asp:ListItem Text="Mrs." Value="Mrs."></asp:ListItem>
                                                    <asp:ListItem Text="Dr." Value="Dr."></asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="First Name">
                                            <ItemTemplate>
                                                <%#Eval("FirstName") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ValidationGroup="VldChild"
                                                    ControlToValidate="FirstName" ErrorMessage="FirstName is required." ToolTip="FirstName is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" SortExpression="MiddleName" />
                                        <asp:TemplateField HeaderText="Last Name">
                                            <ItemTemplate>
                                                <%#Eval("LastName") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="LastNameRequired" ValidationGroup="VldChild" runat="server"
                                                    ControlToValidate="LastName" ErrorMessage="LastName is required." ToolTip="LastName is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PreferredName" HeaderText="Preferred Name(Known As)" SortExpression="PreferredName" />
                                        <asp:TemplateField HeaderText="Gender">
                                            <ItemTemplate>
                                                <asp:RadioButtonList RepeatDirection="Horizontal" Enabled="false" ID="rdlRGender"
                                                    runat="server" SelectedValue='<%# Bind("Gender") %>' DataValueField="Gender">
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:RadioButtonList ID="rdlGender" runat="server" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Gender") %>'
                                                    DataValueField="Gender">
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <asp:RequiredFieldValidator ID="GenderRequired" runat="server" ValidationGroup="VldChild"
                                                    ControlToValidate="rdlGender" ErrorMessage="Gender is required." ToolTip="Gender is required.">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" ShowInsertButton="true" ValidationGroup="VldChild"
                                            InsertText="Save" NewText="Add Child" EditText="Edit" ControlStyle-BorderStyle="Solid"
                                            ControlStyle-BackColor="LightGray" ControlStyle-BorderColor="Black" ControlStyle-BorderWidth="1"
                                            ControlStyle-CssClass="margin" />
                                    </Fields>
                                </asp:DetailsView>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="AccountView" runat="server">
                    <asp:ValidationSummary ID="vldAccountSummary" DisplayMode="BulletList" runat="server" />
                    <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" DataKeyNames="UserProfileID"
                        DataSourceID="SqlDataSource3" Width="55%" AllowPaging="True" CellPadding="4"
                        GridLines="None">
                        <FieldHeaderStyle Font-Bold="true" />
                        <Fields>
                            <asp:BoundField DataField="EmailAddress" HeaderText="Email/UserName" SortExpression="EmailAddress" />
                            <asp:TemplateField HeaderText="Password">
                                <ItemTemplate>
                                    <asp:Label ID="lblPassword" Text='Click EDIT to change Password' runat="Server"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="Passwd" runat="server" TextMode="Password" Text='<%# Bind("Passwd") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswdRequired" runat="server" ControlToValidate="Passwd"
                                        ErrorMessage="Password is required." ToolTip="Password is required.">*</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Confirm Password">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:CompareValidator ID="vldPassword" runat="server" ControlToValidate="Passwd"
                                        ControlToCompare="ConfirmPassword" ErrorMessage="Passwords must match" Display="Dynamic">*</asp:CompareValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" />
                        </Fields>
                    </asp:DetailsView>
                </asp:View>
            </asp:MultiView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT UserProfileID, Salutation, FirstName, MiddleName, LastName, PreferredName, Gender, FamilyBranch, HouseName, BornOn, MaritalStatus, Occupation, Employer FROM tbluserprofile WHERE (UserProfileID = ?)"
                UpdateCommand="UPDATE tbluserprofile SET Salutation=?,FirstName=?, MiddleName=?,LastName=?,PreferredName=?, Gender=?,FamilyBranch=?,HouseName=?, BornOn=?, MaritalStatus=?, Occupation=?, Employer=? WHERE UserProfileID = ?">
                <SelectParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Salutation" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="MiddleName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PreferredName" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="FamilyBranch" Type="String" />
                    <asp:Parameter Name="HouseName" Type="String" />
                    <asp:Parameter Name="BornOn" Type="DateTime" />
                    <asp:Parameter Name="MaritalStatus" Type="String" />
                    <asp:Parameter Name="Occupation" Type="String" />
                    <asp:Parameter Name="Employer" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT tbluserprofile.UserProfileID, EmailAddress, AlternateEmailAddress, Address1,Address2, City, State, Pincode,Country, HomePhone, MobilePhone, Website  FROM tbluserprofile, tbluserlogin WHERE (tbluserprofile.UserProfileID = ?) and tbluserprofile.UserProfileID=tbluserlogin.UserProfileID "
                UpdateCommand="UPDATE tbluserprofile SET  AlternateEmailAddress = ?,Address1 = ?, Address2 = ?, City=?, State=?, Pincode=?, Country=?, HomePhone=?, MobilePhone=?, Website=?   WHERE UserProfileID = ?">
                <SelectParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AlternateEmailAddress" Type="String" />
                    <asp:Parameter Name="Address1" Type="String" />
                    <asp:Parameter Name="Address2" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="State" Type="String" />
                    <asp:Parameter Name="Pincode" Type="String" />
                    <asp:Parameter Name="Country" Type="String" />
                    <asp:Parameter Name="HomePhone" Type="String" />
                    <asp:Parameter Name="MobilePhone" Type="String" />
                    <asp:Parameter Name="Website" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT UserProfileID, EmailAddress, Passwd FROM tbluserlogin WHERE (UserProfileID = ?)"
                UpdateCommand="UPDATE tbluserlogin SET Passwd=AES_ENCRYPT(?,?), EmailAddress=?  WHERE (UserProfileID = ?) ">
                <SelectParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Passwd" Type="String" />
                    <asp:Parameter Name="Key" Type="String"  />
                    <asp:Parameter Name="EmailAddress" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT SpID, Salutation, FirstName, MiddleName, LastName, PreferredName, FamilyName, Gender, EmailAddress, AlternateEmailAddress, MobilePhone, Occupation, Employer, BornOn, MarriedOn, DiedOn FROM tblSpouse WHERE (SpouseID = ?)"
                UpdateCommand="UPDATE tblspouse SET Salutation=?, FirstName=?,MiddleName=?,LastName=?,PreferredName=?,FamilyName=?,Gender=?,EmailAddress=?, AlternateEmailAddress=?, MobilePhone=?, Occupation=?, Employer=?, BornOn=?, MarriedOn=?, DiedOn=?  WHERE SpID = ?"
                InsertCommand="INSERT INTO tblspouse (SpouseID,Salutation, FirstName, MiddleName, LastName, PreferredName, FamilyName, Gender, EmailAddress, AlternateEmailAddress, MobilePhone, Occupation, Employer, BornOn, MarriedOn, DiedOn, UpdatedBy,UpdatedDate) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,current_timestamp())">
                <SelectParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Salutation" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="MiddleName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PreferredName" Type="String" />
                    <asp:Parameter Name="FamilyName" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="EmailAddress" Type="String" />
                    <asp:Parameter Name="AlternateEmailAddress" Type="String" />
                    <asp:Parameter Name="MobilePhone" Type="String" />
                    <asp:Parameter Name="Occupation" Type="String" />
                    <asp:Parameter Name="Employer" Type="String" />
                    <asp:Parameter Name="BornOn" Type="DateTime" />
                    <asp:Parameter Name="MarriedOn" Type="DateTime" />
                    <asp:Parameter Name="DiedOn" Type="DateTime" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" Name="SpouseID" />
                    <asp:Parameter Name="Salutation" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="MiddleName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PreferredName" Type="String" />
                    <asp:Parameter Name="FamilyName" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="EmailAddress" Type="String" />
                    <asp:Parameter Name="AlternateEmailAddress" Type="String" />
                    <asp:Parameter Name="MobilePhone" Type="String" />
                    <asp:Parameter Name="Occupation" Type="String" />
                    <asp:Parameter Name="Employer" Type="String" />
                    <asp:Parameter Name="BornOn" Type="DateTime" />
                    <asp:Parameter Name="MarriedOn" Type="DateTime" />
                    <asp:Parameter Name="DiedOn" Type="DateTime" />
                    <asp:SessionParameter Name="UpdatedBy" Type="String" SessionField="UserName" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT UserProfileID, Salutation, FirstName, MiddleName, LastName, PreferredName, Gender  FROM tbluserprofile where ParentID=?"
                UpdateCommand="UPDATE tbluserprofile SET Salutation=?, FirstName=?,MiddleName=?,LastName=?,PreferredName=?, Gender=?, UpdatedBy=?, UpdatedDate=current_timestamp() WHERE UserProfileID = ?"
                InsertCommand="INSERT INTO tbluserprofile (ParentID, Salutation, FirstName, MiddleName, LastName, PreferredName, Gender, UpdatedBy, UpdatedDate) values (?,?,?,?,?,?,?,?,current_timestamp())">
                <SelectParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Salutation" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="MiddleName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PreferredName" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:SessionParameter SessionField="UserName" Name="UpdatedBy" Type="String" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter SessionField="queryID" Type="Int32" Name="ParentID" />
                    <asp:Parameter Name="Salutation" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="MiddleName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PreferredName" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:SessionParameter SessionField="UserName" Name="UpdatedBy" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
