<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Oiltransfer.aspx.vb" Inherits="KDMT.Oiltransfer" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Diesel Indent</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript">


    
var Optype = 0
var Fuel
var ID = 0;
 var rowcnt = 1;    
                                                        
                                                        
function addoilDetails() {

   
    var txtvechno = document.getElementById('txtvechno'); 
    var txtoiltransfer = document.getElementById('txtoiltransfer');
    var txtempcode = document.getElementById('txtempcode');
    var ddloiltype = document.getElementById('ddloiltype');
    
     var oiltype =  ddloiltype.options[ddloiltype.selectedIndex].text;
   
    var tbody = document.getElementById('tbodyIndent');  
    
    var row  = tbody.insertRow(rowcnt);
    row.setAttribute('id','troil_' + rowcnt);
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdtxtvechno_' + rowcnt);
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdtxtoiltransfer_' + rowcnt);
    var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tdtxtempcode_' + rowcnt);
    var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdtxtoiltype_' + rowcnt);
    var cells5 = row.insertCell(4);
    
   
    cells1.innerHTML = txtvechno.value ;
      
    cells2.innerHTML = txtoiltransfer.value;
    cells3.innerHTML = txtempcode.value;
    cells4.innerHTML = oiltype;
    cells5.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'troil_'+ rowcnt +'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    
    rowcnt = rowcnt + 1;
    txtvechno.value = '';
    txtoiltransfer.value = '';
    txtempcode.value = '';
    //txtoiltype.value = '';  

    txtvechno.focus();        
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
     for (i=1;i< hdnrwcnt.value  ;i++)
              {    
//                if (document.getElementById('tdNomenclature_' + i)!= null){
//                document.getElementById('tdsrno_' + i).innerHTML = parseInt (document.getElementById('hdnsrno').value) + 1
//                document.getElementById('hdnsrno').value = parseInt (document.getElementById('hdnsrno').value) + 1
                      var KL = 0;
                }
            
              
              } 

function validate()
{
    var txtvechno = document.getElementById('txtvechno'); 
    var txtoiltransfer = document.getElementById('txtoiltransfer');
    var txtempcode = document.getElementById('txtempcode');
    var ddloiltype = document.getElementById('ddloiltype');
    
    if (txtoiltransfer.value == '')
    {
    alert ('Please enter oil Qty')
    txtoiltransfer.focus();
    return false ;
    }
    
    
     var oiltype =  ddloiltype.options[ddloiltype.selectedIndex].text;
     if (oiltype =='Select')
     {
     alert ('Please Select oil Type')
    ddloiltype.focus();
    return false ;
     }
    addoilDetails();
    return true ;
}

function  checkqty ()
{
    var txtoiltransfer = document.getElementById('txtoiltransfer');
    if (txtoiltransfer.value == '')
    {
    alert ('Please enter oil Qty')
    txtoiltransfer.focus();
    return false ;
    }
      if (IsNumeric(txtoiltransfer.value) == false )
    {
    alert ('Please enter oil Qty')
    txtoiltransfer.focus();
    return false ;  
    }
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




function validatevendor ()
{
  if (document.getElementById ("txtvendorname").value == "" )
  {
  alert ('Please Enter Vendor Name');
  document.getElementById ("txtvendorname").focus()
  return false;
  }
  
  return true;
}

///////////   for removing blaak spaces 
String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
}


             

          
///////////////////  for filteration ///////////////////////////////////////

function ajaxFunction()
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
if(document.Form1.ddlitem.value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtPartNo').value != "")
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
if (document.Form1.ddlitem.value==ele[i])
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
var partno = document.getElementById('txtPartNo').value;

//var str = document.getElementById('ddlitem').value;
//    if (str.trim() !='')
//    {
//    xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&lfno=" + lfno + "&partno=" + partno ,true);
//xmlHttp.send(null);
//    }
//    return false;

xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&lfno=" + lfno + "&partno=" + partno ,true);
xmlHttp.send(null);




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
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table id="Table1" width="100%" cellpadding="0" cellspacing="0" runat="server" align="center">
                        <tbody>
                            <tr valign="top" style="height: 60px">
                                <td class="innerheading">
                                    Oil Transfer
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Transfer Date</span>
                                    <BDP:BDPLite ID="bdpchalandate" runat="server" TextBoxStyle-CssClass="textfield">
                                    </BDP:BDPLite>
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
                                                        <span>Vech No </span>
                                                    </td>
                                                    <td>
                                                        <span>Oil Transfer </span>
                                                    </td>
                                                    <td>
                                                        <span>Emp Code </span>
                                                    </td>
                                                    <td>
                                                        <span>Oil Type </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <input type="text" id="txtvechno" />
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtoiltransfer" onblur="checkqty()" />
                                                    </td>
                                                    <td class="style1">
                                                        <input type="text" id="txtempcode" />
                                                    </td>
                                                    <td class="style1">
                                                        <asp:DropDownList ID="ddloiltype" runat="server">
                                                        </asp:DropDownList>
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
                <div class="orgbottam">
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
