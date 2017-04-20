<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptreceivereport.aspx.vb"
    Inherits="KDMT.rptreceivereport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Item Receive Report</title>
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

        <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
            runat="server" class="ctrl">
            <tr>
                <td class="text3" align="center" style="height: 22px">
                    <strong><span style="font-size: 11pt; color: black">Item Receipt Register Report</span></strong>
                </td>
            </tr>
            <tr>
                <td>
                    Challan No
                    <asp:TextBox ID="txtchallan" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vendor Name
                    <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                        runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                   Receipt From Date
                    <BDP:BDPLite ID="BDPLite1" runat="server">
                    </BDP:BDPLite>
                    Receipt To Date
                    <BDP:BDPLite ID="BDPLite2" runat="server">
                    </BDP:BDPLite>
                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                    <asp:Button ID="crystal" runat="server" Text="Crystal Report" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divcrt" runat ="server">
        <CR:CrystalReportViewer ID="viewer_item_recieve" runat="server" AutoDataBind="true" />
    
    </div>
   
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
                <strong><span style="font-size: 14pt">Item Receipt Register Report
                    <asp:Label ID="Label3" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                <asp:Label ID="Label1" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                <asp:Label ID="Label2" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
         <tr>
            <td align="left" style="height: 19px" colspan="4">
                <asp:Label ID="lblchallan" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                
            </td>
            <td align="right" style="height: 19px" colspan="4">
                <asp:Label ID="lblvendor" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                
            </td>
        </tr>
        <tr>
            <td colspan="5" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                            <asp:BoundColumn DataField="rec_no" HeaderText="Receipt No" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="rec_date" HeaderText="Date Of Receipt" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="vendor_name" HeaderText="Vendors" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="challan_no" HeaderText="Challan No" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="challan_date" HeaderText="Challan Date" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="item_name" HeaderText="Item" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Part No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="left">
                            </asp:BoundColumn>
                            <%--       <asp:BoundColumn DataField="available" HeaderText="Available"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="quantity" HeaderText="Quantity" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="count_in" HeaderText="Unit" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Reject" HeaderText="Rejected" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="rack_no" HeaderText="L/F No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="po_no" HeaderText="PO No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="po_date" HeaderText="PO Date" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="bill_no" HeaderText="Bill No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="bill_date" HeaderText="Bill Date" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="drb_no" HeaderText="DRB No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid></div>
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="4" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="120px" OnClientClick="printpage();"
                    Text="Print" />
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
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
