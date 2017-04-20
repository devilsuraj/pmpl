<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IRR_Register.aspx.vb" Inherits="KDMT.IRR_Register" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Repair/Replacement Unit  Item </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">function btnShow_onclick() {

}

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
                                    <span id="Label3">Repair/Replacement Unit  Item</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Job Card No.:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtjobno" runat="server" Width="140px" 
                                        meta:resourcekey="txtjobnoResource1" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td align="right">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    From Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dtformDate" runat="server" TextBoxStyle-Width="100px" 
                                        meta:resourcekey="dtformDateResource1" style="display: inline;">
<TextBoxStyle Width="100px"></TextBoxStyle>
                                    </BDP:BDPLite>
                                </td>
                                <td align="right">
                                    To Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px" 
                                        meta:resourcekey="dttoDateResource1" style="display: inline;">
<TextBoxStyle Width="100px"></TextBoxStyle>
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Supervisor :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtsupervisor" runat="server" Width="140px" 
                                        meta:resourcekey="txtsupervisorResource1"></asp:TextBox>
                                </td>
                                <td align="right">
                                    Bus No.
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBusNo" runat="server" Width="140px" 
                                        meta:resourcekey="txtBusNoResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <%--<tr>
                                <td align="right">
                                    Item Name :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="TextBox1" runat="server" Width="140px" 
                                        meta:resourcekey="TextBox1Resource1"></asp:TextBox>
                                </td>
                                <td align="right">
                                    Item No.
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox2" runat="server" Width="140px" 
                                        meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                                </td>
                            </tr>--%>
                             <tr>
                            <td align="right">
                                Deffect Unit Name:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtitemreplace" runat="server" Width="140px"></asp:TextBox>
                            </td>
                            <td align="right">
                                Deffect Unit No :
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtpartno" runat="server" Width="140px"></asp:TextBox>
                            </td>
                        </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <label>
                                        <asp:Button ID="btnshow" runat="server" Text="Show" 
                                        meta:resourcekey="btnshowResource1" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    Repair / Replacement Item Register
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <div align="center">
                                        <asp:DataGrid ID="grdirrlist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                            Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                            ForeColor="Black" Font-Size="11pt" meta:resourcekey="grdirrlistResource1">
                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                            <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="irrid" HeaderText="irrid" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="irrno" HeaderText="IRR No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobdate" HeaderText="Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jocid" HeaderText="jocid" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="joccode" HeaderText="Job Card No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="supervisor" HeaderText="Supervisor"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="Mechanicname" HeaderText="Mechanic Name"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No."></asp:BoundColumn>
                                                <asp:BoundColumn DataField="itemname" HeaderText="Item Name"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="flag" HeaderText="flag" Visible="false"></asp:BoundColumn>
                                                <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="select" Text="Fit"></asp:ButtonColumn>--%>
                                                <asp:TemplateColumn >
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hpfit" runat="server" ForeColor="#0066FF" 
                                                        meta:resourcekey="hpfitResource1">Fit</asp:HyperLink>
                                                </ItemTemplate>
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                 <asp:HyperLink ID="hpshow" runat="server" ForeColor="#0066FF" 
                                                        meta:resourcekey="hpshowResource1">Show</asp:HyperLink>
                                                </ItemTemplate>
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                               
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
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
