<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptchartwiseitemmoving_bal_and_po_details.aspx.vb"
    Inherits="kdmt.rptchartwiseitemmoving_bal_and_po_details" %>

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
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px" colspan="4">
                <strong><span style="font-size: 11pt; color: black">FMS Pending PO Report &nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Type :
            </td>
            <td>
                <asp:DropDownList ID="drbType" runat="server">
                    <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Kit Section" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Stationary" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                Moving Type :
            </td>
            <td>
                <asp:DropDownList ID="ddlmoving" runat="server">
                    <asp:ListItem Text="All Pending PO" Value="11"></asp:ListItem>
                    <asp:ListItem Text="Fast Moving Pending PO" Value="8"></asp:ListItem>
                    <asp:ListItem Text="Medium Moving Pending PO" Value="9"></asp:ListItem>
                    <asp:ListItem Text="Slow Moving Pending PO" Value="10"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <%--<tr>
            <td>
                Consumption and Stock :
            </td>
            <td>
                <asp:DropDownList ID="ddl_cons_stock" runat="server">
                    <asp:ListItem Text="ALL" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Both Nil" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Consumption Nil But Stock Not Nil" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Consumption Not Nil But Stock  Nil" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Both Not Nil" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr> --%>
        <%-- <tr>
            <td>
                From Date
            </td>
            <td>
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
            </td>
            <td>
                To Date
            </td>
            <td>
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
            </td>
        </tr>--%>
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnshow" runat="server" Text="Show" />
            </td>
        </tr>
    </table>
    <div id="divcry" runat="server">
    </div>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">FMS Pending PO Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <asp:Label ID="lblcategory" runat="server"></asp:Label>
            </td>
            <td align="right" colspan="2">
                <asp:Label ID="lblimovingtype" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                <asp:Label ID="lblcons_stock" runat="server"></asp:Label>
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
                            <%--   <asp:TemplateColumn HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </asp:TemplateColumn>--%>
                            <asp:BoundColumn ItemStyle-Width="150" DataField="ROWNO" HeaderText="Sr No" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <%--          <asp:BoundColumn DataField="Vendor_name" HeaderText="Vendor" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>--%>
                            <asp:BoundColumn ItemStyle-Width="150" DataField="lf_no" HeaderText="LF No" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn ItemStyle-Width="150" DataField="bin_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn ItemStyle-Width="150" DataField="part_no" HeaderText="Part No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item" HeaderText="Nomenclature" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <%--<asp:BoundColumn DataField="item_qty" HeaderText="Order Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>--%>
                            <asp:BoundColumn ItemStyle-Width="150" DataField="balance" HeaderText="Balance" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_recentyear_minus_2" HeaderText="" ItemStyle-HorizontalAlign="right">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="file_recentyear_minus_1" HeaderText="" ItemStyle-HorizontalAlign="right">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="file_recentyear" HeaderText="" ItemStyle-HorizontalAlign="right">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="file_MLevel" HeaderText="Minimum Level" ItemStyle-HorizontalAlign="right">
                            </asp:BoundColumn>
                            <asp:BoundColumn ItemStyle-Width="300" DataField="file_vendor_name" HeaderText="Vendor"
                                ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn ItemStyle-Width="300" DataField="file_po_type" HeaderText="PO No"
                                ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_po_date" HeaderText="PO Date" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_item_qty" HeaderText="Order Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_rec_qty" HeaderText="Received Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right" ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_pen_qty" HeaderText="Pending Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right" ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_followup" HeaderText="Pending Status" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right" ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_number" HeaderText="File No" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right" ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_followup" HeaderText="Remark" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right" ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="file_item_code" Visible="false"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="4" class="ctrl" align="center">
                <asp:Button ID="btnexcel" runat="server" Text="Convert To Excel" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
