<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptmakewisereport.aspx.vb"
    Inherits="KDMT.rptmakewisereport"  %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Item Balance Report</title>
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
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 700px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px" colspan="2">
                <strong><span style="font-size: 11pt; color: black">Makewise Report &nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
            </td>
            <td>
                Type Of Items
                <asp:DropDownList runat="server" ID="drpTypeOfItems">
                    <asp:ListItem Value="tata" Text="TATA"></asp:ListItem>
                    <asp:ListItem Value="ley" Text="LEYLAND"></asp:ListItem>
                </asp:DropDownList>
                 <asp:DropDownList runat="server" ID="drpTypeOfItemsNa">
                    <asp:ListItem Value="1" Text="All"></asp:ListItem>
                    <asp:ListItem Value="0" Text="N/A"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Button ID="btnshow" runat="server" Text="Show" />
                <asp:Button ID="btnCry" runat="server" Text="Crystal Report" />
                
            </td>
        </tr>
    </table>
    <div id="divCry" runat ="server" >
        <CR:CrystalReportViewer ID="crst_item_wise" runat="server" AutoDataBind="true" />
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
                <strong><span style="font-size: 14pt">Makewise Report
                    <asp:Label ID="lblmake" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock"  runat="server" Width="100%" AutoGenerateColumns="False"
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
                            <asp:BoundColumn DataField="Category" HeaderText="Category" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rack_no" HeaderText="LF No" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Part N0" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item_name" HeaderText="Item " ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="q" HeaderText="Balance" HeaderStyle-HorizontalAlign="Center">
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
