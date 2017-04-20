<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rejectionentry.aspx.vb"
    Inherits="KDMT.store_Rejectionentry" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>

<html>
<head>
    <title>Rejection Item Entry</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" type="text/javascript">
   
var Optype = 0
var Fuel
var ID = 0;
var rowcnt = 1;
var rowcntSave = 1;
 
 var rowcntother = 1;
 var rowcntothersave = 1; 
 
function addoilDetails() {

 if (document.getElementById('hdnsrno').value == '')
    {
    document.getElementById('hdnsrno').value = 0;
    } 
    var srno = 0;
    var lblsrno = document.getElementById('lblsrno');
    var txtlfno = document.getElementById('txtlfno'); 
    var txtbinno = document.getElementById('txtbinno');
    var txtNomenclature = document.getElementById('txtNomenclature');
    var txtvendor = document.getElementById('txtvendor');
    var txtchallanno = document.getElementById('txtchallanno');
    var txtrejectionqty = document.getElementById('txtrejectionqty');
    
    var vendorname =  document.getElementById('txtvendor').value;
     
    var tbody = document.getElementById('tbodyIndent');  
    
    var row  = tbody.insertRow(rowcnt);
    row.setAttribute('id','trrej_' + rowcnt);
    
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdsrno_' + rowcnt);
    
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdlfno_' + rowcnt);
    var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tdbinno_' + rowcnt);
    var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdNomenclature_' + rowcnt);
    var cells5 = row.insertCell(4);
    cells5.setAttribute('id','tdvendor_' + rowcnt);
    var cells6 = row.insertCell(5);
    cells6.setAttribute('id','tdchallanno_' + rowcnt);
    var cells7 = row.insertCell(6);
    cells7.setAttribute('id','tdrejectionqty_' + rowcnt);
        
    var cells8 = row.insertCell(7);    
   
   cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
    
    cells2.innerHTML = txtlfno.value ;      
    cells3.innerHTML = txtbinno.value;
    cells4.innerHTML = txtNomenclature.value;
    cells5.innerHTML = txtvendor.value;
    cells6.innerHTML = txtchallanno.value;
    cells7.innerHTML = txtrejectionqty.value;
    cells8.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trrej_'+ rowcnt +'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    
    rowcnt = rowcnt + 1;
    
    //txtoiltype.value = ''; 
    txtlfno.value = ''; 
txtbinno.value = '';
txtNomenclature.value = '';
txtvendor.value = '';
txtchallanno.value = '';
txtrejectionqty.value = '';
          txtlfno.focus ();
    document.getElementById('hdnrwcnt').value = rowcnt;     
   // alert(document.getElementById('hdnrwcnt').value)
}

 function ValidateSave()
    {
    
     var detvalues = '';
     var i = 0;
          var hdnrwcnt = document.getElementById('hdnrwcnt').value;
        for (i=1;i<hdnrwcnt ;i++)
              {    
                if (document.getElementById('tdNomenclature_' + i)!= null){
                
                var txtlfNo = document.getElementById('tdlfno_' + i).innerHTML;
                var binno = document.getElementById('tdbinno_' + i).innerHTML;
                var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                
                var vendor = document.getElementById('tdvendor_' + i).innerHTML;
                var challanno = document.getElementById('tdchallanno_' + i).innerHTML;
                
                var rejectionqty = document.getElementById('tdrejectionqty_' + i).innerHTML;
                              
                detvalues = detvalues + txtlfNo + '^' + binno + '^' + Nomenclature + '^' + vendor + '^' + challanno + '^' + rejectionqty + '|';                          
                
                }
              }  
                  document .getElementById ("hdndetail").value = detvalues
                  
              }    

function addPODetails() {

    if (document.getElementById('hdnsrno').value == '')
    {
    document.getElementById('hdnsrno').value = 0;
    } 
    var srno = 0;
    var lblsrno = document.getElementById('lblsrno'); 
    var txtlfNo = document.getElementById('txtlfno');
    var txtCodeNo = document.getElementById('txtCodeNo');
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
    
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdlfno_' + rowcnt);
    var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tdCodeNo_' + rowcnt);
    var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdNomenclature_' + rowcnt);
    var cells5 = row.insertCell(4);
    
    cells5.setAttribute('id','tdbaserate_' + rowcnt);
    var cells6 = row.insertCell(5);
    cells6.setAttribute('id','tdbaseqty_' + rowcnt);
    var cells7 = row.insertCell(6);
    
    cells7.setAttribute('id','tdQuantity_' + rowcnt);
    var cells8 = row.insertCell(7);    
    cells8.setAttribute('id','tdRate_' + rowcnt);    
    var cells9 = row.insertCell(8);    
    cells9.setAttribute('id','tdAmount_' + rowcnt);
    var cells10 = row.insertCell(9);     
   
    cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
   
    cells2.innerHTML = txtlfNo.value;
    cells3.innerHTML = txtCodeNo.value;
    cells4.innerHTML = txtNomenclature.value;
    
    cells5.innerHTML = txtbaserate.value;
    cells6.innerHTML = txtbaseqty.value;
    
    cells7.innerHTML = txtRate.value; 
    cells8.innerHTML = txtQuantity.value;
    cells9.innerHTML = txtAmount.value;
    cells10.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_'+ rowcnt +'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    
    rowcnt = rowcnt + 1;
    lblsrno.value = '';
    txtlfNo.value = '';
    txtCodeNo.value = '';
    txtNomenclature.value = '';  
    txtbaserate.value = '';
    txtbaseqty.value = '';
    txtQuantity.value = '';
    txtRate.value = '';
    txtAmount.value = '';
    txtlfNo.focus();        
    document.getElementById('hdnrwcnt').value = rowcnt;     
   // alert(document.getElementById('hdnrwcnt').value)
}

