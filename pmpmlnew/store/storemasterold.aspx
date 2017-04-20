<%@ Page EnableEventValidation="false" Language="VB" AutoEventWireup="false" CodeFile="storemasterold.aspx.vb"
    Inherits="KDMT.storemasterold" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Stock Receive</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript">

 function fillActualQty()
      {
        if(document.getElementById ("txtChallnQty").value.length>0)
        {
            if(IsNumeric(document.getElementById ("txtChallnQty").value))
            {
            document.getElementById ("txtqty").value=document.getElementById ("txtChallnQty").value;
            }
            else
            {
                alert("Enter Proper Value");
                document.getElementById("txtChallnQty").focus();
                document.getElementById("txtChallnQty").value=0;
            }
        }
        else
            {
            alert("Enter Some Value");
            document.getElementById("txtChallnQty").focus();
                        
            }
      }
function fillItemName()
{
    objddl2 =document.getElementById('Select1');
    if(document.getElementById("ddlitem").value!="" && objddl2.options.length>0)
    {
    document.getElementById("ddlitem").value=objddl2.options[0].text;
    document.getElementById("txtRate").focus();
    }

}
      
function chkItemName()
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
    alert("No Such Item Present");
    document.Form1.ddlitem.focus();
    }
    }
    }
    var cat=document.Form1.ddlitem.value;
    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkitemname&itemid="+document.Form1.ddlitem.value,true);
    xmlHttp.send(null);
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
    }
    }
if (document.getElementById ("txtvendor").value != '')
    {
    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkvendorname&vendorname="+document.getElementById ("txtvendor").value,true);
    xmlHttp.send(null);
    }
}

function validate ()
{

 if (document.getElementById ("radparttype_0").checked == false && document.getElementById ("radparttype_1").checked == false ) 
  {
  alert ('Please Select Part Type');
  return false;
  }
  
  if (document.getElementById ("txtvendor").value == "" )
  {
  alert ('Enter Vendor Name');
  document.getElementById ("txtvendor").focus()
  return false;
  }
  if (document.getElementById ("txtchalan").value.length==0)
  {
  alert ('Please Enter Challan no');
  document.getElementById ("txtchalan").focus()
  return false;
  }
    if( document.getElementById('txtRecNo').value == ''){
        alert('Please Enter Rec No.');
        document.getElementById('txtRecNo').focus();
        return false;
    }
    if( document.getElementById('txtdrb').value == ''){
        alert('Please Enter DRB No.');
        document.getElementById('txtdrb').focus();
        return false;
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


function  check()
{

   var str = document.getElementById('ddlitem').value;
    if (str.trim() !='')
    {
    ajaxFunction();
    }
    return false;
}
        
function  check1()
{
    var str = document.getElementById('ddlitem').value;
    if (str.trim() !='')
    {
    Fromcombo2();
    }
    return false;
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



function Select()
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
    //alert(resultStr)
    } 
    } 

}

//////////////   end  filteration   ///////////////////////////
      
   
      
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

				

				

function ticFunction2()
{
    if(document.getElementById ("txtqty").value.length>0)
    {

        if(IsNumeric(document.getElementById ("txtqty").value))
        {
            LogSheet_receive();
        }
        else
        {
	        
            alert("Enter Proper Value");
            document.getElementById("txtqty").focus();
            document.getElementById("txtqty").value=0;
        }
    }
}			


			
			

			
			
function ticFunction1()
{
BLogSheet();
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
    document.getElementById('txtbqty').value =ele1[0];
    document.getElementById('txtRate').value =ele1[1];
    document.getElementById('txtPartNo').value=ele1[2];
    document.getElementById('txtlfno').value=ele1[3];
    }
    }
    var itemname= document.getElementById('ddlitem').value  ;
    var lfno = document.getElementById('txtlfno').value;
    var partno = document.getElementById('txtPartNo').value;
    xmlHttp.open("GET","AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno ,true);
   //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
    xmlHttp.send(null);
}
			
			
			
			
			
function Fromcombo()
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
var ele1 = resp.split("!");
while(document.getElementById("ddlitem").options.length > 0)
document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length-1);
document.getElementById("ddlitem").value=="";
var temp=document.getElementById("ddlitem")
//if(document.Form1.txtroute.value !="")
// {
for (var i = 0; i < ele1.length-1; i++)
{
var temp=document.getElementById("ddlitem")
newOpt = document.createElement("OPTION");
document.getElementById("ddlitem").options.add(newOpt);
newOpt.value = ele1[i];
newOpt.innerText  = ele1[i];
}
}
}
var cat='' //document.Form1.ddlcat.value;
//alert(cat);
xmlHttp.open("GET","Ajaxstore.aspx?Action=itemname&itemid=''",true);
xmlHttp.send(null);
}

			
			
function emptytext()
{
    if (document .getElementById ('txtPartNo').value !='' && document .getElementById ('ddlitem').value !='' )
    {
    document .getElementById ('txtPartNo').value='';
    document .getElementById ('ddlitem').value='';
    }
}

function emptytextpart ()
{
    if (document .getElementById ('txtlfno').value !='' && document .getElementById ('ddlitem').value !='' )
    {
    document .getElementById ('txtlfno').value='';
    document .getElementById ('ddlitem').value='';
    }
}


function display()
{

    var x=document.getElementById('Select1');
       x.style.display="none";  
}



			
    </script>

