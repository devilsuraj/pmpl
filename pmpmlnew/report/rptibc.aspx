<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptibc.aspx.vb" Inherits="KDMT.rptibc" %>

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
                <td colspan="4" class="text3" align="center" style="height: 22px">
                    <strong><span style="font-size: 11pt; color: black">List Of IBC Report</span></strong>
                </td>
            </tr>
            <tr>
                <td>
                    vendor Name
                    <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                        runat="server" />
                </td>
                <td>
                    Ibc Status<asp:DropDownList ID="ddlibc" runat="server">
                        <asp:ListItem Text="ALL" Value="9"></asp:ListItem>
                        <asp:ListItem Text="Open" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Close" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    IBC From Date
                    <BDP:BDPLite ID="dtibc" runat="server" TextBoxStyle-Width="100px">
                        <TextBoxStyle Width="100px" />
                    </BDP:BDPLite>
                </td>
                <td>
                    IBC To Date
                    <BDP:BDPLite ID="dtibctodate" runat="server" TextBoxStyle-Width="100px">
                        <TextBoxStyle Width="100px" />
                    </BDP:BDPLite>
                </td>
            </tr>
            <tr>
                <td>
                    Bank
                    <asp:DropDownList ID="ddlbank" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center">
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
                <strong><span style="font-size: 14pt">List Of IBC Report </span></strong>
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
            <td align="left" style="height: 19px">
                <asp:Label ID="lblvendor" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right">
                <asp:Label ID="lblbankname" runat="server" Width="96px" Font-Bold="True"></asp:Label>
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
                            <asp:BoundColumn Visible="false" DataField="ibcid"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ibc_date" HeaderText="IBC Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="bank_name" HeaderText="Bank name"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="Int No">
                                <ItemTemplate>
                                    <a href='../report/printibc.aspx?ibcid=<%# DataBinder.Eval(Container, "DataItem.ibcid") %> &ibcform=rptibc'>
                                        <font color="Blue"></font>
                                        <%#DataBinder.Eval(Container, "DataItem.intimateno")%></a>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="intimate_date" HeaderText="Int Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="intimate_rec_date" HeaderText="Int Rec Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="amt_involved" HeaderText="Amt Involved"></asp:BoundColumn>
                            <asp:BoundColumn DataField="last_payment_date" HeaderText="Last Pay date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="material_detail" HeaderText="Material Detail"></asp:BoundColumn>
                            <asp:BoundColumn DataField="vendor_name" HeaderText="Vendor"></asp:BoundColumn>
                            <asp:BoundColumn DataField="invoice_no" HeaderText="Invoice No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="invoice_date" HeaderText="Invoice Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="invoice_amt" HeaderText="Invoice Amt"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lr_no" HeaderText="Lr No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lr_date" HeaderText="Lr Date"></asp:BoundColumn>
                            
                          <%--<asp:BoundColumn DataField="rate_po" HeaderText="PO Rates"></asp:BoundColumn>
                            <asp:BoundColumn DataField="chng_rate" HeaderText="Change in Rates"></asp:BoundColumn>
                            <asp:BoundColumn DataField="qty_dmnd" HeaderText="Qty Demand"></asp:BoundColumn>                            
                            <asp:BoundColumn DataField="qty_rec" HeaderText="received Qty"></asp:BoundColumn>--%>
                            
                            <asp:BoundColumn DataField="release_amt" HeaderText="Release Amt"></asp:BoundColumn>
                            <asp:BoundColumn DataField="po_no" HeaderText="PO"></asp:BoundColumn>
                            <asp:BoundColumn DataField="po_date" HeaderText="PO Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ibc_flag" HeaderText="Status"></asp:BoundColumn>
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
