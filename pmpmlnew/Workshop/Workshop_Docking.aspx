<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="Workshop_Docking.aspx.vb"
    Inherits="kdmt.Workshop_Workshop_Docking" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Docking </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <script language="javascript" src="../Scripts/LogSheetReceipt.js">
        </script>
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
   <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>       Docking Details</h1>
    </div>
  <div class="form-horizontal" style="overflow:auto">
    
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
 
      
        <div id="middal">
         
            <div class="contantbox">
                <div class="orgtop">
                    <div class="orgmiddal">
                        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                        <div>
                            <table align="center" width="100%" border="1" cellpadding="5" cellspacing="5">
                             
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
                                        <asp:TextBox ID="txtjob" Width="60px" runat="server"></asp:TextBox>
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
</asp:Content>