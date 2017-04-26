<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="oilissue.aspx.vb"
    Inherits="kdmt.oilissue" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>PO Master</title>

    <script language="javascript" type="text/javascript">

        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;



        function addPODetails() {

            if (document.getElementById('hdnsrno').value == '') {
                document.getElementById('hdnsrno').value = 0;
            }
            var srno = 0;
            var lblsrno = document.getElementById('lblsrno');

            var txtNomenclature = document.getElementById('txtNomenclature');
            var txtltrperbar = document.getElementById('txtltrperbar');
            var txtnoofbarrel = document.getElementById('txtnoofbarrel');
            var txttotalltr = document.getElementById('txttotalltr');

            var tbody = document.getElementById('tbodyIndent');

            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcnt);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdsrno_' + rowcnt);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdNomenclature_' + rowcnt);
            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdltrperbar_' + rowcnt);
            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdnoofbarrel_' + rowcnt);
            var cells5 = row.insertCell(4);

            cells5.setAttribute('id', 'tdtotalltr_' + rowcnt);


            var cells6 = row.insertCell(5);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

            cells2.innerHTML = txtNomenclature.value;
            cells3.innerHTML = txtltrperbar.value;
            cells4.innerHTML = txtnoofbarrel.value;

            cells5.innerHTML = txttotalltr.value;


            cells6.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            txtNomenclature.value = '';
            txtltrperbar.value = '';
            txtnoofbarrel.value = '';
            txtNomenclature.value = '';
            txttotalltr.value = '';

            document.getElementById('hdnrwcnt').value = rowcnt;
            // alert(document.getElementById('hdnrwcnt').value)
        }




        function Amount() {

            var txtltrperbar = document.getElementById('txtltrperbar');
            var txtperbarrel = document.getElementById('txtperbarrel');
            var txttotalltr = document.getElementById('txttotalltr');
            var Rate = document.getElementById('txtRate');
            var Amt = document.getElementById('txtAmount');
            var itemname = document.getElementById('txtNomenclature')
            if (itemname.value == '') {
                alert('Enter the Oil Name');
                setTimeout(function() { itemname.focus() }, 10);
                return false;
            }


            // return checkQuntity ();


            addPODetails();

        }

        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;
            document.getElementById('hdnsrno').value = 0;
            for (i = 1; i < hdnrwcnt.value; i++) {
                if (document.getElementById('tdNomenclature_' + i) != null) {
                    document.getElementById('tdsrno_' + i).innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1
                    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

                }


            }
        }



        function DeleteUnitConfirm() {
            if (confirm("Are you sure you wan`t to delete.")) { return true }
            else { return false }
        }


        function poexists() {
            var ddlPONo = document.getElementById('ddlPONo').value;
            var dtPODate = document.getElementById('dtPODate_TextBox').value;
            var txtpono = document.getElementById('txtPONo').value;
            var url = "../tmtAjax/Common_ajax.aspx?action=checkpoexists&potype=" + ddlPONo + "&pono=" + txtpono + "&dtpoDate=" + dtPODate;

            sendRequest(url);
            return false;
        }

        function getDefect() {
            var url = '../tmtAjax/Common_ajax.aspx?action=getDefectDetails'
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




        function validate() {

            ValidateSave();
            ddldepot = document.getElementById('ddldepot')
            txtapproved = document.getElementById('txtapproved')
            txtref = document.getElementById('txtref')
            txtgate = document.getElementById('txtgate')
            hdndetail = document.getElementById('hdndetail')

            if (ddldepot.selectedIndex == 0) {
                alert('Select Depot Name');
                ddldepot.focus();
                return false;
            }

            else if (txtapproved.value == '') {
                alert('Enetr Approved By Name');
                txtapproved.focus();
                return false;
            }
            else if (txtref.value == '') {
                alert('Enter Indent No.');
                txtref.focus();
                return false;
            }
            else if (txtgate.value == '') {
                alert('Enter Gate Pass No.');
                txtgate.focus();
                return false;
            }
       

            else if (hdndetail.value == '') {
                alert('please  enter item');
                document.getElementById('txtNomenclature').focus();

                return false;
            }

        }

        function ValidateSave() {

            var detvalues = '';
            var i = 0;
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            for (i = 1; i < hdnrwcnt; i++) {
                if (document.getElementById('tdNomenclature_' + i) != null) {


                    var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                    var ltrperbar = document.getElementById('tdltrperbar_' + i).innerHTML;
                    var noofbarrel = document.getElementById('tdnoofbarrel_' + i).innerHTML;
                    var totalltr = document.getElementById('tdtotalltr_' + i).innerHTML;


                    detvalues = detvalues + Nomenclature + '^' + ltrperbar + '^' + noofbarrel + '^' + totalltr + '^' + '|';


                }
            }
            document.getElementById("hdndetail").value = detvalues

        }


        function ValidateSave1() {


            var detvalues = '';
            var i = 0;

            //        var BusNo = document.getElementById('txtBusNo');        
            //        if (BusNo.value == ''){
            //            alert('Bus No. should not be empty')
            //            BusNo.focus();  ,
            //            return false;
            //        }


            var hdnrwcnt = document.getElementById('hdnrwcnt').value;

            var ddlvendor = document.getElementById('ddlvendor').value;
            var ddlPONo = document.getElementById('ddlPONo').value;
            var dtPODate = document.getElementById('dtPODate_TextBox').value;
            var txtOurRefNo = document.getElementById('txtOurRefNo').value;
            var dtOurRefNo = document.getElementById('dtOurRefNo_TextBox').value;
            var txtYourRefNo = document.getElementById('txtYourRefNo').value;
            var dtYourRefNo = document.getElementById('dtYourRefNo_TextBox').value;

            var txtpono = document.getElementById('txtPONo').value;
            var txtPayment = document.getElementById('txtPayment').value;
            var txtDescount = document.getElementById('txtDescount').value;
            var txtFright = document.getElementById('txtFright').value;
            var txtBankCharges = document.getElementById('txtBankCharges').value;
            var txtGoodsent = document.getElementById('txtGoodsent').value;
            var txtDelivery = document.getElementById('txtDelivery').value;
            var txtValidityPeriod = document.getElementById('txtValidityPeriod').value;
            var txtYear = document.getElementById('txtYear').value;
            var txtBCReg = document.getElementById('txtBCReg').value;
            var txtSrNo = document.getElementById('txtSrNo').value;
            var txtAudited = document.getElementById('txtAudited').value;
            var txtAudit_officer = document.getElementById('txtAudit_officer').value;
            var txtCl = document.getElementById('txtCl').value;
            var Date1_TextBox = document.getElementById('Date1_TextBox').value;
            var Date2_TextBox = document.getElementById('Date2_TextBox').value;
            var txtResNo = document.getElementById('txtResNo').value;
            var txtPurchase = document.getElementById('txtPurchase').value;
            var txtBudgetAccount = document.getElementById('txtBudgetAccount').value;
            var txtPreparedby = document.getElementById('txtPreparedby').value;
            var txtCheckedBy = document.getElementById('txtCheckedBy').value;
            var txtIndentRefNo = document.getElementById('txtIndentRefNo').value;

            var txtspdiscount = document.getElementById('txtspdisc').value;
            var txtvat = document.getElementById('txtvat').value;
            var txted = document.getElementById('txted').value;

            var ddlCategory = document.getElementById('ddlCategory').value;

            for (i = 1; i < hdnrwcnt; i++) {
                if (document.getElementById('tdNomenclature_' + i) != null) {

                    var txtlfNo = document.getElementById('tdlfno_' + i).innerHTML;
                    var CodeNo = document.getElementById('tdCodeNo_' + i).innerHTML;
                    var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                    var Quantity = document.getElementById('tdQuantity_' + i).innerHTML;
                    var Rate = document.getElementById('tdRate_' + i).innerHTML;
                    var Amount = document.getElementById('tdAmount_' + i).innerHTML;

                    detvalues = detvalues + txtlfNo + '^' + CodeNo + '^' + Nomenclature + '^' + Quantity + '^' + Rate + '^' + Amount + '|';

                }
            }


            if (document.getElementById('hdnID').value != '') { ID = document.getElementById('hdnID').value }

            if (Optype == 0) {
                //  var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo +  "&PONo=" + txtpono + "&PODate=" + dtPODate  + "&OurRefNo=" + txtOurRefNo + "&dtOurRefNo=" + dtOurRefNo  + "&YourRefNo=" + txtYourRefNo + "&dtYourRefNo=" + dtYourRefNo  +"&Indentdetails=" + detvalues  + "&Optype=" + Optype+"&txtPayment=" + txtPayment  +  "&txtDescount=" + txtDescount  + "&txtFright=" + txtFright   + "&txtBankCharges=" + txtBankCharges  + "&txtGoodsent=" + txtGoodsent   + "&txtDelivery=" + txtDelivery  + "&txtValidityPeriod=" + txtValidityPeriod  +"&txtYear=" + txtYear  + "&txtBCReg=" + txtBCReg  +"&txtSrNo=" + txtSrNo  + "&txtAudited=" + txtAudited  +"&txtCl=" + txtCl  + "&Date1_TextBox=" + Date1_TextBox  +"&Date2_TextBox=" + Date2_TextBox  + "&txtAudit_officer=" + txtAudit_officer  +"&txtResNo=" + txtResNo + "&txtPurchase=" + txtPurchase +"&txtBudgetAccount=" + txtBudgetAccount   + "&txtPreparedby=" + txtPreparedby   +"&txtCheckedBy=" + txtCheckedBy    + "&txtIndentRefNo=" + txtIndentRefNo  + "&txtspdiscount=" + txtspdiscount  + "&txtvat=" + txtvat  + "&txted=" + txted;                         
                var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo + "&PONo=" + txtpono + "&PODate=" + dtPODate + "&OurRefNo=" + txtOurRefNo + "&dtOurRefNo=" + dtOurRefNo + "&YourRefNo=" + txtYourRefNo + "&dtYourRefNo=" + dtYourRefNo + "&Indentdetails=" + detvalues + "&Optype=" + Optype + "&txtPayment=" + txtPayment + "&txtDescount=" + txtDescount + "&txtFright=" + txtFright + "&txtBankCharges=" + txtBankCharges + "&txtGoodsent=" + txtGoodsent + "&txtDelivery=" + txtDelivery + "&txtValidityPeriod=" + txtValidityPeriod + "&txtYear=" + txtYear + "&txtBCReg=" + txtBCReg + "&txtSrNo=" + txtSrNo + "&txtAudited=" + txtAudited + "&txtCl=" + txtCl + "&Date1_TextBox=" + Date1_TextBox + "&Date2_TextBox=" + Date2_TextBox + "&txtAudit_officer=" + txtAudit_officer + "&txtResNo=" + txtResNo + "&txtPurchase=" + txtPurchase + "&txtBudgetAccount=" + txtBudgetAccount + "&txtPreparedby=" + txtPreparedby + "&txtCheckedBy=" + txtCheckedBy + "&txtIndentRefNo=" + txtIndentRefNo + "&txtspdiscount=" + txtspdiscount + "&txtvat=" + txtvat + "&txted=" + txted + "&ddlCategory=" + ddlCategory;


            }
            else {
                var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo + "&PODate=" + dtPODate + "&OurRefNo=" + txtOurRefNo + "&OurRefNo=" + dtOurRefNo + "&YourRefNo=" + txtYourRefNo + "&YourRefNo=" + dtYourRefNo + "&Indentdetails=" + detvalues + "&Optype=" + Optype;
                Optype = 0;
            }
            //         var defId  = '<%=request.querystring("IndNo") %>'     
            //        alert(defId);
            sendRequest(url);
        }

        function Clean() {
            window.location.href = "po_master.aspx";
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


        function handleresponse() {


            if (xmlHttp.readyState == 4) {
                resp = xmlHttp.responseText;


                if (resp.indexOf('Add') != -1) {
                    alert('Data Added Successfully.');
                    //getDefect();
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
                    alert('This Po alredy entered');
                    setTimeout(function() { document.getElementById('txtPONo').focus() }, 10);

                    return false;
                }


            }
        }

        function addIndentReq() {

        }



        function getitemname() {

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

                    document.getElementById('txtNomenclature').value = resp;
                }
            }
            var txtCodeNo = document.getElementById('txtCodeNo').value;

            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=Nomunclature&CodeNo=" + txtCodeNo, true);
            xmlHttp.send(null);
        }


        function Select() {

            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtNomenclature');
                    objddl1.value = resultStr.trim();
                    document.getElementById('Select1').style.display = "none";
                    document.getElementById('txtltrperbar').focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }

        function Selectbarrel() {

            //var resultStr = "";
            var resultStr = new Array();
            objddl2 = document.getElementById('selectbarreltype');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr = (objddl2.options[i].text).split("|");
                    var objddl1 = document.getElementById('txtltrperbar');
                    objddl1.value = resultStr[0].trim();
                    document.getElementById('hdnavbbarrel').value = resultStr[1].trim();
                    document.getElementById('selectbarreltype').style.display = "none";
                    document.getElementById('txtnoofbarrel').focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }


        function emptytext() {

            if (document.getElementById('txtPartNo').value != '' && document.getElementById('txtItemName').value != '') {
                document.getElementById('txtPartNo').value = '';
                document.getElementById('txtItemName').value = '';
            }
        }

        function emptytextpart() {
            if (document.getElementById('txtsubrack').value != '' && document.getElementById('txtItemName').value != '') {
                document.getElementById('txtsubrack').value = '';
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
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');

                }
            }
            var itemname = document.getElementById('txtNomenclature').value;

            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrack=" + txtsubrack + "&partno=" + partno, true);
            xmlHttp.send(null);
        }

        ///////////   for removing blaak spaces 
        String.prototype.trim = function() {

            return this.replace(/^\s+|\s+$/g, "");
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
            if (document.getElementById("txtReqQty").value.length > 0) {

                if (IsNumeric(document.getElementById("txtReqQty").value)) {
                    addEmpDetails();
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtReqQty").focus();
                }
            }
            else {

                alert("Enter Proper Value");
                document.getElementById("txtReqQty").focus();
            }
        }



        ///////////////////  for filteration ///////////////////////////////////////



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

                    while (document.getElementById("Select1").options.length > 0)

                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.getElementById('txtNomenclature').value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("Select1")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("Select1").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.text = ele[i];
                            if (document.getElementById('txtNomenclature').value == ele[i]) {
                                // temp.style.display="none";				               
                                // return false;
                            }
                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                //  return false;
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById("Select1")
                        temp.size = 0
                        //temp.style.display="none";
                        temp.style.display = '';
                    }
                }
            }



            url = "../store/AjaxStore.aspx?Action=oilitemname&itemid=''&item=" + document.getElementById('txtNomenclature').value + '&t=' + new Date();
            xmlHttp.open("GET", url, true);
            xmlHttp.send(null);





        }


        function barreltypesearch() {

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
                        document.getElementById("selectbarreltype").style.display = 'none';
                        return false;
                    }

                    var ele = resp.split("!");

                    while (document.getElementById("selectbarreltype").options.length > 0)

                        document.getElementById("selectbarreltype").options.remove(document.getElementById("selectbarreltype").options.length - 1);
                    if (document.getElementById('txtNomenclature').value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("selectbarreltype")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("selectbarreltype").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.text = ele[i];
                            if (document.getElementById('txtNomenclature').value == ele[i]) {
                                // temp.style.display="none";				               
                                // return false;
                            }
                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                //  return false;
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById("selectbarreltype")
                        temp.size = 0
                        //temp.style.display="none";
                        temp.style.display = '';
                    }
                }
            }



            url = "../store/AjaxStore.aspx?Action=oilitemnameandbarrel&itemid=''&item=" + document.getElementById('txtNomenclature').value + '&t=' + new Date();
            xmlHttp.open("GET", url, true);
            xmlHttp.send(null);





        }



        function fillitem() {

            objddl2 = document.getElementById('Select1');

            if (document.getElementById("txtNomenclature").value == '' && objddl2.options.length > 0) {

                document.getElementById("txtNomenclature").value = objddl2.options[0].text;
                //  document.getElementById('txtbaserate').focus();
                objddl2.style.display = 'none';
            }

        }

        function check1() {

            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() != '') {
                //Fromcombo2();
            }
            else {
                setTimeout(function() { document.getElementById('txtNomenclature').focus() }, 10);
            }
            return false;
        }


        function checkQuntity() {

            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() == '') {
                setTimeout(function() { document.getElementById('txtNomenclature').focus() }, 10);
                return false;
            }
            else {

                var Quantity = document.getElementById('txtQuantity');
                if (Quantity.value == '') {
                    alert('Enter the Quntity');
                    setTimeout(function() { Quantity.focus() }, 10);

                    return false;
                }
                if (IsNumeric(Quantity.value) == false) {
                    alert('Enter numeric Quantity');
                    setTimeout(function() { Quantity.focus() }, 10);
                    Quantity.value = '';
                    return false;
                }
            }
            return true;
        }
        function calculatebefore() {
            var txtltrperbar = document.getElementById('txtltrperbar');
            var txtnoofbarrel = document.getElementById('txtnoofbarrel');
            if (txtnoofbarrel.value != '') {
                document.getElementById('txttotalltr').value = (parseFloat(txtltrperbar.value) * parseFloat(txtnoofbarrel.value)).toFixed(2);
            }
        }

        function calculate() {

            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() == '') {
                setTimeout(function() { document.getElementById('txtNomenclature').focus() }, 10);
                return false;
            }
            else {

                var txtltrperbar = document.getElementById('txtltrperbar');
                var txtnoofbarrel = document.getElementById('txtnoofbarrel');
                if (txtltrperbar.value == '') {
                    alert('Enter the No of ltr contain Per barrel');
                    setTimeout(function() { txtltrperbar.focus() }, 10);
                    return false;
                }

                if (IsNumeric(txtltrperbar.value) == false) {
                    alert('Enter Numbers Only');
                    setTimeout(function() { txtltrperbar.focus() }, 10);
                    txtltrperbar.value = '';
                    return false;
                }
                if (txtnoofbarrel.value == '') {
                    alert('Enter the Quntity');
                    setTimeout(function() { txtnoofbarrel.focus() }, 10);
                    return false;
                }

                if (IsNumeric(txtnoofbarrel.value) == false) {
                    alert('Enter numeric Quantity');
                    setTimeout(function() { txtnoofbarrel.focus() }, 10);
                    txtnoofbarrel.value = '';
                    return false;
                }
                if ((txtnoofbarrel.value) == 0) {
                    alert('No Of issue barrel should not be Zero');
                    txtltrperbar.value = '';
                    setTimeout(function() { document.getElementById('txtNomenclature').focus() }, 10);
                    return false;
                }
                if ((txtnoofbarrel.value) > parseFloat(document.getElementById('hdnavbbarrel').value)) {
                    alert('No Of issue barrel should be less than or equal to Available Barrel');
                    setTimeout(function() { txtnoofbarrel.focus() }, 10);
                    return false;
                }
                document.getElementById('txttotalltr').value = (parseFloat(txtltrperbar.value) * parseFloat(txtnoofbarrel.value)).toFixed(2);

                return Amount();
            }
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
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');

                }
            }
            var itemname = document.getElementById('txtNomenclature').value;

            xmlHttp.open("GET", "AjaxStore.aspx?Action=itemqty&itemid=" + itemname, true);
            //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
            xmlHttp.send(null);
        }



        function setfocus() {
            document.getElementById('txtNomenclature').focus();
        }
 
    </script>

    <link href="css/website.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete2.css" rel="stylesheet" />
    <link href="SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
    <link href="css/website.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete2.css" rel="stylesheet" />
    <link href="SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
    <link href="css/website.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.autocomplete2.css" rel="stylesheet" />
    <link href="SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #txtref_asrtu
        {
            width: 825px;
        }
        #txtspdisc
        {
            width: 817px;
        }
        .style1
        {
            height: 23px;
        }
    </style>

    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Job Order Card Master</h1>
    </div>
    <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
    <div class="form-horizontal">
       
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    </div>
    <div id="middal1">
     
        <div class="contantbox">
            <div class="orgtop1">
            </div>
            <div class="orgmiddal1">
                <table width="100%" style="width: 1000px" border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="6" align="center" class="innerheading">
                            <span id="Label3">OIL Issue
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td align="right">
                                        Depot Name:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddldepot" TabIndex="1" runat="server" Width="216px" Height="25"
                                            Font-Size="Medium">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right">
                                        Date : -
                                    </td>
                                    <td align="left">
                                 
                                                     <asp:TextBox ID="BDPissuedate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPissuedate"
                                        PopupButtonID="BDPissuedate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Worker Name :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtwname" TabIndex="3" runat="server" Width="168px" Height="20"
                                            Font-Size="Medium"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Approved By :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtapproved" TabIndex="4" runat="server" Width="168px" Height="20"
                                            Font-Size="Medium"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="style1">
                                        Indent No :
                                    </td>
                                    <td align="left" class="style1">
                                        <asp:TextBox ID="txtref" TabIndex="5" runat="server" Height="20" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                    <td align="right" class="style1">
                                    </td>
                                    <td align="left" class="style1">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Gate Pass No :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtgate" TabIndex="7" runat="server" Height="20" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Remark :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtremark" TabIndex="8" TextMode="MultiLine" runat="server" Width="168px"
                                            Height="20" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdindent" colspan="6">
                            <div style="border: solid 2px #000">
                                <table id="tblIndent" width="100%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbodyIndent">
                                        <tr class='gridhead'>
                                            <td>
                                                SR No.
                                            </td>
                                            <td>
                                                Nomenclature
                                            </td>
                                            <td>
                                                Ltr per Barrel
                                            </td>
                                            <td>
                                                No of Barrel
                                            </td>
                                            <td>
                                                Total Ltr
                                            </td>
                                        </tr>
                                        <tr class='gridtxt'>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <input type="text" id="txtNomenclature" onpropertychange="itemsearch()" />
                                                <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                    runat="server"></asp:ListBox>
                                            </td>
                                            <td>
                                                <input readonly="readonly" type="text" id="txtltrperbar" onfocus="barreltypesearch()"
                                                    style="width: 70px" maxlength="10" size="10" />
                                                <asp:ListBox ID="selectbarreltype" Style="display: none; align: left" onclick="Selectbarrel();"
                                                    runat="server"></asp:ListBox>
                                                <input id="hdnavbbarrel" runat="server" type="hidden" name="hdnavbbarrel" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtnoofbarrel" onblur="return calculate();" style="width: 70px"
                                                    maxlength="10" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txttotalltr" readonly="readonly" style="width: 70px" size="15" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="6">
                            <asp:Button ID="btnsubmit" runat="server" Text="Save" />
                            <a href="oilISSUE.aspx">Reset</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="orgbottam1">
            </div>
        </div>
    </div>
</asp:Content>