<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_pending_indent.aspx.vb"
    Inherits="kdmt.rpt_pending_indent" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Indent Slip Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript">
        function printpage() {
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
    <a href="Storereport.aspx" class="ctrl">Back</a>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED</span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 16pt; color: black"><span lang="en-us">Pending Indent</span>
                    Report</span></strong>&nbsp;
            </td>
        </tr>
        
        <tr>
            <td colspan="4" align="left" style="height: 50px">
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
                            <asp:BoundColumn DataField="item_name" HeaderText="Item " ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rack_no" HeaderText="L/F No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Part No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="pen_qty" HeaderText="Issue Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