</head>
<body onload="MM_preloadImages('../images/btn_h.gif')">
    <form id="Form1" runat="server">
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%" cellpadding="0" cellspacing="0" runat="server" align="center">
                        <tbody>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="innerheading">
                                    <span id="Label3">Stock Received</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="text-align: center">
                                        <table>
                                            <tr align="left">
                                                <td align="right">
                                                    <asp:Label ID="lblmessage" ForeColor="red" Text="Click here for adding vendor" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:CheckBox ID="check" AutoPostBack="true" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="trvendor" runat="server" visible="false">
                                            <tr>
                                                <td align="right">
                                                    Add Vendor Name
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtvendorname" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Add1
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtadd1" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Add2
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtadd2" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Capital
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtcapital" runat="server" Width="350px"></asp:TextBox>
                                                </td>                                                
                                            </tr>
                                            <tr>
                                            <td align="right">
                                                    Contact Person Name 
                                             <td align="left">
                                                    <asp:TextBox ID="txtcontactno" runat="server" Width="143px"></asp:TextBox>&nbsp;&nbsp;
                                                   Contact No.<asp:TextBox ID="txtcontactnname" runat="server" Width="122px"></asp:TextBox>
                                                </td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:ImageButton ID="save_vendor" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                        border="0" Width="87" Height="38" AlternateText="Save" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tblmain" runat="server">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButtonList ID="radparttype" RepeatDirection="Horizontal" runat="server">
                                                            <asp:ListItem Text="SP" Value="sp"> </asp:ListItem>
                                                            <asp:ListItem Text="HW" Value="hw"> </asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="Label2" runat="server" Text="  Vendor Name"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <input type="text" id="txtvendor" style="width: 220px" tabindex="1" onblur="chkvendorname()"
                                                            class="textfield" runat="server" />
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                        Security Date
                                                    </td>
                                                    <td align="left" style="height: 25px">
                                                        <BDP:BDPLite ID="BDPLite1" TabIndex="2" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        PO. No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPoNo" TabIndex="3" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        PO. Date
                                                    </td>
                                                    <td align="left">
                                                        <BDP:BDPLite ID="bdpPoDate" TabIndex="4" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Challan No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtchalan" TabIndex="5" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Challan Date
                                                    </td>
                                                    <td align="left">
                                                        <BDP:BDPLite ID="BDPLite2" TabIndex="6" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Bill No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbill" TabIndex="5" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Bill Date
                                                    </td>
                                                    <td align="left">
                                                        <BDP:BDPLite ID="bdpbilldate" TabIndex="6" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Rec No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtRecNo" Text ="0" ReadOnly ="true"  runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Rec Date
                                                    </td>
                                                    <td align="left">
                                                        <BDP:BDPLite ID="bdpRecDate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Inward No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtInwardNo" TabIndex="7" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td  align="right">
                                                        D.R.B No
                                                    </td>
                                                    <td  align="left">
                                                        <asp:TextBox ID="txtdrb" TabIndex="7" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <td align="right">
                                                        Gate Pass No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtgate" TabIndex="8" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 7px" colspan="9">
                                                        &nbsp;
                                                        <table id="Grd_Item" cellpadding="4" cellspacing="0" bordercolor="#FFFFFF" border="0"
                                                            bgcolor="#f4f4f4" height="51px" style="border-collapse: collapse" runat="server">
                                                            <tr class="gridhead">
                                                                <td>
                                                                    LF No
                                                                </td>
                                                                <td>
                                                                    Part No.
                                                                </td>
                                                                <td>
                                                                    Item Name
                                                                </td>
                                                                <td>
                                                                    Available Qty
                                                                </td>
                                                                <td>
                                                                    Rate
                                                                </td>
                                                                <td>
                                                                    Qty. in Challan
                                                                </td>
                                                                <td>
                                                                    Actual Qty. Recvd
                                                                </td>
                                                                <td style="height: 24px">
                                                                </td>
                                                            </tr>
                                                            <tr class="gridtxt">
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtlfno" TabIndex="9" onblur="emptytext();ajaxFunction();"
                                                                        runat="server" Width="100px" Height="22px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtPartNo" TabIndex="10" onblur="emptytextpart();ajaxFunction();"
                                                                        runat="server" Width="100px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="ddlitem" TabIndex="11" onpropertychange="ajaxFunction()"
                                                                        onblur="return check1();" runat="server" Width="175px"></asp:TextBox><asp:ListBox
                                                                            ID="Select1" Style="display: none; align: left" onclick="Select();" runat="server">
                                                                        </asp:ListBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtbqty" TabIndex="12" Onfocus="display ()" ReadOnly="true"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtRate" TabIndex="13" onblur="if (!IsNumeric(this.value)){alert('Enter proper value');this.value=0;return false}"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtChallnQty" TabIndex="14" onblur="return fillActualQty();"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtqty" TabIndex="15" onblur="ticFunction2()"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td style="height: 28px">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="7" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="btnSubmit" TabIndex="16" runat="server" ImageUrl="../images/btn_h.gif"
                                                                align="absmiddle" border="0" Width="87" Height="38" AlternateText="Save" />
                                                        </a><a class="canceltxt" href="#">Cancel</a>
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


/*

    var txtSecDate = document.getElementById('BDPLite1_TextBox');
        txtSecDate.readOnly = true;
    var txtPODate = document.getElementById('bdpPoDate_TextBox');
        txtPODate.readOnly = true;
    var txtChlnDate = document.getElementById('BDPLite2_TextBox');
        txtChlnDate.readOnly = true;
    var txtBillDate = document.getElementById('bdpbilldate_TextBox');
        txtBillDate.readOnly = true;
    var txtRecDate = document.getElementById('bdpRecDate_TextBox');
        txtRecDate.readOnly = true;      

*/  
    </script>

</body>
</html>
