<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Bus_seek.aspx.vb" Inherits="KDMT.Bus_seek" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sick Bus</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Sick Bus Report</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    From Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dtformDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="right">
                                    To Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <label>
                                        <asp:Button ID="btnshow" runat="server" Text="Show" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Sick Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="BDPLiteseek" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="right">
                                    Sick Shift :
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlshift" runat="server">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="I"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="II"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    Bus Sick Report
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <div align="center">
                                        <asp:DataGrid ID="grdjoclist" Style="align: center; valign: middle;" runat="server"
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
                                                <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No."></asp:BoundColumn>
                                                <asp:BoundColumn DataField="date" HeaderText="Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="defect" HeaderText="Deffect" Visible="False"></asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Note">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtnote" runat="server" Width="280px" Text='<%# DataBinder.Eval(Container,"DataItem.note") %>'></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Seek Flag">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="ch1" runat="server" Checked='<%# DataBinder.Eval(Container,"DataItem.seekflag") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="Save" Text="Save"></asp:ButtonColumn>
                                                <asp:BoundColumn DataField="JOC_id" HeaderText="JOC_id" Visible="False"></asp:BoundColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4" valign="top" class="style3">
                                    <asp:Button ID="Button3" runat="server" Text="Convert to Excel" Visible="False" />
                                    <asp:Button ID="Button1" runat="server" Width="87px" Text="Print"></asp:Button>
                                    <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" Visible="False" />
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
</body>
</html>
