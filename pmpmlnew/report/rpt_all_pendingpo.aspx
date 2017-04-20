<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_all_pendingpo.aspx.vb"
    Inherits="KDMT.rpt_all_pendingpo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
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
		
		
		
///////////   for removing blaak spaces 
String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
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

    <table id="Table2" align="center" cellspacing="0" class="ctrl" cellpadding="0" border="1"
        style="width: 750px" runat="server">
        <tr>
            <td align="right">
                Vendor Name :
            </td>
            <td>
                <asp:TextBox ID="txtvendor" onblur="chkvendorname()" runat="server" Width="280px">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Type :
            </td>
            <td>
                <asp:DropDownList ID="drpType" runat="server">
                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                    <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
            
                </asp:DropDownList>
            </td>
            <td align="right">
                PO Type :
            </td>
            <td>
                <asp:DropDownList ID="drbPoType" runat="server">
                 <asp:ListItem Text="All" Value=""></asp:ListItem>
                    <asp:ListItem Text="RC" Value="RC"></asp:ListItem>
                    <asp:ListItem Text="T&C" Value="T"></asp:ListItem>
                    <asp:ListItem Text="SP" Value="SP"></asp:ListItem>
                    <asp:ListItem Text="STN" Value="STN"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">
                PO Year :
            </td>
            <td>
                <asp:DropDownList ID="ddlfinancecalendar" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td colspan="2" align="left">
                <asp:Button ID="btn_showpo" runat="server" Text="Show" />
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
            </td>
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">ALL Pending PO Report </span></strong>
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
                            <asp:BoundColumn DataField="po_date" HeaderText="PO Date" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Vendor_name" HeaderText="Vendor" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="category" HeaderText="Category" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                     
                            <asp:TemplateColumn HeaderText="PO No" ItemStyle-HorizontalAlign ="Left" >
                                <ItemTemplate>
                                    <a href='rpt_po_details.aspx?podate=<%# DataBinder.Eval(Container, "DataItem.actual_date") %>&vendor_name=<%# DataBinder.Eval(Container, "DataItem.vendor_name") %>&Category=<%# DataBinder.Eval(Container, "DataItem.Category") %>&po_TYPE=<%# DataBinder.Eval(Container, "DataItem.po_str") %>&po_no=<%# DataBinder.Eval(Container, "DataItem.po_no") %>'>
                                        <font color="Blue"></font>
                                        <%#DataBinder.Eval(Container, "DataItem.po")%></a>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
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
