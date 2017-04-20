<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptfuelsummary.aspx.vb"
    Inherits="KDMT.rptfuelsummary" %>

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
    <style type="text/css">
        .style1
        {
            height: 24px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="fuelreport.aspx" class="ctrl">Back</a>
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
                <td colspan="4" class="text3" align="center" style="height: 22px">
                    <strong><span style="font-size: 11pt; color: black">Fuel Summary Report</span></strong>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Advance Cheque From Date
                </td>
                <td>
                    <BDP:BDPLite ID="bdpadv_chqdate_from" runat="server" TextBoxStyle-Width="100px">
                        <TextBoxStyle Width="100px" />
                    </BDP:BDPLite>
                </td>
                <td align="right">
                    Advance Cheque To Date
                </td>
                <td>
                    <BDP:BDPLite ID="bdpadv_chqdate_to" runat="server" TextBoxStyle-Width="100px">
                        <TextBoxStyle Width="100px" />
                    </BDP:BDPLite>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Challan From Date
                </td>
                <td>
                    <BDP:BDPLite ID="bdpchallan_from" runat="server" TextBoxStyle-Width="100px">
                        <TextBoxStyle Width="100px" />
                    </BDP:BDPLite>
                </td>
                <td align="right">
                    Challan To Date
                </td>
                <td>
                    <BDP:BDPLite ID="bdpchallan_to" runat="server" TextBoxStyle-Width="100px">
                        <TextBoxStyle Width="100px" />
                    </BDP:BDPLite>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Fuel Vendor
                </td>
                <td>
                    <asp:TextBox ID="txtfuel" runat="server"></asp:TextBox>
                </td>
                <td align="right">
                    Depot Name
                </td>
                <td>
                    <asp:DropDownList ID="ddldepo" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Depot Name
                </td>
                <td>
                    <asp:DropDownList ID="ddldieselflag" runat="server">
                    <asp:ListItem Text ="All" Value = "9"></asp:ListItem>
                    <asp:ListItem Text ="Open" Value = "0"></asp:ListItem>
                    <asp:ListItem Text ="close" Value = "1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                </td>
            </tr>
        </table>
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
                <strong><span style="font-size: 14pt">Fuel Summary Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                <asp:Label ID="advcheque_fromdate" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px">
                <asp:Label ID="advcheque_todate" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                <asp:Label ID="lblchallan_date" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px">
                <asp:Label ID="lblchallan_todate" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                <asp:Label ID="lblvendor" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right">
                <asp:Label ID="lbldepotname" runat="server" Width="96px" Font-Bold="True"></asp:Label>
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
                            <asp:BoundColumn DataField="adv_no" HeaderText="Advanced NO"></asp:BoundColumn>
                            <asp:BoundColumn DataField="adv_chq_date" HeaderText="Advanced cheque Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="fuel_vendor_desc" HeaderText="Diesel vendor"></asp:BoundColumn>
                            <asp:BoundColumn DataField="cont_name" HeaderText="Depo Name"></asp:BoundColumn>
                            <asp:BoundColumn DataField="chq_no" HeaderText="Cheque No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Amount" HeaderText="Amount"></asp:BoundColumn>
                            <asp:BoundColumn DataField="tanker_date" HeaderText="Tanker Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="challan_date" HeaderText="Challan Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="challan_no" HeaderText="Challan No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rec_qty" HeaderText="Rec Qty"></asp:BoundColumn>
                            <asp:BoundColumn DataField="challan_amt" HeaderText="Challan Amt"></asp:BoundColumn>
                            <asp:BoundColumn DataField="shortage" HeaderText="Shortage "></asp:BoundColumn>
                            <asp:BoundColumn DataField="short_amt" HeaderText="Short Amt"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript">


$("#txtfuel").autocompleteArray(
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
