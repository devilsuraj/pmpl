<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Brakedown_List.aspx.vb" Inherits="KDMT.Brakedown_List" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Breakdown Bus List</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
    </script>

    <script language="javascript"> 
	   function printpage()
		{
		window.print();
		}
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <a href="../report/allworkshopreport.aspx" class="ctrl">Back</a>
    <div>
       <%-- <uc:header ID="Header1" runat="server" />--%>
        <div id="middal">
            <%--<uc:leftmenu ID="Leftmenu1" runat="server" />--%>
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Breakdown Bus Report</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    From Date:
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dtformDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="right">
                                    To Date:
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Bus No:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtbusno" runat="server"></asp:TextBox>
                                </td>
                                <td align="right">
                                    Bus Type:
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlbustype" runat="server">
                                        <asp:ListItem Text="select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="CNG-JnNRUM" Value="CNG-JnNRUM"></asp:ListItem>
                                        <asp:ListItem Text="CNG-NON-JnNRUM" Value="CNG-NON-JnNRUM"></asp:ListItem>
                                        <asp:ListItem Text="CONVERTED CNG" Value="Converted CNG"></asp:ListItem>
                                         <asp:ListItem Text="ASUDGAON" Value="Asudgaon"></asp:ListItem>
                                         <asp:ListItem Text="VOLVO" Value="VOLVO"></asp:ListItem>
                                         <asp:ListItem Text="Tata Mini Bus" Value="Tata Mini Bus"></asp:ListItem>
                                          <asp:ListItem Text="Tata BS III" Value="Tata BS III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                            <td align="right">
                                    Shift:
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlshift" runat="server">
                                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="I" Text="I"></asp:ListItem>
                                        <asp:ListItem Value="II" Text="II"></asp:ListItem>
                                        <asp:ListItem Value="III" Text="III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td></td><td></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <label>
                                        <asp:Button ID="btnshow" runat="server" Text="Show" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    Breakdown Bus Report
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <div align="center">
                                        <asp:DataGrid ID="grdjoclist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" ShowFooter="False" Font-Bold="False" Font-Italic="False"
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
                                                <asp:BoundColumn DataField="JOC_id" HeaderText="Job No" Visible="false"></asp:BoundColumn> 
                                                <asp:BoundColumn DataField="jobdate" HeaderText="Job Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="routeno" HeaderText="Route No" ItemStyle-HorizontalAlign="right"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="drvname" HeaderText="Driver Code" ItemStyle-HorizontalAlign="right"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="place" HeaderText="Place" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>

                                                <asp:BoundColumn DataField="deffect_decr" HeaderText="Deffect" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="shift" HeaderText="Shift"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffecttime" HeaderText="Deffect Time" Visible="False">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="workshoptime" HeaderText="Informed Time in Workshop"></asp:BoundColumn>
                                                
                                                <asp:BoundColumn DataField="brakedownclosetime" HeaderText="Job Closed Time in Workshop"></asp:BoundColumn>
                                                 <asp:BoundColumn DataField="taskdone" HeaderText="Work Done"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="inspno" HeaderText="Last Inspection"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="Name" HeaderText="Attended By"></asp:BoundColumn>
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="print" Text="Print" Visible="false">
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
