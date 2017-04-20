<%@ Page Language="VB" AutoEventWireup="false" CodeFile="purchase_request_report.aspx.vb"
    Inherits="KDMT.purchase_request_report" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchase Request Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>
    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>
    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
    <style type="text/css">
        .AutoCompleteExtenderClass
        {
            margin-top: 10px;
            padding: 0px;
            height: 300px;
            position: absolute;
            z-index: 999;
            color: Blue;
            overflow: scroll;
            cursor: pointer;
        }
        
        .AutoCompleteExtenderClass::-webkit-scrollbar
        {
            width: 1em;
        }
        
        .AutoCompleteExtenderClass::-webkit-scrollbar-track
        {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        }
        
        .AutoCompleteExtenderClass::-webkit-scrollbar-thumb
        {
            background-color: darkgrey;
            outline: 1px solid slategrey;
        }
        
        .style1
        {
            height: 27px;
        }
        
        .style2
        {
            width: 223px;
            height: 27px;
        }
        
        .style3
        {
            width: 97px;
            height: 27px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 700px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px" colspan="4">
                <strong><span style="font-size: 11pt; color: black">Purchase Request Report&nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:TextBox ID="txtfilename" runat="server" Width="250px"></asp:TextBox>
                <asp:AutoCompleteExtender ID="AutoCompleteExtender1" CompletionListCssClass="AutoCompleteExtenderClass"
                    runat="server" TargetControlID="txtfilename" MinimumPrefixLength="1" EnableCaching="true"
                    CompletionSetCount="1" CompletionInterval="1000" ServiceMethod="GetAutoCompletefilename"
                    UseContextKey="true">
                </asp:AutoCompleteExtender>
            </td>
            <td align="left">
                <asp:Button ID="btnshow" runat="server" Text="Show Report" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <%--<div id="divcry" runat ="server" >
        <CR:CrystalReportViewer ID="crst_item_master" runat="server" AutoDataBind="true" />
    </div>--%>
    <table id="Table1" align="center" border="1" style="width: 700px" runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Purchase Request Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left">
                <strong><span style="font-size: 14pt">File Number: </span>
                    <asp:Label ID="lblfileno" Text="" runat="server"></asp:Label>
                </strong>
            </td>
            <td align="left" colspan="2">
                <strong><span style="font-size: 14pt">File Name: </span>
                    <asp:Label ID="lblfilename" Text="" runat="server"></asp:Label>
                </strong>
            </td>
            <td align="left">
                <strong><span style="font-size: 14pt">Date: </span>
                    <asp:Label ID="lblDate" Text="" runat="server"></asp:Label>
                </strong>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center" style="height: 19px">
                <div align="center">
                    <asp:GridView ID="grdpurchase" Style="align: center; valign: middle;" runat="server"
                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderStyle="None" BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False"
                        Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" ForeColor="Black">
                        <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <%--<PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" mod="NumericPages" />--%>
                        <RowStyle ForeColor="#000066" Font-Size="12px" />
                        <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                            Font-Size="10pt" Font-Strikeout="False" Font-Names="Times New Roman" Font-Underline="False"
                            Wrap="False" />
                        <Columns>
                            <%--<asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex + 1%>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                            <asp:BoundField DataField="srno" HeaderText="Sr No"></asp:BoundField>
                            <asp:BoundField DataField="item_name" HeaderText="Item Name" HeaderStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="LFno" HeaderText="LF. No." ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundField>
                            <asp:BoundField DataField="subrack_no" HeaderText="Subrack No" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="part_no" HeaderText="Part No" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="balance" HeaderText="Balance" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="MLevel" HeaderText="Minimum Level" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="last_3_month" HeaderText="Last 3 Month" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="last_6_month" HeaderText="Last 6 Month" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="recentyear" HeaderText="" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="recentyear_minus_1" HeaderText="" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="recentyear_minus_2" HeaderText="" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="vendor_name" HeaderText="Vendor Name" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="po_date" HeaderText="PO Date" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="potype" HeaderText="PO Type" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="pen_qty" HeaderText="Pending Qty" ItemStyle-HorizontalAlign="right">
                            </asp:BoundField>
                            <asp:BoundField DataField="Followup" HeaderText="Followup" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="actiontaken" HeaderText="Action Taken" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <asp:BoundField DataField="qtytopurchase" HeaderText="Qty To Purchase" ItemStyle-HorizontalAlign="left">
                            </asp:BoundField>
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <%--<asp:BoundColumn DataField="vendor_name" HeaderText="Vendor"></asp:BoundColumn>--%>
                        </Columns>
                    </asp:GridView>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                &nbsp;
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
