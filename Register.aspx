<%@ Page Title="" Language="C#" MasterPageFile="~/External.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="contents">
<img src="images/title_register.gif"  />
<div>
<b>Why Register?</b>
 If you are a Kallivayalil, you are encouraged to register yourself. By registering, you will have access to the Kallivayalil online address book, image gallery and to our family tree. We encourage you to register and use this website to get in touch with Kallivayalil's across the globe.
 
 <p><b>Steps to Register</b>
 <ol>
 <li>Complete the form below and click the <i>Register</i> button</li>
 <li>You and the administrator will receive an email with your registration details.</li>
 <li>The Administrator will verify your information and then activate your account. Note: You may be contacted for verification</li>
 <li>You will receive an email as soon as the administrator acts on your registration request. Once your account is activated, you can now login. </li>
 <li>Note: If your account is NOT activated, you can contact us for the details for the decline.</li></ol>
 </p>
</div>
<b>Registration Form</b>
<br />
<br />
  <asp:Label ID="ConfirmationLabel" runat="server" ForeColor="Maroon"  Font-Bold="true" Text="Thank You for registering. A confirmation email has been sent to the emailaddress you provided. We will review your information and your account will be activated at the earliest." Visible="False" ></asp:Label><br /><br />
<asp:ValidationSummary ID="vldSummary" runat="server" ValidationGroup="ctlUserRegister" DisplayMode="BulletList" />
            <asp:Panel ID="UserRegistration" runat="server"                                 
                Style="background-image: none; background-color: #FFFFFF; margin-left:30px;">
                <table >
                <tr>
                <td><asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstName">First Name</asp:Label></td>
                <td style="margin-left: 40px"><asp:TextBox ID="FirstName" runat="server" TabIndex="1" CssClass="FormText"></asp:TextBox><asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName" ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="ctlUserRegister" Display="Dynamic">*</asp:RequiredFieldValidator></td>
                <td style="width:35px"></td>
                <td>
                    <asp:Label ID="PhoneNumLabel" runat="server" AssociatedControlID="PhoneNumber">Home Phone</asp:Label>
                    </td>
                <td> 
                    <asp:TextBox ID="PhoneNumber" runat="server" CssClass="FormText" TabIndex="8"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PhoneNumberRequired" runat="server" 
                        ControlToValidate="PhoneNumber" ErrorMessage="PhoneNumber is required." 
                        ToolTip="Phone Number is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                <td><asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="LastName" >Last Name</asp:Label></td>
                <td><asp:TextBox ID="LastName" runat="server" CssClass="FormText" TabIndex="2"></asp:TextBox><asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName" ErrorMessage="Last Name is required."  ToolTip="Last Name is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator></td>
                <td style="width:35px"></td>
                <td>
                    <asp:Label ID="Address1Label" runat="server" AssociatedControlID="Address1">Address</asp:Label>
                    </td>
                <td>
                    <asp:TextBox ID="Address1" runat="server" CssClass="FormText" TabIndex="9"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="AddressRequired" runat="server" 
                        ControlToValidate="Address1" ErrorMessage="Address is required." 
                        ToolTip="Address is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                <td><asp:Label ID="FamilyBranchLabel" runat="server" AssociatedControlID="FamilyBranch">Family Branch</asp:Label></td>
                <td> <asp:DropDownList ID="FamilyBranch" runat="server" CssClass="FormSelect" TabIndex="3">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem Value="Kallivayalil">Kallivayalil Kallivayalil</asp:ListItem>
                    <asp:ListItem Value="Anavalaril">Kallivayalil Anavalaril</asp:ListItem>
                    <asp:ListItem Value="Kondooparambil">Kallivayalil Kondooparambil</asp:ListItem>
                </asp:DropDownList><asp:RequiredFieldValidator ID="FamilyBranchRequired" runat="server" ControlToValidate="FamilyBranch" ErrorMessage="FamilyBranch is required." ToolTip="Family Branch is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator> </td>
                <td style="width:35px"></td>
                <td> &nbsp;</td>
                <td> 
                    <asp:TextBox ID="Address2" runat="server" CssClass="FormText" TabIndex="10"></asp:TextBox>
                    </td> </tr>
                <tr>
                 <td><asp:Label ID="lblBornInto" runat="server" AssociatedControlID="rdlConnection">Kallivayalil Connection</asp:Label></td>
                <td><asp:RadioButtonList ID="rdlConnection" runat="server" RepeatDirection="Horizontal" TabIndex="4">
                <asp:ListItem Value="B">Born Into</asp:ListItem>
                <asp:ListItem Value="M">Married Into</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="ConnectionRequired" runat="server" ControlToValidate="rdlConnection" ErrorMessage="Kallivayalil Connection is required." ToolTip="How are you connected to the Kallivayalil Family is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator> </td>
                <td style="width:35px"></td>
                <td>
                    <asp:Label ID="CityDistrictLabel" runat="server" 
                        AssociatedControlID="CityDitrict">City/District</asp:Label>
                    </td>
                <td>
                    <asp:TextBox ID="CityDitrict" runat="server" CssClass="FormText" TabIndex="11"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="CityDistrictRequired" runat="server" 
                        ControlToValidate="CityDitrict" ErrorMessage="City/District is required." 
                        ToolTip="City/District is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator>
                    </td>
                </tr>                              
               
               <tr>
               <td> <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" >E-mail Address</asp:Label></td>
               <td> <asp:TextBox ID="Email" runat="server" CssClass="FormText" TabIndex="5"></asp:TextBox><asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="ctlUserRegister" style="width: 8px;">*</asp:RequiredFieldValidator></td>                
               <td style="width:35px"></td>
               <td>
                   <asp:Label ID="StateLabel" runat="server" AssociatedControlID="State">State</asp:Label>
                   </td>
               <td> 
                   <asp:TextBox ID="State" runat="server" CssClass="FormText" TabIndex="12"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="StateRequired" runat="server" 
                       ControlToValidate="State" ErrorMessage="State is required." 
                       ToolTip="State is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator>
                   </td>
                </tr> 
                <tr>
                 <td> <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" >Password</asp:Label></td>
                <td><asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="FormText" ValidationGroup="ctlUserRegister" TabIndex="6"></asp:TextBox><asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"  ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ctlUserRegister" style="width: 8px;">*</asp:RequiredFieldValidator></td>
                <td style="width:35px"></td>
                <td>
                    <asp:Label ID="PinCodeLabel" runat="server" AssociatedControlID="PinCode">Zip/PinCode</asp:Label>
                    </td>
                <td>
                    <asp:TextBox ID="PinCode" runat="server" CssClass="FormText" TabIndex="13"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PinCodeRequired" runat="server" 
                        ControlToValidate="PinCode" ErrorMessage="PinCode is required." 
                        ToolTip="PinCode is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator>
                </td></tr>
                <tr>
                <td><asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword" >Confirm Password</asp:Label></td>
                <td><asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"  CssClass="FormText" ValidationGroup="ctlUserRegister" TabIndex="7"></asp:TextBox><asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="ctlUserRegister" style="width: 8px;">*</asp:RequiredFieldValidator><asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="ctlUserRegister"></asp:CompareValidator></td>
                <td style="width:35px"></td>
                <td>
                    <asp:Label ID="CountryLabel" runat="server" AssociatedControlID="Country" 
                        Style="height: 19px;">Country</asp:Label>
                    </td>
                <td>
                    <asp:TextBox ID="Country" runat="server" CssClass="FormText" TabIndex="14"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="CountryRequired" runat="server" 
                        ControlToValidate="Country" ErrorMessage="Country is required." 
                        ToolTip="Country is required." ValidationGroup="ctlUserRegister">*</asp:RequiredFieldValidator>
                    </td>
                </tr>         
                <tr>
                <td></td>
                <td><asp:ImageButton ID="RegisterButton" runat="server" OnClick="RegisterButton_Click" Style="clear: both;" Text="Register" ValidationGroup="ctlUserRegister" TabIndex="15"  ImageUrl="~/images/Register.gif"  /> </td>
                <td style="width:35px"></td>
                <td></td>
                <td></td>                
                </tr>                
                </table>
              
            </asp:Panel>
</div>
</asp:Content>

