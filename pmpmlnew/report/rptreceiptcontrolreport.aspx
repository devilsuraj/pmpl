<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptreceiptcontrolreport.aspx.vb"
    Inherits="KDMT.rptreceiptcontrolreport" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vendorwise Receive Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript"> 
	   function printpage()
		{
		window.print();
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
            height: 29px;
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

        <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
            runat="server" class="ctrl">
            <tr>
                <td class="text3" align="center" style="height: 22px">
                    <strong><span style="font-size: 11pt; color: black">RECEIPT CONTROL REGISTER</span></strong>
                </td>
            </tr>
            <tr visible="false">
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style1">
                    Rec No :-
                    <asp:TextBox ID="txtrecno" runat="server"></asp:TextBox>
                    <span style="padding-left: 30px;">Rec Control Year</span> <span style="padding-left: 30px;">
                        <asp:DropDownList ID="ddlrecyear" runat="server">
                        </asp:DropDownList>
                    </span><span style="padding-left: 30px;">Part Type
                        <asp:DropDownList ID="ddlparttype" runat="server">
                            <asp:ListItem Text="SP" Value="SP"></asp:ListItem>
                            <asp:ListItem Text="HW" Value="HW"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="btnshow" runat="server" Text="Show" /></span>
                </td>
            </tr>
        </table>
    </div>
    <table id="Table1" align="center" border="1" style="width: 100%" runat="server">
        <tr>
            <td colspan="5" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED VAHAN
                    MAHAMANDAL LIMITED </span></strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5">
                <strong><span style="font-size: 14pt">Receipt Control Register
                    <asp:Label ID="Label3" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="4">
                Supplier's Name & Address:-
                <asp:Label ID="lblSupName" Font-Underline="true" Style='font-family: Times New Roman;
                    font-size: 12px;' runat="server" Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Serial No.
                <asp:Label ID="lblSerNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                Bill No.:-
                <asp:Label ID="lblBlNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Challan No.:-
                <asp:Label ID="lblChNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Date:-
                <asp:Label ID="lblChDT" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                &nbsp;
            </td>
            <td align="left" style="height: 19px">
                PMPML Bill No.
                <asp:Label ID="lblPMPLNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                Date :-
                <asp:Label ID="lblBlDT" Style='font-family: Times New Roman; font-size: 12px;' runat="server"
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Order No.:-
                <asp:Label ID="lblOrdNo" runat="server" Style='font-family: Times New Roman; font-size: 14px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Date :-
                <asp:Label ID="lblOrdDT" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Rec No.:-
                <asp:Label ID="lblRecNo" runat="server" Style='font-family: Times New Roman; font-size: 14px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Date :-
                <asp:Label ID="lblRecDate" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td align="center" colspan="4">
                <asp:Label ID="Label2" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True" Font-Names="Verdana" Width="224px"></asp:Label>
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
                        <ItemStyle ForeColor="#000066" Font-Size="12px" />
                        <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                            Font-Size="10pt" Font-Strikeout="False" Font-Names="Times New Roman" Font-Underline="False" 
                            Wrap="False" />
                        <Columns>
                            <asp:TemplateColumn HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="Item_Name" ItemStyle-HorizontalAlign="left" HeaderText="Description of the Article"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_No" HeaderText="Part No." ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item_rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="center"
                                ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="amount" HeaderText="Amount(Rs.)" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="unit" HeaderText="Unit" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="total_qty" HeaderText="Quantity" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right"></asp:BoundColumn>
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <%--<asp:BoundColumn DataField="vendor_name" HeaderText="Vendor"></asp:BoundColumn>--%>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="5">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5" valign="top" style="height: 50px">
                &nbsp;
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="5" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript">



    </script>

</body>
</html>
