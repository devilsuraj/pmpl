<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="frmibc.aspx.vb" Inherits="KDMT.frmibc" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/website.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete2.css" rel="stylesheet" />
    <link href="SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
    <link href="css/website.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete2.css" rel="stylesheet" />
    <link href="SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
    <link href="css/website.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete2.css" rel="stylesheet" />
    <link href="SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />

    <script src="popcalendar.js"></script>

    <link href="popcalendar.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .style2 {
            width: 201px;
        }

        .style3 {
            width: 201px;
            height: 23px;
        }

        .style4 {
            height: 23px;
        }
    </style>

    <script>


        function chkvendorname() {
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

                    if (ele1 == "NO-SUCH-ITEM") {
                        alert("No Such Vendor Present");
                        document.getElementById("txtvendor").focus();
                        return false;
                    }
                    else {

                        getpono();
                    }
                }
            }
            if (document.getElementById("txtvendor").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkvendorname&vendorname=" + document.getElementById("txtvendor").value, true);
                xmlHttp.send(null);
            }
        }

        function ajaxFunction() {

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

            xmlHttp.onreadystatechange = handleresponse
        }

        ajaxFunction();

        function sendRequest(url) {
            //debugger
            ajaxFunction();
            url = url + '&t=' + new Date();
            xmlHttp.open("GET", url);
            xmlHttp.send(null);
        }

        function Clean() {
            window.location.href = "frmibc.aspx";
        }


        function handleresponse() {

            var arrApp = new Array();
            if (xmlHttp.readyState == 4) {
                resp = xmlHttp.responseText;
                if (resp.indexOf('PassIndent') != -1) {
                    arrApp = resp.split("|");
                    resp = arrApp[0];
                    document.getElementById('hdnrwcnt').value = arrApp[1];
                    if (arrApp.length > 2) {
                        document.getElementById('txtvendor').value = arrApp[2];
                        document.getElementById('bdpPoDate').value = arrApp[3];
                        document.getElementById('hdnPoDate').value = arrApp[5];
                        if (arrApp[4] != '') {
                            if (arrApp[4] == 'SP') {
                                document.getElementById("lblmaterialtype").value = 'SP';
                                document.getElementById("hdnmaterial_detail").value = 'SP';


                            }
                            else {
                                document.getElementById("lblmaterialtype").value = 'HW';
                                document.getElementById("hdnmaterial_detail").value = 'HW';
                            }
                        }

                    }
                    else {
                        // var now = new Date();                                       
                        // document.getElementById('bdpPoDate').value = now.toString('dd-MMM-yyyy');
                        // document.getElementById('txtvendor').value = '';     
                    }


                }
                else if (resp.indexOf('Duplicate') != -1) {
                    alert('This Intimation No alredy entered');
                    setTimeout(function () { document.getElementById('txtintimateno').focus() }, 10);

                    return false;
                }
                else if (resp.indexOf('PoNo') != -1) {
                    var ele = resp.split("!");

                    while (document.getElementById("ListBox1").options.length > 0)
                        document.getElementById("ListBox1").options.remove(document.getElementById("ListBox1").options.length - 1);

                    for (var i = 1; i < ele.length; i++) {
                        var temp = document.getElementById("ListBox1")
                        temp.style.display = '';
                        temp.size = ele.length;
                        newOpt = document.createElement("option");
                        document.getElementById("ListBox1").options.add(newOpt);
                        newOpt.value = ele[i];
                        newOpt.text = ele[i];
                    }
                }


            }
        }

        function getpodate(obj) {

            var txtvendor = document.getElementById('txtvendor')
            var txtPoNo = document.getElementById('txtpono')
            var bdpPoDate = document.getElementById('bdpPoDate')
            if (txtPoNo.value == '') {
                alert('Please Enter PO Number.')
                return false;
            }
                //        else if (isValidDate(bdpPoDate.value) == false){
                //            alert('Please Check Date');
                //            var dt = new Date();
                //            var month = dt.getMonth() + 1;
                //            //var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
                //            //bdpPoDate.value =  currentDate;
                //            setTimeout(function(){bdpPoDate.focus()}, 10);
                //            //bdpPoDate.focus();
                //            return false;
                //        } 
            else {
                var dateTime = '04/01/2012';
                var myDate = new Date(dateTime);
                var arrDareTime = new Array();
                var ComingDate = bdpPoDate.value.replace(/-/g, '/');
                arrDareTime = ComingDate.split("/");
                var ComingDate = arrDareTime[1] + "/" + arrDareTime[0] + "/" + arrDareTime[2];
                var ComDate = new Date(ComingDate);
                if (ComDate < myDate) {
                    alert("please check your date")
                }
                var PO = txtPoNo.value.split(" ")
                var url = '../tmtAjax/Common_ajax.aspx?action=getpoDetailsdt&potype=' + PO[0] + '&pono=' + PO[1] + '&dtpo=' + obj.value + "&vendor=" + txtvendor.value;
                sendRequest(url);
                return false;
            }
        }


        function getpo() {
            var txtvendor = document.getElementById('txtvendor')
            var txtPoNo = document.getElementById('txtpono')
            if (txtPoNo.value == '') {
                return false;
            }
            else {
                var PO = txtPoNo.value.split(" | ")
                var url = '../tmtAjax/Common_ajax.aspx?action=getpoDetails&potype=' + PO[0] + '&pono=' + PO[1] + '&poyear=' + PO[2] + "&vendor=" + txtvendor.value;

                sendRequest(url);
                return false;
            }
        }
        function getpono() {

            var txtvendor = document.getElementById('txtvendor');

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtvendor.value == '') {
                txtvendor.focus();
                alert('Please Enter Vendor Name');
                return false;
            }
            else {
                var url = '../tmtAjax/Common_ajax.aspx?action=getpoNo&vendor=' + txtvendor.value;
                sendRequest(url);
                return false;
            }
        }


        function checkintimate() {

            var txtintimate = document.getElementById('txtintimateno');

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtintimate.value == '') {
                txtintimate.focus();
                alert('Please Enter Intimate No');
                return false;
            }
            else {
                var url = '../tmtAjax/Common_ajax.aspx?action=chkintimate&intimate=' + txtintimate.value;
                sendRequest(url);
                return false;
            }
        }

        function intimatevalidate() {
            var txtintimate = document.getElementById('txtintimateno');

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtintimate.value == '') {
                txtintimate.focus();
                alert('Please Enter Intimate No');
                return false;
            }
        }

        //nileshcode
        function checkLRNO() {

            var txtLrno = document.getElementById('txtLrno');

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtLrno.value == '') {
                txtLrno.focus();
                alert('Please Enter LR No');
                return false;
            }
            else {
                var url = '../tmtAjax/Common_ajax.aspx?action=chkintimate&intimate=' + txtLrno.value;
                sendRequest(url);
                return false;
            }
        }
        //


        function Select(obj) {

            var resultStr = "";
            for (var i = 0; i < obj.options.length; i++) {
                if (obj.options[i].selected) {
                    resultStr += (obj.options[i].text);
                    obj.value = resultStr;
                    obj.style.display = "none";
                    document.getElementById('txtpono').value = resultStr;
                    document.getElementById('txtpono').focus();
                    return false;
                    //alert(resultStr)
                }
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
            return true;
        }


        function validate() {

            var ddlbank = document.getElementById('ddlbank');
            var bank = ddlbank.options[ddlbank.selectedIndex].text;
            if (bank == 'select') {
                alert('Please select your Bank')
                ddlbank.focus();
                return false;
            }
            var txtintimate = document.getElementById('txtintimateno');

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtintimate.value == '') {
                txtintimate.focus();
                alert('Please Enter Intimate No');
                return false;
            }

            if (document.getElementById("txtamtinvolved").value.length == 0) {
                alert('Please Enter Involve Amount');
                document.getElementById("txtamtinvolved").focus()
                return false;
            }

            if (IsNumeric(document.getElementById("txtamtinvolved").value) == false) {
                alert('Please Enter Number Only');
                document.getElementById("txtamtinvolved").focus()
                return false;
            }
            if (document.getElementById("txtvendor").value == "") {
                alert('Enter Vendor Name');
                document.getElementById("txtvendor").focus()
                return false;
            }



            if (document.getElementById("txtinvoiceamt").value.length == 0) {
                alert('Please Enter Invoice Amount');
                document.getElementById("txtinvoiceamt").focus()
                return false;
            }

            if (IsNumeric(document.getElementById("txtinvoiceamt").value) == false) {
                alert('Please Enter Invoice Amount in Number Only');
                document.getElementById("txtinvoiceamt").focus()
                return false;
            }

            if (document.getElementById("txtreleaseamount").value.length == 0) {
                alert('Please Enter Release Amount');
                document.getElementById("txtreleaseamount").focus()
                return false;
            }

            if (IsNumeric(document.getElementById("txtreleaseamount").value) == false) {
                alert('Please Enter Release Amount in Number Only');
                document.getElementById("txtreleaseamount").focus()
                return false;
            }



            return true;
        }


    </script>
    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>IBC</h1>
    </div>
    <div align="center">

        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnmaterial_detail" runat="server" type="hidden" name="hdnmaterial_detail" />
        <input id="hdnPoDate" runat="server" type="hidden" name="hdnPoDate" />
    </div>
    <div id="middal1">

        <div class="contantbox">
            <div class="orgtop1">
            </div>
            <div class="orgmiddal1">
                <table class="style1">

                    <tr visible="false" runat="server">
                        <td>
                            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">IBC Date
                        </td>
                        <td>

                            <asp:TextBox ID="dtibc" Width="100px" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="dtibc"
                                PopupButtonID="dtibc" Format="dd-MMM-yyyy">
                            </asp:CalendarExtender>
                            <asp:ScriptManager ID="Scriptmanager1" runat="server">
                            </asp:ScriptManager>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">1) Name off the bank and branch
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlbank" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">2) Intimation No
                        </td>
                        <td>
                            <asp:TextBox ID="txtintimateno" onblur="return checkintimate()" runat="server"></asp:TextBox>
                            Date
                      
                                <asp:TextBox ID="dtintimateDate" Width="100px" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="dtintimateDate"
                                PopupButtonID="dtintimateDate" Format="dd-MMM-yyyy">
                            </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">3) Information Received On
                        </td>
                        <td>

                            <asp:TextBox ID="dtinfodate" Width="100px" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="dtinfodate"
                                PopupButtonID="dtinfodate" Format="dd-MMM-yyyy">
                            </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">4) Amount Involved
                        </td>
                        <td>
                            <asp:TextBox ID="txtamtinvolved" MaxLength="10" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">5) Last Date of payment
                        </td>
                        <td>

                            <asp:TextBox ID="dtlastdate" Width="100px" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="dtlastdate"
                                PopupButtonID="dtlastdate" Format="dd-MMM-yyyy">
                            </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">6) Details Regarding material
                        </td>
                        <td class="style4">
                            <asp:DropDownList ID="ddldrbtype" runat="server" Visible="false">
                                <asp:ListItem Text="SP" Value="SP">
                                </asp:ListItem>
                                <asp:ListItem Text="HW" Value="HW">
                                </asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="lblmaterialtype" ForeColor="red" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">a) sender name
                        </td>
                        <td>
                            <asp:TextBox ID="txtvendor" onblur="return chkvendorname()" Font-Bold="true" Width="250px"
                                runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddlPO" runat="server" Visible="false">
                                <asp:ListItem Text="RC" Value="RC">
                                </asp:ListItem>
                                <asp:ListItem Text="SP" Value="SP">
                                </asp:ListItem>
                                <asp:ListItem Text="PA" Value="PA">
                                </asp:ListItem>
                                <asp:ListItem Text="T" Value="T&C">
                                </asp:ListItem>
                                <asp:ListItem Text="PB" Value="PB">
                                </asp:ListItem>
                                <asp:ListItem Text="PMT" Value="PMT">
                                </asp:ListItem>
                            </asp:DropDownList>
                            PONO &nbsp;<asp:TextBox ID="txtpono" onblur="getpo();" runat="server">
                            </asp:TextBox>
                            <asp:ListBox ID="ListBox1" onclick="Select(this);" Style="display: none; align: left"
                                runat="server"></asp:ListBox>
                            PO. Date
                            <asp:TextBox ID="bdpPoDate" ReadOnly="true" runat="server" Size="10" Width="80"></asp:TextBox>
                            <%--  <img id="Cal_Start" onclick="return popUpCalendar(this, bdpPoDate)" src="../images/cal.gif"
                                valign="Middle" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">b) Invoice No&nbsp;
                        </td>
                        <td class="style4">
                            <asp:TextBox ID="txtinvoiceno" runat="server"></asp:TextBox>
                            Date
                        
                                <asp:TextBox ID="dtinvoicedate" Width="100px" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="dtinvoicedate"
                                PopupButtonID="dtinvoicedate" Format="dd-MMM-yyyy">
                            </asp:CalendarExtender>
                            Amount
                            <asp:TextBox ID="txtinvoiceamt" MaxLength="10" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style3">c) LR No</td>
                        <td class="style4">
                            <asp:TextBox ID="txtLrno" runat="server"></asp:TextBox>
                            &nbsp;Date
                         
                                <asp:TextBox ID="DTLrdate" Width="100px" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender6" runat="server" TargetControlID="DTLrdate"
                                PopupButtonID="DTLrdate" Format="dd-MMM-yyyy">
                            </asp:CalendarExtender>
                        </td>

                    </tr>
                    <tr>
                        <td class="style2">d) Amout to be released by as per terms by bank
                        </td>
                        <td>
                            <asp:TextBox ID="txtreleaseamount" MaxLength="10" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">e) Terms of payment accepted by PMPML
                        </td>
                        <td>
                            <asp:TextBox ID="txtpaymentterms" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">f) Bank Commossion charges to be borne by
                        </td>
                        <td>
                            <asp:TextBox ID="txtbccharge" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">g) other details if any
                        </td>
                        <td>
                            <asp:TextBox ID="txtothers" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="style2">
                            h) Rates as per purchase order
                        </td>
                        <td>
                            <asp:TextBox ID="txtratespurchase" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                       <tr>
                        <td class="style2">
                            i) Change in Rates
                        </td>
                        <td>
                            <asp:TextBox ID="txtchnginrate" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                       <tr>
                        <td class="style2">
                            j) Quantity Demand
                        </td>
                        <td>
                            <asp:TextBox ID="txtqtydmnd" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                       <tr>
                        <td class="style2">
                            k) Total Qty Received
                        </td>
                        <td>
                            <asp:TextBox ID="txttotqtyrec" runat="server"></asp:TextBox>
                        </td>
                    </tr> --%>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                border="0" Width="87" Height="38" AlternateText="Save" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="orgbottam1">
            </div>
        </div>
    </div>


    <script type="text/javascript">

        $("#txtvendor").autocomplete(

                {
                    source: [<% =strVendor  %>]
		}
	);

    </script>

</asp:Content>
