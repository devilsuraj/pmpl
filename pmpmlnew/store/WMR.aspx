<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="WMR.aspx.vb"
     Inherits="KDMT.WMR" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
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

            /////////for duplicate check   //////////////
            for (i = 1; rowcnt > i; i++) {
                var itemname = document.getElementById('tdBinNo_' + i).innerHTML
                var itemnamenow = document.getElementById('txtBinNo').value
                if (itemname == itemnamenow) {
                    alert('This Item Already Entered Above.');
                    return false;
                }

            }



            var tbody = document.getElementById('tbodyIndent');
            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trissue_' + rowcnt);
            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdsrno_' + rowcnt);
            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdBinNo_' + rowcnt);
            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdPartNo_' + rowcnt);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdItemName_' + rowcnt);
            //            var cells5 = row.insertCell(4);
            //            cells5.setAttribute('id', 'tdbqty_' + rowcnt);
            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdqty_' + rowcnt);
            var cells6 = row.insertCell(5);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
            cells2.innerHTML = txtBinNo.value;
            cells3.innerHTML = txtPartNo.value;
            cells4.innerHTML = txtItemName.value;
            //            cells5.innerHTML = txtbqty.value;
            cells5.innerHTML = txtReqQty.value;
            cells6.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trissue_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'



            rowcnt = rowcnt + 1;
            txtBinNo.value = '';
            txtPartNo.value = '';
            txtItemName.value = '';
            //txtbqty.value = '';
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




        function chkitem() {

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
                    if (ele1.substring(0, 8) == "NotExist") {
                        document.getElementById('txtItemName').value = '';
                        alert("No Such Item Present");
                        document.getElementById('txtBinNo').focus();
                        return false;
                    }
                    else {
                        return addissueitem();

                    }

                }
            }

            var txtBinNo = document.getElementById('txtBinNo').value;
            var txtItemName = document.getElementById('txtItemName').value;
            if (txtBinNo != '') {

                xmlHttp.open("GET", "../store/Sub_Store_Iss.aspx?Action=chkitem&binno=" + txtBinNo + " &name=" + txtItemName, true);
                xmlHttp.send(null);
                return false;
            }

            return true;
        }




        function addissueitem() {
            //if (document.getElementById("chkReturn").checked == false) {
            //            if (parseFloat(document.getElementById("txtbqty").value) < parseFloat(document.getElementById("txtReqQty").value)) {
            //                alert("Issue Qty sholuld be less than or equal to available qty");
            //                setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
            //                return false;
            //            }
            if ((document.getElementById("txtBinNo").value) == '') {
                alert("Bin No should not be blank");
                setTimeout(function () { document.getElementById('txtBinNo').focus() }, 10);
                return false;
            }
            if ((document.getElementById("txtItemName").value) == '') {
                alert("Item Name should not be blank");
                setTimeout(function () { document.getElementById('txtBinNo').focus() }, 10);
                return false;
            }

            if (parseFloat(document.getElementById("txtReqQty").value) == 0) {
                alert("Issue Qty sholuld not be equal to zero");
                setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
                return false;
            }
            if (parseFloat(document.getElementById("txtbqty").value) < parseFloat(document.getElementById("txtReqQty").value)) {
                alert("Issue Qty sholuld be less than or equal to available qty");
                setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
                return false;
            }

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

            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            for (i = 1; i < hdnrwcnt; i++) {



                if (document.getElementById('tdBinNo_' + i) != null) {

                    var BinNo = document.getElementById('tdBinNo_' + i).innerHTML;
                    var PartNo = document.getElementById('tdPartNo_' + i).innerHTML;
                    var ItemName = document.getElementById('tdItemName_' + i).innerHTML;
                    var RecQty = document.getElementById('tdqty_' + i).innerHTML;

                    Recs = Recs + '' + BinNo + '|' + PartNo + '|' + ItemName + '|' + RecQty + '^'

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


            if (IsValidDate(document.getElementById("txtissuedate").value) == false) {
                alert('Incorrect WMR Date Format');
                document.getElementById("txtissuedate").focus()
                return false;
            }

            if (document.getElementById("ddlvendor").selectedIndex == 0) {
                alert('Select Section Name');
                document.getElementById("ddlvendor").focus()
                return false;
            }
            if (document.getElementById("ddlvendor").value == 16) {
                if (document.getElementById("txtvehicle").value == '') {
                    alert('Please Enter Vehicle No');
                    document.getElementById("txtvehicle").focus()
                    return false;
                }
            }

            if (document.getElementById("txtWMR").value == '') {
                alert('Please Enter WMR');
                document.getElementById("txtWMR").focus()
                return false;
            }

            if (document.getElementById('hdnrwcnt').value == '' || document.getElementById('hdnrwcnt').value == '0') {
                alert('Please Enter Atlaest One Material');
                document.getElementById('txtBinNo').focus()
                return false;
            }
            save();
            return true;
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


        function vechvalid(objvech) {


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
                    if (resp == 9) {
                        alert("No Such vehicle")
                        // document.getElementById("tableVech").focus();
                        objvech.value = ''
                        objvech.focus();
                        return false;
                    }

                }

            }

            if (objvech.value != '') {

                xmlHttp.open("GET", "../Forms/Ajaxstore.aspx?Action=checkvehicle&vechno=" + objvech.value + "&Fueltype=2", true);

                xmlHttp.send(null);
            }
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

 

</style>
        </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" Runat="Server">
     <div class="breadcrumbs">
        <h1>WorkShop Material Request</h1>
    </div>
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
    
    <div id="middal">
        <div class="contantbox">
            <div class="orgmiddal">
                <div>
                    <table>
                     
                        <tr>
                            <td class="style4">
                                <table width="100%">
                                    <tr>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Date :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtissuedate" Width="80px" runat="server"></asp:TextBox>
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
                                        <td align="left" class="style1">
                                            <asp:TextBox ID="txtWMR" ReadOnly="False" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <%--<td align="right">
                                Date :
                            </td>
                            <td align="left" class="style1">
                                <BDP:BDPLite ID="BDPLite1" runat="server" TabIndex="3">
                                </BDP:BDPLite>
                            </td>--%>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Job No :
                                        </td>
                                        <td align="left" class="style1">
                                            <asp:TextBox ID="txtjobyymm" runat="server" Width="50px"></asp:TextBox>
                                            <asp:TextBox ID="txtjobno" runat="server" Width="20px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <%--Worker Name :--%>
                                            Vehicle No
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtvehicle" onblur="return vechvalid(this);" runat="server" Width="168px"></asp:TextBox>
                                            <asp:AutoCompleteExtender ServiceMethod="SearchVehicle" MinimumPrefixLength="1" CompletionInterval="100"
                                                EnableCaching="false" CompletionSetCount="10" TargetControlID="txtvehicle" ID="AutoCompleteExtender1"
                                                runat="server" FirstRowSelected="false">
                                            </asp:AutoCompleteExtender>
                                        </td>
                                        <td align="right">
                                            Section Name:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlvendor" runat="server" Width="216px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Approved By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtapprovedby" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Remark
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtremark" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                                <table id="Grd_Item" class="heading1" width="100%" border="1">
                                    <tbody runat="server" id="tbodyIndent">
                                        <tr class='gridhead'>
                                            <td>
                                                SR No.
                                            </td>
                                            <td>
                                                LF No.
                                            </td>
                                            <td>
                                                Part No.
                                            </td>
                                            <td>
                                                Item Name
                                            </td>
                                            <td style="display: none">
                                                Available<br />
                                                Qty.
                                            </td>
                                            <td>
                                                Request Qty.
                                            </td>
                                        </tr>
                                        <tr class='gridtxt'>
                                            <td>
                                                <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtBinNo" onblur="getPartItem(this,3)" name="txtBinNo" size="20" />
                                                <label id="lblBinExist">
                                                </label>
                                            </td>
                                            <td>
                                                <input type="text" id="txtPartNo" name="txtPartNo" size="20" />
                                                <label id="lblPrtExist">
                                                </label>
                                            </td>
                                            <td>
                                                <input type="text" id="txtItemName" style="width: 250px" size="100" name="txtItemName" />
                                                <label id="lblItemCode">
                                                </label>
                                                <label id="lblItmExist">
                                                </label>
                                                <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                    runat="server"></asp:ListBox>
                                            </td>
                                            <td align="left" style="width: 43px; height: 28px; display: none">
                                                <asp:TextBox ID="txtbqty" runat="server" Width="56px" ReadOnly="True"></asp:TextBox>
                                            </td>
                                            <td>
                                                <input type="text" id="txtReqQty" style="width: 100px" name="txtReqQty" onblur="return chkitem();" />
                                            </td>
                                        </tr>
                                        <%-- <tr>
                                <td class="style8">
                                    Sr
                                </td>
                                <td class="style9">
                                    Category
                                </td>
                                <td style="width: 147px; height: 24px">
                                    Item Name
                                </td>
                                <td style="width: 43px; height: 24px">
                                    Available<br />
                                    Qty.
                                </td>
                                <td style="height: 24px">
                                    Ref. no
                                </td>
                                <td style="height: 24px">
                                    Returnable
                                </td>
                                <td style="width: 55px; height: 24px">
                                    Issue
                                    <br />
                                    Qty.
                                </td>
                            </tr>
                            <tr>
                                <td class="style8">
                                </td>
                                <td align="left" class="style10">
                                    <asp:DropDownList ID="ddlcat" runat="server" Width="181px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="ddlitem"  onblur="Fromcombo2()"
                                        runat="server" Width="200px"></asp:TextBox>
                                    <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                        runat="server"></asp:ListBox>
                                </td>
                                <td align="left" style="width: 43px; height: 28px;">
                                    <asp:TextBox ID="txtbqty" runat="server" Width="56px" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td style="height: 28px; width: 55px;">
                                    <asp:TextBox ID="txtRefNo" runat="server" Width="56px"></asp:TextBox>
                                </td>
                                <td style="height: 28px">
                                    <asp:CheckBox ID="chkReturn" runat="server" Text=" " />
                                </td>
                                <td align="left" style="height: 28px;">
                                    <asp:TextBox ID="txtReqQty" onfocus="chkItemName()" onblur="addissueitem()" runat="server"
                                        Width="56px"></asp:TextBox>
                                </td>
                            </tr>--%>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="style5">
                                <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif"></asp:ImageButton>&nbsp;<asp:ImageButton
                                    ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"></asp:ImageButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="style7">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="Hid_Rec" runat="server" />
                </div>
            </div>
        </div>
    </div>
    </form>
    <script type="text/jscript" language="javascript">

        //-->


        $(document).ready(function () {
            SearchText();

        });

        function getPartItem(obj, Type) {

            var txtBinNo = document.getElementById('txtBinNo');
            var txtItemName = document.getElementById('txtItemName');
            var txtPartNo = document.getElementById('txtPartNo');
            var txtMRV = document.getElementById('txtMRV');
            var txtbqty = document.getElementById('txtbqty');

            if (obj.value != '') {
                $.ajax({ type: 'POST', url: '../Store/Sub_Store_Iss.aspx?Type=' + Type + '&binno=' + txtBinNo.value + '&itemname=' + txtItemName.value + '&Partno=' + txtPartNo.value + '&mrvno=' + obj.value + "&Opt=GetFill", data: $('#form1').serialize(), success: function (response) {



                    if (response.substring(0, 9) == 'saveError') {
                        alert('Error occured while fetching data.')
                        isSaveClicked = 0;
                    }
                    else if (response.substring(0, 3) == 'got') {

                        arrobj = response.substring(3).split("~");
                        txtItemName.value = arrobj[7]; txtBinNo.value = arrobj[5]; txtPartNo.value = arrobj[6]

                        $('#lblPrtExist').html(''); $('#lblItmExist').html('');
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
                                        url: "../Store/Indent_Request_Details.aspx/GetAutoCompleteDataPartNo",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,
                                        data: JSON.stringify({ "ItemName": $('#txtItemName').val(), "PartNo": $('#txtPartNo').val(), "BinNo": $('#txtBinNo').val() }),
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
                                        url: "../Store/Indent_Request_Details.aspx/GetAutoCompleteDataItemName",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,
                                        data: JSON.stringify({ "PartNo": $('#txtPartNo').val(), "ItemName": $('#txtItemName').val(), "BinNo": $('#txtBinNo').val() }),
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
                                        url: "../Store/Indent_Request_Details.aspx/GetAutoCompleteDataBinNo",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,

                                        data: JSON.stringify({ "PartNo": $('#txtPartNo').val(), "ItemName": $('#txtItemName').val(), "BinNo": $('#txtBinNo').val() }),
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





        }
       
        
    </script>
     </asp:Content>