<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="closejobcard.aspx.vb"
    Inherits="kdmt.closejobcard" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Closing Job Card</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
        function validate() {
            var ab;
            ab = document.getElementById("ddldeffect").value;
            //    alert(ab);

            if (ab == '00') {
                alert('Select Deffect Type');
                document.getElementById("ddldeffect").focus();
                return false;
            }
        }
        function Chkbusdetails12() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange = function() {

                if (xmlHttp.readyState == 4) {

                    resp = xmlHttp.responseText;

                    var ele = resp.split("!");

                    for (var i = 0; i < ele.length; i++) {
                        if (i == 1) {
                            document.getElementById("txtjocno").value = ele[i];

                        }
                    }
                }
            }
            if (document.getElementById("txtBusNo").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkbusdetailsjobclose&busno=" + document.getElementById("txtBusNo").value + "&deffectp=" + document.getElementById("ddldeffectplace").value, true);
                xmlHttp.send(null);
            }
        }

        function Chkbusdetails() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange = function() {

                if (xmlHttp.readyState == 4) {


                    resp = xmlHttp.responseText;

                    var ele = resp.split("!");

                    for (var i = 0; i < ele.length; i++) {
                       
                        if (i == 1) {
                            document.getElementById("txtBusNo").value = ele[i];
                        }
                        if (i == 11) {

                            document.getElementById("txtjob").value = ele[i];
                        }
                        if (i == 12) {

                            document.getElementById("txtjobno").value = ele[i];
                        }
                    }
                }
            }

            if ((document.getElementById("txtjobno").value != '') || (document.getElementById("txtBusNo").value != '')) {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkjobbusdetails&busno=" + document.getElementById("txtBusNo").value + "&newjob=" + document.getElementById("txtjob").value + "&newjobno=" + document.getElementById("txtjobno").value, true);
                xmlHttp.send(null);
            }


        }


        function chkBrakedown() {

            //    document.getElementById("Select1").style.display='none';
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp;

                    if (ele1 == "2" && document.getElementById("txtbdclosedtime").value == '') {
                    debugger

                        alert("Please enter Brakedown Close Time");
                     document.getElementById("txtbdclosedtime").focus();
                        return false;

                    }

                }
            }
           // var cat = document.Form1.txtItemName.Text;
            //alert(cat);
            xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkdeffectplace&busno=" + document.getElementById("txtBusNo").value + "&newjob=" + document.getElementById("txtjob").value + "&newjobno=" + document.getElementById("txtjobno").value, true);
            xmlHttp.send(null);
        }


    </script>

    <style>
        .chkliststyle input
        {
            float: left;
            width: 20%;
        }
        .chkliststyle label
        {
            float: left;
            width: 70%;
            text-align: left;
            padding-left: 3px;
            padding-right: 5px;
        }
        .style2
        {
            width: 155px;
        }
    </style>
   <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Closing Job Details</h1>
    </div>
    <div class="form-horizontal" style="overflow:auto">
     
        <div id="middal">
        
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                         
                            <tr>
                                <td align="right" style="width: 100px">
                                    Bus No
                                </td>
                                <td class="style2">
                                    <input type="text" id="txtBusNo" style="width: 140px" class="textfield" onblur="Chkbusdetails();"
                                        runat="server" />
                                </td>
                                <td align="right" style="width: 100px">
                                    Job No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtjob" Width="30px" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="txtjobno" Width="40px" onblur="Chkbusdetails();" MaxLength="4" runat="server"></asp:TextBox>
                                    <asp:Label ID="lblmsg" runat="server" ForeColor ="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <table id="tbldata" runat="server" visible="false" width="100%" border="1" align="left"
                                        cellpadding="5" cellspacing="5">
                                        <tr>
                                            <td align="right">
                                                Remark
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtremark" runat="server" Width="300px" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                            <td id ="tdbd" runat ="server" align="right">
                                                BreakDownclosedtime
                                            </td>
                                               <td id ="tdclosedtime" runat ="server" align="left">
                                                <asp:TextBox ID="txtbdclosedtime" onblur="chkBrakedown();" runat="server" Width="100px" MaxLength="5"></asp:TextBox>
                                            </td></tr><tr>
                                            <td align="right">
                                                Closed Date
                                            </td>
                                            <td id="tdclosed" runat ="server" align="left">
                                                 <asp:TextBox ID="BDPLite1" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                                    PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                            </td>
                                            <td align="right">
                                    Close Job Time
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtjotime" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                                        </tr>
                                        <tr id ="tddeffect" runat ="server">
                                            <td colspan="4" align="center">
                                                <asp:DataGrid ID="grddeffectlist" Style="align: center; valign: middle;" runat="server"
                                                    Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                                    BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                                    Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                                    ForeColor="Black" Font-Size="11pt">
                                                    <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                        Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <Columns>
                                                        <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="joc_id" HeaderText="joc_id" Visible="false"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="insp_job_dtl_id" HeaderText="insp_job_dtl_id" Visible="false">
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="deffectid" HeaderText="deffectid" Visible="false"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="defect" HeaderText="Deffect Type"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="subdefect" HeaderText="Sub Deffect Type"></asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Task Done">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txttaskdone" maxlength="1000" TextMode="MultiLine" Height="70" width="300" Text='<%#DataBinder.Eval(Container.DataItem,"taskdone")%>'
                                                                    runat="server"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                                    </Columns>
                                                </asp:DataGrid>
                                            </td>
                                        </tr>
                                         <tr id="trdocking" runat="server">
                                <td align="left" colspan ="4" width ="100%">
                                    <asp:DataGrid ID="grdinsp" width ="100%" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="Black" BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False"
                                        Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                        ForeColor="Black" Font-Size="11pt">
                                        <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                        <ItemStyle ForeColor="#000066" />
                                        <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                            Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Sr No">
                                                <ItemTemplate>
                                                    <%#Container.ItemIndex + 1%>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:BoundColumn DataField="dockingmain" ItemStyle-HorizontalAlign="left" HeaderText="Work List"
                                                Visible="True"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="note" ItemStyle-HorizontalAlign="left" HeaderText="Note"
                                                Visible="True"></asp:BoundColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                                        <tr id ="tdsave" runat ="server" >
                                            <td colspan="4" align="center">
                                               <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"
                                        TabIndex="9"></asp:ImageButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="orgbottam">
                    </div>
                </div>
            </div>
        </div>
    </div>
 
    <script>

//$("#txtjocno").autocompleteArray(
//		[<% =strjobno %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);
//	$("#txtmech").autocompleteArray(
//		[<% =strmech %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);
//	$("#txtBusNo").autocompleteArray(
//		[<% =strBusno  %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);
$(document).ready(function() {
         $("#txtjocno").autocomplete
           ({
            source: [<%= strjobno  %>]
            });
      });
      
        $(document).ready(function() {
         $("#txtmech").autocomplete
           ({
            source: [<%= strmech  %>]
            });
      });
      
        $(document).ready(function() {
         $("#txtBusNo").autocomplete
           ({
            source: [<%= strBusno  %>]
            });
      });
      
    </script>

</asp:Content>