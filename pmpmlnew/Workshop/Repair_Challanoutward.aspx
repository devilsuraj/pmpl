<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Repair_Challanoutward.aspx.vb"
    Inherits="KDMT.Repair_Challanoutward" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Repair Challan Outward</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<script language="javascript" src="../Scripts/LogSheet_repairoutward.js"></script>--%>

    <script language="javascript">

        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;

        function additemDetails() {

            var txtpartno = document.getElementById('txtPartNo');
            var txtitem = document.getElementById('txtitem');
            var txtcompno = document.getElementById('txtcompno');
            var txtnmmtno = document.getElementById('txtnmmtno');
            var txtmfgyear = document.getElementById('txtmfgyear');
            var txtcompname = document.getElementById('txtcompname');
            var ddlptype = document.getElementById('ddlptype');
            var ddlhotcold = document.getElementById('ddlhotcold');
            var txtremark = document.getElementById('txtremark');
            var txtqty = document.getElementById('txtqty');
            var ddlunit = document.getElementById('ddlunit');

            var chkreturn = document.getElementById('chkreturn')

            var tbody = document.getElementById('tbodyIndent');

            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcnt);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdPartNo_' + rowcnt);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tditem_' + rowcnt);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdcompno_' + rowcnt);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdnmmtno_' + rowcnt);

            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdmfgyear_' + rowcnt);

            var cells6 = row.insertCell(5);
            cells6.setAttribute('id', 'tdcompname_' + rowcnt);

            var cells7 = row.insertCell(6);
            cells7.setAttribute('id', 'ddlptype_' + rowcnt);
            
            var cells8 = row.insertCell(7);
            cells8.setAttribute('id', 'ddlhotcold_' + rowcnt);


            var cells9 = row.insertCell(8);
            cells9.setAttribute('id', 'tdqty_' + rowcnt);
            
            var cells10 = row.insertCell(9);
            cells10.setAttribute('id', 'ddlunit_' + rowcnt);
            

            var cells11 = row.insertCell(10);
            cells11.setAttribute('id', 'tdremark_' + rowcnt);

            var cells12 = row.insertCell(11);
            cells12.setAttribute('id', 'tdreturn_' + rowcnt);

            var cells13 = row.insertCell(12);



            
            var remoldtype
            var unit
            var hotcold
            var ddldepttype = document.getElementById("nmmtdept")
            if (ddldepttype.options[ddldepttype.selectedIndex].text == 'Workshop Tyre') {
                if (ddlptype.options[ddlptype.selectedIndex].text == 'SELECT') { remoldtype = '' } else { remoldtype = ddlptype.options[ddlptype.selectedIndex].text }
                if (ddlhotcold.options[ddlhotcold.selectedIndex].text == 'SELECT') { hotcold = '' } else { hotcold = ddlhotcold.options[ddlhotcold.selectedIndex].text }
                
                
            }
            else {
                remoldtype = '';
                 hotcold = '';
                 unit = '';
            }
            if (ddlunit.options[ddlunit.selectedIndex].text == 'SELECT') { unit = '' } else { unit = ddlunit.options[ddlunit.selectedIndex].text }
            var isreturn = ''
            if (chkreturn.checked == true) { isreturn = 'Yes' } else { isreturn = 'No' }
            cells1.innerHTML = txtpartno.value;
            cells2.innerHTML = txtitem.value;
            cells3.innerHTML = txtcompno.value;
            cells4.innerHTML = txtnmmtno.value;
            cells5.innerHTML = txtmfgyear.value;
            cells6.innerHTML = txtcompname.value;
            cells7.innerHTML = remoldtype;
            cells8.innerHTML = hotcold;
            cells9.innerHTML = txtqty.value;
            cells10.innerHTML = unit;
            cells11.innerHTML = txtremark.value;
            cells12.innerHTML = isreturn
            cells13.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            txtitem.value = '';
            if (ddldepttype.options[ddldepttype.selectedIndex].text == 'Workshop Tyre') {
            txtqty.value = '1';
            }
            else 
            {
            txtqty.value = '';
            }
            
            txtcompno.value = '';
            txtnmmtno.value = '';
            txtmfgyear.value = '';
            txtcompname.value = '';
            txtremark.value = '';
            txtpartno.value = '';
            chkreturn.checked = false

            txtitem.focus();
            document.getElementById('hdnrwcnt').value = rowcnt;
            // alert(document.getElementById('hdnrwcnt').value)
        }


        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;

        }



        function additemDetailsother() {


            var txtitem1 = document.getElementById('txtitem1');
            var txtremark1 = document.getElementById('txtremark1');
            var txtqty1 = document.getElementById('txtqty1');
            var ddlunit1 = document.getElementById('ddlunit1');
            var chkreturn1 = document.getElementById('chkreturn1')

            var tbodyother = document.getElementById('tbodyother');

            var row = tbodyother.insertRow(rowcnt);
            row.setAttribute('id', 'trother_' + rowcnt);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tditem1_' + rowcnt);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdqty1_' + rowcnt);
            
            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'ddlunit1_' + rowcnt);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdremark1_' + rowcnt);

            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdreturn1_' + rowcnt);

            var cells6 = row.insertCell(5);
            var isreturn = ''
            if (chkreturn1.checked == true) { isreturn = 'Yes' } else { isreturn = 'No' }


