<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="oilpo.aspx.vb"
    Inherits="kdmt.oilpo" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>PO Master</title>

    <script language="javascript" type="text/javascript">

        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;       
var rowcntSave = 1;
var rowcntother = 1;
 var rowcntothersave = 1;


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
            var txtRate = document.getElementById('txtRate');
            var txtperbarrel = document.getElementById('txtperbarrel');
            var txtAmount = document.getElementById('txtAmount');
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
            cells6.setAttribute('id', 'tdRate_' + rowcnt);
            var cells7 = row.insertCell(6);

            cells7.setAttribute('id', 'tdperbarrel_' + rowcnt);
            var cells8 = row.insertCell(7);
            cells8.setAttribute('id', 'tdAmount_' + rowcnt);

            var cells9 = row.insertCell(8);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

            cells2.innerHTML = txtNomenclature.value;
            cells3.innerHTML = txtltrperbar.value;
            cells4.innerHTML = txtnoofbarrel.value;

            cells5.innerHTML = txttotalltr.value;
            cells6.innerHTML = txtRate.value;

            cells7.innerHTML = txtperbarrel.value;
            cells8.innerHTML = txtAmount.value;

            cells9.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            txtNomenclature.value = '';
            txtltrperbar.value = '';
            txtnoofbarrel.value = '';
            txtNomenclature.value = '';
            txttotalltr.value = '';

            txtperbarrel.value = '';
            txtRate.value = '';
            txtAmount.value = '';

            document.getElementById('hdnrwcnt').value = rowcnt;
            document.getElementById('txtNomenclature').focus();
            // alert(document.getElementById('hdnrwcnt').value)
        }

