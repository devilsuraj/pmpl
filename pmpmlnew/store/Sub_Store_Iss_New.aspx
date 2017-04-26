<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Sub_Store_Iss_New.aspx.vb"
     Inherits="KDMT.Sub_Store_Iss_New" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script language="javascript">


        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;


        function addissueDetails() {


            if (document.getElementById('hdnsrno').value == '') {
                document.getElementById('hdnsrno').value = 0;
            }
            var srno = 0;
            var lblsrno = document.getElementById('lblsrno');
            var txtBinNo = document.getElementById('txtBinNo');
            var txtPartNo = document.getElementById('txtPartNo');
            var txtItemName = document.getElementById("txtItemName");
            var txtbqty = document.getElementById('txtbqty');
            var txtReqQty = document.getElementById('txtReqQty');



            var tbody = document.getElementById('tbodyIndent');
            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trissue_' + rowcnt);
            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdsrno_' + rowcnt);
            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdlfNo_' + rowcnt);
            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdPartNo_' + rowcnt);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdItemName_' + rowcnt);
            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdbqty_' + rowcnt);
            var cells6 = row.insertCell(5);
            cells6.setAttribute('id', 'tdqty_' + rowcnt);
            var cells7 = row.insertCell(6);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
            cells2.innerHTML = txtBinNo.value;
            cells3.innerHTML = txtPartNo.value;
            cells4.innerHTML = txtItemName.value;
            cells5.innerHTML = txtbqty.value;
            cells6.innerHTML = txtReqQty.value;
            cells7.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trissue_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'



            rowcnt = rowcnt + 1;
            txtBinNo.value = '';
            txtPartNo.value = '';
            txtItemName.value = '';
            txtbqty.value = '';
            txtReqQty.value = '';

            //txtoiltype.value = '';  

            txtBinNo.focus();
            document.getElementById('hdnrwcnt').value = rowcnt;
            // alert(document.getElementById('hdnrwcnt').value)
        }

        function deleteRow(cnt) {
            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;
            document.getElementById('hdnsrno').value = 0;
            for (i = 1; i < hdnrwcnt.value; i++) {
                if (document.getElementById('tdItemName_' + i) != null) {
                    document.getElementById('tdsrno_' + i).innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1
                    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
                }
            }
        }

        function addissueitem() {
            //if (document.getElementById("chkReturn").checked == false) {
            //            if (parseFloat(document.getElementById("txtbqty").value) < parseFloat(document.getElementById("txtReqQty").value)) {
            //                alert("Issue Qty sholuld be less than or equal to available qty");
            //                setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
            //                return false;
            //            }

            //            if (parseFloat(document.getElementById("txtReqQty").value) == 0) {
            //                alert("Issue Qty sholuld not be equal to zero");
            //                setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
            //                return false;
            //            }

            if (document.getElementById("txtReqQty").value.length > 0) {
                if (IsNumeric(document.getElementById("txtReqQty").value)) {
                    addissueDetails();
                }
                else {
                    alert("Enter Proper Value");
                    setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
                    return false;
                }
            }
        }

        function save() {

            var Recs = '';
            var j = 0;
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;

            for (i = 0; i < hdnrwcnt; i++) {
                var RecQty = document.getElementById('txtIssQty_' + i)

                if (RecQty.value != 0) {
                    j = 1;
                }
            }

            if (j == 0) {
                alert('Please Enter Atleast One Issue Qty');
                return false;
            }

            for (i = 0; i < hdnrwcnt; i++) {

                if (document.getElementById('tdlfNo_' + i) != null) {
                    var BinNo = document.getElementById('tdlfNo_' + i).innerHTML;
                    var PartNo = document.getElementById('tdPartNo_' + i).innerHTML;
                    var ItemName = document.getElementById('tdItemName_' + i).innerHTML;
                    var AvbQty = document.getElementById('tdbqty_' + i).innerHTML;
                    //var RecQty = document.getElementById('tdqty_' + i).innerHTML;
                    var RecQty = document.getElementById('txtIssQty_' + i).value;

                    Recs = Recs + '' + BinNo + '|' + PartNo + '|' + ItemName + '|' + AvbQty + '|' + RecQty + '^'

                }
            }

            document.getElementById("Hid_Rec").value = Recs;

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

        function fillItemName() {
            objddl2 = document.getElementById('Select1');
            if (document.getElementById("ddlitem").value != "" && objddl2.options.length > 0) {
                document.getElementById("ddlitem").value = objddl2.options[0].text;
                document.getElementById("txtReqQty").focus();
            }

        }
        function validate() {
           
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;


            for (k = 0; k < hdnrwcnt; k++) {

                if (document.getElementById('tdlfNo_' + k) != null) {


                    var BinNo = document.getElementById('tdlfNo_' + k).innerHTML;
                    var PartNo = document.getElementById('tdPartNo_' + k).innerHTML;
                    var ItemName = document.getElementById('tdItemName_' + k).innerHTML;
                    var AvbQty = document.getElementById('tdbqty_' + k).innerHTML;
                    var Reqqty = document.getElementById('tdqty_' + k).innerHTML;
                    var IssQty = document.getElementById('txtIssQty_' + k).value;

                    if (IssQty == '') {
                        alert('Please Enter Issue Qty ');
                        setTimeout(function () { document.getElementById('txtIssQty_' + k).focus() }, 1000);
                        return false;
                    }
                    if (IsNumeric(IssQty) == false) {
                        alert('Please Enter Proper value ');
                        setTimeout(function () { document.getElementById('txtIssQty_' + k).focus() }, 1000);
                        return false;
                    }
                    if (parseFloat(IssQty) > parseFloat(Reqqty)) {
                        alert('Issue Qty Should be less than Requested Qty');
                        setTimeout(function () { document.getElementById('txtIssQty_' + k).focus() }, 1000);
                        return false;
                    }

                    if (parseFloat(IssQty) > parseFloat(AvbQty)) {
                        alert('Issue Qty Should be less than Available Qty');
                        setTimeout(function () { document.getElementById('txtIssQty_' + k).focus() }, 1000);
                        return false;
                    }

                    //                    Recs = Recs + '' + BinNo + '|' + PartNo + '|' + ItemName + '|' + AvbQty + '|' + RecQty + '^'

                }
            }

            if (save() == false) { return false; }
            else { return true; }
        }

        function chkItemName() {
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

                        alert("No Such Item Present");
                        document.Form1.ddlitem.focus();

                    }

                }
            }
            var cat = document.Form1.ddlitem.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=chkitemname&itemid=" + document.Form1.ddlitem.value, true);
            xmlHttp.send(null);
        }

        function ajaxFunction() {
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

                    if (resp == 0) {
                        //alert("No Such item")
                        return false;
                    }

                    var ele = resp.split("!");
                    //			                          

                    while (document.getElementById("Select1").options.length > 0)
                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);

                    if (document.Form1.ddlitem.value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("Select1")
                            temp.style.display = "block";
                            temp.size = ele.length;
                            //alert("asdasd")
                            newOpt = document.createElement("OPTION");
                            document.getElementById("Select1").options.add(newOpt);

                            //str=ele[i];
                            //alert (ele[i] + "ravi")
                            newOpt.value = ele[i];
                            newOpt.innerText = ele[i];
                            if (document.Form1.ddlitem.value == ele[i]) {
                                //alert("ravi")
                                temp.style.display = "none";
                                return false;
                            }
                            if (ele[i] == "0") {
                                //alert("raviwewerwer")
                                temp.style.display = "none";
                                return false;
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById("Select1")
                        temp.size = 0
                        temp.style.display = "none";

                    }
                }
            }
            xmlHttp.open("GET", "AjaxStore.aspx?Action=itemname1&itemid=" + document.Form1.ddlcat.value + "&item=" + document.Form1.ddlitem.value, true);
            //xmlHttp.open("GET","Ajaxwaytrip.aspx?Action=Fair&&start="+document.Form1.ddlfrom.value+"&end="+document.Form1.ddlto.value+"&value="+document.Form1.txtroute.value+"&age="+document.Form1.txtAge.value+"&Passtype="+'ST'+"&direction="+'N'+"&month="+document.Form1.hidmonth.value,true);
            //xmlHttp.open("GET","../store/AjaxStore.aspx?Action=item&itemname="+document.Form1.txtitem.value,true);
            xmlHttp.send(null);
            //alert(document.frmRF.txtlocation.value)
        }



        function Select() {

            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('ddlitem');
                    objddl1.value = resultStr;
                    var x = document.getElementById('Select1');
                    x.style.display = "none";
                    document.getElementById('ddlitem').focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }

        //////////////   end  filteration   ///////////////////////////

        // check for numeric fields only

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



        function ticFunction2() {
            if (document.getElementById("txtReqQty").value.length > 0) {

                if (IsNumeric(document.getElementById("txtReqQty").value)) {
                    LogSheet2();
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtReqQty").focus();
                }
            }
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
                    }
                }
            }
            var cat = document.Form1.ddlcat.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=itemname&itemid=" + document.Form1.ddlcat.value, true);
            xmlHttp.send(null);
        }





        function Fromcombo2() {
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
                    var ele1 = resp.split('|');
                    Form1.txtbqty.value = ele1[0];

                }
            }
            var cat = document.Form1.ddlitem.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=itemqty&itemid=" + document.Form1.ddlitem.value, true);
            xmlHttp.send(null);
        }




    </script>
    <style> 
   
        table{border-collapse:collapse!important; }
            table td, table th {
                background-color: #fff !important;
                text-align: left;
                padding: 10px;
                margin-top: 3px;
             font-family: "Open Sans",sans-serif;
             font-weight:400;
             font-size:14px;
            }
               

    table td input[type=number], input[type=text],input[type=date],input[type=time], input[type=password],input[type=email], select, textarea {
                width: 100%;
    height: 34px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #c2cad8;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            } 

    table td textarea{margin:0;font:inherit;color:inherit;overflow:auto;height:auto;}

     table td input[type=submit] {
                    color: #FFF;
    background-color: #3598dc;
    border-color: #3598dc;
                }

                table td input[type=submit] {
                    color: #666;
                    background-color: #c2cad8;
                    border-color: #bcc5d4;
                }
     

            table td lable{
                    font-weight: 400;
                        display: inline-block;
                        max-width:100%;
            }
        #ddlwmr {
        width:150px;
        }
 

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" Runat="Server">
      <div class="breadcrumbs">
        <h1>         Issue To Workshop</h1>
    </div>
     <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnVechName" runat="server" type="hidden" name="hdnVechName" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
    <div>
        <table width="70%">
            <tr>
                <td align="right">
                    Date :
                </td>
                <td align="left">
                    <asp:TextBox ID="txtissuedate" Width="120"  runat="server"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtissuedate"
                        PopupButtonID="imgPopBtnissue" Format="dd-MMM-yyyy">
                    </asp:CalendarExtender>
                    <asp:ImageButton ID="imgPopBtnissue" ImageAlign="AbsBottom" ImageUrl="~/images/imgCalendar.png"
                        runat="server" />
                    <asp:ScriptManager ID="Scriptmanager1" runat="server">
                    </asp:ScriptManager>
                </td>
                <td align="right">
                    WMR No :
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlwmr" runat="server" >
                    </asp:DropDownList>
                    <input type="button" class="btn btn-cont" id="btnshow" onclick="getPartItem(this,5)" value='Show' />
                </td>
            </tr>
            <tr id='trdet' style="display: none">
                <td align="right">
                    Vehicle No
                </td>
                <td align="left">
                    <asp:Label ID="lblvehicle" Font-Bold="true" runat="server"></asp:Label>
                </td>
                <td align="right">
                    Section Name:
                </td>
                <td align="left">
                    <asp:Label ID="lblvendor" Font-Bold="true" runat="server"></asp:Label>
                    <asp:HiddenField ID="hdnVenId" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    Worker Name :
                </td>
                <td align="left">
                    <asp:TextBox ID="txtwname"  runat="server"
                        Font-Size="Medium"></asp:TextBox>
                </td>
                <td align="right">
                    Approved By :
                </td>
                <td align="left">
                    <asp:TextBox ID="txtapproved" runat="server"
                        Font-Size="Medium"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Gate Pass No :
                </td>
                <td align="left">
                    <asp:TextBox ID="txtgate" runat="server"  Font-Size="Medium"></asp:TextBox>
                </td>
                <td align="right">
                    Remark :
                </td>
                <td align="left">
                    <asp:TextBox ID="txtremark"  TextMode="MultiLine" runat="server" 
                         Font-Size="Medium"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Job No :
                </td>
                <td align="left" class="style1">
                    <asp:TextBox ID="txtjobyymm" runat="server" Width="90px" MaxLength="4"></asp:TextBox>
                    <asp:TextBox ID="txtjobno" runat="server" Width="50px" MaxLength="2"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    &nbsp;<%--<asp:Button ID="btnshow" OnClientClick="getPartItem(this,5)" runat="server" Text="Show" />--%>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="dvItmDet">
                    </div>
                </td>
            </tr>
            <tr id='trsave' style="display: none">
                <td colspan="4" align="center">
                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif" >
                    </asp:ImageButton>&nbsp;<asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
                       ></asp:ImageButton>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="Hid_Rec" runat="server" />
    </div>
    <script type="text/jscript" language="javascript">

        //-->


        $(document).ready(function () {
            SearchText();

        });

        function checkqty(id, Avbqty, reqqty) {


            if ((document.getElementById(id).value == '')) {
                alert('Please Enter Proper Qty')
                setTimeout(function () { document.getElementById(id).focus() }, 10);
                return false;
            }

            if ((document.getElementById(id).value == '0') && parseFloat(Avbqty) != 0) {
                alert('Please Enter Proper Qty');
                setTimeout(function () { document.getElementById(id).focus() }, 10);

                return false;
            }
            if (IsNumeric(document.getElementById(id).value) == true) {
                if (parseFloat(document.getElementById(id).value) > parseFloat(reqqty)) {
                    alert('Should be less than or Equal to Request Qty')
                    setTimeout(function () { document.getElementById(id).focus() }, 10);
                    return false;
                }
            }
            else {
                alert('Please Enter Proper Qty')
                setTimeout(function () { document.getElementById(id).focus() }, 10);
                return false;
            }


            if (IsNumeric(document.getElementById(id).value) == true) {
                if (parseFloat(document.getElementById(id).value) > parseFloat(Avbqty)) {
                    alert('Should be less than or Equal to Available Qty')
                    setTimeout(function () { document.getElementById(id).focus() }, 10);
                    return false;
                }
            }
            else {
                alert('Please Enter Proper Qty')
                setTimeout(function () { document.getElementById(id).focus() }, 10);
                return false;
            }
        }


        function ValIssQty(i) {

            //var pattern = /^[0-9]+$/;   //(^[0-9]*[1-9]+[0-9]*\.[0-9]*$)|(^[0-9]*\.[0-9]*[1-9]+[0-9]*$)|(^[0-9]*[1-9]+[0-9]*$)
            var pattern = /^(([0-9]*)|(([0-9]*).([0-9]*)))$ /;
            var tdAvlqty = document.getElementById('tdbqty_' + i);
            var tdqty = document.getElementById('tdqty_' + i);
            var txtIssQty = document.getElementById('txtIssQty_' + i);
            var tdBalQty = document.getElementById('tdBalQty_' + i);
            var tdIssuedQty = document.getElementById('tdIssuedQty_' + i);

            //            if (txtIssQty.value.trim() != '' || txtIssQty.value.trim() != '0') {
            //                if (!pattern.test(txtIssQty.value.trim())) {
            if (IsNumeric(txtIssQty.value.trim()) == false) {
                alert('Enter only numeric value');
                txtIssQty.vaue = '';
                setTimeout(function () { txtIssQty.focus() }, 7000);
                return false;
            }
            if (parseInt(txtIssQty.value.trim()) <= 0) {
                alert('Enter Proper Qty');
                txtIssQty.vaue = '';
                setTimeout(function () { txtIssQty.focus() }, 7000);
                return false;
            }
            if (parseInt(txtIssQty.value.trim()) > parseInt(tdAvlqty.innerHTML.trim())) {
                alert('Issue Qty Should not greater then Available Qty');
                txtIssQty.vaue = '';
                setTimeout(function () { txtIssQty.focus() }, 7000);
                return false;
            }
            if ((parseInt(txtIssQty.value.trim()) + parseInt(tdIssuedQty.innerHTML.trim())) > parseInt(tdqty.innerHTML.trim())) {
                alert('Issue Qty Should not greater then Requested Qty');
                txtIssQty.vaue = '';
                setTimeout(function () { txtIssQty.focus() }, 7000);
                return false;
            }
            return true;
            //tdBalQty.innerHTML = tdqty.innerHTML.trim() - txtIssQty.value.trim() - tdIssuedQty.innerHTML.trim();
            //tdIssuedQty.innerHTML = parseInt(txtIssQty.value.trim()) + parseInt(tdIssuedQty.innerHTML.trim());
            // }
        }

        function getPartItem(obj, Type) {

            var lblvehicle = document.getElementById('lblvehicle');
            var hdnVechName = document.getElementById('hdnVechName');
            var hdnVenId = document.getElementById('hdnVenId');
            var lblvendor = document.getElementById('lblvendor');
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            var ddlwmr = document.getElementById('ddlwmr');


            if (obj.value != '') {
                $.ajax({ type: 'POST', url: 'Sub_Store_Iss_New.aspx?Type=' + Type + '&mrvno=' + ddlwmr.value + "&Opt=GetFill", data: $('#form1').serialize(), success: function (response) {

                    if (response.substring(0, 9) == 'saveError') {
                        alert('Error occured while fetching data.')
                        isSaveClicked = 0;
                    }
                    else if (response.substring(0, 3) == 'got') {

                        arrobj = response.substring(3).split("~");
                        dvItmDet.innerHTML = arrobj[2];
                        lblvehicle.innerHTML = arrobj[3];
                        hdnVechName.value = arrobj[3];
                        hdnVenId.value = arrobj[4];
                        lblvendor.innerHTML = arrobj[5];
                        hdnrwcnt.value = arrobj[6];
                        $("#trsave").css("display", "block");
                        $("#trdet").css("display", "block");
                        return false;


                    }
                    else if (response.substring(0, 8) == 'NotExist') {
                        $('#lblMRVExist').html('');
                    }
                    else if (response.substring(0, 5) == 'Exist') {
                        $('#lblMRVExist').html('Exist');



                        txtMRV.focus();
                    }
                }
                });
            }
        }

        function SearchText() {

            $("#txtPartNo").autocomplete
                           ({

                               source: function (request, response) {
                                   $.ajax
                                    ({

                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "Indent_Request_Details.aspx/GetAutoCompleteDataPartNo",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,
                                        data: JSON.stringify({ "ItemName": $.trim($('#txtItemName').val()), "PartNo": $.trim($('#txtPartNo').val()), "BinNo": $.trim($('#txtBinNo').val()) }),
                                        //dataType: "json",
                                        success: function (data) {
                                            //lblPrtExist = document.getElementById("lblPrtExist") 
                                            //$("lblPrtExist").value = "NotExist";
                                            if (data.d == 'NotExist') { $('#lblPrtExist').html('NotExist'); }
                                            else { response(data.d); $('#lblPrtExist').html(''); $('#lblItmExist').html(''); $('#lblBinExist').html(''); }

                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });

                               }
                           });


            $("#txtItemName").autocomplete
                           ({
                               source: function (request, response) {
                                   $.ajax
                                    ({

                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "Indent_Request_Details.aspx/GetAutoCompleteDataItemName",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,
                                        data: JSON.stringify({ "PartNo": $.trim($('#txtPartNo').val()), "ItemName": $.trim($('#txtItemName').val()), "BinNo": $.trim($('#txtBinNo').val()) }),
                                        //dataType: "json",
                                        success: function (data) {
                                            if (data.d == 'NotExist') {
                                                $('#lblItmExist').html('NotExist');
                                            }
                                            else { response(data.d); $('#lblItmExist').html(''); $('#lblPrtExist').html(''); $('#lblBinExist').html(''); }
                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });

                               }
                           });

            $("#txtBinNo").autocomplete
                           ({
                               source: function (request, response) {
                                   $.ajax
                                    ({


                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "Indent_Request_Details.aspx/GetAutoCompleteDataBinNo",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,

                                        data: JSON.stringify({ "PartNo": $.trim($('#txtPartNo').val()), "ItemName": $.trim($('#txtItemName').val()), "BinNo": $.trim($('#txtBinNo').val()) }),
                                        //dataType: "json",
                                        success: function (data) {
                                            if (data.d == 'NotExist') {
                                                $('#lblBinExist').html('NotExist');
                                            }
                                            else { response(data.d); $('#lblItmExist').html(''); $('#lblPrtExist').html(''); $('#lblBinExist').html(''); }
                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });

                               }
                           });


            $("#txtvehicle").autocomplete
           ({

               source: function (request, response) {
                   $.ajax
                    ({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Workshop/workshopreport.aspx/GetAutoComplete",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('txtvehicle').value }),
                        //dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

               }
           });

            $("#txtWMR").autocomplete
           ({

               source: function (request, response) {
                   $.ajax
                    ({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Workshop/workshopreport.aspx/GetAutoCompleteWMR",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SearchText": document.getElementById('txtWMR').value }),
                        //dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

               }
           });



        }
       
        
    </script>
</asp:Content>

