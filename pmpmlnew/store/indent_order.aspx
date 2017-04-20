<%@ Page Language="VB" AutoEventWireup="false" CodeFile="indent_order.aspx.vb" Inherits="KDMT.indent_order" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Traffic - Log Sheet Submission</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/indent_request.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script language="javascript">

function validate ()
{
if (document.getElementById ("ddlrefno").selectedIndex==0)
    {
    alert ('Please Select Request No');
    document.getElementById ("ddlrefno").focus()
    return false;
    }



var rowCount = document.getElementById('tblreqdatails').rows.length;
var j=0;
for (i=0;i<=rowCount - 2;i++)
{
var idclosed = 'chkclosed' + i 
if (document.getElementById(idclosed).checked == false   )
    {    
    var id = 'txtvendor' + i 
    if (document.getElementById(id).value == '' )
        {
        j = 1
        alert ('Please Select Vendor')
        document.getElementById(id).focus();
        return false 
        }
    }
}
if(!confirm("Do you want to Save"))
    {
    return(false);
    }
return true;
}
      
      


function allselect()
{

var rowCount = document.getElementById('tblreqdatails').rows.length;
    for (i=0;i<=rowCount - 2;i++)
    {
    var id = 'chkclosed' + i 
    if (document.getElementById('chkall').checked == true  )
    {
     document.getElementById(id).checked = true;
    }
    else
    {
     document.getElementById(id).checked = false;
    }
    }
}


   ///////////   for removing blaak spaces 
String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
}

////////////   end  filteration   ///////////////////////////
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


	
function remain_qty (order_qty,id )
{
var rem_qtyid = document.getElementById ('lblrem_qty' + id).innerHTML
var lblreq_qty = document.getElementById ('lblreq_qty' + id).innerHTML
var hdnrem_qty = document.getElementById ('lblrem_qty' + id).innerHTML
if ( (order_qty) != ''   )
    {
    if ( IsNumeric(order_qty) == true  )
        {
        if (eval(order_qty) > eval(hdnrem_qty))
            {
            alert ("Order Qty Should be less than Remaining Qty")
            document.getElementById ('txtorderqty' + id).focus();
            }
        else
            {
            document.getElementById ('lblrem_qty_' + id).innerHTML  = eval (hdnrem_qty) -  eval (order_qty) 
            }
        }
    else 
        {
        alert ("Enter Proper Qty")
        document.getElementById ('txtorderqty' + id).focus();
        }
    }
else
    {
    alert ("Enter Qty")
    document.getElementById ('txtorderqty' + id).focus();
    }
}
			
			
			





    </script>

    <style type="text/css">
        .style1
        {
            width: 197px;
        }
        .style2
        {
            height: 46px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">Indent Order</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align="right" class="style1">
                                            Select Request No:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlrefno" TabIndex="1" AutoPostBack="true" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                        </td>
                                        <td align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <table id="tblreqdatails" border="1" runat="server">
                                                <tr id="trheader" class="gridhead" runat ="server" >
                                                    <td>
                                                        Req Date
                                                    </td>
                                                    <td>
                                                        LF No
                                                    </td>
                                                    <td>
                                                        Item Name
                                                    </td>
                                                    <td>
                                                        Part No
                                                    </td>
                                                    <td>
                                                        Req Qty
                                                    </td>
                                                    <td>
                                                        Remain Qty
                                                    </td>
                                                    <td>
                                                        order Qty
                                                    </td>
                                                    <td>
                                                        Bal Qty
                                                    </td>
                                                    <td>
                                                        Vendor
                                                    </td>
                                                    <td>
                                                        order Date
                                                    </td>
                                                    <td>
                                                        Closed All<input type="checkbox" onclick="allselect()" id="chkall" name="chkall" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                        <tr id="trbutton" runat ="server">
                            <td style="height: 22px">
                                <div align="center">
                                    &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"
                                        TabIndex="9"></asp:ImageButton><asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
                                            TabIndex="10"></asp:ImageButton></div>
                            </td>
                           
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
            <asp:HiddenField ID="hdncount" runat="server" />
        </div>
    </div>
   
    </form>

    <script type="text/javascript">
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->


function fillvendor(vendorid)
{

var id = '#' + vendorid 
$(id).autocompleteArray(
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
}

	

    </script>

</body>
</html>
