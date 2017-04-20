<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptItemrate.aspx.vb" Inherits="KDMT.report_rptItemrate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 700px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px">
                <strong><span style="font-size: 11pt; color: black">Item Rate&nbsp; Report &nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                Type Of Items
                <asp:DropDownList runat="server" ID="drpTypeOfItems" >
                    <asp:ListItem Value="1" Text="Spare Part"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Hardware"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Kit Section"></asp:ListItem>
                    <asp:ListItem Value="4" Text="STN"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnshow" runat="server" Text="Show" />
            </td>
        </tr>
    </table>
    <div id="divcryrpt" runat ="server">
    </div> 
    <table id="Table1" align="center" border="1" style="width: 700px" runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL 
                LIMITED        </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Item Balance Report
                    <asp:Label ID="Label3" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                From Date:-
                <asp:Label ID="lblfrom" runat="server" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                To Date:-
                <asp:Label ID="lbltodate" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" runat="server" Width="100%" AutoGenerateColumns="False"
                        BackColor="White" BorderColor="Black" BorderStyle="None" BorderWidth="1px" CellPadding="1"
                        ShowFooter="True" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black">
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
                            <asp:BoundColumn DataField="item_code" HeaderText="Item Code" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Item_name" HeaderText="Item Name" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Rack_No" HeaderText="LF NO" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Subrack_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_no4" HeaderText="Part No " ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="avg_rate" HeaderText="AVG Rate" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="last_rate" HeaderText="Last Rate" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            
                        </Columns>
                    </asp:DataGrid>
                </div>
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
                Store Dept
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4" valign="top" style="height: 50px">
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
