<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GlassPOMaster.aspx.vb" Inherits="KDMT.GlassPOMaster" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Glass PO Master</title>
    
        <script language="javascript" type="text/javascript">
   
var Optype = 0
var Fuel
var ID = 0;
var rowcnt = 1;
 
function addPODetails() {

    if (document.getElementById('hdnsrno').value == '')
    {
    document.getElementById('hdnsrno').value = 0;
    } 
    var srno = 0;
    //var lblsrno = document.getElementById('lblsrno'); 
    //var txtlfNo = document.getElementById('txtlfno');
    //var txtCodeNo = document.getElementById('txtCodeNo');
    var txtNomenclature = document.getElementById('txtNomenclature');
    var txtbaserate = document.getElementById('txtbaserate');
    var txtbaseqty = document.getElementById('txtbaseqty');
    var txtQuantity = document.getElementById('txtQuantity');
    var txtRate = document.getElementById('txtRate');
    var txtAmount = document.getElementById('txtAmount'); 
    var tbody = document.getElementById('tbodyIndent');  
    
    var row  = tbody.insertRow(rowcnt);
    row.setAttribute('id','trPO_' + rowcnt);
    
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdsrno_' + rowcnt);
    
    //var cells2 = row.insertCell(1);
    //cells2.setAttribute('id','tdlfno_' + rowcnt);
    //var cells3 = row.insertCell(2);
    //cells3.setAttribute('id','tdCodeNo_' + rowcnt);
    var cells4 = row.insertCell(1);
    cells4.setAttribute('id','tdNomenclature_' + rowcnt);
    var cells5 = row.insertCell(2);
    
    cells5.setAttribute('id','tdbaserate_' + rowcnt);
    var cells6 = row.insertCell(3);
    cells6.setAttribute('id','tdbaseqty_' + rowcnt);
    var cells7 = row.insertCell(4);
    
    cells7.setAttribute('id','tdQuantity_' + rowcnt);
    var cells8 = row.insertCell(5);    
    cells8.setAttribute('id','tdRate_' + rowcnt);    
    var cells9 = row.insertCell(6);    
    cells9.setAttribute('id','tdAmount_' + rowcnt);
    var cells10 = row.insertCell(7);     
   
    cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
   
    //cells2.innerHTML = txtlfNo.value;
    //cells3.innerHTML = txtCodeNo.value;
    cells4.innerHTML = txtNomenclature.value;
    
    cells5.innerHTML = txtbaserate.value;
    cells6.innerHTML = txtbaseqty.value;
    
    cells7.innerHTML = txtRate.value; 
    cells8.innerHTML = txtQuantity.value;
    cells9.innerHTML = txtAmount.value;
    cells10.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_'+ rowcnt +'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    
    rowcnt = rowcnt + 1;
    //lblsrno.value = '';
    //txtlfNo.value = '';
    //txtCodeNo.value = '';
    txtNomenclature.value = '';  
    txtbaserate.value = '';
    txtbaseqty.value = '';
    txtQuantity.value = '';
    txtRate.value = '';
    txtAmount.value = '';
    //txtlfNo.focus();        
    document.getElementById('hdnrwcnt').value = rowcnt;     
   // alert(document.getElementById('hdnrwcnt').value)
}

function Amount(){

    var Quantity = document.getElementById('txtbaseqty');
    var Rate = document.getElementById('txtRate');    
    var Amt = document.getElementById('txtQuantity');
    if(Rate.value==''){
        alert('Enter the Rate');
       setTimeout(function(){Rate.focus()}, 10);  
        return false;
    }
    if(isNaN(Rate.value)){
        alert('Enter numeric Rate');
       setTimeout(function(){Rate.focus()}, 10);  
        Rate.value='';
        return false;
    }   
    
   // return checkQuntity ();
    if (checkQuntity()==true )
    {
    document.getElementById('txtAmount').value = ((Rate.value) * (Amt.value)).toFixed(2);
    addPODetails();
    }
}

