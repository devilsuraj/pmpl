<%@ Page Language="VB" AutoEventWireup="false"  CodeFile="rptcontractorwise.aspx.vb" Inherits="KDMT.rptcontractorwise" %>

<%@ Register Assembly="CrystalDecisions.Web" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>




<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Contractor Wise Issue Report</title>
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
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px">
                <strong><span style="font-size: 11pt; color: black"> Depot Wise Issued Report &nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Select Depot
                <asp:DropDownList ID="DropDownList1" runat="server" Width="300px">
                </asp:DropDownList>
            
                Type Of Items
                <asp:DropDownList runat="server" ID="drpTypeOfItems">
                      <asp:ListItem Text="sparepart" Value="1"></asp:ListItem>
                    <asp:ListItem Text="hardware" Value="2"></asp:ListItem>
                   
                    <asp:ListItem Text="stn" Value="4"></asp:ListItem>
                   
                    <asp:ListItem Text="Kit" Value="3"></asp:ListItem>
                </asp:DropDownList>
                 <asp:DropDownList runat="server" ID="DropDownList2">
                   <asp:ListItem Text="All" Value="1"></asp:ListItem>  
                     <asp:ListItem Text="Only Hardware" Value="0"></asp:ListItem>                 
                    <asp:ListItem Text="Paint" Value="paint"></asp:ListItem>
                    <asp:ListItem Text="New Tyre" Value="tyre"></asp:ListItem>
                    <asp:ListItem Text="Battery" Value="battery"></asp:ListItem>
                    <asp:ListItem Text="Tool" Value="tool"></asp:ListItem>
                   
                </asp:DropDownList>
                </td>
        </tr>
        <tr>
            <td>
                From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
                To Date
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
                <asp:Button ID="btnshow" runat="server" Text="Show" />
                <asp:Button ID="Button4" runat="server" Text="Convert to Excel" />
                <asp:Button ID="crystal" runat="server" Text="Crystal Report" />
                </td>
        </tr>
    </table>
    <div id="divcrt" runat ="server" >
      <CR:CrystalReportViewer ID="item_view_contract" runat="server" 
            AutoDataBind="true" EnableDatabaseLogonPrompt="False" Height="50px" 
            ReuseParameterValuesOnRefresh="True" Width="350px"  />
            

    </div>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL 
                LIMITED </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Depot Wise Issued Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <asp:Label ID="lblcontractor" runat="server"></asp:Label>
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
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" runat="server"
                        Width="650px" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                            <asp:BoundColumn DataField="veh_no" HeaderText="Vech No" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="itemname" HeaderText="Item " ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Part No" ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Quantity" HeaderText="Quantity" ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                             <asp:BoundColumn DataField="rate" HeaderText="Rate" ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                              <asp:BoundColumn DataField="amount" HeaderText="Amount" ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                              
                            <asp:BoundColumn DataField="worker" HeaderText="Employee" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="trans_date" HeaderText="Date" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
 
 
        <tr class="ctrl">
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
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