function addPODetailsother() {
//debugger
    if (document.getElementById('hdnsrnoother').value == '')
    {
    document.getElementById('hdnsrnoother').value = 0;
    } 
    var srnoother = 0;
    var lblsrno = document.getElementById('lblsrnoother'); 
   var txtQty1 = document.getElementById('txtqty1');
   var txtQty2 = document.getElementById('txtqty2');
   var txtQty3 = document.getElementById('txtqty3');
//   var txtQty4 = document.getElementById('txtqty4');
//   var txtQty5 = document.getElementById('txtqty5');
   
    var tbody = document.getElementById('tbodyother');  
    
    var row  = tbody.insertRow(rowcntother);
    row.setAttribute('id','trPOother_' + rowcntothersave);
    
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdsrnoother_' + rowcntothersave);
    
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdQty1_' + rowcntothersave);
    
     var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tdQty2_' + rowcntothersave);
    
     var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdQty3_' + rowcntothersave);
    
//     var cells5 = row.insertCell(4);
//    cells5.setAttribute('id','tdQty4_' + rowcntothersave);
//    
//     var cells6 = row.insertCell(5);
//    cells6.setAttribute('id','tdQty5_' + rowcntothersave);   
   
      var cells7 = row.insertCell(4);     
   
    cells1.innerHTML = parseInt(document.getElementById('hdnsrnoother').value) + 1;
    document.getElementById('hdnsrnoother').value = parseInt(document.getElementById('hdnsrnoother').value) + 1
   
    cells2.innerHTML = txtQty1.value;
    cells3.innerHTML = txtQty2.value;
    cells4.innerHTML = txtQty3.value;
    
//    cells5.innerHTML = txtQty4.value;
//    cells6.innerHTML = txtQty5.value;
     cells7.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRowother(\'trPOother_'+ rowcntothersave+'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
        
    rowcntother= rowcntother+ 1;
    rowcntothersave = rowcntothersave + 1
    txtQty1.value = '';
    txtQty2.value = '';
    txtQty3.value = '';
//    txtQty4.value = '';
//    txtQty5.value = '';
  
    txtQty1.focus();        
    document.getElementById('hdnrwcntother').value = rowcntothersave;     
   // alert(document.getElementById('hdnrwcnt').value)
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

    
    function validatedata(){

        var txtvendor = document.getElementById('txtvendor');
        var txtlfno = document.getElementById('txtlfno');      
        var txtNomenclature = document.getElementById('txtNomenclature');
        var txtchallanno = document.getElementById('txtchallanno');          
        var txtrejectionqty = document.getElementById('txtrejectionqty');  

        
        if (txtvendor.value == 0){
            alert('Select vendor name');
            txtvendor.focus();
            return false;
        }


        else if (txtNomenclature.value == ''){
            alert('Enter Item Name.');
            txtNomenclature.focus();
            return false;
        }
         
       else if (hdndetail.value == ''){
           alert ('please  enter item');
           document.getElementById('txtlfno').focus();
            
            return false;
        }
CheckRejectiondetail();
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

function emptytext()
{
debugger
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
    document.getElementById('txtsubrack').value=ele1[3];
    }
    }
    var itemname= document.getElementById('txtItemName').value  ;
    var txtsubrack = document.getElementById('txtsubrack').value;
    //var partno = document.getElementById('txtPartNo').value;   
    xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrack=" + txtsubrack ,true);
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
if(document.getElementById('txtNomenclature').value != "" || document.getElementById('txtlfno').value != "" )
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
var lfno = document.getElementById('txtlfno').value;
//var partno = document.getElementById('txtCodeNo').value;

 if (lfno == "")
{
    if (document.getElementById ('txtNomenclature').value.length >=3 )
    {
    url = "../store/AjaxStore.aspx?Action=itemnamedeptwisenew&itemid=''&item=" + document.getElementById ('txtNomenclature').value + "&lfno=" + lfno 
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
    }
    else
    {
   // document.getElementById("<%= Select1.clientID %>").options.length = 0;
     document.getElementById("<%= Select1.clientID %>").style.display='none'
    }
}
else
{
    url = "../store/AjaxStore.aspx?Action=itemnamedeptwisenew&itemid=''&item=" + document.getElementById ('txtNomenclature').value + "&lfno=" + lfno
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
}
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

    //document.getElementById('txtCodeNo').value=ele1[2];
    document.getElementById('txtlfno').value=ele1[3];
    }
    }
    var itemname= document.getElementById('txtNomenclature').value  ;
    var lfno = document.getElementById('txtlfno').value;
    //var partno = document.getElementById('txtCodeNo').value;
    xmlHttp.open("GET","AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno ,true);
   
    xmlHttp.send(null);
}		

