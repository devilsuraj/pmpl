<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ABC_Analysis_monthly.aspx.vb" Inherits="KDMT.report_ABC_Analysis_monthly" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>ABC Analysis</title>
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
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        class="ctrl">
        <tr>
            <td valign="top" align="center">
                <strong><span style="font-size: 16pt; color: black">ABC Report</span></strong>
            </td>
        </tr>
        <tr visible="true">
            <td>
                From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
                To Date
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
            </td>
        </tr>
        <tr>
            <td>
                Type :
                <asp:DropDownList ID="drpType" runat="server">
                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                    <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Kit" Value="3"></asp:ListItem>
                     <asp:ListItem Text="STN" Value="4"></asp:ListItem>
                      
                </asp:DropDownList>
                <asp:Button ID="Button4" runat="server" Text="Show Report" />
                <asp:Button ID="btnexcel" runat="server" Text="Convert To Excel" Visible="false" />
            </td>
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL 
                LIMITED</span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">ABC Classification Report</span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                From Date:-                 <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                To Date:-
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 455px" colspan="2" align="left">
                Total Items
                <asp:Label ID="lbltotalitems" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" colspan="2">
                Annual Consumption value(Rs.) :
                <asp:Label ID="lblACRange" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock"  runat="server"
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
                            <asp:BoundColumn DataField="class" Visible="false" HeaderText="Class" FooterText="Total"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="Class" FooterText="Total">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkClass" runat="server" HeaderText="Class"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="item_count" HeaderText="Item Count" FooterText="100%"
                                ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="right">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="item_per" HeaderText="%" FooterText="100%" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="right"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ABC_value" HeaderText="AC Value(Rs.)" FooterText="100%"
                                ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="right">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ABC_per" HeaderText="%" FooterText="100%" ItemStyle-HorizontalAlign="right"
                                FooterStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                        <FooterStyle />
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="4" valign="top" style="height: 50px">
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>