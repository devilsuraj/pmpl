<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Workshop_Docking.aspx.vb"
    Inherits="KDMT.Workshop_Workshop_Docking" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Docking </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <script language="javascript" src="../Scripts/LogSheetReceipt.js">

    <script type="text/javascript" language="JavaScript" src="../Scripts/FusionCharts.js"></script>
    <script type="text/javascript" language="JavaScript">
        function myJS(myVar, mybus, inspstatus, insp, insptype, jobno,newjob,newjobno) {
            //window.alert(myVar);
            if (insptype == "1") {
                window.open('Insp_docking_list.aspx?insp1=' + myVar + '&busno=' + mybus + '&inspstatus=' + inspstatus + '&insp=' + insp + '&insptype=' + insptype + '&jobno=' + jobno + '&newjob=' + newjob + '&newjobno=' + newjobno + '', 'name', 'width=1200,height=500,scrollbars=1');
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

            xmlHttp.onreadystatechange = function () {

                if (xmlHttp.readyState == 4) {

                    resp = xmlHttp.responseText;

                    var ele = resp.split("!");

                    for (var i = 0; i < ele.length; i++) {
                        if (i == 1) {

                            document.getElementById("txtjoc").value = ele[i];

                        }
                        if (i == 2) {

                            document.getElementById("txtjob").value = ele[i];
                        }
                        if (i == 3) {

                            document.getElementById("txtjobno").value = ele[i];
                        }
                    }
                }
            }
            if (document.getElementById("txtBusNo").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkbusdetailsjob_Docking&busno=" + document.getElementById("txtBusNo").value, true);
                xmlHttp.send(null);
            }
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
        .style4
        {
            height: 31px;
        }
    </style>
</head>
<body>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <form id="form1" runat="server">
    <div>
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                    <div class="orgmiddal">
                        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                        <div>
                            <table align="center" width="100%" border="1" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td colspan="4" class="style4">
                                        Docking Details
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Bus No.
                                    </td>
                                    <td>
                                        <input type="text" id="txtBusNo" style="width: 140px" class="textfield" onblur="Chkbusdetails();"
                                            runat="server" />
                                        <%--<asp:TextBox ID="txtBusNo" runat="server" Width="140px"></asp:TextBox>--%>
                                    </td>
                                    <td align="right">
                                        JOC No :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtjob" Width="30px" runat="server"></asp:TextBox>
                                        <asp:TextBox ID="txtjobno" Width="40px" MaxLength="4" TabIndex="1" AutoPostBack="True"
                                            runat="server"></asp:TextBox>
                                        <input type="text" id="txtjoc" style="width: 170px; display: none" class="textfield"
                                            runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="Button1" runat="server" Text="Show" Style="height: 26px" />
                                    </td>
                                    <td align="right">
                                        TotalKm
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lbltotalkm" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <asp:Literal ID="FCLiteral2" runat="server"></asp:Literal>
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
    </form>
    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//    $("#txtBusNo").autocompleteArray(
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

//    $("#txtjoc").autocompleteArray(
//		[<% =strjobno  %>],
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
         $("#txtBusNo").autocomplete
           ({
            source: [<%= strBusno  %>]
            });
      });
//      
//       $(document).ready(function() {
//         $("#txtjoc").autocomplete
//           ({
//            source: [<%= strjobno  %>]
//            });
//      });




    </script>
</body>
</html>