function CheckRejectiondetail()
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
    debugger 
    resp = ""
    resp = xmlHttp.responseText;
    if( resp == '')
    {
    alert ('Please enter correct data');
    return false ;
    }
    else
    {
    addoilDetails();
    return true ;
    }
    

    //document.getElementById('txtCodeNo').value=ele1[2];
    document.getElementById('txtlfno').value=ele1[3];
    }
    }
    var itemname= document.getElementById('txtNomenclature').value  ;
    var lfno = document.getElementById('txtlfno').value;
    var txtvendor = document.getElementById('txtvendor').value;
    var txtrejectionqty = document.getElementById('txtrejectionqty').value;
    var txtchallanno = document.getElementById('txtchallanno').value;
    
    xmlHttp.open("GET","AjaxStore.aspx?Action=itemrejectiondetails&itemname=" + itemname + "&lfno=" + lfno + "&txtvendor=" + txtvendor + "&txtchallan=" + txtchallanno + "&txtrejectionqty=" + txtrejectionqty,true);
   
    xmlHttp.send(null);
}			

function setfocus()			
{
document.getElementById ('txtlfno').focus();
}

 function fillitem()
           {
                objddl2 =document.getElementById('Select1');
                 
                if(document.getElementById("txtNomenclature").value =='' && objddl2.options.length>0)
                {
                    document.getElementById("txtNomenclature").value=objddl2.options[0].text;
//                    document.getElementById('txtbaserate').focus();
                    objddl2.style.display='none'; 
                }
           }

function chkvendorname()
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
    var ele1 = resp;

    if(ele1=="NO-SUCH-ITEM")
    {
    alert("No Such Vendor Present");
    document.getElementById ("txtvendor").focus();   
    }
    else {
    
//        getpono();
    }
    }
    }
if (document.getElementById ("txtvendor").value != '')
    {
    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkvendorname&vendorname="+document.getElementById ("txtvendor").value,true);
    xmlHttp.send(null);
    }
}

function validate()
{
    var txtNomenclature = document.getElementById('txtNomenclature'); 
    var txtvendor = document.getElementById('txtvendor');
    var txtchallanno = document.getElementById('txtchallanno');
    var txtrejectionqty = document.getElementById('txtrejectionqty');
    
    if (txtNomenclature.value == '')
    {
    alert ('Please enter Item Name')
    txtNomenclature.focus();
    return false ;
    }     

    if (txtvendor == "")
    {
    alert ('Please Enter The Vendor Name')
    txtvendor.focus();
    return false ;
    }     
     
    if (txtchallanno == "")
    {
    alert ('Please Enter The Challan No')
    txtchallanno.focus();
    return false ;
    }
     
    if (txtrejectionqty == "")
    {
    alert ('Please Enter The Rejecttion Quantity')
    txtrejectionqty.focus();
    return false ;
    }
    return  CheckRejectiondetail();
    
    return true ;
}

    </script>

    <style type="text/css">
        .style1
        {
            height: 33px;
        }
    </style>
</head>
<body onload="MM_preloadImages('../images/btn_h.gif')">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table id="Table1" width="100%" cellpadding="0" cellspacing="0" runat="server" align="center">
                        <tbody>
                            <tr valign="top" style="height: 60px">
                                <td class="innerheading">
                                    Rejection Item Entry
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="text-align: center">
                                        <table id="tblIndent" width="100%" border="1" cellpadding="2" cellspacing="2">
                                            <tbody runat="server" id="tbodyIndent">
                                                <tr class="gridhead">
                                                    <td>
                                                        SR No.
                                                    </td>
                                                    <td>
                                                        <span>LF No </span>
                                                    </td>
                                                    <td>
                                                        <span>Bin No </span>
                                                    </td>
                                                    <td>
                                                        Item Name<span> </span>
                                                    </td>
                                                    <td>
                                                        Vendor Name<span> </span>
                                                    </td>
                                                    <td>
                                                        Challan No<span> </span>
                                                    </td>
                                                    <td>
                                                        Rejection Quantity<span> </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtlfno" onblur="itemsearch()" />
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtbinno" />
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txtNomenclature" onpropertychange="itemsearch()" onblur="fillitem();check1();" />
                                                        <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                            runat="server"></asp:ListBox>
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtvendor" onblur="chkvendorname();" style="width: 220px"
                                                            runat="server" />
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtchallanno" />
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtrejectionqty" />
                                                    </td>
                                                    <td>
                                                        <input type="button" value="ADD" onclick="return validate()" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="7" style="height: 50px">
                                                        <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                            border="0" Width="87" Height="38" AlternateText="Save" />
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
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

$("#txtvendor").autocompleteArray(
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
