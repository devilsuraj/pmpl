<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptvehiclewise.aspx.vb"
    Inherits="KDMT.rptvehiclewise" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Bus Wise Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript"> 
	   function printpage()
		{
		window.print();
		}
		
		function validate ()
		{
		if (document .getElementById("txtbusno").value == '')
		{
		alert ("Please Enter Bus No");
		document .getElementById ("txtbusno").focus();
		return false ;
		}
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
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 600px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px">
                <strong><span style="font-size: 11pt; color: black">Bus Wise Report</span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Enter Bus No
                <asp:TextBox ID="txtbusno" runat="server">
                </asp:TextBox>
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
            </td>
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 600px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">Pune Mahanagar Parivahan Mahamandal Limited </span></strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Bus Wise Report
                    <asp:Label ID="Label3" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                Fromdate:-
                <asp:Label ID="lblfrom" runat="server" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                ToDate:-
                <asp:Label ID="lbltodate" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Bus No :-
                <asp:Label ID="lblvechno" runat="server" Font-Bold="True" Font-Names="Verdana "></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="width: 700px; align: center; valign: middle;"
                        runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                            <asp:BoundColumn DataField="veh_no" HeaderText="Vech No"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ItemName" HeaderText="Item Name" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="Quantity" HeaderText="Quantity" ItemStyle-HorizontalAlign="right"></asp:BoundColumn>
                            <asp:BoundColumn DataField="worker" HeaderText="Worker Name"></asp:BoundColumn>
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="trans_date" HeaderText="Date"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid></div>
            </td>
        </tr>


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
