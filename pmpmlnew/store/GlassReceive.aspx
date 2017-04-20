<%@ Page Language="VB" EnableEventValidation="false" AutoEventWireup="false" CodeFile="GlassReceive.aspx.vb"
    Inherits="KDMT.GlassReceive" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>

    <script language="javascript" type="text/javascript">
    var Optype = 0 
    var Fuel
    var ID = 0; 
    var rowcnt = 1;
    var rowcntsave = 1;
    var srno = 1;
    
    function addPODetails() {

    if(document.getElementById('hdnrwcnt').value == '')
    {
    document.getElementById('hdnrwcnt').value = 0;
    } 

   var hdnsrno = document.getElementById('hdnsrno'); 
   var lblsrno = document.getElementById('lblsrno'); 
   var drdglasstype = document.getElementById('drdglasstype');  
   var ddlitem = document.getElementById('ddlitem');
   var txtlength = document.getElementById('txtlength');
   var txtbreadth = document.getElementById('txtbreadth');   
   var txtsqrfit = document.getElementById('txtsqrfit'); 
   var txtqty = document.getElementById('txtqty');
   var txttotsqrfit = document.getElementById('txttotsqrfit');  
   
    var tbody = document.getElementById('tbody');  
    
    var row  = tbody.insertRow(rowcnt);
    row.setAttribute('id','trPO_' + rowcntsave);
    
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdsrno_' + rowcntsave);
    
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdglasstype_' + rowcntsave);
    
    var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tditem_' + rowcntsave);
    
    var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdlength_' + rowcntsave);
    
    var cells5 = row.insertCell(4);
    cells5.setAttribute('id','tdbreadth_' + rowcntsave);
    
    var cells6 = row.insertCell(5);
    cells6.setAttribute('id','tdsqrfit_' + rowcntsave);   
  
    var cells7 = row.insertCell(6);     
    cells7.setAttribute('id','tdQty_' + rowcntsave);   
    
    var cells8 = row.insertCell(7);     
    cells8.setAttribute('id','tdtotsqrfit_' + rowcntsave);   
    
    var cells9 = row.insertCell(8);
    
    cells1.innerHTML = parseInt(srno);
    srno += 1;    
   
    cells2.innerHTML = drdglasstype.options[drdglasstype.selectedIndex].text 
    cells3.innerHTML = ddlitem.value;
    cells4.innerHTML = txtlength.value;  
    cells5.innerHTML = txtbreadth.value;
    cells6.innerHTML = txtsqrfit.value;
    cells7.innerHTML = txtqty.value;
    cells8.innerHTML = txttotsqrfit.value;
    cells9.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntsave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a><input id="glasstypeID_'+ rowcntsave +'" type="hidden" value="' + drdglasstype.value +'" name="glasstypeID" />'    
    
    rowcnt += 1;
    rowcntsave += 1;
    drdglasstype.selectedIndex = 0; 
    ddlitem.value = ''; 
    txtlength.value = '';
    txtbreadth.value = '';
    txtsqrfit.value = '';
    txtqty.value = '';
    txttotsqrfit.value = '';
    
    drdglasstype.focus();        
    document.getElementById('hdnrwcnt').value = rowcntsave;     
   // alert(document.getElementById('hdnrwcnt').value)
}

    function deleteRow(cnt) {    
        var hdnrwcnt = document.getElementById('hdnrwcnt');
        var tr = document.getElementById(cnt);
        document.getElementById('tbody').removeChild(tr);
        rowcnt -= 1;         
        srno = 1;        
        for (i = 1; i < hdnrwcnt.value; i++) {
           if (document.getElementById('tdsrno_' + i) != null) {
               document.getElementById('tdsrno_' + i).innerHTML = srno
               srno +=  1
           }
        }
    }
    
    function emptytext()
    {
        if (document .getElementById ('txtPartNo').value !='' && document .getElementById ('ddlitem').value !='' )
       {
        document .getElementById ('txtPartNo').value;
        document .getElementById ('ddlitem').value;
        document .getElementById ('ddlitem').value;
       }
    }       
    
    function ValidateSave(){ 
 
    var detvalues = '';
    var i = 0;    

        var hdnrwcnt = document.getElementById('hdnrwcnt');
        var hdnPOtype = document.getElementById('hdnPOtype');
        var hdnPoNo = document.getElementById('hdnPoNo');
        var hdndetail = document.getElementById('hdndetail');        
        var radparttype = '';
        
        var txtpotype = document.getElementById('txtpono').value;
        var PO = txtpotype.split(" | ")  
            hdnPOtype.value = PO[0];
            hdnPoNo.value = PO[1]                          
        
        for (i=0;i<hdnrwcnt ;i++){  
            var receiveQty = document.getElementById('txtqty' + i);
            if(receiveQty != null){
                if (receiveQty.value == ''){
                    alert('Received Qty. should not be empty')
                    receiveQty.focus();  
                    return false;
                }
            }    
        }
        
        if( document.getElementById('txtvendorname').value == ''){
            alert('Please select vendor');
            document.getElementById('txtvendorname').focus();
            return false;
        }   //debugger;      
              
        for (i=0;i<hdnrwcnt.value ;i++)
        {    
            if (document.getElementById('tdsrno_' + i)!= null){ 
           // alert(document.getElementById('tdQty5_' + i).innerHTML);               
                var drdglasstype = document.getElementById('glasstypeID_' + i).value;
                var ddlitem = document.getElementById('tditem_' + i).innerHTML;
                var txtlength = document.getElementById('tdlength_' + i).innerHTML;
                var txtbreadth = document.getElementById('tdbreadth_' + i).innerHTML;
                var txtsqrfit = document.getElementById('tdsqrfit_' + i).innerHTML;   
                            
                var txtqty = document.getElementById('tdQty_' + i).innerHTML;
                var txttotsqrfit = document.getElementById('tdtotsqrfit_' + i).innerHTML;
                                                    
                hdndetail.value = hdndetail.value + drdglasstype + '^' + ddlitem + '^' + txtlength + '^' + txtbreadth + '^' + txtsqrfit + '^' + txtqty +  '^' + txttotsqrfit + '|';                
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
        if(document.getElementById('ddlitem').value != "")
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
          if (ele[i].toLowerCase() != '') {
        if ((document.getElementById('ddlitem').value).toLowerCase() == (ele[i].toLowerCase())) {
            document.getElementById("<%= Select1.clientID %>").style.display = 'none'
            return false;
        }
    }
                                    

        if (ele[i]=="0")
        {
        //temp.style.display="none";				               
        //  return false;
        }			
                                 
        }

        }
        
        }
        }
       
            if (document.getElementById ('ddlitem').value.length >=3 ){
           
        //    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
            url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value ;   
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
        //    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
        url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value ;   
            xmlHttp.open("GET",url ,true);
            xmlHttp.send(null);
        //}
    }

 function fillitem()
           {        
                objddl2 =document.getElementById('Select1');
                 
                if(document.getElementById("ddlitem").value =='' && objddl2.options.length>0)
                {    
                    document.getElementById("ddlitem").value=objddl2.options[0].text;
                    document.getElementById('txtlength').focus();
                    objddl2.style.display='none'; 
                }                      
           }


