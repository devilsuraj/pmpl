<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Sub_Store_Indent_Request.aspx.vb" Inherits="KDMT.Sub_Store_Indent_Request"
    EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet">
   <script src="../scripts/jquery-1.11.0.min.js"></script>
            <script src="../scripts/jquery-ui.js"></script>
       <script language="javascript" type="text/javascript">

        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;
        var rowcntSave = 1;
        var dltcnt = 0


        function addDetails() {

            if (document.getElementById('hdnsrno').value == '') {
                document.getElementById('hdnsrno').value = 0;
            }
            var srno = 0;
            var lblsrno = document.getElementById('lblsrno');
            var txtBinNo = document.getElementById('txtBinNo');
            var txtPartNo = document.getElementById('txtPartNo');
            var txtItemName = document.getElementById('txtItemName');
            var txtbqty = document.getElementById('txtbqty');
            var txtReqQty = document.getElementById('txtReqQty');


            var tbody = document.getElementById('tbodyIndent');
            var tblIndent = document.getElementById('tblIndent');
            var hdnrwcnt = document.getElementById('hdnrwcnt');


            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntSave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdsrno_' + rowcntSave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdBinNo_' + rowcntSave);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdPartNo_' + rowcntSave);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tditem_' + rowcntSave);

            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdavbqty_' + rowcntSave);
            cells5.setAttribute('style', 'display:none');

            var cells6 = row.insertCell(5);
            cells6.setAttribute('id', 'tdReqQty_' + rowcntSave);

            var cells7 = row.insertCell(6);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

            cells2.innerHTML = txtBinNo.value;
            cells3.innerHTML = txtPartNo.value;
            cells4.innerHTML = txtItemName.value;
            cells5.innerHTML = txtbqty.value;
            cells6.innerHTML = txtReqQty.value;

            cells7.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntSave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt += 1;
            rowcntSave += 1;
            lblsrno.value = '';

            txtBinNo.value = '';
            txtPartNo.value = '';
            txtItemName.value = '';
            txtbqty.value = '';
            txtReqQty.value = '';
            txtBinNo.focus();
            document.getElementById('hdnrwcnt').value = rowcntSave;
        }


        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;
            document.getElementById('hdnsrno').value = 0;

            for (i = 1; i < hdnrwcnt.value; i++) {
                if (document.getElementById('tditem_' + i) != null) {
                    document.getElementById('tdsrno_' + i).innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1
                    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

                }

            }
        }



        function DeleteUnitConfirm() {
            if (confirm("Are you sure you wan`t to delete.")) { return true }
            else { return false }
        }


        function getDefect() {
            var url = '../tmtAjax/Common_ajax.aspx?action=getDefectDetails'
            sendRequest(url);
            return false;
        }

        function getindent() {
            var url = "../store/AjaxStore.aspx?action=getindentno&date=" + document.getElementById('txttodate').value + "&locid=" + document.getElementById('ddlLocation').value;
            sendRequest(url);
            return false;
        }

        function DeleteDefect(ID) {
            if (Optype == 1) {
                alert('Please quit editing mode for deleting.');
                return false;
            }
            if (DeleteUnitConfirm() == true) {
                Optype = 2;
                var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&Optype=" + Optype;
                sendRequest(url);
                return false;
            }
        }

        function ddlSelection(tdvalue, ddl) {
            for (i = 0; i < ddl.length; i++) {
                if (ddl.options[i].text == tdvalue) {
                    ddl.selectedIndex = i;
                }
            }
        }

        function editDefect(id) {
            var ddlDefPriority = document.getElementById('ddlDefPriority');
            ddlSelection(document.getElementById('tdDefPriority_' + id).innerHTML, ddlDefPriority);
            document.getElementById('dtDefectDate_TextBox').value = document.getElementById('tdDefDate_' + id).innerHTML;

            document.getElementById('txtDriverNo').value = document.getElementById('tdDriverNo_' + id).innerHTML;
            document.getElementById('txtDefectTime').value = document.getElementById('tdDefectTime_' + id).innerHTML;
            document.getElementById('txtDescription').value = document.getElementById('tdDescription_' + id).innerHTML;

            document.getElementById('hdnID').value = id
            Optype = 1;
        }

        function ValidateSave() {


            if (IsValidDate(document.getElementById("txttodate").value) == false) {
                alert('Incorrect IndentDate Format');
                document.getElementById("txttodate").focus()
                return false;
            }



            var detvalues = '';
            var i = 0;



            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            //            var txtapprovedby = document.getElementById('txtapprovedby');
            // var txtMRV = document.getElementById('txtMRV');
            var txtBusNo = document.getElementById('txtBusNo');
            var ddlLocation = document.getElementById('ddlLocation');
            var ddlapprovedby = document.getElementById('ddlapprovedby');

            if (ddlLocation.value == 0) {
                alert('Please Select Location');
                ddlLocation.focus();
                return false;
            }

            else if (ddlapprovedby.value == 0) {
                alert('Please Select Approved By');
                ddlapprovedby.focus();
                return false;
            }
            //            else if (txtMRV.value == '') {
            //                alert('Please Enter Indent No');
            //                txtMRV.focus();
            //                return false;
            //            }
            //            else if (txtBusNo.value == '') {
            //                alert('Please Enter Bus No.');
            //                txtBusNo.focus();
            //                return false;
            //            }


            for (i = 1; i < rowcntSave; i++) {
                if (document.getElementById('tditem_' + i) != null) {
                    var BinNo = document.getElementById('tdBinNo_' + i).innerHTML;
                    var PartNo = document.getElementById('tdPartNo_' + i).innerHTML;
                    var ItemName = document.getElementById('tditem_' + i).innerHTML;
                    var avbqty = 0;
                    var ReqQty = document.getElementById('tdReqQty_' + i).innerHTML;

                    detvalues = detvalues + BinNo + '^' + PartNo + '^' + ItemName + '^' + avbqty + '^' + ReqQty + '|';
                }
            }

            document.getElementById('Hid_Rec').value = detvalues
        }

        function Clean() {
            window.location.href = "View_Defect_Details.aspx";
        }

        function ajaxFunction1() {

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
                        document.getElementById("Select1").style.display = 'none';
                        return false;
                    }

                    var ele = resp.split("!");
                    //			                          

                    while (document.getElementById("Select1").options.length > 0)
                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.getElementById('txtItemName').value != "" || document.getElementById('txtBinNo').value != "" || document.getElementById('txtPartNo').value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("Select1")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("Select1").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.innerText = ele[i];
                            if (document.getElementById('txtItemName').value == ele[i]) {
                                //temp.style.display="none";				               
                                // return false;
                            }
                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                // return false;
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
            var lfno = document.getElementById('txtBinNo').value;
            var partno = document.getElementById('txtPartNo').value;

            if (lfno == "" && partno == "") {
                if (document.getElementById('txtItemName').value.length >= 3) {
                    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById('txtItemName').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                    xmlHttp.open("GET", url, true);
                    xmlHttp.send(null);
                }
                else {

                    //  document.getElementById("Select1").style.display = 'none'
                }
            }
            else {
                url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById('txtItemName').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
        }


        function Select() {
            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtItemName');
                    objddl1.value = resultStr;
                    document.getElementById("Select1").style.display = 'none';
                    document.getElementById('txtItemName').focus();
                    return false;
                }

            }
            document.getElementById("Select1").style.display = 'none';
            Fromcombo2()
        }

        ajaxFunction();

        function sendRequest(url) {
            url = url + '&t=' + new Date();
            xmlHttp.open("GET", url);
            xmlHttp.send(null);
        }



        function handleresponse() {

            if (xmlHttp.readyState == 4) {
                resp = xmlHttp.responseText;

                if (resp.indexOf('PassDefectSearch') != -1) {
                    //            document.getElementById('dvDefectMaster').innerHTML = resp.substring(16);
                    return false;
                }
                else if (resp.indexOf('OptFail') != -1) {
                    alert('Error Occur While Operation.');
                    return false;
                }

                else if (resp.substring(0, 6) == 'indent') {
                    document.getElementById('lblindent').innerHTML = resp.substring(6, 16);
                    return false;
                }
                else if (resp.indexOf('Add') != -1) {
                    alert('Data Added Successfully.');
                    getDefect();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Edit') != -1) {
                    alert('Data Updated Successfully.');
                    getDefect();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Duplicate') != -1) {
                    alert('Defect No. is already exist.');
                    getDefect();
                    Clean();
                    return false;
                }

                else if (resp.indexOf('Delete') != -1) {
                    alert('Data Deleted Successfully.');
                    getDefect();
                    return false;
                }
                else if (resp.indexOf('indentno') != -1) {
                    alert('Your Indent No Is ' + resp.substring(8))
                    //document.getElementById('lblindent').innerHTML =  resp.substring(8)
                    Clean();

                    return false;
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
            //if (txtBinNo != '') {

            xmlHttp.open("GET", "../store/Sub_Store_Iss.aspx?Action=chkitem&binno=" + txtBinNo + " &name=" + txtItemName, true);
            xmlHttp.send(null);
            return false;
            // }s

            return true;
        }


        function addissueitem() {
            //if (document.getElementById("chkReturn").checked == false) {
            //            if (parseFloat(document.getElementById("txtbqty").value) < parseFloat(document.getElementById("txtReqQty").value)) {
            //                alert("Issue Qty sholuld be less than or equal to available qty");
            //                setTimeout(function () { document.getElementById('txtReqQty').focus() }, 10);
            //                return false;
            //            }
            //            if ((document.getElementById("txtBinNo").value) == '') {
            //                alert("Bin No should not be blank");
            //                setTimeout(function () { document.getElementById('txtBinNo').focus() }, 10);
            //                return false;
            //            }
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
            //            if (parseFloat(document.getElementById("txtbqty").value) < parseFloat(document.getElementById("txtReqQty").value)) {
            //                alert("Issue Qty sholuld be less than or equal to available qty");
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
                var PartNo = document.getElementById('tdPartNo_' + i).innerHTML
                var PartNoNow = document.getElementById('txtPartNo').value
                if (itemname == itemnamenow && PartNo == PartNoNow) {
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
            cells4.setAttribute('id', 'tditem_' + rowcnt);
            //            var cells5 = row.insertCell(4);
            //            cells5.setAttribute('id', 'tdbqty_' + rowcnt);
            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdReqQty_' + rowcnt);
            var cells6 = row.insertCell(5);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
            cells2.innerHTML = txtBinNo.value;
            cells3.innerHTML = txtPartNo.value;
            cells4.innerHTML = txtItemName.value;
            //            cells5.innerHTML = txtbqty.value;
            cells5.innerHTML = txtReqQty.value;
            cells6.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trissue_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'


           
            rowcntSave += 1;
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


        function emptytext() {

            if (document.getElementById('txtPartNo').value != '' && document.getElementById('txtItemName').value != '') {
                document.getElementById('txtPartNo').value = '';
                document.getElementById('txtItemName').value = '';
            }
        }

        function emptytextpart() {
            if (document.getElementById('txtItemName').value != '') {
                document.getElementById('txtItemName').value = '';
            }
        }

        function display() {

            var x = document.getElementById('Select1');
            x.style.display = "none";
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

                    document.getElementById('txtbqty').value = ele1[0];
                    document.getElementById('txtPartNo').value = ele1[3];
                    document.getElementById('txtBinNo').value = ele1[2];


                }
            }
            var itemname = document.getElementById('txtItemName').value;
            var lfno = document.getElementById('txtBinNo').value;
            var partno = document.getElementById('txtPartNo').value;
            xmlHttp.open("GET", "AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno, true);
            xmlHttp.send(null);
        }


        function check1() {
            var str = document.getElementById('txtItemName').value;
            if (str.trim() != '') {
                Fromcombo2();
            }
            return false;
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

        function validateqty() {
            if (document.getElementById("txtItemName").value == '') {
                alert("Please Enter Item Name");
                document.getElementById("txtItemName").focus();
                return false;
            }
//            if (document.getElementById("txtBinNo").value == '') {
//                alert("Please Enter Bin No");
//                document.getElementById("txtBinNo").focus();
//                return false;
//            }
            //            if (document.getElementById("lblBinExist").value == 'NotExist') {
            //                alert("Please Enter Correct Bin No");
            //                document.getElementById("txtBinNo").focus();
            //                return false;
            //            }
            //            if (document.getElementById("lblPrtExist").value == 'NotExist') {
            //                alert("Please Enter Correct Part No");
            //                document.getElementById("txtPartNo").focus();
            //                return false;
            //            }
            //            if (document.getElementById("lblItmExist").value == 'NotExist') {
            //                alert("Please Enter Correct Item Name");
            //                document.getElementById("txtItemName").focus();
            //                return false;
            //            }
            if (document.getElementById("txtReqQty").value.length > 0) {

                if (IsNumeric(document.getElementById("txtReqQty").value)) {
                    addDetails();
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtItemName").focus();
                }
            }
            else {

                alert("Enter Proper Value");
                document.getElementById("txtItemName").focus();
            }
        }	
 
    </script>
    <style type="text/css">
        .display
        {
            display: none;
        }
        .style1
        {
            height: 20px;
        }
        td,tr,table {
        border:none;

        }
        td {
        text-align:left; 
        padding:5px;
        margin-left:10px;
        }
    </style>
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
        <h1>    Branch Indent Request</h1>
    </div>
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="Hid_Rec" runat="server" type="hidden" name="Hid_Rec" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <div class="center form-horizontal">

        <input id="Hidden1" runat="server" type="hidden" name="hdnID" />
        <input id="Hidden2" runat="server" type="hidden" name="Hid_Rec" />
        <input id="Hidden3" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="Hidden4" runat="server" type="hidden" name="hdnsrno" />
   
        <div id="middal">
            <div class="contantbox">
                <div class="orgmiddal">
                    <div>
                        <table width="100%" border="1" cellpadding="5" cellspacing="5">
                            
                            <tr>
                                <td align="right">
                                    Indent Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txttodate" onblur="getindent()" Width="110px" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txttodate"
                                        PopupButtonID="imgPopBtnFrom_Edit" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                                    <asp:ImageButton ID="imgPopBtnFrom_Edit" ImageAlign="AbsBottom" ImageUrl="~/images/imgCalendar.png"
                                        runat="server" />
                                    <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                    </asp:ScriptManager>
                                </td>
                                <td width="169" align="right">
                                    Location
                                </td>
                                <td width="174">
                                    <asp:DropDownList ID="ddlLocation" Width="180px" onchange="getindent()" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label1" runat="server" Text="Your Indent No Is" ForeColor="black"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblindent" Font-Size="20px" runat="server" Text="" ForeColor="blue"></asp:Label>
                                </td>
                                <td width="169">
                                </td>
                                <td width="174">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Approved By
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="txtapprovedby" Width="130px" runat="server"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlapprovedby" Width="180px" runat="server">
                                        <asp:ListItem Text="Select" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="DGM" Value="DGM"></asp:ListItem>
                                        <asp:ListItem Text="AE" Value="AE"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    Remark
                                </td>
                                <td>
                                    <asp:TextBox ID="txtremark" Width="250px" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr runat="server" visible="false">
                                <td align="right">
                                    Vehicle No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBusNo" Width="140px" Text="0" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:Label ID="lblerror" Font-Size="20px" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdindent" colspan="4">
                                    <table id="tblIndent" width="100%" border="1" cellpadding="5" cellspacing="5">
                                        <tbody runat="server" id="tbodyIndent">
                                            <tr class='gridhead'>
                                                <td class="style1">
                                                    SR No.
                                                </td>
                                                <td class="style1">
                                                    LF No.
                                                </td>
                                                <td class="style1">
                                                    Part No.
                                                </td>
                                                <td class="style1">
                                                    Item Name
                                                </td>
                                                <td style="display: none" class="style1">
                                                    Available<br />
                                                    Qty.
                                                </td>
                                                <td class="style1">
                                                    Required Qty.
                                                </td>
                                            </tr>
                                            <tr class='gridtxt'>
                                                <td>
                                                    <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                                </td>
                                                <td>
                                                    <input type="text" id="txtBinNo"  name="txtBinNo" size="20" onblur="emptytext();ajaxFunction();" />
                                                    <label id="lblBinExist">
                                                    </label>
                                                </td>
                                                <td>
                                                    <input type="text" id="txtPartNo" name="txtPartNo" size="20"  onblur="emptytextpart();ajaxFunction();"/>
                                                    <label id="lblPrtExist">
                                                    </label>
                                                </td>
                                                <td>
                                                    <input type="text" id="txtItemName" style="width: 250px" size="100" name="txtItemName" onpropertychange="ajaxFunction();" onblur="return check1();" />
                                                    <label id="lblItmExist">
                                                    </label>
                                                    <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                        runat="server"></asp:ListBox>
                                                </td>
                                                <td style="display: none" align="left" style="width: 43px; height: 28px;">
                                                    <asp:TextBox ID="txtbqty" runat="server" Width="56px" ReadOnly="True"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <input type="text" id="txtReqQty" style="width: 100px" name="txtReqQty" onblur="return chkitem();" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <asp:Button ID="btnadd" runat="server" OnClientClick="return ValidateSave()" Text="Add" />
                                </td>
                                <td colspan="2" align="center">
                                    <asp:Button ID="btnaddandsave" runat="server" OnClientClick="return ValidateSave()"
                                        Text="AddandSave" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <div align="center">
                                        <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                            Font-Size="11pt">
                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                            <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn Visible="false" DataField="jobno" HeaderText="jobno"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="BinNo" HeaderText="LF No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="partno" HeaderText="part No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="itemname" HeaderText="Item Name"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="avbqty" Visible="false" HeaderText="Avb Qty"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="reqqty" HeaderText="Req Qty"></asp:BoundColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trsave" runat="server" visible="false">
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" />
                                    <a href="Sub_Store_Indent_Request.aspx">Reset</a>
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
      <script type="text/javascript">


        $(document).ready(function () {
            SearchText();

        });


        //        function getPartItem(obj, Type) {

        //            var txtBinNo = document.getElementById('txtBinNo');
        //            var txtItemName = document.getElementById('txtItemName');
        //            var txtPartNo = document.getElementById('txtPartNo');
        //            //var txtMRV = document.getElementById('txtMRV');
        //            var txtbqty = document.getElementById('txtbqty');

        //            if (obj.value != '') {
        //                $.ajax({ type: 'POST', url: '../Store/Sub_Store_Iss.aspx?Type=' + Type + '&binno=' + txtBinNo.value + '&itemname=' + txtItemName.value + '&Partno=' + txtPartNo.value + '&mrvno=' + obj.value + "&Opt=GetFill", data: $('#form1').serialize(), success: function (response) {


        //                    if (response.substring(0, 9) == 'saveError') {
        //                        alert('Error occured while fetching data.')
        //                        isSaveClicked = 0;
        //                    }
        //                    else if (response.substring(0, 3) == 'got') {

        //                        arrobj = response.substring(3).split("~");
        //                        txtItemName.value = arrobj[7]; txtBinNo.value = arrobj[5]; txtPartNo.value = arrobj[6]

        //                        $('#lblPrtExist').html(''); $('#lblItmExist').html('');
        //                        return false;
        //                    }
        //                    //                    else if (response.substring(0, 8) == 'NotExist') {
        //                    //                        $('#lblMRVExist').html('');
        //                    //                    }
        //                    //                    else if (response.substring(0, 5) == 'Exist') {
        //                    //                        $('#lblMRVExist').html('Exist');
        //                    //                        txtMRV.focus();
        //                    //                    }
        //                }
        //                });
        //            }
        //        }
        function getPartItem(obj, Type) {


            $.ajax({ type: 'POST', url: 'sub_store_indent_request.aspx?Type=' + Type + '&PartItem=' + obj.value + '&indentdate=' + document.getElementById('txttodate').value, data: $('#form1').serialize(), success: function (response) {

                var txtBinNo = document.getElementById('txtBinNo');
                var txtItemName = document.getElementById('txtItemName');
                var txtPartNo = document.getElementById('txtPartNo');
                var txtMRV = document.getElementById('txtMRV');

                if (response.substring(0, 9) == 'saveError') {
                    alert('Error occured while fetching data.')
                    isSaveClicked = 0;
                }
                else if (response.substring(0, 3) == 'got') {
                    arrobj = response.substring(3).split("~");
                    if (arrobj[1] == 1) { txtItemName.value = arrobj[2]; txtBinNo.value = arrobj[3]; }
                    if (arrobj[1] == 2) { txtPartNo.value = arrobj[2]; txtBinNo.value = arrobj[3]; }
                    if (arrobj[1] == 3) { txtPartNo.value = arrobj[2]; txtItemName.value = arrobj[3]; }
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
                                        data: JSON.stringify({ "ItemName": $('#txtItemName').val(), "PartNo": $('#txtPartNo').val(), "BinNo": $('#txtBinNo').val() }),
                                        //dataType: "json",
                                        success: function (data) {
                                            //lblPrtExist = document.getElementById("lblPrtExist") 
                                            //$("lblPrtExist").value = "NotExist";
                                            if (data.d == 'NotExist') {
                                                $('#txtBinNo').val('')
                                                $('#txtItemName').val('')
                                                $('#lblPrtExist').html('NotExist');
                                            }
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
                                        data: JSON.stringify({ "PartNo": $('#txtPartNo').val(), "ItemName": $('#txtItemName').val(), "BinNo": $('#txtBinNo').val() }),
                                        //dataType: "json",
                                        success: function (data) {
                                            if (data.d == 'NotExist') {
                                                $('#txtBinNo').val('')
                                                $('#txtPartNo').val('')
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
                                        url: "sub_store_indent_request.aspx/GetAutoCompleteLfNumber",
                                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                                        //data: details,
                                        // data: JSON.stringify({ "ItemName": $('#txtItemName').val(), "PartNo": $('#txtPartNo').val(), "BinNo": $('#txtBinNo').val() }),
                                        data: JSON.stringify({ "BinNo": $('#txtBinNo').val() }),
                                        //dataType: "json",
                                        success: function (data) {
                                            if (data.d == 'NotExist') {
                                                $('#txtItemName').val('')
                                                $('#txtPartNo').val('')
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

            $("#txtBusNo").autocomplete
           ({

               source: function (request, response) {
                   $.ajax
                    ({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../Workshop/workshopreport.aspx/GetAutoComplete",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('txtBusNo').value }),
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

