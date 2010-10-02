<%@ Page Title="" Language="C#" MasterPageFile="~/External.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link type="text/css" href="css/jquery-ui-1.7.1.custom.css" rel="stylesheet" />
    <link type="text/css" href="css/dsp-jquery-ui-custom.css" rel="stylesheet" />

    <script type="text/javascript" src="scripts/jquery-1.3.2.js"></script>

    <script type="text/javascript" src="scripts/jquery.marquee.js"></script>

    <script type="text/javascript" src="scripts/ui.core.js"></script>

    <script type="text/javascript" src="scripts/ui.resizable.js"></script>

    <script type="text/javascript" src="scripts/ui.draggable.js"></script>

    <script type="text/javascript" src="scripts/ui.droppable.js"></script>

    <script type="text/javascript" src="scripts/ui.dialog.js"></script>

    <script type="text/javascript">
        jQuery(document).ready(InitializeJQueryItems);

        function InitializeJQueryItems() {
            var dlg = jQuery("#eventDialogArea").dialog({ autoOpen: false, modal: true });
            //           dlg.parent().appendTo(jQuery("form:first")); //allows for asp.net post back

            $('marquee').marquee('pointer').mouseover(function() {
                $(this).trigger('stop');
            }).mouseout(function() {
                $(this).trigger('start');
            }).mousemove(function(event) {
                if ($(this).data('drag') == true) {
                    this.scrollLeft = $(this).data('scrollX') + ($(this).data('x') - event.clientX);
                }
            });
        }


        function openQuickAddDialog(mouseX, mouseY, title, details, imgSrc) {
            var xPos, yPos;
            xPos = mouseX - 650;
            yPos = mouseY + 100;
            if (xPos < 0)
                xPos = 0;
            if (yPos < 0)
                yPos = 0;
            jQuery("#eventDialogArea").dialog("option", "position", [xPos, yPos]);
            jQuery("#eventDialogArea").dialog("option", "width", 500);
            jQuery("#eventDialogArea").dialog("option", "title", title);
            var content = document.getElementById("divEvent");
            content.innerHTML = details;
            var imageSrc = document.getElementById("imgEvent");
            imageSrc.src = imgSrc;
            jQuery("#eventDialogArea").dialog("open");
        }

    </script>

    <style type="text/css">
        .style4
        {
            height: 233px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="eventDialogArea" title="News/Upcoming Events" style="display: none;">
        <div id="eventDialogContentsArea" style="height: 120px;">
            <table>
                <tr>
                    <td>
                        <img src="images/Grad-Cap.png" id="imgEvent" />
                    </td>
                    <td>
                        <div id="divEvent">
                        </div>
                    </td>
                </tr>
            </table>
            <div style="margin-top: 10px; height: 30px;">
                <input type="button" value="Close" style="border: 1px #000 solid;" onclick="javascript:jQuery('#eventDialogArea').dialog('close');" />
            </div>
        </div>
    </div>
    <div class="contents">
    
        <table>
            <tr>
                <td colspan="3">
                    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
                        width="703" height="246">
                        <param name="movie" value="swf/banner.swf" />
                        <param name="quality" value="high" />
                        <param name="wmode" value="transparent"> 
                        <embed src="swf/banner.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
                            type="application/x-shockwave-flash" width="703" height="246"></embed>
                    </object>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    <img src="images/title_origin.gif" />
                </td>
            </tr>
            <tr>
                <td width="570px" valign="top" class="style4">
                    <div style="overflow: auto; height: 155px; scrollbar-3dlight-color: #eeeded; scrollbar-arrow-color: #09176d;
                        scrollbar-base-color: #000000; scrollbar-darkshadow-color: #09176d; scrollbar-face-color: #ffffff;
                        scrollbar-highlight-color: #09176d; scrollbar-shadow-color: #09176d">
                        <p style="text-align: justify; margin-right: 5px;">
                            Around the time that the Bharananganam church was established, there were four prominent
                            Christian families living along the banks of the Meenachil River. They were the
                            Aakan, Arackal, Choonda, and Brattiani families. These families became Christians
                            in Kodungallur and came to stay initially at the Thalikotta near Kottayam. From
                            Thalikotta they moved to Bharanganam at the invitation of the ruling Kartha of Meenachil.
                            <br />
                            <br />
                            The Namboodiris living at Bharananganam approached the Meenachil Kartha for permission
                            to bring a Christian (Mappila) to live near the temple to purify the temple oils.
                            With the consent of the Meenachil Kartha, the Namboodiris met the head of the Arackal
                            family. Subsequently the eldest son of the Arackal family came to stay near the
                            temple at Bharananganam in the property known as Kovil Kattu. This "Kovil Kattu"
                            gradually became "Kokakattu" and the eldest son of the Arackal family who came to
                            stay at Kovil Kattu is the first Karnavar of the Kokkattu family. He enjoyed great
                            influence and favour with the Meenachil Kartha and received various honours from
                            the Kartha including the title of Tharakan and was allowed the "Veerasringala",
                            the "Amsavadi",and the "Koothuvilkku".<br />
                            <br />
                            Kokkattu Karnavar had two sons. The elder moved to Thekkey Attam. This Thekkay Attam
                            familyis the source of families such as Aiypenparambilkunnel, Chalil, Pala Kootiyani,
                            Nellikunnel, Erathukunnel, Thuruthippara, Tharapel and Kinattukara.
                            <br />
                            <br />
                            The son who stayed at the Tharavadu had two sons and a daughter. The daughter was
                            married into the Thoonkuzhiyil family. The elder son moved to Kandathil and this
                            Kandathil family is the source of the Kalariparambil, Kottarathin Kuzhi, Punnathanathu,
                            Alakalathil, Chavarpuzha, Palakudiyil and Kalapurackal families.<br />
                            <br />
                            The second son, Ittyavira Kuruvilla, had four sons and two daughters. The daughters
                            were married into the Olickal and Perekattu families. The eldest of the sons, Ittyavira
                            Chacko married from the Kizhakethalackal family and moved to Kallivayalil in Vilakkumadom.
                            He had two sons of the elder, Ittyavira Punnoose married from Tharappel. He had
                            no children. The younger son Ittyavira Ittyavira married four times. From the third
                            marriage, from Uppumakel, he had a son, Ittyavira Chacko, who moved to Kondooparambil.
                            From the fourth marriage he had two sons of whom the elder, Michael (Mikhail), stayed
                            at Kallivayalil and the younger, Joseph, moved to Anavalaril.<br />
                            <br />
                            This brings us to the Kallivayalil family in its present main divisions of <b>Kondooparambil</b>,
                            <b>Kallivayalil</b> and <b>Anavalaril</b> and connects with the survey of the roots
                            written by Shri K.J. Joseph Kallivayalil.<br />
                            <br />
                            <span class="ItalicsText">The following information has been extracted from a brief
                                survey of the history of the Kokkattu Family written by Shri Abraham Kuruvilla,
                                Kokkattu Kanjirathunkal. Shri Kuruvilla states that the survey is based on the input
                                gathered from consultations with the senior members of various families such as
                                Parekattu, Olickal, Perekattu, Kalariparambil, Pulikunnel, and Kallivayalil. This
                                includes material not available in account given by Shri. K.J. Joseph Kallivayalil.
                            </span></span></p>
                    </div>
                </td>
                <td width="5px" class="style4">
                </td>
                <td valign="top" class="style4">
                    <table width="96%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <img src="images/newsbox_topcut.jpg" />
                            </td>
                        </tr>
                        <tr>
                            <td background="images/newsbox_repeater.gif" style="background-repeat: repeat-y"
                                width="220px" height="130px" valign="top">
                                <table cellpadding="6" cellspacing="0" border="0">
                                    <tr>
                                        <td align="left" class="style2">
                                            <img src="images/title_events.gif" style="width: 198px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="news" align="left">
                                            <marquee id="ml" behaviour="scroll" style="text-align: center; width: 226px; height: 90px;"
                                                direction="up" scrollamount="1" name="ml">
                                                <asp:Repeater ID="Repeater1" runat="server">                                                
                                                <ItemTemplate>                                                 
                                                        <asp:HyperLink ID="HyperLink2" runat="server"  onclick='<%# Eval("URL") %>'>                                                        
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Desc") %>'></asp:Label></asp:HyperLink><br />
                                                 </ItemTemplate>
                                        </asp:Repeater></marquee>
                                            Click on the event to view more details.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:HyperLink ID="lnkAddEvent" runat="server" NavigateUrl="~/AddEvent.aspx">Add New Event</asp:HyperLink>
                                            <br />
                                            <asp:HyperLink ID="lnkModifyEvent" runat="server" NavigateUrl="~/ModifyEvent.aspx">Modify/Delete Event</asp:HyperLink>
                                            <br />
                                            <asp:HyperLink ID="lnkViewAll" runat="server" NavigateUrl="~/ViewEvents.aspx">View All</asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/newsbox_bottomcut.jpg" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
