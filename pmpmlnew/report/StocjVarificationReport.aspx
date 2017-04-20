<%@ Page Language="VB" AutoEventWireup="false" CodeFile="StocjVarificationReport.aspx.vb" Inherits="KDMT.StocjVarificationReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<html>
<head>
    <title>Stock Varification Report</title>
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
                <strong><span style="font-size: 16pt; color: black">Stock Varification Report</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Type Of Items
                <asp:DropDownList runat="server" ID="drpTypeOfItems">
                    <asp:ListItem Value="1" Text="Spare Part"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Hardware"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Kit Section"></asp:ListItem>
                    <asp:ListItem Value="4" Text="STN"></asp:ListItem>
                </asp:DropDownList>
                YEAR
                <asp:DropDownList ID="ddlfinancecalendar" runat="server">
                </asp:DropDownList>
                <asp:Button ID="btnShowreport" runat="server" Text="Show Report" />
                <asp:Button ID="Button1" runat="server" Text="Crystal Report" />
                 <asp:Button ID="btnexcel" runat="server" Text="Convert To Excel" Visible="false" />
            </td>
        </tr>
        </table>
    <div id="divcry" runat="server">
        <CR:CrystalReportViewer ID="cry_Itemsumvalrpt" runat="server" 
            AutoDataBind="true" />
    </div>
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
                <strong><span style="font-size: 14pt">Stock Varification Report</span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                Year:-
                <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
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
                             <asp:BoundColumn DataField="item_code" HeaderText="Item Code " HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item_name" HeaderText="Item Name " HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rack_no" HeaderText="LF No" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Part No" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            
                            <asp:BoundColumn DataField="balance" HeaderText="Bin Card Balance" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                <asp:BoundColumn DataField="" HeaderText="Excess" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                 <asp:BoundColumn DataField="" HeaderText="Shortage" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                 <asp:BoundColumn DataField="unit" HeaderText="Unit" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                
                                
                            <asp:BoundColumn DataField="RateRupees" HeaderText="Rate Rs" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                <asp:BoundColumn DataField="RatePaise" HeaderText="Rate Paise" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="AmountRupees" HeaderText="Actual Rs" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                <asp:BoundColumn DataField="AmountPaise" HeaderText="Actual Paise" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="" HeaderText="Remark" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="4" valign="top" style="height: 50px">
                <asp:Button ID="btnPrintPage" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="btnClose" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