function deleteRow(cnt) { 
  
    var tr = document.getElementById(cnt);
    document.getElementById('tbodyIndent').removeChild(tr);
    var hdnrwcnt = document.getElementById('hdnrwcnt');
    //hdnrwcnt.value = hdnrwcnt.value -1;
    rowcnt = rowcnt - 1;   
    document.getElementById('hdnsrno').value = 0;
     for (i=1;i< hdnrwcnt.value  ;i++)
              {    
                if (document.getElementById('tdNomenclature_' + i)!= null){
                document.getElementById('tdsrno_' + i).innerHTML = parseInt (document.getElementById('hdnsrno').value) + 1
                document.getElementById('hdnsrno').value = parseInt (document.getElementById('hdnsrno').value) + 1
                      
                }
              } 
}

function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you wan`t to delete.")){return true}
     else{return false}  
   }
   

    function poexists(){  
        var ddlPONo = document.getElementById('ddlPONo').value;
        var dtPODate = document.getElementById('dtPODate_TextBox').value;  
        var txtpono = document.getElementById('txtPONo').value;        
        var url = "../tmtAjax/Common_ajax.aspx?action=checkpoexists&potype=" + ddlPONo + "&pono=" + txtpono + "&dtpoDate=" + dtPODate;       
        
        sendRequest(url);                                
         return false;
    }
    
       function getDefect(){         
        var url = '../tmtAjax/Common_ajax.aspx?action=getDefectDetails'        
        sendRequest(url);                                
         return false;
    }
    
    function DeleteDefect(ID){    
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
               Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&Optype=" + Optype;
            sendRequest(url);
            return false;
        }     
    }
    
    function ddlSelection(tdvalue,ddl){        
        for (i=0;i<ddl.length;i++){         
             if(ddl.options[i].text == tdvalue){
                ddl.selectedIndex = i;
             }
         }
    }
    
    function editDefect(id){    
        var ddlDefPriority = document.getElementById('ddlDefPriority');         
        ddlSelection(document.getElementById('tdDefPriority_'+ id).innerHTML,ddlDefPriority);         
        document.getElementById('dtDefectDate_TextBox').value = document.getElementById('tdDefDate_'+ id).innerHTML;               
        document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_'+ id).innerHTML;
        document.getElementById('txtDriverNo').value = document.getElementById('tdDriverNo_'+ id).innerHTML;
        document.getElementById('txtDefectTime').value = document.getElementById('tdDefectTime_'+ id).innerHTML;
        document.getElementById('txtDescription').value = document.getElementById('tdDescription_'+ id).innerHTML;                                                                  
        document.getElementById('hdnID').value = id
        Optype = 1;    
    }
       
    function validatedata(){

        ValidateSave();
        var ddlvendor = document.getElementById('ddlvendor');
        var ddlCategory = document.getElementById('ddlCategory');  
        var ddlPONo = document.getElementById('ddlPONo');      
        var txtpono = document.getElementById('txtPONo');
        var txtOurRefNo = document.getElementById('txtOurRefNo');          
        var txtYourRefNo = document.getElementById('txtYourRefNo');  
        var hdndetail = document.getElementById('hdndetail'); 
        
        if (ddlvendor.value == 0){
            alert('Select vendor name');
            ddlvendor.focus();
            return false;
        }
        var category =  ddlCategory.options[ddlCategory.selectedIndex].text;
        if ( category == 'Select')
        {
            alert('Select Category');
            ddlCategory.focus();
            return false ;
        }
        else if (ddlPONo.value == 0){
            alert('Select PO name');
            ddlPONo.focus();
            return false;
        }
        else if (txtpono.value == ''){
            alert('Enter PONo.');
            txtpono.focus();
            return false;
        }
 
          else if (IsNumeric(txtpono.value) == false  ){
            alert('please Enter numbers Only.');
            txtpono.focus();
            return false;
        }
         
       else if (hdndetail.value == ''){
           alert ('please  enter item');
           document.getElementById('txtlfno').focus();
            
            return false;
        }        
    }
    
    function ValidateSave()
    {
     var detvalues = '';
     var i = 0;
          var hdnrwcnt = document.getElementById('hdnrwcnt').value;
        for (i=1;i<hdnrwcnt ;i++)
              {    
                if (document.getElementById('tdNomenclature_' + i)!= null){
                
                //var txtlfNo = document.getElementById('tdlfno_' + i).innerHTML;
                //var CodeNo = document.getElementById('tdCodeNo_' + i).innerHTML;
                var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                
                var baserate = document.getElementById('tdbaserate_' + i).innerHTML;
                var baseqty = document.getElementById('tdbaseqty_' + i).innerHTML;
                
                var Quantity = document.getElementById('tdQuantity_' + i).innerHTML;
                var Rate = document.getElementById('tdRate_' + i).innerHTML;
                var Amount = document.getElementById('tdAmount_' + i).innerHTML; 
                       
                detvalues = detvalues + Nomenclature + '^' + baserate + '^' + baseqty + '^' + Quantity + '^' + Rate + '^' + Amount + '|';
                          
                }
              }  
                  document .getElementById ("hdndetail").value = detvalues                  
              }
    
    
    function ValidateSave1(){ 
    

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
                               
       var ddlCategory =document.getElementById('ddlCategory').value;           
      
        for (i=1;i<hdnrwcnt ;i++)
              {    
                if (document.getElementById('tdNomenclature_' + i)!= null){
                
                var txtlfNo = document.getElementById('tdlfno_' + i).innerHTML;
                var CodeNo = document.getElementById('tdCodeNo_' + i).innerHTML;
                var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                var Quantity = document.getElementById('tdQuantity_' + i).innerHTML;
                var Rate = document.getElementById('tdRate_' + i).innerHTML;
                var Amount = document.getElementById('tdAmount_' + i).innerHTML; 
                       
                detvalues = detvalues + txtlfNo + '^' + CodeNo + '^' + Nomenclature + '^' + Quantity + '^' + Rate + '^' + Amount + '|';
              
                }
              }                            
            
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){                       
           //  var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo +  "&PONo=" + txtpono + "&PODate=" + dtPODate  + "&OurRefNo=" + txtOurRefNo + "&dtOurRefNo=" + dtOurRefNo  + "&YourRefNo=" + txtYourRefNo + "&dtYourRefNo=" + dtYourRefNo  +"&Indentdetails=" + detvalues  + "&Optype=" + Optype+"&txtPayment=" + txtPayment  +  "&txtDescount=" + txtDescount  + "&txtFright=" + txtFright   + "&txtBankCharges=" + txtBankCharges  + "&txtGoodsent=" + txtGoodsent   + "&txtDelivery=" + txtDelivery  + "&txtValidityPeriod=" + txtValidityPeriod  +"&txtYear=" + txtYear  + "&txtBCReg=" + txtBCReg  +"&txtSrNo=" + txtSrNo  + "&txtAudited=" + txtAudited  +"&txtCl=" + txtCl  + "&Date1_TextBox=" + Date1_TextBox  +"&Date2_TextBox=" + Date2_TextBox  + "&txtAudit_officer=" + txtAudit_officer  +"&txtResNo=" + txtResNo + "&txtPurchase=" + txtPurchase +"&txtBudgetAccount=" + txtBudgetAccount   + "&txtPreparedby=" + txtPreparedby   +"&txtCheckedBy=" + txtCheckedBy    + "&txtIndentRefNo=" + txtIndentRefNo  + "&txtspdiscount=" + txtspdiscount  + "&txtvat=" + txtvat  + "&txted=" + txted;                         
      var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo +  "&PONo=" + txtpono + "&PODate=" + dtPODate  + "&OurRefNo=" + txtOurRefNo + "&dtOurRefNo=" + dtOurRefNo  + "&YourRefNo=" + txtYourRefNo + "&dtYourRefNo=" + dtYourRefNo  +"&Indentdetails=" + detvalues  + "&Optype=" + Optype+"&txtPayment=" + txtPayment  +  "&txtDescount=" + txtDescount  + "&txtFright=" + txtFright   + "&txtBankCharges=" + txtBankCharges  + "&txtGoodsent=" + txtGoodsent   + "&txtDelivery=" + txtDelivery  + "&txtValidityPeriod=" + txtValidityPeriod  +"&txtYear=" + txtYear  + "&txtBCReg=" + txtBCReg  +"&txtSrNo=" + txtSrNo  + "&txtAudited=" + txtAudited  +"&txtCl=" + txtCl  + "&Date1_TextBox=" + Date1_TextBox  +"&Date2_TextBox=" + Date2_TextBox  + "&txtAudit_officer=" + txtAudit_officer  +"&txtResNo=" + txtResNo + "&txtPurchase=" + txtPurchase +"&txtBudgetAccount=" + txtBudgetAccount   + "&txtPreparedby=" + txtPreparedby   +"&txtCheckedBy=" + txtCheckedBy    + "&txtIndentRefNo=" + txtIndentRefNo  + "&txtspdiscount=" + txtspdiscount  + "&txtvat=" + txtvat  + "&txted=" + txted+"&ddlCategory="+ddlCategory;                         
        }
        else{
             var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo + "&PODate=" + dtPODate  + "&OurRefNo=" + txtOurRefNo + "&OurRefNo=" + dtOurRefNo  + "&YourRefNo=" + txtYourRefNo + "&YourRefNo=" + dtYourRefNo  +"&Indentdetails=" + detvalues  + "&Optype=" + Optype;                         
             Optype = 0;
        }
//         var defId  = '<%=request.querystring("IndNo") %>'     
//        alert(defId);
        sendRequest(url);
    }
 
    function Clean(){
        window.location.href = "po_master.aspx";
    }
    
function ajaxFunction() {

    try	{
        // Firefox, Opera 8.0+, Safari
        xmlHttp=new XMLHttpRequest();   
    }
    catch (e) {
        // Internet Explorer
        try {
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
	    catch (e) {
            try { 
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
		    catch (e) {
                alert("Your browser does not support AJAX!");
			    return false;
            }            
        }
    }

    xmlHttp.onreadystatechange=handleresponse
}

ajaxFunction();

function sendRequest(url) {
//debugger
   ajaxFunction();
   url = url + '&t=' + new Date();
   xmlHttp.open("GET",url);
   xmlHttp.send(null);
}

function handleresponse() { 

    if(xmlHttp.readyState==4) {            
        resp = xmlHttp.responseText;       
      
         if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');        
            //getDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('This Po alredy entered');                  
                setTimeout(function(){document.getElementById('txtPONo').focus()}, 10);
            
            return false;
        }        
    }
}

function addIndentReq(){
}

function getitemname(){

    var xmlHttp;
    try
        {
        // Firefox, Opera 8.0+, Safari
        xmlHttp=new XMLHttpRequest();   
        }
    catch (e)
        {
            // Internet Explorer
            try
            {
                xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e)
            {
                try
                { 
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                catch (e)
                {
                    alert("Your browser does not support AJAX!");
                    return false;
                }
            }
        }
    xmlHttp.onreadystatechange=function()   
    {
        if(xmlHttp.readyState==4)
            {
                resp = ""
                resp = xmlHttp.responseText;               
                
                document.getElementById('txtNomenclature').value = resp;
            }           
    }       
    var txtCodeNo = document.getElementById('txtCodeNo').value;
    
    xmlHttp.open("GET","../store/AjaxStore.aspx?Action=Nomunclature&CodeNo=" +  txtCodeNo ,true);    
    xmlHttp.send(null);
}

function Select()
{
    var resultStr = ""; 
    objddl2 =document.getElementById('Select1');
    for(var i = 0; i < objddl2.options.length; i++ )
    {  
    if( objddl2.options[i].selected ) 
    {    
    resultStr+= (objddl2.options[i].text);
    var objddl1 = document.getElementById('txtItemName');
    objddl1.value=resultStr;
    var x=document.getElementById('Select1');
       x.style.display="none";  
    document.getElementById('txtItemName').focus();
    return false;
    //alert(resultStr)
    } 
    } 
}

function emptytext()
{
    if (document .getElementById ('txtPartNo').value !='' && document .getElementById ('txtItemName').value !='' )
    {
    document .getElementById ('txtPartNo').value='';
    document .getElementById ('txtItemName').value='';
    }
}

function emptytextpart()
{
    if (document .getElementById ('txtsubrack').value !='' && document .getElementById ('txtItemName').value !='' )
    {
    document .getElementById ('txtsubrack').value='';
    document .getElementById ('txtItemName').value='';
    }
}

function display()
{
    var x=document.getElementById('Select1');
       x.style.display="none";  
}

function Fromcombo2()
{
    var xmlHttp;
    try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();   
    }
    catch (e)
    {
    // Internet Explorer
    try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e)
    {
    try
    { 
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    catch (e)
    {
    alert("Your browser does not support AJAX!");
    return false;
    }
    }
    }
    xmlHttp.onreadystatechange=function()
    {
    if(xmlHttp.readyState==4)
    {
    resp = ""
    resp = xmlHttp.responseText;
    var ele1 = resp.split('|');
    //document.getElementById('txtPartNo').value=ele1[2];
    //document.getElementById('txtsubrack').value=ele1[3];
    }
    }
    var itemname= document.getElementById('txtItemName').value  ;
    //var txtsubrack = document.getElementById('txtsubrack').value;
    //var partno = document.getElementById('txtPartNo').value;   
    xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrack=" + txtsubrack + "&partno=" + partno ,true);
    xmlHttp.send(null);
}
			
///////////   for removing blaak spaces 
String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
}

  function IsNumeric(strString)
            {
					var ValidChars = "0123456789.";
					var Char;
						for (i = 0; i < strString.length; i++) 
					{ 
							Char = strString.charAt(i); 
							if (ValidChars.indexOf(Char) == -1) 
						{
							return false;
						}
					}
						return true;
			}

function validateqty()
			{
			    if(document.getElementById ("txtReqQty").value.length>0)
                {
			        if(IsNumeric(document.getElementById ("txtReqQty").value))
                    {
			            addEmpDetails();
			        }
			        else
			        {    			        
			            alert("Enter Proper Value");
			            document.getElementById ("txtReqQty").focus();
			        }
			    }
			      else
			        {    			        
			            alert("Enter Proper Value");
			            document.getElementById ("txtReqQty").focus();
			        }
			}	
			
			
			          
///////////////////  for filteration ///////////////////////////////////////


function Select()
{ 
    var resultStr = ""; 
    objddl2 =document.getElementById('Select1');
    for(var i = 0; i < objddl2.options.length; i++ )
    {  
    if( objddl2.options[i].selected ) 
    {    
    resultStr+= (objddl2.options[i].text);
    var objddl1 = document.getElementById('txtNomenclature');
    objddl1.value=resultStr;
    var x=document.getElementById('Select1');
       x.style.display="none";  
    document.getElementById('txtNomenclature').focus();
    return false;
    //alert(resultStr)
    } 
    } 
}

function itemsearch()
{
var xmlHttp;
try
{
// Firefox, Opera 8.0+, Safari
xmlHttp=new XMLHttpRequest();   
}
catch (e)
{
// Internet Explorer
try
{
xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
}
catch (e)
{
try
{ 
xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
}
catch (e)
{
alert("Your browser does not support AJAX!");
return false;
}
}
}
xmlHttp.onreadystatechange=function()
{
if(xmlHttp.readyState==4)
{

resp = xmlHttp.responseText;

if (resp == 0)
{
document.getElementById("Select1").style.display='none';
return false;
}

var ele = resp.split("!");

while(document.getElementById("Select1").options.length > 0)

document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
if(document.getElementById('txtNomenclature').value != "")
{
for (var i = 0; i < ele.length; i++)
{

var temp=document.getElementById("Select1")
temp.style.display='';
temp.size=ele.length;
newOpt = document.createElement("option");
document.getElementById("Select1").options.add(newOpt);

newOpt.value = ele[i];
newOpt.text  = ele[i];
if (document.getElementById ('txtNomenclature').value==ele[i])
{
// temp.style.display="none";				               
// return false;
}
if (ele[i]=="0")
{
//temp.style.display="none";				               
//  return false;
}		                         
}
}
else
{
var temp=document.getElementById("Select1")
temp.size=0
//temp.style.display="none";
temp.style.display='';
}
}
}
//var lfno = document.getElementById('txtlfno').value;
//var partno = document.getElementById('txtCodeNo').value;

 //if (lfno == "" && partno == "")
//{
    if (document.getElementById ('txtNomenclature').value.length >=3 )
    {
    url = "../store/AjaxStore.aspx?Action=itemnamedeptwiseglass&itemid=''&item=" + document.getElementById ('txtNomenclature').value;   
    //url = "../store/AjaxStore.aspx?Action=itemnamedeptwiseglass&itemid=''&item=" + document.getElementById ('txtNomenclature').value + '&t=' + new Date();   
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
    }
    else
    {
   // document.getElementById("<%= Select1.clientID %>").options.length = 0;
     document.getElementById("<%= Select1.clientID %>").style.display='none'
    }
//}
//else
//{
    //url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('txtNomenclature').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
    //xmlHttp.open("GET",url ,true);
    //xmlHttp.send(null);
//}
}

function emptytext()
{
   if (document .getElementById ('txtCodeNo').value !='' && document .getElementById ('txtNomenclature').value !='' )
   {
    document .getElementById ('txtCodeNo').value='';
    document .getElementById ('txtNomenclature').value='';
    }
}

function emptytextpart ()
{
    if (document .getElementById ('txtlfno').value !='' && document .getElementById ('txtNomenclature').value !='' )
    {
    document .getElementById ('txtlfno').value='';
    document .getElementById ('txtNomenclature').value='';
    }
}

 function fillitem()
           {        
                objddl2 =document.getElementById('Select1');
                 
                if(document.getElementById("txtNomenclature").value =='' && objddl2.options.length>0)
                {    
                    document.getElementById("txtNomenclature").value=objddl2.options[0].text;
                    document.getElementById('txtbaserate').focus();
                    objddl2.style.display='none'; 
                }                       
           }

function  check1()
{
    var str = document.getElementById('txtNomenclature').value;
    if (str.trim() !='')
    {
    Fromcombo2();
    }
    else
    {
    setTimeout(function(){document.getElementById('txtNomenclature').focus()}, 10);
    }
    return false;
}
    
    
function checkQuntity(){

    var str = document.getElementById('txtNomenclature').value;
    if (str.trim() =='')
    {
    setTimeout(function(){document.getElementById('txtNomenclature').focus()}, 10);
    return false;
    }
       else
       {

    var Quantity = document.getElementById('txtQuantity');
    if(Quantity.value ==''){
        alert('Enter the Quntity');
        setTimeout(function(){Quantity.focus()}, 10);
        
        return false;                
    }
    if(IsNumeric(Quantity.value)== false){
        alert('Enter numeric Quantity');
        setTimeout(function(){Quantity.focus()}, 10);
        Quantity.value='';
        return false;
    }
    }
    return true;
}      
      
function calculate ()
{
    var str = document.getElementById('txtNomenclature').value;
    if (str.trim() =='')
    {
    setTimeout(function(){document.getElementById('txtNomenclature').focus()}, 10);
    return false;
    }
       else
       {
    var baserate = document.getElementById('txtbaserate');
    var baseQuantity = document.getElementById('txtbaseqty');
     if(baserate.value ==''){
        alert('Enter the Base Rate');
        setTimeout(function(){baserate.focus()}, 10); 
        return false;                
    }
   
    if(IsNumeric(baserate.value)== false  ){
        alert('Enter Numbers Only');
        setTimeout(function(){baserate.focus()}, 10); 
        baserate.value='';
        return false;
    }
    if(baseQuantity.value ==''){
        alert('Enter the Quntity');
         setTimeout(function(){baseQuantity.focus()}, 10);
        return false;                
    }
   
    if(IsNumeric(baseQuantity.value)== false  ){
        alert('Enter numeric Quantity');
        setTimeout(function(){baseQuantity.focus()}, 10);
        baseQuantity.value='';
        return false;
    }
    document.getElementById('txtRate').value = (parseFloat (baserate.value ) / parseFloat (baseQuantity.value )).toFixed(2);
    }
}



function Fromcombo2()
{
    var xmlHttp;
    try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();   
    }
    catch (e)
    {
    // Internet Explorer
    try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e)
    {
    try
    { 
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    catch (e)
    {
    alert("Your browser does not support AJAX!");
    return false;
    }
    }
    }
    xmlHttp.onreadystatechange=function()
    {
    if(xmlHttp.readyState==4)
    {
    resp = ""
    resp = xmlHttp.responseText;
    var ele1 = resp.split('|');
    //document.getElementById('txtbqty').value =ele1[0];
    //document.getElementById('txtRate').value =ele1[0];
    //document.getElementById('txtCodeNo').value=ele1[2];
    //document.getElementById('txtlfno').value=ele1[3];
    }
    }
    var itemname= document.getElementById('txtNomenclature').value  ;
    //var lfno = document.getElementById('txtlfno').value;
      //var partno = document.getElementById('txtCodeNo').value;
    xmlHttp.open("GET","AjaxStore.aspx?Action=itemqtyglass&itemid=" + itemname  ,true);
       
   //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
    xmlHttp.send(null);
}		
			
function setfocus()			
{
document.getElementById ('txtlfno').focus();
}
 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    </div>
    <div id="middal1">
        <uc:leftmenu ID="Leftmenu1" runat="server" />
        <div class="contantbox">
            <div class="orgtop1">
            </div>
            <div class="orgmiddal1">
                <table width="100%" style="width: 1000px" border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="6" align="center" class="innerheading">
                            <span id="Label3">Glass Purchase Order (
                                <asp:Label ID="lbldepttype" Text="" ForeColor="red" runat="server"></asp:Label>
                                )</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            Vendor Name:
                            <asp:TextBox ID="ddlvendor" runat="server" Width="216px">
                            </asp:TextBox>
                        </td>
                        <td colspan="2" align="left">
                            <span>Category</span>
                            <asp:DropDownList ID="ddlCategory" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            P.O Date
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtPODate" TextBoxStyle-Width="100px" runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
                        </td>
                        <td align="right">
                            P.O No.
                        </td>
                        <td align="left">
                            <select id="ddlPONo" runat="server" style="width: 140px">
                                <option value="RC">RC</option>
                                <option value="SP">SP</option>
                                <option value="PA">PA</option>
                                <option value="T">T&C</option>
                                <option value="PB">PB</option>
                                <option value="PMT">PMT</option>
                                <option value="STN">STN</option>
                            </select>
                            <span lang="en-us">
                                <%--   <input type="text" id="txtPONo" name="txtPONo" size="5px" onclick="return txtPONo_onclick()"
                                    />--%>
                                <asp:TextBox ID="txtPONo" Width="70%" onblur="poexists();" runat="server"></asp:TextBox>
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
                            <BDP:BDPLite ID="dtOurRefNo" TextBoxStyle-Width="100px" TextBoxStyle-CssClass="textfield"
                                runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
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
                            <BDP:BDPLite ID="dtYourRefNo" TextBoxStyle-Width="100px" TextBoxStyle-CssClass="textfield"
                                runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
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
                                                Rate
                                            </td>
                                            <td>
                                                No of Qty
                                            </td>
                                            <td>
                                                Per Qty Rate
                                            </td>
                                            <td>
                                                Square Fit
                                            </td>
                                            <td>
                                                Amount</td>
                                        </tr>
                                        <tr class='gridtxt'>
                                            <td>
                                                <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                            </td>
                                            
                                            <td>
                                                <input type="text" id="txtNomenclature" onpropertychange="itemsearch()" onblur="fillitem();check1();" />
                                                <asp:ListBox ID="Select1" runat="server" Style="display: none; text-align:left" onclick="Select();"></asp:ListBox>
                                            </td>
                                            <td>
                                                <input type="text" id="txtbaserate" style="width: 70px" maxlength="10" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtbaseqty" onblur="return calculate();" style="width: 70px"
                                                    maxlength="10" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtRate" readonly="readonly" style="width: 70px" size="15" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtQuantity" style="width: 70px" size="10" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtAmount" onfocus="return Amount();" size="20" />
                                            </td>
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
                            <BDP:BDPLite ID="Date2" TextBoxStyle-Width="100px" runat="server" TabIndex="23">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
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
                            <BDP:BDPLite ID="Date1" TextBoxStyle-Width="100px" runat="server" TabIndex="20">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
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
                            <a href="Indent_Request_Details.aspx">Reset</a>
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

</body>
</html>
