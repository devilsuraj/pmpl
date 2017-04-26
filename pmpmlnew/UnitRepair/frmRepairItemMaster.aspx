<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="frmRepairItemMaster.aspx.vb" Inherits="KDMT.frmRepairItemMaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Repair Item Master</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />
    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>
    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <script language="javascript">

        function redirect() {
            alert('this item already in stock');
            window.location.href('../storeitemmaster.aspx');
        }

        var clockID = 0;

        function UpdateClock() {
            if (clockID) {
                clearTimeout(clockID);
                clockID = 0;
            }

            var tDate = new Date();

            //lbltime.innerHTML = "" + tDate.getHours() + ":" + tDate.getMinutes() + ":" + tDate.getSeconds();

            clockID = setTimeout("UpdateClock()", 1000);
        }
        function StartClock() {
            clockID = setTimeout("UpdateClock()", 500);
        }

        function KillClock() {
            if (clockID) {
                clearTimeout(clockID);
                clockID = 0;
            }
        }


        function IsNumeric(strString) {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return;
        }








        function ticFunction2() {
            LogSheet2();
        }
        function ticFunction1() {
            BLogSheet();
        }


        function Fromcombo() {
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
                    var ele1 = resp.split("!");
                    while (document.getElementById("ddlitem").options.length > 0)
                        document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length - 1);
                    document.getElementById("ddlitem").value == "";
                    var temp = document.getElementById("ddlitem")
                    //if(document.Form1.txtroute.value !="")
                    // {
                    for (var i = 0; i < ele1.length - 1; i++) {
                        var temp = document.getElementById("ddlitem")
                        newOpt = document.createElement("OPTION");
                        document.getElementById("ddlitem").options.add(newOpt);
                        newOpt.value = ele1[i];
                        newOpt.innerText = ele1[i];
                        //								//if (document.Form1.txtroute.value==ele1[i])
                        //								//{
                        //								//    temp.style.display="none";				               
                        //				               //     return false;
                        //								}
                        //                               	if (ele1[i]=="0")
                        //								{
                        //								    temp.style.display="none";				               
                        //				                    return false;
                        //								}			                         
                    }

                    //}

                    //else
                    //{
                    //var temp=document.getElementById("ddlfrom")
                    //temp.size=0;
                    //temp.style.display="none";
                    //}
                }
            }
            var cat = document.Form1.ddlcat.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=itemname&itemid=" + document.Form1.ddlcat.value, true);
            xmlHttp.send(null);
        }


        function validate() {
            if (document.getElementById("ddlvendor").selectedIndex == 0) {
                alert('Please Select Department');
                document.getElementById("ddlvendor").focus()
                return false;
            }

            if (document.getElementById("txtname").value.length == 0) {
                alert('Please Enter Item Name');
                document.getElementById("txtname").focus()
                return false;
            }

            if (document.getElementById("txtDefectStatus").value.length == 0) {
                alert('Please Enter Defect stock');
                document.getElementById("txtDefectStatus").focus()
                return false;
            }

            if (document.getElementById("txtStoreStock").value.length == 0) {
                alert('Please Enter Store stock');
                document.getElementById("txtStoreStock").focus()
                return false;
            }

            if (document.getElementById("txtBusStock").value.length == 0) {
                alert('Please Enter Bus stock');
                document.getElementById("txtBusStock").focus()
                return false;
            }

            if (IsNumeric(document.getElementById("txtDefectStatus").value) == false) {
                alert('Please Enter Numbers Only ');
                document.getElementById("txtDefectStatus").focus()
                return false;
            }

            if (IsNumeric(document.getElementById("txtStoreStock").value) == false) {
                alert('Please Enter Numbers Only ');
                document.getElementById("txtStoreStock").focus()
                return false;
            }

            if (IsNumeric(document.getElementById("txtBusStock").value) == false) {
                alert('Please Enter Numbers Only ');
                document.getElementById("txtBusStock").focus()
                return false;
            }



            if (document.getElementById("ddlserialno").selectedIndex == 0) {
                alert('Please Select item serial number or not');
                document.getElementById("ddlserialno").focus()
                return false;
            }


            return true;
        }
      
			

    </script>
<link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>GATEPASS IN</h1>
    </div>
       <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <div class="form-horizontal">
  
        <div id="middal">
     
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading" colspan="4">
                                <span id="Label3">Repair Item Master</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Date:
                            </td>
                            <td align="left" colspan="2">
                             
                                    <asp:TextBox ID="BDPLite1" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                        PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td align="right">
                                Department:
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="ddlvendor" runat="server" Width="180px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Item Name:
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox ID="txtname" runat="server" Width="350px"></asp:TextBox>
                            </td>
                            <td align="right">
                                Is SerialNo:
                            </td>
                            <td align="left" colspan="2">
                                <asp:DropDownList ID="ddlserialno" runat="server">
                                    <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="0" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Unit:
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox ID="txtunit" runat="server"></asp:TextBox>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblunit" runat="server" Text="Ft , Kg , Ltr , Mtr , Roll, Set" ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td align="right">
                                Defect Stock:
                            </td>
                            <td style="width: 100px; height: 17px" align="left">
                                <asp:TextBox ID="txtDefectStatus" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Store Stock:
                            </td>
                            <td style="width: 100px; height: 17px" align="left">
                                <asp:TextBox ID="txtStoreStock" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Bus Stock:
                            </td>
                            <td style="width: 100px; height: 17px" align="left">
                                <asp:TextBox ID="txtBusStock" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Remark :
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="50px" class="textfield"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton>
                                <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>
</asp:content>