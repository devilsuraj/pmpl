<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptABCmonthly.aspx.vb" Inherits="KDMT.report_rptABCmonthly" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ABC Classification Report</title>
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
    <a href="ABC_Analysis_monthly.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        class="ctrl">
        <tr>
            <td valign="top" align="center">
                <strong><span style="font-size: 16pt; color: black">ABC Classification Report</span></strong>
            </td>
        </tr>
        <tr style="display: none">
            <td>
                From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
                To Date
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
                <asp:Button ID="Button4" runat="server" Text="Show Report" />
            </td>
            <td style="width: 73px">
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED</span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="left">
                Category :-
                <asp:Label ID="Lbldrbtype" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td style="width: 65px" align="center">
                Class :-
                <asp:Label ID="lblClass" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" colspan="2">
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                From Date:-
                <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                To Date:-
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
          
            <td style="width: 455px"  colspan="2" align="left">
                Total Items :
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
                    <asp:DataGrid ID="grdstock" runat="server"
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
                           <%-- <asp:BoundColumn DataField="Class" Visible="false" HeaderText="Class" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>  --%>
                           <%--  <asp:BoundColumn DataField="itemname" FooterText="Total" HeaderText="Item Name"
                                FooterStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-Wrap="false"></asp:BoundColumn>  --%>
                            <asp:BoundColumn DataField="itemname" HeaderText="Item Name" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lfno" HeaderText="LF No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="binno" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="partno" HeaderText="Part No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="openbalance" HeaderText="Opening Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="right"></asp:BoundColumn>
                            <asp:BoundColumn DataField="receivebalance" HeaderText="Received Qty" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="right"></asp:BoundColumn>
                            <asp:BoundColumn DataField="issueqty" HeaderText="Issued Qty" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                           <asp:BoundColumn DataField="itemrate" HeaderText="Rate" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                           <asp:BoundColumn DataField="abccon1" HeaderText="Consumption Value" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="balance" HeaderText="Balance" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>  
                           <asp:BoundColumn DataField="po_no" HeaderText="PO NO" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>  
                          <asp:BoundColumn DataField="po_date" HeaderText="PO Date" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>  
                                <asp:BoundColumn DataField="month_cons" HeaderText="Monthly Consumption" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>  
                        </Columns>
                        <FooterStyle />
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr class="ctrl">
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
