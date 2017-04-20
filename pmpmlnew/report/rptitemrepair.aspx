<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptitemrepair.aspx.vb" Inherits="KDMT.rptitemrepair" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Item Repair Report</title>
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
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px">
                <strong><span style="font-size: 11pt; color: black">Item Repair Report</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Select<asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="1" Selected="True">IN</asp:ListItem>
                    <asp:ListItem Value="2">OUT</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td>
                From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
                To Date
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
                <asp:Button ID="btnshow" runat="server" Text="Show" />
            </td>
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" style="width: 650px"
        runat="server" border="1">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">Pune Mahanagar Parivahan Mahamandal Limited  </span>
                </strong>
            </td>
        </tr>
        <td align="center" colspan="4" style="height: 22px">
            <strong><span style="font-size: 14pt"></span></strong>
        </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                <asp:Label ID="Label3" runat="server" Width="96px" Font-Bold="True">Fromdate:</asp:Label>
            </td>
            <td align="left" style="height: 19px">
                &nbsp;<asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="width: 223px; height: 19px;">
                &nbsp;<asp:Label ID="Label4" runat="server" Width="96px" Font-Bold="True">ToDate:</asp:Label>
            </td>
            <td align="right" style="height: 19px; width: 97px;">
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4" style="height: 50px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" Width="224px">Item Repair Report</asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
                        Width="95%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                            <asp:BoundColumn DataField="gate_pass_no" HeaderText="Gate Pass No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="vech_no" HeaderText="Vech No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                            <%--          <asp:BoundColumn DataField="qty" HeaderText="Quantity"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="total_qty" HeaderText="Quantity"></asp:BoundColumn>
                            <asp:BoundColumn DataField="cont_name" HeaderText="Contractor"></asp:BoundColumn>
                            <asp:BoundColumn DataField="trans_date" HeaderText="Date"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid></div>
            </td>
        </tr>
        <tr>
            <td>

            </td>
            <td>
            </td>
            <td style="width: 223px">
            </td>
            <td style="width: 97px">
                Workshop Dept
            </td>
        </tr>

        <tr>
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
