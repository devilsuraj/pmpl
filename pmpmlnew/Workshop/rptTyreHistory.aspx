<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptTyreHistory.aspx.vb" 
Inherits="KDMT.report_rptTyreHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Tyre Report</title>
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
     <a href="../report/allworkshopReport.aspx" class="ctrl">Back</a>
    <div>
    
            <table id= "Table2" align="center" border="1" cellpadding="0" cellspacing="0" style="width: 80%" class="ctrl">
                <tr>
                <td colspan="6" class="innerheading" align="center">
                                    <strong><span id="Span1">Tyre Report</span></strong></td>
                            </tr>
                            <tr >
                                <td align="right">
                                    From Date :
                                </td>
                                <td align="left">
                                  
                                    <BDP:BDPLite ID="dtfromdate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="right">
                                    To Date :
                                </td>
                                <td align="left">
                                
                                    <BDP:BDPLite ID="dttodate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                             <tr>
                                <td align="right">
                                    Bus No:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBusNo" runat="server" Width="140px"></asp:TextBox>
                                </td>
                                 <td align="right">
                                   Remove/Fitted
                                </td>
                                <td colspan="4" align="left">
                                    <asp:DropDownList ID="ddltype" runat="server" >
                                        <asp:ListItem Text="select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Remove" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Fitted" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                
                            </tr>
                            
                            <tr>
                                <td align="right">
                                    Part No:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtPartNo" runat="server" Width="140px"></asp:TextBox>
                                </td>
                                <td align="right">
                                    Part Company No:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCompanyNo" runat="server" Width="140px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Reason:
                                </td>
                                <td align="left">
                                   
                                    <asp:DropDownList ID="ddlReason" runat="server" >
                                        <asp:ListItem Text="select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Puncture" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Remold" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                
                                </td>
                                
                            </tr>
                           
                         <tr>
                                <td colspan="6" align="center">
                                    <label>
                                        <asp:Button ID="btnshow" runat="server" Text="Show" />
                                    </label>
                                </td>
                            </tr>
                            
                            </table>
  
   
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 969px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">Navi Mumbai Municipal Transport,Turbhe Depot </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td valign="top" align="center" colspan="4">
                <strong><span style="font-size: 16pt; color: black">Tyre Report</span></strong>
            </td>
        </tr>
        <%--  <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Brakedown Bus Report</span></strong>
            </td>
        </tr>--%>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                
                From Date:-
                <asp:Label ID="lblfromdate" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                To Date:-
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
    <%--    <tr align="center">
        <td colspan="3">
        Removed From Bus
        </td>
        <td colspan="3">
        Refit To Bus
        </td>
        </tr>--%>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdTyre" Style="align: center; valign: middle;" runat="server"
                        Width="98%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                              <asp:TemplateColumn HeaderText="Sr No">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                           <%--<asp:BoundColumn DataField="Bus_No" HeaderText="Bus No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Company_No" HeaderText="Tyre Manufacture No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_WS_No" HeaderText="NMMT No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Company" HeaderText="Make"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_size" HeaderText="Size"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Position_Name" HeaderText="Tyre Position"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Status" HeaderText="Part_Status" Visible=false></asp:BoundColumn>
                            <asp:BoundColumn DataField="Repair_Type" HeaderText="Puncture/Remold"></asp:BoundColumn>
                            <asp:BoundColumn DataField="PH_Date" HeaderText="Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Company_No1" HeaderText="Tyre Manufacture No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_WS_No1" HeaderText="NMMT No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Company1" HeaderText="Make"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Status1" HeaderText="Part_Status" Visible =false></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="trans_date" HeaderText="Date"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Bus_No" HeaderText="Bus No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Company_No" HeaderText="Tyre Manufacture No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_WS_No" HeaderText="NMMT No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Company" HeaderText="Make"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_size" HeaderText="Size"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Position_Name" HeaderText="Tyre Position"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_Status" HeaderText="Part_Status" ></asp:BoundColumn>
                            <asp:BoundColumn DataField="Repair_Type" HeaderText="Puncture/Remold"></asp:BoundColumn>
                            
                        </Columns>
                     
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                Aeon Software
            </td>
            <td>
            </td>
            <td style="width: 223px">
            </td>
            <td style="width: 97px">
                Workshop Dept
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4" valign="top" style="height: 25px">
                <asp:LinkButton ID="LinkButton1" runat="server">AEON  Software Private Limited</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4" valign="top" style="height: 50px" class="ctrl" >
                 <asp:Button ID="btnExcel" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print" class="ctrl"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" Visible="False" />
            </td>
        </tr>
    </table>
      </div>
    </form>
    

</body>
</html>