String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
}

function Fromcombo2()
{
//debugger
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
    var ele1 = resp.split('|')


   document.getElementById('txtlength').value=ele1[0];
    document.getElementById('txtbreadth').value=ele1[1];
    }
    }
    var itemname= document.getElementById('ddlitem').value  ;
//    var lfno = document.getElementById('txtlfno').value;
//    var partno = document.getElementById('txtPartNo').value;
//    xmlHttp.open("GET","AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno ,true);
xmlHttp.open("GET","AjaxStore.aspx?Action=Getglasssize&itemid=" + itemname ,true);

    xmlHttp.send(null);
}	

//        function ticFunction2()
//		{
//		    if(document.getElementById("txtqty").value.length>0)
//            {

//		        if(IsNumeric(document.getElementById ("txtqty").value))
//                {
////		            LogSheet2();
// document.getElementById("txtbalqty").value = parseFloat(document.getElementById("txtbqty").value)  - parseFloat(document.getElementById("txtqty").value)
//		        }
//		        else
//		        {
//			        
//		            alert("Enter Proper Value");
//		            setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
//		            
//		        }
//		    }
//		}	
	
function  check1()
{ 
//debugger
    var str = document.getElementById('ddlitem').value;
    if (str.trim() !='')
    {
    Fromcombo2();
    }
    else
    {
    //debugger;
    setTimeout(function(){document.getElementById('ddlitem').focus()}, 10);
    }
    return false;
}
        function ticFunction2()
		{		
		debugger
	    if(document.getElementById("txtlength").value.length>0)		    
            {
            
		        if(IsNumeric(document.getElementById ("txtlength").value))
                {
                   document.getElementById("txtsqrfit").value = (parseFloat(parseFloat(document.getElementById("txtlength").value)  * parseFloat(document.getElementById("txtbreadth").value))/1000000);
		        }
		        else
		        {			        
		            alert("Enter Proper Value");
		            setTimeout(function(){document.getElementById('txtqty').focus()}, 10);		            
		        }
		        document.getElementById('txtsqrfit').focus();
		    }		    
		}	
		
		 function ticFunctiontotSq2()
		{
		
	    if(document.getElementById("txtsqrfit").value.length>0)		    
            {
            
		        if(IsNumeric(document.getElementById ("txtsqrfit").value))
                {
                   document.getElementById("txttotsqrfit").value = (parseFloat(document.getElementById("txtsqrfit").value)  * parseFloat(document.getElementById("txtqty").value)).toFixed(2);
		        }
		        else
		        {			        
		            alert("Enter Proper Value");
		            setTimeout(function(){document.getElementById('txtqty').focus()}, 10);		            
		        }		     
		        addPODetails();   
		    }
		}	
		
		  // check for numeric fields only
      
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

