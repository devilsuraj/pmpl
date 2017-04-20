<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_workshopreport.aspx.vb"
    Inherits="KDMT.Workshop_rpt_workshopreport" EnableEventValidation="true" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Workshop Report</title>
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
    <style type="text/css">
        .style1
        {
            height: 15px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="../workshop/workshopreport.aspx" class="ctrl">Back</a>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="2" style="border-color: #000000;
        border-style: solid; width: 750px; font-family: 'Times New Roman', Times, serif;
        font-size: 15px;" runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">Navi Mumbai Municipal Transport,Turbhe Depo </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">&nbsp;Job Card Report</span></strong>
            </td>
        </tr>
        <%-- <tr>
            <td align="left" style="height: 19px" colspan="2">
                <asp:Label ID="lblshow" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                :-
                <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px; font-weight: bold;" colspan="2">
                To Date:-
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px; font-weight: bold;" colspan="4">
                Shift InCharge :-
                <asp:Label ID="Label2" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
        </tr>--%>
        <tr>
            <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
                <table width="100%" border="0" align="center" cellpadding="5" cellspacing="5" style="color: black;">
                    <tr>
                        <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                            border-left-style: none;" align="center">
                            <table id="Table3" border="0" align="center" cellpadding="5" cellspacing="5" style="padding: 10px;
                                color: black; width: 100%;">
                                <tr style="border: solid;">
                                    <td align="left" colspan="4" style="font-weight: bold; font-size: large; text-decoration: underline;">
                                        Job Card Details :
                                    </td>
                                </tr>
                                <tr style="border: solid;">
                                    <td align="right" width="100px">
                                        Job Card No :
                                    </td>
                                    <td style="font-weight: bold;" align="left" class="style1">
                                        <asp:Label ID="lbljocno" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Bus No. :
                                    </td>
                                    <td align="left" style="font-weight: bold;" width="130px">
                                        <asp:Label ID="lblbusno" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Model :
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <asp:Label ID="lblmodel" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Chassis :
                                    </td>
                                    <td align="left" style="font-weight: bold;">
                                        <asp:Label ID="lblchassis" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        KMS. :
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <asp:Label ID="lblkms" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Engine :
                                    </td>
                                    <td align="left" style="font-weight: bold;">
                                        <asp:Label ID="lblengine" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Job Date :
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <asp:Label ID="lbljobdate" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Job Time :
                                    </td>
                                    <td align="left" style="font-weight: bold;">
                                        <asp:Label ID="lbljobtime" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                  <tr>
                                    <td align="right">
                                        Job Close Date :
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <asp:Label ID="lblclosedate" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Job Close Time :
                                    </td>
                                    <td align="left" style="font-weight: bold;">
                                        <asp:Label ID="lblclosebtime" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Driver Name :
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <asp:Label ID="lbldrv" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <%-- Deffect Type:--%>
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <%-- <asp:Label ID="lbldeffect" runat="server" Text="Label"></asp:Label>--%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
                <table id="tbldeffect" runat="server" width="100%" border="0" align="center" cellpadding="5"
                    cellspacing="5" style="color: black;">
                    <tr>
                        <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                            border-left-style: none;" align="center">
                            <table id="Table5" border="0" align="center" cellpadding="5" cellspacing="5" style="padding: 10px;
                                color: black; width: 100%;">
                                <tr style="border: solid;">
                                    <td align="left" colspan="4" class="style1" style="font-weight: bold; font-size: large;
                                        text-decoration: underline;">
                                        Brakedown Details :
                                    </td>
                                </tr>
                                <%-- <tr style="border: solid;">
                                    <td align="center" width="100%" colspan="4">
                                      <table>--%>
                                <tr id="first" visible="false">
                                    <td align="right">
                                        Route No:
                                    </td>
                                    <td align="left" style="font-weight: bold;" class="style1">
                                        <asp:Label ID="txtrt" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Place :
                                    </td>
                                    <td align="left" class="style2" style="font-weight: bold;">
                                        <asp:Label ID="txtplc" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Deffect Time:
                                    </td>
                                    <td align="left" class="style1" style="font-weight: bold;">
                                        <asp:Label ID="txtdt" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Workshop Time :
                                    </td>
                                    <td align="left" class="style2" style="font-weight: bold;">
                                        <asp:Label ID="txtwt" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Reason :
                                    </td>
                                    <td align="left" class="style2" style="font-weight: bold;">
                                        <asp:Label ID="txtarreason" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td align="right">
                                        Supervisor Name :
                                    </td>
                                    <td align="left" class="style2" style="font-weight: bold;">
                                        <asp:Label ID="txtname" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <%-- </table>
                                    </td>
                                </tr>--%>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
                <table width="100%" border="0" align="center" cellpadding="5" cellspacing="5" style="color: black;">
                    <tr>
                        <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                            border-left-style: none;" align="center">
                            <table id="Table2" border="0" align="center" cellpadding="5" cellspacing="5" style="padding: 10px;
                                color: black; width: 100%;">
                                <tr style="border: solid;">
                                    <td align="left" colspan="4" class="style1" style="font-weight: bold; font-size: large;
                                        text-decoration: underline;">
                                        Inspection with Assign Details :
                                    </td>
                                </tr>
                                <tr style="border: solid;" valign="top">
                                    <td align="left" colspan="4" style="font-size: large;" class="style1">
                                        <strong>Inspection Note :</strong>
                                        <%--<asp:TextBox ID="txtinspectionnote" runat="server" Width="350px" Height="70px"></asp:TextBox>--%>
                                        <asp:Label ID="txtinspectionnote" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="border: solid;">
                                    <td align="center" width="100%" colspan="4">
                                        <asp:DataGrid ID="grddeffectlist" Style="align: center; valign: middle;" runat="server"
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
                                                <asp:BoundColumn DataField="deffect_decr" HeaderText="Deffect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffect" HeaderText="Sub Deffect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="inspnote" HeaderText="Inspection Note" Visible="False">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="Name" HeaderText="Assign Mechinc"></asp:BoundColumn>
                                                 <asp:BoundColumn DataField="taskdone" HeaderText="Task Done"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deptid" HeaderText="Assign Note" Visible="False"></asp:BoundColumn>
                                                <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
                <table width="100%" border="0" align="center" cellpadding="5" cellspacing="5" style="color: black;">
                    <tr>
                        <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                            border-left-style: none;" align="center">
                            <table id="Table4" border="0" align="center" cellpadding="5" cellspacing="5" style="padding: 10px;
                                color: black; width: 100%;">
                                <tr style="border: solid;">
                                    <td align="left" colspan="4" style="font-weight: bold; font-size: large; text-decoration: underline;"
                                        class="style1">
                                        Issued Items :
                                    </td>
                                </tr>
                                <%--<tr style="border: solid;">
                                    <td align="center" width="100%" colspan="4">
                                        <asp:DataGrid ID="grdindent" Style="align: center; valign: middle;" runat="server"
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
                                                <asp:BoundColumn DataField="Item_name" HeaderText="Item Name"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="part_NO" HeaderText="Part No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="total_qty" HeaderText="Qty"></asp:BoundColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>--%>
                                <tr style="border: solid;">
                                    <td align="center" width="100%" colspan="4">
                                        <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
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
                                                <asp:BoundColumn DataField="refno" HeaderText="Indent No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="part_no" HeaderText="Part No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="total_qty" HeaderText="Total Qty"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="wname" HeaderText="Worker Name"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="approvedby" HeaderText="Approved By"></asp:BoundColumn>
                                                <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                            </Columns>
                                        </asp:DataGrid>
                                </tr>
                        </td>
                </table>
            </td>
        </tr>
    </table>
    </td> </tr>
    <%-- <tr>
            <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
                <table width="100%" border="0" align="center" cellpadding="5" cellspacing="5" style="color: black;">
                    <tr>
                        <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                            border-left-style: none;" align="center">
                            <table id="Table5" border="0" align="center" cellpadding="5" cellspacing="5" style="padding: 10px;
                                color: black; width: 100%;">
                                <tr style="border: solid;">
                                    <td align="left" colspan="4" style="font-weight: bold; font-size: large; text-decoration: underline;">
                                        Indent For Store :
                                    </td>
                                </tr>
                                <tr style="border: solid;">
                                    <td align="center" width="100%" colspan="4">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>--%>
    <tr>
        <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="5" style="color: black;">
                <tr>
                    <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                        border-left-style: none;" align="center" valign="top">
                        <table id="Table6" border="0" align="center" cellpadding="5" cellspacing="5" style="padding: 10px;
                            color: black; width: 100%;">
                            <tr style="border: solid;">
                                <td align="left" colspan="3" class="style1" style="font-weight: bold; font-size: large;
                                    text-decoration: underline;">
                                    <%--Total No of Days Move Job :--%>
                                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr style="border: solid;">
                                <td align="left" colspan="1" style="font-size: large;" valign="top" class="style1">
                                    <strong>Note :</strong>
                                    <%-- <asp:TextBox ID="txtnote" runat="server" Width="350px" Height="50px"></asp:TextBox>--%>
                                    <asp:Label ID="txtnote" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <%-- <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                   
                </div>
            </td>
        </tr>--%>
    <tr>
        <td align="center" style="border-width: thin; border-style: solid;" colspan="4">
            Workshop Dept
        </td>
        <%--<td align="center" style="width: 40px; border-width: thin; border-style: solid;"
                colspan="4">
                Workshop Dept
            </td>--%>
    </tr>
    <tr>
        <td align="center" colspan="4" valign="top" style="height: 20px">
            <asp:LinkButton ID="LinkButton1" runat="server">AEON  Software Private Limited</asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td align="center" colspan="4" valign="top" style="height: 20px">
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
