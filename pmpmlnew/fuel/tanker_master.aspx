<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="tanker_master.aspx.vb"
    Inherits="kdmt.tanker_master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Diesel Indent</title>
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
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkdieselvendorname&vendorname="+document.getElementById ("txtvendor").value,true);
    xmlHttp.send(null);
    }
}

function chkdeponame()
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
    alert("No Such Depo Present");
    document.getElementById ("txtdepot").focus();
    }
    }
    }
if (document.getElementById ("txtdepot").value != '')
    {
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkdeponame&deponame="+document.getElementById ("txtdepot").value,true);
    xmlHttp.send(null);
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


function validate(){

  
if (document.getElementById ("txtchalanno").value.length==0)
  {
  alert ('Please Enter Challan_no');
  document.getElementById ("txtchalanno").focus()
  return false;
  }
  
  if (document.getElementById ("txtshort").value.length==0)
  {
  alert ('Please Enter Shortage');
  document.getElementById ("txtshort").focus()
  return false;
  }
  
  if(IsNumeric(document.getElementById ("txtshort").value) == false )
    {
    alert ('Please Enter Numbers only');
    document.getElementById ("txtshort").focus()
    return false;
    }
  
   if (document.getElementById ("txtshortamt").value.length==0)
  {
  alert ('Please Enter Shortage amt');
  document.getElementById ("txtshortamt").focus()
  return false;
  }
  if(IsNumeric(document.getElementById ("txtshortamt").value) == false )
    {
    alert ('Please Enter Numbers only');
    document.getElementById ("txtshortamt").focus()
    return false;
    }
  
   
     if (document.getElementById ("txtrec_qty").value.length==0)
  {
 alert ('Please Enter Receive Qty');
  document.getElementById ("txtrec_qty").focus()
  return false;
  }
  
  
    if(IsNumeric(document.getElementById ("txtrec_qty").value) == false )
    {
    alert ('Please Enter Numbers only');
    document.getElementById ("txtrec_qty").focus()
    return false;
    }
        
    if (document.getElementById ("txtchalan_amt").value.length==0)
  {
  alert ('Please Enter Chalan Amt');
  document.getElementById ("txtchalan_amt").focus()
  return false;
  }
    if(IsNumeric(document.getElementById ("txtchalan_amt").value) == false )
    {
     alert ('Please Enter Numbers only');
    document.getElementById ("txtchalan_amt").focus()
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
    
    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Job Order Card Master</h1>
    </div>
    <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
 
 
    <asp:HiddenField ID="hdnid" runat="server" />
      <div class="form-horizontal">
     
        <div id="middal">
           
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table id="Table1" width="100%" cellpadding="0" cellspacing="0" runat="server" align="center">
                        <tbody>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="innerheading">
                                    Tanker
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="text-align: center">
                                        <table id="tblmain" runat="server">
                                            <tbody>
                                                <tr>
                                                    <td align="right">
                                                        Indent No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtindentno" runat="server" class="textfield" ReadOnly="True"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Challan No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtchalanno" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        &nbsp;Challan Date
                                                    </td>
                                                    <td align="left">
                                                
                                                              <asp:TextBox ID="bdpchalandate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="bdpchalandate"
                                        PopupButtonID="bdpchalandate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Shortage&nbsp; in Ltr
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtshort" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                        Shoratage amt
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtshortamt" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Rec Qty
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtrec_qty" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        &nbsp;Challan Amt
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtchalan_amt" runat="server" class="textfield"></asp:TextBox>
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
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:DataGrid ID="dgresult" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                                        HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                                        runat="server" AutoGenerateColumns="False">
                                                        <Columns>
                                                            <asp:BoundColumn DataField="indent_id" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="adv_no" HeaderText="Advanced NO"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="adv_cheque_date" HeaderText="Advanced cheque Date"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="fuel_vendor_desc" HeaderText="Diesel vendor"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cont_name" HeaderText="Depo Name"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="chq_no" HeaderText="Cheque No"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="Amount" HeaderText="Amount"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="tank_date" HeaderText="Tanker Date"></asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Update tanker Info">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="Edit" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.indent_id") %>'
                                                                        CommandName="select" ImageUrl="../images/edit.gif" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                        <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                                    </asp:DataGrid>
                                                </td>
                                            </tr>
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


    <script type="text/javascript">

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


$("#txtdepot").autocompleteArray(
		[<% =strDepot  %>],
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