function addPODetailsother() {

    if (document.getElementById('hdnsrnoother').value == '')
    {
    document.getElementById('hdnsrnoother').value = 0;
    } 
    var srnoother = 0;
    var lblsrno = document.getElementById('lblsrnoother'); 
   var txtsrno1 = document.getElementById('txtsrno1');  
   var txtQty1 = document.getElementById('txtmon1');
   var txtQty2 = document.getElementById('txtmon2');
   var txtQty3 = document.getElementById('txtmon3');
   var txtQty4 = document.getElementById('txtmon4');
   var txtQty5 = document.getElementById('txtmon5');
   var txtQty6 = document.getElementById('txtmon6');
   var txtQty7 = document.getElementById('txtmon7');
   var txtQty8 = document.getElementById('txtmon8');
   var txtQty9 = document.getElementById('txtmon9');
   var txtQty10 = document.getElementById('txtmon10');
   var txtQty11 = document.getElementById('txtmon11');
   var txtQty12 = document.getElementById('txtmon12');
   
    var tbody = document.getElementById('tbodyother');  
    
    var row  = tbody.insertRow(rowcntother);
    row.setAttribute('id','trPOother_' + rowcntothersave);
    
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdsrnoother_' + rowcntothersave);
    
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdsrno1_' + rowcntothersave);
    
     var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tdQty1_' + rowcntothersave);
    
     var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdQty2_' + rowcntothersave);
    
    var cells5 = row.insertCell(4);
    cells5.setAttribute('id','tdQty3_' + rowcntothersave);
    
     var cells6 = row.insertCell(5);
    cells6.setAttribute('id','tdQty4_' + rowcntothersave);
    
     var cells7 = row.insertCell(6);
    cells7.setAttribute('id','tdQty5_' + rowcntothersave);
    
    var cells8 = row.insertCell(7);
    cells8.setAttribute('id','tdQty6_' + rowcntothersave);
    
     var cells9 = row.insertCell(8);
    cells9.setAttribute('id','tdQty7_' + rowcntothersave);
    
    var cells10 = row.insertCell(9);
    cells10.setAttribute('id','tdQty8_' + rowcntothersave);
   
   var cells11 = row.insertCell(10);
    cells11.setAttribute('id','tdQty9_' + rowcntothersave);
    
    var cells12 = row.insertCell(11);
    cells12.setAttribute('id','tdQty10_' + rowcntothersave);
    
    var cells13 = row.insertCell(12);
    cells13.setAttribute('id','tdQty11_' + rowcntothersave);
    
    var cells14 = row.insertCell(13);
    cells14.setAttribute('id','tdQty12_' + rowcntothersave);
    
   
    var cells15 = row.insertCell(14);     
   
    cells1.innerHTML = parseInt(document.getElementById('hdnsrnoother').value) + 1;
    document.getElementById('hdnsrnoother').value = parseInt(document.getElementById('hdnsrnoother').value) + 1
   
    cells2.innerHTML = txtsrno1.value;
    cells3.innerHTML = txtQty1.value;
    cells4.innerHTML = txtQty2.value;    
    cells5.innerHTML = txtQty3.value;
    cells6.innerHTML = txtQty4.value;
    cells7.innerHTML = txtQty5.value;    
    cells8.innerHTML = txtQty6.value;
    cells9.innerHTML = txtQty7.value;
    cells10.innerHTML = txtQty8.value;    
    cells11.innerHTML = txtQty9.value;
    cells12.innerHTML = txtQty10.value;
    cells13.innerHTML = txtQty11.value;    
    cells14.innerHTML = txtQty12.value;    

    cells15.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRowother(\'trPOother_'+ rowcntothersave+'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    
    rowcntother= rowcntother+ 1;
    rowcntothersave = rowcntothersave + 1
    txtsrno1.value = '';
    txtQty1.value = '';
    txtQty2.value = '';
    txtQty3.value = '';
    txtQty4.value = '';
    txtQty5.value = '';   
    txtQty6.value = '';  
    txtQty7.value = '';    
    txtQty8.value = '';
    txtQty9.value = '';
    txtQty10.value = '';
    txtQty11.value = '';   
    txtQty12.value = '';      
  
   // txtsrno1.focus();        
    document.getElementById('hdnrwcntother').value = rowcntothersave;     
   // alert(document.getElementById('hdnrwcnt').value)
    txtsrno1.focus();
    ValidateSaveother(); 
}

 function ValidateSaveother()
    {
    //debugger
     var detvaluesother = '';
    var i = 0;
          var hdnrwcntother = document.getElementById('hdnrwcntother').value;
        for (i=1;i<hdnrwcntother ;i++)
              {    
                if (document.getElementById('tdsrno1_' + i)!= null)
                {                               
                var srno1 = document.getElementById('tdsrno1_' + i).innerHTML;
                var mon1 = document.getElementById('tdQty1_' + i).innerHTML;//                
                var mon2 = document.getElementById('tdQty2_' + i).innerHTML;
                var mon3 = document.getElementById('tdQty3_' + i).innerHTML;                
                var mon4 = document.getElementById('tdQty4_' + i).innerHTML;
                var mon5 = document.getElementById('tdQty5_' + i).innerHTML;
                var mon6 = document.getElementById('tdQty6_' + i).innerHTML;
                var mon7 = document.getElementById('tdQty7_' + i).innerHTML;
                var mon8 = document.getElementById('tdQty8_' + i).innerHTML;
                var mon9 = document.getElementById('tdQty9_' + i).innerHTML;
                var mon10 = document.getElementById('tdQty10_' + i).innerHTML;
                var mon11 = document.getElementById('tdQty11_' + i).innerHTML;
                var mon12 = document.getElementById('tdQty12_' + i).innerHTML; 
                       
//                detvaluesother = detvaluesother + txtlfNo + '^' + CodeNo + '^' + Nomenclature + '^' + baserate + '^' + baseqty + '|';
                  detvaluesother = detvaluesother + srno1 + '^' + mon1 + '^' + mon2 + '^' + mon3 + '^' + mon4 + '^' + mon5 + '^' + mon6 + '^' + mon7  + '^' + mon8 + '^' + mon9 + '^' + mon10 + '^' + mon11 + '^' + mon12 + '|' ;            
                }
              }  
                  document .getElementById ("hdndetailother").value = detvaluesother                  
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
            if (Rate.value == '') {
                alert('Enter the Rate');
                setTimeout(function() { Rate.focus() }, 10);
                return false;
            }
            if (isNaN(Rate.value)) {
                alert('Enter numeric Rate');
                setTimeout(function() { Rate.focus() }, 10);
                Rate.value = '';
                return false;
            }

            // return checkQuntity ();

            txtperbarrel.value = ((Rate.value) * (txtltrperbar.value)).toFixed(2);
            Amt.value = ((Rate.value) * (txttotalltr.value)).toFixed(2);
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




        function validatedata() {

            ValidateSave();
            var ddlvendor = document.getElementById('ddlvendor');

            var ddlPONo = document.getElementById('ddlPONo');
            var txtpono = document.getElementById('txtPONo');
            var txtOurRefNo = document.getElementById('txtOurRefNo');
            var txtYourRefNo = document.getElementById('txtYourRefNo');
            var hdndetail = document.getElementById('hdndetail');

            if (ddlvendor.value == 0) {
                alert('Select vendor name');
                ddlvendor.focus();
                return false;
            }

            else if (ddlPONo.value == 0) {
                alert('Select PO name');
                ddlPONo.focus();
                return false;
            }
            else if (txtpono.value == '') {
                alert('Enter PONo.');
                txtpono.focus();
                return false;
            }

            else if (IsNumeric(txtpono.value) == false) {
                alert('please Enter numbers Only.');
                txtpono.focus();
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
                    var noofbarre = document.getElementById('tdnoofbarrel_' + i).innerHTML;
                    var totalltr = document.getElementById('tdtotalltr_' + i).innerHTML;
                    var Rate = document.getElementById('tdRate_' + i).innerHTML;
                    var perbarrel = document.getElementById('tdperbarrel_' + i).innerHTML;
                    var Amount = document.getElementById('tdAmount_' + i).innerHTML;

                    detvalues = detvalues + Nomenclature + '^' + ltrperbar + '^' + noofbarre + '^' + totalltr + '^' + Rate + '^' + perbarrel + '^' + Amount + '|';


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
                    objddl1.value = resultStr;
                 
                    document.getElementById('Select1').style.display = "none";
                    document.getElementById('txtltrperbar').focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }

        function visiblefalse() {
         
            document.getElementById('Select1').style.display = "none";
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
                document.getElementById('txttotalltr').value = (parseFloat(txtltrperbar.value) * parseFloat(txtnoofbarrel.value)).toFixed(2);


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
        .style1
        {
            height: 43px;
        }
        #txtref_asrtu
        {
            width: 825px;
        }
        #txtspdisc
        {
            width: 817px;
        }
    </style>

    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Job Order Card Master</h1>
    </div>
    <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
    <div class="form-horizontal">>

        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
         <input id="hdnrwcntother" runat="server" type="hidden" name="hdnrwcntother" />
         <input id="hdnsrnoother" runat="server" type="hidden" name="hdnsrnoother" />
         <input id="hdndetailother" runat="server" type="hidden" name="hdndetailother" />
    </div>
    <div id="middal1">
    
        <div class="contantbox">
            <div class="orgtop1">
            </div>
            <div class="orgmiddal1">
                <table width="100%" style="width: 1000px" border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="6" align="center" class="innerheading">
                            <span id="Label3">Purchase Order (
                                <asp:Label ID="lbldepttype" Text="OIL" ForeColor="red" runat="server"></asp:Label>
                                )</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            Vendor Name:
                            <asp:TextBox ID="ddlvendor" runat="server" Width="216px"> </asp:TextBox>
                        </td>
                        <td colspan="2" align="left">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            P.O Date
                        </td>
                        <td>
                          
                                     <asp:TextBox ID="dtPODate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="dtPODate"
                                        PopupButtonID="dtPODate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                        </td>
                        <td align="right">
                            P.O No.
                        </td>
                        <td align="left">
                            <select id="ddlPONo" runat="server" style="width: 140px">
                                <option value="OIL">OIL</option>
                            </select>
                            <span lang="en-us">
                                <%--   <input type="text" id="txtPONo" name="txtPONo" size="5px" onclick="return txtPONo_onclick()"
                                    />--%>
                                <asp:TextBox ID="txtPONo" Width="70%" ReadOnly="true" runat="server"></asp:TextBox>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Our Ref No.
                        </td>
                        <td>
                            <input type="text" id="txtOurRefNo" name="txtOurRefNo" />
                        </td>
                        <td align="right">
                            Our Ref Date
                        </td>
                        <td>
                    
                        
                                     <asp:TextBox ID="dtOurRefNo" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="dtOurRefNo"
                                        PopupButtonID="dtOurRefNo" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Your Ref No.
                        </td>
                        <td>
                            <input type="text" id="txtYourRefNo" name="txtYourRefNo" />
                        </td>
                        <td align="right">
                            Your Ref Date :
                        </td>
                        <td>
                         
                                     <asp:TextBox ID="dtYourRefNo" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="dtYourRefNo"
                                        PopupButtonID="dtYourRefNo" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            Ref ASRTU
                        </td>
                        <td colspan="3">
                            <input type="text" id="txtref_asrtu" name="txtref_asrtu" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            Special Discount
                        </td>
                        <td colspan="3" class="style1">
                            <input type="text" id="txtspdisc" name="txtspdisc" />%
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Vat
                        </td>
                        <td align="left">
                            <input type="text" id="txtvat" value='0' name="txtvat" />%
                        </td>
                        <td align="right">
                            ED
                        </td>
                        <td align="left">
                            <input type="text" id="txtED" value='0' name="txtED" onblur="setfocus()" />%
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
                                            <td>
                                                Per LTR Rate
                                            </td>
                                            <td>
                                                Per Barrel Rate
                                            </td>
                                            <td>
                                                Amount
                                            </td>
                                        </tr>
                                        <tr class='gridtxt'>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <input type="text" id="txtNomenclature" onpropertychange="itemsearch()" onblur="fillitem();" />
                                                <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                    runat="server"></asp:ListBox>
                                            </td>
                                            <td>
                                                <input type="text" id="txtltrperbar" style="width: 70px" onblur ="calculatebefore()" maxlength="5" size="5" />
                                                <%--<input type="text" id="txtbaserate" style="width: 70px" maxlength="10" size="10" />--%>
                                            </td>
                                            <td>
                                                <input type="text" id="txtnoofbarrel" onfocus="visiblefalse()"   onblur="return calculate();" style="width: 70px"
                                                    maxlength="5" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txttotalltr" readonly="readonly" style="width: 70px" size="15" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtRate" maxlength="8" style="width: 70px" size="15" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtperbarrel" onfocus="return Amount();" style="width: 70px"
                                                    size="15" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtAmount"" " size="20" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td id="td1" colspan="6">
                            <div style="border: solid 2px #000">
                                <table id="tblother" width="100%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbodyother">
                                        <tr class='gridhead'>
                                            <td>
                                                SR No.
                                            </td> 
                                            <td>
                                                Item No.
                                            </td>
                                            <td>                                          
                                                APR</td>
                                                 <td>
                                                     MAY</td>
                                                 <td>
                                                     JUN</td>
                                                 <td>
                                                     JULY</td>
                                                 <td>
                                                     AUG</td>
                                                 <td>
                                                     SEP</td>
                                                     <td>
                                                OCT</td>
                                            <td>
                                                NOV</td>
                                            <td>
                                                DEC</td>
                                                 <td>
                                                     JAN</td>
                                                 <td>
                                                     FEB</td>
                                                 <td>
                                                     MAR</td>                                                 
                                           <%-- <td>
                                                4
                                            </td>
                                            <td>
                                                5
                                            </td>--%>
                                        </tr>
                                        <tr class='gridtxt'>
                                            <td>
                                                <input type="text" id="lblsrnoother" style="width: 20px" readonly="readonly" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtsrno1" style="width: 50px; text-align:center" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon1" style="width: 50px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon2" style="width: 50px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon3" style="width: 50px"
                                                    size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon4" style="width: 50px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon5" style="width: 50px"
                                                    size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon6" style="width: 50px" size="10"   />
                                            </td>
                                             <td>
                                                <input type="text" id="txtmon7" style="width: 50px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon8" style="width: 50px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon9" style="width: 50px"
                                                    size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon10" style="width: 50px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtmon11" style="width: 50px"
                                                    size="10" />
                                            </td>    
                                            <td>
                                                <input type="text" id="txtmon12" style="width: 50px"
                                                    size="10"  onblur="addPODetailsother();" />
                                            </td>                                         
                                          <%--  <td>
                                                <input type="text" id="txtqty4" style="width: 70px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtqty5" onblur="addPODetailsother();" style="width: 70px"
                                                    size="10" />
                                            </td>--%>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 13px">(1) Bill and Challans should be sent in triplicate,</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(2) Payment will be made </span>
                        </td>
                        <td>
                            <input type="text" value="Through Bank" id="txtPayment" name="txtPayment" tabindex="9" />
                        </td>
                        <td align="left" colspan="1" rowspan="6" valign="top">
                            <span style="font-size: 18px">This purchase is made under the
                                <br />
                                <br />
                                powers vested in me under the
                                <br />
                                <br />
                                B.P.M.C. Act, 1994 Chapter V,
                                <br />
                                <br />
                                Section(1)(i)(2) Exection
                                <br />
                                <br />
                                of contract waived.</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(3) Discount</span>
                        </td>
                        <td>
                            <input type="text" id="txtDescount" name="txtDescount" tabindex="10" />%
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(4) Freight will be borne by</span>
                        </td>
                        <td>
                            <input type="text" id="txtFright" name="txtFright" tabindex="11" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(5) Bank charges/commission will be borne by</span>
                        </td>
                        <td>
                            <input type="text" id="txtBankCharges" name="txtBankCharges" tabindex="11" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(6) Good to be sent by</span>
                        </td>
                        <td>
                            <input type="text" id="txtGoodsent" name="txtGoodsent" tabindex="12" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(7) Delivert should be completed by</span>
                        </td>
                        <td>
                            <input type="text" id="txtDelivery" name="txtDelivery" tabindex="13" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span style="font-size: 14px">(8) Validity Period</span>
                        </td>
                        <td>
                            <input type="text" id="txtValidityPeriod" name="txtValidityPeriod" tabindex="14" />
                        </td>
                    </tr>
                    <tr rowspan="2">
                        <td>
                            <span style="font-size: 14px">Total Commitment Rs.............year</span>
                        </td>
                        <td>
                            <input type="text" id="txtYear" name="txtYear" tabindex="15" />
                        </td>
                        <td align="left" colspan="2" style="width: 50%">
                            <span style="font-size: 14px">Rate sanctioned by TC/Transport Manager</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-size: 14px">Entd in B/C Regr</span>
                            <input type="text" id="txtBCReg" name="txtBCReg" tabindex="16" />
                        </td>
                        <td>
                            <span style="font-size: 14px">Sr.No</span>
                            <input type="text" id="txtSrNo" name="txtSrNo" tabindex="17" />
                        </td>
                        <td align="left" colspan="2">
                            <span style="font-size: 14px">Res.No.</span>
                            <input type="text" id="txtResNo" name="txtResNo" tabindex="22" />
                            <span style="font-size: 14px">Trans.ManagDt.</span>
                     
                                     <asp:TextBox ID="Date2" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="Date2"
                                        PopupButtonID="Date2" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        </td>
                        <td align="left" colspan="2">
                            <span style="font-size: 14px">Purchase Authorised by </span>
                            <input type="text" id="txtPurchase" name="txtPurchase" tabindex="24" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-size: 14px">Audited by</span>
                            <input type="text" id="txtAudited" name="txtAudited" tabindex="18" />
                        </td>
                        <td>
                            <span style="font-size: 14px">Cl.</span>
                            <input type="text" id="txtCl" size="15px" name="txtCl" tabindex="19" />
                            <span style="font-size: 14px">Dt.</span>
                     
                                     <asp:TextBox ID="Date1" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="Date1"
                                        PopupButtonID="Date1" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                        </td>
                        <td align="left" colspan="2">
                            <span style="font-size: 14px">Budegt Account Hd</span>
                            <input type="text" id="txtBudgetAccount" name="txtBudgetAccount" onclick="return txtBudgetAccount_onclick()"
                                tabindex="25" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        </td>
                        <td align="left" colspan="2">
                            <span style="font-size: 14px">Prepared by</span>
                            <input type="text" id="txtPreparedby" name="txtPreparedby" tabindex="26" />
                            <span style="font-size: 14px">Checked by</span>
                            <input type="text" id="txtCheckedBy" name="txtCheckedBy" tabindex="28" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-size: 14px">Audited Officer</span>
                        </td>
                        <td>
                            <input type="text" id="txtAudit_officer" name="txtAudit_officer" tabindex="21" />
                        </td>
                        <td>
                            <span style="font-size: 14px">Indent Ref No .</span>
                            <input type="text" id="txtIndentRefNo" name="txtIndentRefNo" tabindex="29" onblur="setfocus()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="6">
                            <asp:Button ID="Button1" runat="server" Text="Save" />
                            <asp:Button ID="btn_print" Text="Print" runat="server" />
                            <a href="oilpo.aspx">Reset</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="orgbottam1">
            </div>
        </div>
    </div>
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});

$("#txtref_asrtu").autocompleteArray(
		[<% =strref_asrtu  %>],
		{
			delay:10,
			minChars:1,
			matchSubset:1,
			onItemSelect:selectItem,
			onFindValue:findValue,
			autoFill:true,
			maxItemsToShow:10
		}
	);


$("#txtspdisc").autocompleteArray(
		[<% =strspdisc  %>],
		{
			delay:10,
			minChars:1,
			matchSubset:1,
			onItemSelect:selectItem,
			onFindValue:findValue,
			autoFill:true,
			maxItemsToShow:10
		}
	);
	
	
$("#ddlvendor").autocompleteArray(
		[<% =strVendor  %>],
		{
			delay:10,
			minChars:1,
			matchSubset:1,
			onItemSelect:selectItem,
			onFindValue:findValue,
			autoFill:true,
			maxItemsToShow:10
		}
	);



    </script>

</asp:Content>