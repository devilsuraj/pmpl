<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="sick_reason_editable.aspx.vb"
    Inherits="kdmt.sick_reason_editable" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Sick Reason Update</title>
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

            xmlHttp.onreadystatechange = function () {

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

            xmlHttp.onreadystatechange = function () {

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
        <h1>Sick Reason Update</h1>
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
                        <table width="100%" align="left" cellpadding="5" cellspacing="5">
                         
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
                                <asp:TextBox ID="txtjob" Width="60px" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="txtjobno" Width="40px" onblur="Chkbusdetails();" MaxLength="4" runat="server"></asp:TextBox>
                                    <asp:Label ID="lblmsg" runat="server" ForeColor ="Red"></asp:Label>
                                       <asp:Button ID="btnshow" runat="server" Text="Show" />
                                </td>
                            </tr>
                            <tr class="tddefect">
                                <td align="right" style="width: 100px">
                                    Reason
                                </td>
                                <td class="style2">
                                    <asp:DropDownList ID="ddlReason" runat="server">
                                                        </asp:DropDownList>
                                </td>
                                <td align="right" style="width: 100px">
                                    Description
                                </td>
                                <td>
                               <asp:TextBox ID="txtDesc" runat="server" Width="300px" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr class="tddefect">
                                <td colspan="4" align="center">
                                 
                                    <asp:Button ID="btn_update" runat="server" Text="Update" style="height: 26px" />
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" />
                                </td>
                            </tr>

                            <tr id="tddefect" >
                                            <td colspan="4" align="center">
                                             <table   id="tbldata" runat="server" visible="false" width="100%" align="left"
                                        cellpadding="5" cellspacing="5">
                                                                   
                                        <tr >
                                            <td align="left" colspan="4">
                                              Old Sick Reason:
                                           
                                               <asp:Label ID="lbloldSickReason" Font-Bold="true" runat="server"></asp:Label>
                                            </td>
                                            
                                        </tr>
                                        
                                        <tr>
                                            
                                            <td id ="tdbd" runat ="server" align="right">
                                                Reason Type:
                                            </td>
                                               <td id ="tdclosedtime" runat ="server" align="left">
                                                
                                            </td>
                                            <td align="right">
                                                Description:
                                            </td>
                                            
                                            </tr>
                           
                                        <tr id ="tdsave" runat ="server" >
                                            <td colspan="4" align="center">
                                               <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif" TabIndex="9">
                    </asp:ImageButton>
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
     <script src="../scripts/jquery-1.11.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.tddefect').hide();
            $('#btnshow').click(function () {
           
                $('.tddefect').fadeIn(300);
            });
        });
       
     
    </script>
</asp:Content>
