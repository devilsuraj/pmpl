<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptinvoice.aspx.vb" Inherits="KDMT.rptinvoice" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Depot Wise Summary Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript"> 
	   function printpage()
		{
		window.print();
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
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkvendorname&vendorname="+document.getElementById ("txtvendor").value,true);
    xmlHttp.send(null);
    }
}
		
		

    </script>

    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <div>

        <script src="<% =session("host") %>SpryAssets/SpryMenuBar.js" type="text/javascript"></script>

        <link href="<% =session("host") %>SpryAssets/SpryMenuBarVertical.css" rel="stylesheet"
            type="text/css">

        <script src="<% =Session("host") %>includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>

        <script language="javascript" src="<% =Session("host") %>includes/scripts/jquery.autocomplete.js"></script>

        <link rel="stylesheet" href="<% =Session("host") %>css/jquery.autocomplete2.css" />

        <script type="text/javascript">


function findValue(li) {
	if( li == null ) return alert("No match!");

	// if coming from an AJAX call, let's use the CityId as the value
	if( !!li.extra ) var sValue = li.extra[0];

	// otherwise, let's just display the value in the text box
	else var sValue = li.selectValue;

	//alert("The value you selected was: " + sValue);
}

function selectItem(li) {
	findValue(li);
}
    
//-->
        </script>

        <table width="850px" align="center" border="1" class="ctrl ">
            <tr>
                <td class="innerheading" colspan="4">
                    <span id="Span1">List Of Invoice Report</span>
                </td>
            </tr>
            <tr>
                <td align="right" class="style2">
                    vendor Name
                </td>
                <td>
                    <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                        runat="server" />
                </td>
                <td align="right">
                    Invoice No
                </td>
                <td>
                    <asp:TextBox ID="txtinvoice" runat="server" BackColor="#FFFFC0" ToolTip="Enter Invoice No"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style2">
                    Fromdate
                </td>
                <td align="left">
                    <BDP:BDPLite ID="bdpfromdate" runat="server">
                    </BDP:BDPLite>
                </td>
                <td align="right">
                    To Date
                </td>
                <td align="left">
                    <BDP:BDPLite ID="bdptodate" runat="server">
                    </BDP:BDPLite>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btn_show" runat="server" Text="Show" />
                </td>
            </tr>
        </table>
    </div>
    <table id="tblcontain" align="center" cellspacing="0" cellpadding="0" border="1"
        style="width: 850px" runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">List Of Invoice Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                <asp:Label ID="lbldate" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px">
                <asp:Label ID="lbltodate" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td  align="left" style="height: 19px">
                <asp:Label ID="lblvendor" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right">
                <asp:Label ID="lblinvoice" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:Literal ID="htmlchallan" runat="server"></asp:Literal>
                    
                </div>
            </td>
        </tr>
    </table>
    </form>

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



    </script>

</body>
</html>
