<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptprojection.aspx.vb" Inherits="Kdmt.rptprojection" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<html>
<head>
    <title>PROJECTION Report</title>
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
                <strong><span style="font-size: 11pt; color: black">Projection Report &nbsp;</span></strong>
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
                    <asp:ListItem Text="STN" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                Moving Type :
            </td>
            <td>
                <asp:DropDownList ID="ddlmoving" runat="server">
                    <asp:ListItem Text="ALL" Value=""></asp:ListItem>
                    <asp:ListItem Text="Fast Moving" Value="F"></asp:ListItem>
                    <asp:ListItem Text="Medium Moving" Value="M"></asp:ListItem>
                    <asp:ListItem Text="Slow Moving" Value="S"></asp:ListItem>
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
        <tr>
            <td>
                Level
            </td>
            <td>
                <asp:DropDownList ID="ddlbelow" runat="server">
                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Stock  Below Min Level " Value="1"></asp:ListItem>
                    <asp:ListItem Text="Stock goes Below Min Level After 15 Days." Value="2"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                From Date
            </td>
            <td>
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnshow" runat="server" Text="Show" />
                <asp:Button ID="btncry" runat="server" Text="Crystal Report " />
            </td>
        </tr>
    </table>
    <div id="divcry" runat="server">
        <CR:CrystalReportViewer ID="crst_item_move" runat="server" AutoDataBind="true" />
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
                <strong><span style="font-size: 14pt">Projection Report </span></strong>
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
                <asp:Label ID="lbllevel" runat="server"></asp:Label>
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
        <tr visible="false">
            <td align="left" style="height: 19px" colspan="4">
                Total :
                <asp:Label ID="lbltotal" runat="server" Font-Bold="True"></asp:Label>
                Class A :
                <asp:Label ID="lbla" runat="server" Font-Bold="True"></asp:Label>
                Class B :
                <asp:Label ID="lblb" runat="server" Font-Bold="True"></asp:Label>
                Class C :
                <asp:Label ID="lblc" runat="server" Font-Bold="True"></asp:Label>
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
                            <asp:BoundColumn DataField="cat" HeaderText="Category(A,B,C)" HeaderStyle-HorizontalAlign="center"
                                ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="movetype" HeaderText="Move Type" HeaderStyle-HorizontalAlign="center"
                                ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Item_name" HeaderText="Nomenclature" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lf_no" HeaderText="L/F_No " ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Bin_No" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Part_No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Actual_min" HeaderText="Min Level" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="current_stock" HeaderText="Balance" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="expect_15stock" HeaderText="Balance After 15" ItemStyle-HorizontalAlign="right"
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
