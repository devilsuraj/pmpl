<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Deptwisedeffectrpt.aspx.vb" Inherits="KDMT.Workshop_Deptwisedeffectrpt" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Deffect Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>
    <script language="javascript" type="text/javascript">
</script>

</head>
<body>
    <form id="form1" runat="server">
    <a href="../report/allworkshopReport.aspx" class="ctrl">Back</a>
    <div>
        <%--<uc:header ID="Header1" runat="server" />--%>
        <div id="middal">
           <%-- <uc:leftmenu ID="Leftmenu1" runat="server" />--%>
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading" 
                                    style="font-weight: bold; font-size: large">
                                    <span id="Label3">Section wise Deffect Report</span>
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
                        <td align="right">
                                    Section :
                                </td>
                                <td align="left" >
                                   <asp:DropDownList ID="ddldeffect" runat="server" Width="155px" AutoPostBack="false"
                                        TabIndex="1" ForeColor="Black">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    Status :
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlstatus" runat="server">
                                        <asp:ListItem Value="00">Select</asp:ListItem>
                                        <asp:ListItem Value="0">Open</asp:ListItem>
                                        <asp:ListItem Value="1">Close</asp:ListItem>
                                    </asp:DropDownList>
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
                                <td colspan="4" align="center" style="font-weight: bold; font-size: large">
                                    Section wise Deffect Report</td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <div align="center">
                                        <asp:DataGrid ID="grdjoclist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False"
                                            Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                            ForeColor="Black" Font-Size="11pt">
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
                                                <asp:BoundColumn DataField="jobdate" HeaderText="Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect_decr" HeaderText="Section" ></asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffect" HeaderText="Deffect" ></asp:BoundColumn>
                                                <asp:BoundColumn DataField="locid" HeaderText="Status"></asp:BoundColumn>
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="print" Text="Print" Visible ="false" >
                                                </asp:ButtonColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="Button1" runat="server" Width="87px" Text="Print"></asp:Button>
                                    <asp:Button ID="btnExcel" runat="server" Text="Convert to Excel" />
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