function Selectdata()
{    
    var resultStr = ""; 
    objddl2 =document.getElementById('Select1');
    for(var i = 0; i < objddl2.options.length; i++ )
    {  
    if( objddl2.options[i].selected ) 
    {    
    resultStr+= (objddl2.options[i].text);
    var objddl1 = document.getElementById('ddlitem');
    objddl1.value=resultStr;
    var x=document.getElementById('Select1');
       x.style.display="none";         
    document.getElementById('ddlitem').focus();
    return false;    
    } 
    } 
}

function chkvendorname()
{
//debugger
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
    var ele1 = resp;

    if(ele1=="NO-SUCH-ITEM")
    {
    alert("No Such Vendor Present");
    document.getElementById ("txtvendorname").focus();   
    }
    else {    
        getpono();
    }
    }
    }
if (document.getElementById ("txtvendorname").value != '')
    {
    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkvendorname&vendorname="+document.getElementById ("txtvendorname").value,true);
    xmlHttp.send(null);
    }
}

function sendRequest(url) {

   ajaxFunction();
   url = url + '&t=' + new Date();
   xmlHttp.open("GET",url);
   xmlHttp.send(null);
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

function getpono(){  

        var txtvendorname = document.getElementById('txtvendorname'); 
               
        //alert (setTimeout(function(){txtvendorname.value}, 10));
       
        if (txtvendorname.value == ''){
            txtvendorname.focus();
            alert ('Please Enter Vendor Name');
            return false;
        } 
        else{                
            var url = '../tmtAjax/Common_ajax.aspx?action=getpoNo&vendor=' + txtvendorname.value;               
            sendRequest(url);                                
            return false;
        }
    }
    
     function getpo(){    
         
        var txtvendorname = document.getElementById('txtvendorname')
        var txtPoNo = document.getElementById('txtpono')        
        if (txtPoNo.value == ''  ){            
            return false;
        } 
        else{                            
            var PO = txtPoNo.value.split(" | ")            
            var url = '../tmtAjax/Common_ajax.aspx?action=getpoDetails&potype=' + PO[0] + '&pono=' + PO[1] + '&poyear=' + PO[2] + "&vendor=" + txtvendorname.value;
            sendRequest(url);                                
            return false;
        }
    }
    
function Select(obj)
{ 
    var resultStr = "";         
    for(var i = 0; i < obj.options.length; i++ )
    {  
        if( obj.options[i].selected ) 
        {    
            resultStr+= (obj.options[i].text);   
            obj.value=resultStr;    
            obj.style.display="none";  
            document.getElementById('txtpono').value = resultStr;
            document.getElementById('txtpono').focus();
            return false;
            //alert(resultStr)
        } 
    } 
}

function handleresponse() { 
var arrApp = new Array();
    if(xmlHttp.readyState==4) {            
        resp = xmlHttp.responseText;
            //debugger;                    
        if (resp.indexOf('PassIndent')!= -1) {             
            arrApp =  resp.split("|");           
            resp = arrApp[0];                             
            document.getElementById('hdnrwcnt').value = arrApp[1];                 
            if (arrApp.length > 2){             
                document.getElementById('txtvendorname').value = arrApp[2];     
                document.getElementById('bdpPoDate').value = arrApp[3];   
                   document.getElementById('bdpPoDate').value = arrApp[5];                      
                 document.getElementById('hdnPoDate').value = arrApp[5];   
                if(arrApp[4] != ''){             
            }                               
                }
            else{         
            }          
                          
            //document.getElementById('dvRIndent').innerHTML = resp.substring(10);                                    
            return false;
        }
        else if(resp.indexOf('PoNo') != -1){                               
            var ele = resp.split("!");
            
            while(document.getElementById("ListBox1").options.length > 0)
            document.getElementById("ListBox1").options.remove(document.getElementById("ListBox1").options.length-1);            
            
            for (var i = 1; i < ele.length; i++){
                var temp=document.getElementById("ListBox1")
                temp.style.display='';
                temp.size=ele.length;
                newOpt = document.createElement("option");
                document.getElementById("ListBox1").options.add(newOpt);
                newOpt.value = ele[i];
                newOpt.text  = ele[i];
            }                        
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
           else if(resp.indexOf('Failpo') != -1) {  
            alert('This Is Not a Valid PO');   
            document.getElementById('txtPOtype').focus();         
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');                    
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                              
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Defect No. is already exist.');                              
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                              
            return false;
        }           
    }
}

function validate ()
{
  if (document.getElementById ("txtvendorname").value == "" )
  {
      alert ('Enter Vendor Name');
      document.getElementById ("txtvendorname").focus()
      return false;
  }
  if (document.getElementById('txtpono').value == "")
  {
      document.getElementById('txtpono').focus();
      alert ('Please Enter Po First');
      return false;
  }   
  if (document.getElementById ("txt_challanno").value.length==0)
  {
      alert ('Please Enter Challan no');
      document.getElementById ("txt_challanno").focus()
      return false;
  }
  if( document.getElementById('txt_recno').value == ''){
        alert('Please Enter Rec No.');
        document.getElementById('txt_recno').focus();
        return false;
    }     
  ValidateSave()
    return true;
}


function addrecitem ()
{
debugger
    if(parseFloat(document.getElementById("txtqty").value)>0)
    {
     
     actqy = parseFloat(document.getElementById("txtqty").value) * parseFloat(document.getElementById("txtsqrfit").value)
   var hdnrwcnt = document.getElementById('hdnrwcnt').value;
    var balqty = (document.getElementById("BalQty").value);
     var drdglasstype = document.getElementById('drdglasstype'); 
   var i = 0;
  for (i=1;i<hdnrwcnt ;i++)
            {    
                if (document.getElementById('tditem_' + i)!= null)
                {
                             
                 var name = document.getElementById('tdglasstype_' + i).innerHTML;
                  
                 //var avbqty = document.getElementById('tdavbbal_' + i).innerHTML;
                 var recqty = document.getElementById('tdtotsqrfit_' + i).innerHTML;
    
              
                 if ( drdglasstype.options[drdglasstype.selectedIndex].text   == name   ){
                
               balqty =  balqty - recqty; 
               }
         }
              }
       
     if ( balqty < actqy)
        {
        var alt= "PO Bal Qty Of this Item is "
        alt = alt + document.getElementById("BalQty").value
         alert(alt);
        setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
        return false ;
        }
        if(IsNumeric(document.getElementById ("txtqty").value))
        {
             
        ticFunctiontotSq2();
        }
        else
        {
        alert("Enter Proper Value");
        setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
        return false ;
        }
    }
}

  function glassbalandLandB() {
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
                    //alert(resp)
                    document.getElementById("BalQty").value = ele1[0];
                      document.getElementById("txtlength").value = ele1[1];
                    document.getElementById("txtbreadth").value = ele1[2];
                 
                }
            }
             var ele1 = document.getElementById('txtpono').value.split('|');
            var type =ele1[0];
            var pono=ele1[1];
            var poyear=ele1[2];
            var vendorname = document.getElementById('txtvendorname').value
            var drdglasstype = document.getElementById('drdglasstype');  
            var glasstype  = drdglasstype.options[drdglasstype.selectedIndex].text;
            var glassname  =  document.getElementById('ddlitem').value;
            
    
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=glassbalandLandB&type=" + type + "&pono=" + pono + "&poyear=" + poyear + "&vendorname=" + vendorname + "&glasstype=" + glasstype + "&glassname=" + glassname, true);
            xmlHttp.send(null);
  
  }
  
  function forlengthandbreadth() {
//debugger
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
                    //alert(resp)
                    document.getElementById("txtlength").value = ele1[0];
                    document.getElementById("txtbreadth").value = ele1[1];
                    //document.getElementById("txtlength").value = ele1[0];
                }
            }
             var ele1 = document.getElementById('txtpono').value.split('|');
            var type =ele1[0];
            var pono=ele1[1];
            var poyear=ele1[2];
            var vendorname = document.getElementById('txtvendorname').value
            var drdglasstype = document.getElementById('drdglasstype');  
            var glasstype  = drdglasstype.options[drdglasstype.selectedIndex].text;
            var glassname  =  document.getElementById('ddlitem').value;
    
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=glasslengthbreadth&type=" + glasstype + "&pono=" + pono + "&poyear=" + poyear + "&vendorname=" + vendorname + "&glassname=" + glassname, true);
            xmlHttp.send(null);
        }


    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="BalQty" runat="server" type="hidden" name="BalQty" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnrwcntsave" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="Hidden1" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnPOtype" runat="server" type="hidden" name="hdnPOtype" />
        <input id="hdnPoNo" runat="server" type="hidden" name="hdnPoNo" />
        <input id="Hidden2" runat="server" type="hidden" name="hdndetail" />
        <input id="Hidden3" runat="server" type="hidden" name="hdnPoDate" />
        <input id="hdnPoDate" runat="server" type="hidden" name="hdnPoDate" />
        <input id="hdnddlitem" runat="server" type="hidden" name="hdnddlitem" />
        <div id="middal">
            <uc:leftmenu ID="leftmenu" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                Receive Glass<span id="Span1"> (
                                    <asp:Label ID="lbldepttype" Text="" ForeColor="red" runat="server"></asp:Label>
                                    )</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align="right">
                                            Vendor Name :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtvendorname" onblur="chkvendorname();" Style="width: 220px" runat="server"
                                                Width="168px" Height="20" Font-Size="Medium"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            PO No:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtpono" TabIndex="1" runat="server" Width="168px" onblur="getpo();"
                                                Height="20" Font-Size="Medium"></asp:TextBox>
                                            <asp:ListBox ID="ListBox1" onclick="Select(this);" Style="display: none; text-align: center"
                                                runat="server"></asp:ListBox>
                                            <%--<select id="ddlPOtype" runat="server" style="width: 60px">
                                                            <option value="RC">RC</option>
                                                            <option value="SP">SP</option>
                                                            <option value="PA">PA</option>
                                                            <option value="T&C">T&C</option>
                                                            <option value="PB">PB</option>
                                                            <option value="PMT">PMT</option>
                                                        </select>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            PO. Date
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="bdpPoDate" ReadOnly="true" runat="server" Size="10" Width="80"></asp:TextBox>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Challan No
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                            <asp:TextBox ID="txt_challanno" runat="server" TabIndex="2"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Challan Date
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                            <BDP:BDPLite ID="BDPLite2" TabIndex="3" runat="server" Height="20" Font-Size="Medium">
                                            </BDP:BDPLite>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Bill No
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                            <asp:TextBox ID="txt_Billno" runat="server" TabIndex="4"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Bill Date
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                            <BDP:BDPLite ID="BDPLite3" TabIndex="5" runat="server" Height="20" Font-Size="Medium">
                                            </BDP:BDPLite>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Rec No
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                            <asp:TextBox ID="txt_recno" ForeColor="red" ReadOnly="true" runat="server" TabIndex="6"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Recive Date
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                            <BDP:BDPLite ID="BDPLite4" TabIndex="7" runat="server" Height="20" Font-Size="Medium">
                                            </BDP:BDPLite>
                                        </td>
                                    </tr>
                                </table>
                        </tr>
                        <tr>
                            <td>
                                <table id="Grd_Item" width="100%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbody">
                                        <tr class="gridhead">
                                            <td>
                                                SR No.
                                            </td>
                                            <td>
                                                Glass Type
                                            </td>
                                            <%-- <td>
                                                LF No
                                            </td>
                                            <td>
                                                Part No.
                                            </td>--%>
                                            <td>
                                                Item Name
                                            </td>
                                            <td>
                                                Length
                                            </td>
                                            <td>
                                                Breadth
                                            </td>
                                            <td>
                                                &nbsp;Sq. Fit.
                                            </td>
                                            <td>
                                                Quantity
                                            </td>
                                            <td>
                                                Total sqr ft
                                            </td>
                                        </tr>
                                        <tr class="gridtxt">
                                            <td>
                                                <input type="text" style="display: none" id="lblsrno" readonly="readonly" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drdglasstype" Width="100" runat="server" TabIndex="8">
                                                </asp:DropDownList>
                                            </td>
                                            <%-- <td align="left" style="width: 100px; height: 28px;">
                                                <asp:TextBox class="textfield" ID="txtlfno" TabIndex="9" onblur="emptytext();itemsearch();"
                                                    runat="server" Width="100px" Height="20" Font-Size="Medium"></asp:TextBox>
                                                <asp:ListBox ID="ListBox1" Style="display: none; text-align: left;" onclick="Select();"
                                                    runat="server"></asp:ListBox>
                                            </td>
                                            <td align="left" style="width: 100px; height: 28px;">
                                                <asp:TextBox class="textfield" ID="txtPartNo" onblur="emptytextpart();ajaxFunction();"
                                                    runat="server" Width="100px" Height="20" Font-Size="Medium"></asp:TextBox>
                                            </td>--%>
                                            <td>
                                                <asp:TextBox ID="ddlitem" onpropertychange="itemsearch();" TabIndex="9" onblur="glassbalandLandB();"
                                                    runat="server"></asp:TextBox>
                                                <asp:ListBox ID="Select1" runat="server" Style="display: none; text-align: left"
                                                    onclick="Selectdata();"></asp:ListBox>
                                            </td>
                                            <td>
                                                <asp:TextBox type="text" ID="txtlength" Style="width: 70px" MaxLength="10" runat="server"
                                                    size="10" TabIndex="10"></asp:TextBox>
                                            </td>
                                            <td align="left" style="width: 43px; height: 28px;">
                                                <%--      <asp:TextBox ID="txtbreadth" onfocus="chkItemName()" TabIndex="11" runat="server"
                                                    Width="56px" ReadOnly="True" Height="20" Font-Size="Medium"></asp:TextBox>--%>
                                                <asp:TextBox ID="txtbreadth" TabIndex="11" runat="server" Width="56px" Height="20"
                                                    Font-Size="Medium" onblur="ticFunction2()"></asp:TextBox>
                                            </td>
                                            <td align="center" style="height: 28px;">
                                                <%--<asp:TextBox ID="txtsqrfit" onblur="ticFunction2()" TabIndex="12" runat="server"
                                                    Width="56px" Height="20px" Font-Size="Medium"></asp:TextBox>--%>
                                                <asp:TextBox ID="txtsqrfit" TabIndex="12" runat="server" Width="56px" Height="20px"
                                                    Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td align="center" style="height: 28px;">
                                                <asp:TextBox ID="txtqty" runat="server" Width="56px" Height="20px" Font-Size="Medium"
                                                    onblur="addrecitem();" TabIndex="12"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txttotsqrfit" runat="server" Width="56px" Height="20" Font-Size="Medium"
                                                    TabIndex="13"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                        <tr>
                            <td style="height: 22px">
                                <div align="center">
                                    &nbsp;<asp:ImageButton ID="btnSubmit" OnClientClick="return ValidateSave();" runat="server"
                                        TabIndex="14" ImageUrl="../images/btn_h.gif"></asp:ImageButton><asp:ImageButton ID="btnclear"
                                            TabIndex="15" runat="server" ImageUrl="../images/cancel.gif"></asp:ImageButton></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
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
	
$("#txtvendorname").autocompleteArray(
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
