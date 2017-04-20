<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_po_by_date.aspx.vb" Inherits="KDMT.report_rpt_po_by_date" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PO Order Report</title>
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

        <a href="storereport.aspx" class="ctrl">Back</a>
        <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
            runat="server" class="ctrl">
            <tr>
                <td class="text3" align="center" style="height: 22px" colspan="4">
                    <strong><span style="font-size: 11pt; color: black">Pending PO Report &nbsp;</span></strong>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    Vendor Name :
                    <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                        runat="server" />&nbsp;&nbsp; Po <span>Category :&nbsp; </span>
       
           <asp:DropDownList ID="drpType" runat ="server" style="width: 140px" >
           <asp:ListItem Text="All" Value="0" ></asp:ListItem>
           <asp:ListItem Text="SpareParts" Value="1" ></asp:ListItem>
        <asp:ListItem Text ="Hardware" Value ="2" >
        </asp:ListItem>
        
        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <span>PO Type</span> :
                    <asp:DropDownList ID="drbPoType" runat="server">
                        <asp:ListItem Text="RC" Value="RC"></asp:ListItem>
                        <asp:ListItem Text="T&C" Value="T"></asp:ListItem>
                        <asp:ListItem Text="SP" Value="SP"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <span>From Po No</span>
                    <asp:TextBox ID="txtPONofrom" runat="server"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp; To<span> Po No</span>
                    :&nbsp;
                    <asp:TextBox ID="txtPONoto" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;From Date :
                    <BDP:BDPLite ID="bdppodatefrom" runat="server">
                    </BDP:BDPLite>
                    
                     &nbsp;
                    
                     To Date :
                    <BDP:BDPLite ID="bdppodateto" runat="server">
                    </BDP:BDPLite>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                    <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                </td>
            </tr>
        </table>
        <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
            runat="server">
            <tr>
                <td colspan="4" align="center">
                    <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL 
                    LIMITED       </strong>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <strong><span style="font-size: 14pt">Pending PO Report </span></strong>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    <asp:Label ID="lbldate" runat="server"></asp:Label>
                </td>
                <td align="right" colspan="2">
                    <asp:Label ID="lblVendor" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    <asp:Label ID="lblcategory" runat="server"></asp:Label>
                </td>
                   <td align="right" colspan="2">
                    <asp:Label ID="lblpotype" runat="server"></asp:Label>
                </td>
            </tr>
           
            <tr>
                <td align="left" style="height: 19px" colspan="2">
                    <asp:Label ID="Label4" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                    <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                </td>
                <td align="right" style="height: 19px" colspan="2">
                    <asp:Label ID="Label5" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                    <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="left" style="height: 50px">
                    <div align="center">
                        <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
                            Width="750px" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                            BorderStyle="None" BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False"
                            Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" ForeColor="Black">
                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                            <ItemStyle ForeColor="#000066" />
                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                            <Columns>
                                <asp:TemplateColumn HeaderText="Sr No.">
                                    <ItemTemplate>
                                        <%#Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                
                                <asp:BoundColumn DataField="po_no" HeaderText="Order No " ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                <asp:BoundColumn DataField="vendor_name" HeaderText="Vendor Name" ItemStyle-HorizontalAlign="left"
                                    HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                <asp:BoundColumn DataField="item_name" HeaderText="Nomenclature" HeaderStyle-HorizontalAlign="left"
                                    ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="part_no" HeaderText="Part_No" ItemStyle-HorizontalAlign="left"
                                    HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="total_qty" HeaderText="Quantity" ItemStyle-HorizontalAlign="right">
                                </asp:BoundColumn>
                               
                            </Columns>
                        </asp:DataGrid>
                    </div>
                </td>
            </tr>
        </table>
    </div>
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
