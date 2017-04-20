<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Workshop_inspReport.aspx.vb"
    Inherits="KDMT.Workshop_Workshop_inspReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Docking </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js">

    <script type="text/javascript" language="JavaScript" src="../Scripts/FusionCharts.js"></script>

    <script type="text/javascript" language="JavaScript">
     
    </script>

    <style>
        .chkliststyle input
        {
            float: left;
            width: 20%;
        }
        .chkliststyle label
        {
            float: left;
            width: 70%;
            text-align: left;
            padding-left: 3px;
            padding-right: 5px;
        }
        .style4
        {
            height: 31px;
        }
        #tbl1
        {
            width: 756px;
        }
        #Table1
        {
            width: 756px;
        }
        .style5
        {
            width: 756px;
        }
    </style>
</head>
<body onload="MM_preloadImages('../images/btn_h.gif');" style="text-align: left">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <form id="form1" runat="server">
    <div>
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                    <div class="orgmiddal">
                        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                        <div>
                            <table align="center" border="1" cellpadding="5" cellspacing="5" style="width: 100%">
                                <tr>
                                    <td class="text3" align="center" style="height: 22px">
                                        <strong><span style="font-size: 11pt; color: black">Half Docking Report &nbsp;</span></strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" class="style4">
                                        Inspection Report Date :-
                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table id="tbl1" runat="server">
                                            <tr>
                                                <td>
                                                    Kms :- 10000
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <div align="center">
                                                        <asp:DataGrid ID="grdinsp" Style="align: center; valign: middle;" runat="server"
                                                            Width="99%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                                            BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                                            Font-Size="11pt">
                                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                                            <ItemStyle ForeColor="#000066" />
                                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                            <Columns>
                                                                <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="lastinpdate" HeaderText="Last Inspection Date"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="lastinspno" HeaderText="Last Inspection No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="kms" HeaderText="Kms"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="curkms" HeaderText="Current Kms"></asp:BoundColumn>
                                                            </Columns>
                                                        </asp:DataGrid>
                                                    </div>
                                                </td>
                                            </tr>
                                <tr>
                                    <td align="left">
                                        <table id="Table1" runat="server">
                                            <tr>
                                                <td>
                                                    Kms :- 7500
                                                </td>
                                            </tr>
                                            <tr>
                                              <td align="center">
                                                    <div align="center" >
                                                        <asp:DataGrid ID="grdinsp1" Style="align: center; valign: middle;" runat="server"
                                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                                            BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                                            Font-Size="11pt">
                                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                                            <ItemStyle ForeColor="#000066" />
                                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                            <Columns>
                                                                <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="lastinpdate" HeaderText="Last Inspection Date"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="lastinspno" HeaderText="Last Inspection No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="kms" HeaderText="Kms"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="curkms" HeaderText="Current Kms"></asp:BoundColumn>
                                                            </Columns>
                                                        </asp:DataGrid>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="left">
                                        <table id="Table2" runat="server">
                                            <tr>
                                                <td class="style5">
                                                    Kms :- 3750
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="style5">
                                                    <div align="center" >
                                                        <asp:DataGrid ID="grdinsp2" Style="align: center; valign: middle;" runat="server"
                                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                                            BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                                            Font-Size="11pt">
                                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                                            <ItemStyle ForeColor="#000066" />
                                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                            <Columns>
                                                                <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="lastinpdate" HeaderText="Last Inspection Date"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="lastinspno" HeaderText="Last Inspection No"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="kms" HeaderText="Kms"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="curkms" HeaderText="Current Kms"></asp:BoundColumn>
                                                            </Columns>
                                                        </asp:DataGrid>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <asp:Button ID="Button1" runat="server" Text="Show" Style="height: 26px" Visible="False" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="orgbottam">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//
    </script>

</body>
</html>