var unit
  
                  
                if (ddlunit1.options[ddlunit1.selectedIndex].text == 'SELECT') { unit = '' } else { unit = ddlunit1.options[ddlunit1.selectedIndex].text }
        
          

            cells1.innerHTML = txtitem1.value;
            cells2.innerHTML = txtqty1.value;
            cells3.innerHTML = unit ;
            cells4.innerHTML = txtremark1.value;
            cells5.innerHTML = isreturn;
            cells6.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRowother(\'trother_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'




            rowcnt = rowcnt + 1;
            txtitem1.value = '';
            txtqty1.value = '';
            txtremark1.value = '';
            chkreturn1.checked = false



            txtitem1.focus();
            document.getElementById('hdnrwcnt').value = rowcnt;
            // alert(document.getElementById('hdnrwcnt').value)
        }


        function deleteRowother(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyother').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;

        }

        function IsNumeric(strString) {
            var ValidChars = "0123456789";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }


        function validatevendor() {
            if (document.getElementById("txtInwardNo").value == "") {
                alert('Please Enter Inward No');
                document.getElementById("txtInwardNo").focus()
                return false;
            }
            if (document.getElementById("txtvendor").value == "") {
                alert('Please Enter Vendor Name');
                document.getElementById("txtvendor").focus()
                return false;
            }
            if (document.getElementById("txtchallanno").value == "") {
                alert('Please Enter Challan No');
                document.getElementById("txtchallanno").focus()
                return false;
            }
            return true;
        }




        function ValidateSave() {

//            if (document.getElementById("txtnmmtchalan").value == "") {
//                alert('Please Enter Challan No');
//                document.getElementById("txtnmmtchalan").focus()
//                return false;
//            }

            if (document.getElementById("nmmtdept").selectedIndex == 0) {
                alert('Please Select Dept');
                document.getElementById("nmmtdept").focus()
                return false;
            }
            if (document.getElementById("ddltoloc").selectedIndex == 0) {
                alert('Please Select location');
                document.getElementById("ddltoloc").focus()
                return false;
            }
            if (document.getElementById("ddlgatepasstype").selectedIndex == 0) {
                alert('Please Select Gatepass Type');
                document.getElementById("ddlgatepasstype").focus()
                return false;
            }
            if (document.getElementById("ddltoloc").selectedIndex == 2) {
                if (document.getElementById("txtvendor").value == "") {
                    alert('Please Enter Vendor name');
                    document.getElementById("txtvendor").focus()
                    return false;
                }
            }


            //            if (document.getElementById("txtauthperson").value == "") {
            //                alert('Please Enter authorized  Person');
            //                document.getElementById("txtauthperson").focus()
            //                return false;
            //            }
            //            if (document.getElementById("txtissuename").value == "") {
            //                alert('Please Enter Name');
            //                document.getElementById("txtissuename").focus()
            //                return false;
            //            }

            if (document.getElementById('hdnrwcnt').value == 0) {
                alert('Please Enter Repair Item');
                document.getElementById("txtitem").focus()
                return false;
            }


            var detvalues = '';
            var i = 0;
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            debugger
            if (document.getElementById('hdndepttype').value == "0") {
                for (i = 1; i < hdnrwcnt; i++) {
                    if (document.getElementById('tditem_' + i) != null) {



                        var partno = document.getElementById('tdPartNo_' + i).innerHTML;
                        var item = document.getElementById('tditem_' + i).innerHTML;
                        var compno = document.getElementById('tdcompno_' + i).innerHTML;
                        var nmmtno = document.getElementById('tdnmmtno_' + i).innerHTML;
                        var mfgyear = document.getElementById('tdmfgyear_' + i).innerHTML;
                        var compname = document.getElementById('tdcompname_' + i).innerHTML;
                        var ddlptype = document.getElementById('ddlptype_' + i).innerHTML;
                        var ddlhotcold = document.getElementById('ddlhotcold_' + i).innerHTML;
                        var remark = document.getElementById('tdremark_' + i).innerHTML;
                        var quantity = document.getElementById('tdqty_' + i).innerHTML;
                        var ddlunit = document.getElementById('ddlunit_' + i).innerHTML;
                        var isreturn = document.getElementById('tdreturn_' + i).innerHTML;


                        detvalues = detvalues + partno + '^' + item + '^' + compno + '^' + nmmtno + '^' + mfgyear + '^' + compname + '^' + ddlptype + '^'+ ddlhotcold + '^' + quantity + '^' + ddlunit + '^' + remark + '^'  + isreturn + '|';
                    }
                }
            }
            else {
                for (i = 1; i < hdnrwcnt; i++) {
                    if (document.getElementById('tditem1_' + i) != null) {




                        var item = document.getElementById('tditem1_' + i).innerHTML;
                        var remark = document.getElementById('tdremark1_' + i).innerHTML;

                        var quantity = document.getElementById('tdqty1_' + i).innerHTML;
                        var ddlunit1 = document.getElementById('ddlunit1_' + i).innerHTML;
                        var isreturn = document.getElementById('tdreturn1_' + i).innerHTML;

                        detvalues = detvalues + " " + '^' + item + '^' + " " + '^' + " " + '^' + " " + '^' + " " + '^' + " " + '^' + " " + '^' + quantity +'^' +  ddlunit1 + '^' + remark  + '^' + isreturn + '|';
                    }
                }
            }

            document.getElementById("hdndetail").value = detvalues
            return true;


        }
        function validateSave1() {
            if (document.getElementById("txtgateno").value == "") {
                alert('Please Enter Gate No');
                document.getElementById("txtgateno").focus()
                return false;
            }
            if (document.getElementById("txtcheckedby").value == "") {
                alert('Please Enter Name');
                document.getElementById("txtcheckedby").focus()
                return false;
            }


        }



        function ticFunction() {
            if (document.getElementById("txtitem").value == "") {
                alert('Please Enter Item');
                document.getElementById("txtitem").focus()
                return false;
            }
            var ddldepttype = document.getElementById("nmmtdept")
            var ddlgatepasstype = document.getElementById("ddlgatepasstype")
            if ((ddldepttype.options[ddldepttype.selectedIndex].text == 'Workshop Tyre')&& (ddlgatepasstype.options[ddlgatepasstype.selectedIndex].text != 'Asudgaon')) {

                if (document.getElementById("txtcompno").value == "") {
                    alert('Please Enter Company No');
                    document.getElementById("txtcompno").focus()
                    return false;
                }
                if (document.getElementById("txtnmmtno").value == "") {
                    alert('Please Enter NMMT No');
                    document.getElementById("txtnmmtno").focus()
                    return false;
                }
//                if (document.getElementById("txtmfgyear").value == "") {
//                    alert('Please Enter Manufactured Year');
//                    document.getElementById("txtmfgyear").focus()
//                    return false;
//                }
                if (document.getElementById("txtcompname").value == "") {
                    alert('Please Enter Company Name');
                    document.getElementById("txtcompname").focus()
                    return false;
                }
                if (document.getElementById("ddlptype").selectedIndex == 0) {
                    alert('Please Select Remolding Type');
                    document.getElementById("ddlptype").focus()
                    return false;
                }
            }

            else
            { }

 if (document.getElementById("ddlunit").selectedIndex == 0) {
                    alert('Please Select Unit');
                    document.getElementById("ddlunit").focus()
                    return false;
                }
            if (document.getElementById("txtqty").value.length > 0) {

                if (IsNumeric(document.getElementById("txtqty").value) == true) {
                if (document.getElementById("txtqty").value > 0 ){
                additemDetails()
                }
                else
                {
                    alert("Enter Proper Value");
                    document.getElementById("txtqty").focus();
                    return false;
                }
                    
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtqty").focus();
                    return false;
                }

            }
            else {

                alert("Please enter Qty");
                document.getElementById("txtqty").focus();
                return false;
            }
             
            
        }

        function ticFunction2() {

            if (document.getElementById("txtitem1").value == "") {
                alert('Please Enter Item');
                document.getElementById("txtitem1").focus()
                return false;
            }
             if (document.getElementById("ddlunit1").selectedIndex == 0) {
                    alert('Please Select Unit');
                    document.getElementById("ddlunit1").focus()
                    return false;
                }
            if (document.getElementById("txtqty1").value.length > 0) {

                if (IsNumeric(document.getElementById("txtqty1").value) == true) {
                
                if (document.getElementById("txtqty1").value > 0 ){
                 additemDetailsother()
                }
                else
                {
                    alert("Enter Proper Value");
                    document.getElementById("txtqty1").focus();
                    return false;
                }
                
                
                   
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtqty1").focus();
                    return false;
                }

            }
            else {

                alert("Please enter Qty");
                document.getElementById("txtqty1").focus();
                return false;
            }
           
        }







        function emptytext() {
            if (document.getElementById('txtPartNo').value != '' && document.getElementById('txtitem').value != '') {
                document.getElementById('txtPartNo').value = '';
                document.getElementById('txtitem').value = '';
            }
        }

        //function emptytextpart ()
        //{
        //    if (document .getElementById ('txtSubRackNo').value !='' && document .getElementById ('ddlitem').value !='' )
        //    {
        //    document .getElementById ('txtSubRackNo').value='';
        //    document .getElementById ('ddlitem').value='';
        //    }
        //}
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
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');

                    document.getElementById('txtPartNo').value = ele1[2];

                }
            }
            var itemname = document.getElementById('txtitem').value;

            var partno = document.getElementById('txtPartNo').value;
            if (itemname != '') {
                xmlHttp.open("GET", "AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&partno=" + partno, true);
                //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
                xmlHttp.send(null);
            }
        }


        function itemsearch() {
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


                    if (resp == 0) {
                        document.getElementById("Select1").style.display = 'none';
                        return false;
                    }

                    var ele = resp.split("!");
                    //			                          

                    while (document.getElementById("Select1").options.length > 0)
                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.getElementById('txtitem').value != "" || document.getElementById('txtPartNo').value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("Select1")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("Select1").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.innerText = ele[i];
                            if ((document.getElementById('txtitem').value == ele[i]) && (document.getElementById('txtitem').value != '')) {
                                document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                                return false;
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

            var partno = document.getElementById('txtPartNo').value;
            if (partno != '') {
                xmlHttp.open("GET", "AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById('txtitem').value + "&partno=" + partno, true);
                xmlHttp.send(null);
            }
            else {
                if (document.getElementById('txtitem').value.length >= 3) {
                    xmlHttp.open("GET", "AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById('txtitem').value + "&partno=" + partno, true);
                    xmlHttp.send(null);
                }
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
            //
            ajaxFunction();
            url = url + '&t=' + new Date();
            xmlHttp.open("GET", url);
            xmlHttp.send(null);
        }


        function handleresponse() {

            if (xmlHttp.readyState == 4) {
                resp = xmlHttp.responseText;
                if (resp.indexOf('notexist') != -1) {
                    alert('item name not exist');
                    setTimeout(function() { document.getElementById('txtitem').focus() }, 10);
                    return false;
                }
                if (resp.indexOf('exist') != -1) {
                    alert('This Challan is already exist');
                    setTimeout(function() { document.getElementById('txtnmmtchalan').focus() }, 10);
                    return false;
                }
            }
        }

        function Select() {
            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtitem');
                    objddl1.value = resultStr;
                    document.getElementById("Select1").style.display = 'none';
                    document.getElementById('txtitem').focus();
                    return false;
                }
            }
        }
        function fillItemName() {
            objddl2 = document.getElementById('Select1');
            if (document.getElementById("txtitem").value != "" && objddl2.options.length > 0) {
                document.getElementById("txtitem").value = objddl2.options[0].text;
                document.getElementById("txtqty").focus();
            }

        }


        function checkchallan() {

            var txtinvoice = document.getElementById('txtnmmtchalan');

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtinvoice.value == '') {
                txtinvoice.focus();
                alert('Please Enter Challan No');
                return false;
            }
            else {

                var url = 'AjaxStore.aspx?action=chkchallan&challan=' + txtinvoice.value;
                sendRequest(url);
                return false;
            }
        }


        function checkyear() {
            if (document.getElementById("txtmfgyear").value.length > 0) {

                if (IsNumeric(document.getElementById("txtmfgyear").value) == true) {

                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtmfgyear").focus();
                    return false;
                }
                if (document.getElementById("txtmfgyear").value.length != 4) {
                    alert("Enter Proper Value");
                    document.getElementById("txtmfgyear").focus();
                    return false;
                }

            }

        }
        
        

    </script>

    <style type="text/css">
        .style1
        {
            height: 25px;
            width: 191px;
        }
        #tblmain
        {
            width: 809px;
        }
        .style2
        {
            width: 50px;
        }
        .style3
        {
            width: 133px;
        }
        #Table1
        {
            width: 89%;
        }
        .style20
        {
            width: 106px;
        }
        .style21
        {
            height: 27px;
        }
    </style>
</head>
<body onload="MM_preloadImages('../images/btn_h.gif')">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <form id="Form1" runat="server">
    <asp:HiddenField ID="hdndepttype" runat="server" />
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassno" runat="server" type="hidden" name="hdngatepassno" />
    <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassid" runat="server" type="hidden" name="hdngatepassid" />
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table id="Table1" cellpadding="0" cellspacing="0" runat="server" align="center"
                        width="100%">
                        <tbody>
                            <tr style="height: 50px">
                                <td class="innerheading">
                                    <span id="Label3">GATEPASS OUT</span>
                                    <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:Button ID="print" Text="print" runat="server" />
                                    <asp:RadioButtonList RepeatDirection="Horizontal" ID="radtype" runat="server" AutoPostBack="True">
                                        <asp:ListItem Value="0">create gatepass</asp:ListItem>
                                        <asp:ListItem Value="1">update security info</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="text-align: left">
                                        <table id="tblmain" visible="false" runat="server">
                                            <tbody>
                                                <tr visible="false">
                                                    <td align="right">
                                                        Nmmt Challan
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtnmmtchalan" onblur="checkchallan()" MaxLength="5" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        From Dept :
                                                    </td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="nmmtdept" runat="server" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td align="right">
                                                        Challan Date :
                                                    </td>
                                                    <td align="left">
                                                        <%-- <asp:Label ID="BDPLite1" runat="server" Text=""></asp:Label>--%><BDP:BDPLite
                                                            ID="BDPLite1" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td class="style20">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Challan Outward No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtchallanno" runat="server" class="textfield" ReadOnly="True"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        To Place :
                                                    </td>
                                                    <td align="left" style="margin-left: 40px">
                                                        <asp:DropDownList ID="ddltoloc" runat="server" AutoPostBack="true">
                                                            <asp:ListItem Text="Select" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="Nmmt Location" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Vendor" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="ddlgatepasstype" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="tdven" runat="server">
                                                        Vendor
                                                    </td>
                                                    <td align="left" id="tdvendor" runat="server">
                                                        <asp:TextBox ID="txtvendor" MaxLength="100" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style21">
                                                        Request No
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtreq" MaxLength="50" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Req Date
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <BDP:BDPLite ID="BDPreqdate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style21">
                                                        Authorised Person :
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtauthperson" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Designation :
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtaudesign" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Id No :
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtauid" MaxLength="5" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Vechicle No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbusno" MaxLength="12" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                    <td align="right">
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Name :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtissuename" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Designation :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtissuedesig" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Id No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtissueid" MaxLength="5" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td align="right">
                                                        Bus In Kms :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbusinkm" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                       Bus Out Kms :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbusoutkm" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style21">
                                                        Note :
                                                    </td>
                                                    <td align="left" class="style21" colspan="4">
                                                        <asp:TextBox ID="txtnote" MaxLength="250" Width="300" Height="30" TextMode="MultiLine"
                                                            runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <div style="text-align: center">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="trmain" runat="server" visible="false">
                                                    <td style="height: 7px" colspan="9" align="center">
                                                        <table id="tblIndent" width="100%" border="1" cellpadding="2" cellspacing="2">
                                                            <tbody runat="server" id="tbodyIndent">
                                                                <tr class="gridhead">
                                                                    <td>
                                                                        Part No
                                                                    </td>
                                                                    <td>
                                                                        Item
                                                                    </td>
                                                                    <td>
                                                                        Company No
                                                                    </td>
                                                                    <td>
                                                                        NMMT No
                                                                    </td>
                                                                    <td>
                                                                        Mfg Year
                                                                    </td>
                                                                    <td>
                                                                        Company
                                                                    </td>
                                                                    <td>
                                                                        Plane Type
                                                                    </td>
                                                                    <td>
                                                                        HOTCOLD
                                                                    </td>
                                                                    <td>
                                                                        Qty
                                                                    </td>
                                                                    <td>
                                                                        Unit
                                                                    </td>
                                                                    <td>
                                                                        Remark
                                                                    </td>
                                                                    <td>
                                                                        Is Return
                                                                    </td>
                                                                </tr>
                                                                <tr class="gridtxt">
                                                                    <td align="left" style="width: 100px; height: 28px;">
                                                                        <asp:TextBox class="textfield" ID="txtPartNo" MaxLength="20" onblur="emptytext();itemsearch();"
                                                                            runat="server" Width="100px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtitem" onpropertychange="itemsearch();" onblur="Fromcombo2()"
                                                                            MaxLength="100" runat="server" Width="300px" EnableTheming="True"></asp:TextBox>
                                                                        <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                                            runat="server"></asp:ListBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtcompno" MaxLength="20" runat="server" Width="100px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtnmmtno" MaxLength="10" runat="server" Width="70px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtmfgyear" onblur="checkyear();" MaxLength="4" runat="server" Width="40px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtcompname" MaxLength="20" runat="server" Width="165px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlptype" runat="server">
                                                                            <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="NP" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="RP" Value="2"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlhotcold" runat="server">
                                                                            <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="COLD1" Value="COLD1"></asp:ListItem>
                                                                            <asp:ListItem Text="COLD2" Value="COLD2"></asp:ListItem>
                                                                            <asp:ListItem Text="HOT1" Value="HOT1"></asp:ListItem>
                                                                            <asp:ListItem Text="HOT2" Value="HOT2"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtqty" MaxLength="4" runat="server" Width="50px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlunit" runat="server">
                                                                            <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="Ltr" Value="Ltr"></asp:ListItem>
                                                                            <asp:ListItem Text="Kg" Value="Kg"></asp:ListItem>
                                                                            <asp:ListItem Text="Nos" Value="Nos"></asp:ListItem>
                                                                            <asp:ListItem Text="Mtr" Value="Mtr"></asp:ListItem>
                                                                            <asp:ListItem Text="Roll" Value="Roll"></asp:ListItem>
                                                                            <asp:ListItem Text="Set" Value="Set"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtremark" MaxLength="250" runat="server" Width="165px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:CheckBox ID="chkreturn" runat="server" Width="20px"></asp:CheckBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnadd" value="ADD" onclick="ticFunction()" name="btnadd" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr id="trother" runat="server" visible="false">
                                                    <td style="height: 7px" colspan="9" align="center">
                                                        <table id="tblother" width="100%" border="1" cellpadding="2" cellspacing="2">
                                                            <tbody runat="server" id="tbodyother">
                                                                <tr class="gridhead">
                                                                    <td>
                                                                        Item
                                                                    </td>
                                                                    <td>
                                                                        Qty
                                                                    </td>
                                                                    <td>
                                                                        Unit
                                                                    </td>
                                                                    <td>
                                                                        Remark
                                                                    </td>
                                                                    <td>
                                                                        Is Return
                                                                    </td>
                                                                </tr>
                                                                <tr class="gridtxt">
                                                                    <td align="left" style="width: 100px; height: 28px;">
                                                                        <asp:TextBox ID="txtitem1" MaxLength="100" Width="300px" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtqty1" MaxLength="3" runat="server" Width="165px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlunit1" runat="server">
                                                                            <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="Ltr" Value="Ltr"></asp:ListItem>
                                                                            <asp:ListItem Text="Kg" Value="Kg"></asp:ListItem>
                                                                            <asp:ListItem Text="Nos" Value="Nos"></asp:ListItem>
                                                                            <asp:ListItem Text="Mtr" Value="Mtr"></asp:ListItem>
                                                                            <asp:ListItem Text="Roll" Value="Roll"></asp:ListItem>
                                                                            <asp:ListItem Text="Set" Value="Set"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtremark1" MaxLength="250" runat="server" EnableTheming="True"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:CheckBox ID="chkreturn1" runat="server" Width="20px"></asp:CheckBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="Button1" value="ADD" onclick="ticFunction2()" name="btnadd" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="7" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                                border="0" Width="87" Height="38" AlternateText="Save" />
                                                        </a><a class="canceltxt" href="#">Cancel</a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table id="tblsecurity" runat="server" visible="false">
                                            <tbody>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Challan No :
                                                    </td>
                                                    <td align="left" colspan="5">
                                                        <asp:TextBox ID="txtoutchallanno" runat="server" class="textfield" AutoPostBack="True"></asp:TextBox>
                                                        <asp:Label ID="lblmsg" Text="" ForeColor="red" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Security (Depot) :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtsecname" ReadOnly="true" Text="Turbhe,Depot" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                    </td>
                                                    <td align="left" class="style1">
                                                    </td>
                                                    <td align="right" class="style2">
                                                        Date :
                                                    </td>
                                                    <td align="left">
                                                        <BDP:BDPLite ID="secdate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Gate No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtgateno" MaxLength="1" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                    </td>
                                                    <td align="left" class="style1">
                                                    </td>
                                                    <td align="right" class="style2">
                                                        Time :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txttime" MaxLength="5" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Checked By :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtcheckedby" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                        Designation :
                                                    </td>
                                                    <td align="left" class="style1">
                                                        <asp:TextBox ID="txtdesig" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style2">
                                                        Id No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtsecid" MaxLength="5" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="7" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="ImageButtonupdate" runat="server" ImageUrl="../images/btn_h.gif"
                                                                align="absmiddle" border="0" Width="87" Height="38" AlternateText="Update" />
                                                        </a><a class="canceltxt" href="#">Cancel</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" align="center">
                                                        <asp:GridView ID="gvgatepass" runat="server" AutoGenerateColumns="False" Width="80%">
                                                            <Columns>
                                                                <asp:BoundField DataField="item_name" HeaderText="particulars" ItemStyle-HorizontalAlign="Left" />
                                                                <asp:BoundField DataField="qty" HeaderText="Qty" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="orgbottam1">
                </div>
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript">

        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", { imgRight: "SpryAssets/SpryMenuBarRightHover.gif" });


    </script>
</body>
</html>
