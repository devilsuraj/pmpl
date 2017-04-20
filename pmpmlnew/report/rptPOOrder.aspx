<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptPOOrder.aspx.vb" Inherits="KDMT.rptPOOrder" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript"> 
//	   function printpage()
//		{
//		window.print();
//		}

function funPrintPo()
{
//window.open('../store/print_po.aspx.aspx'+GetHFValue(),'FeedbackWindow','width=960,height=640,scrollbars=yes,resizable=yes,status=yes')"
window.open('../store/print_po.aspx?PONO="+ document.getElementById ('txtPONo').value +"&POType=" + document.getElementById ('drbPoType').value + "&ItemType=" + document.getElementById ('drbType').value)";   


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
            width: 101px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        class="ctrl">
          <tr>
            <td valign="top" align="center" >
                <strong><span style="font-size: 16pt; color: black">PO Order Report</span></strong>
            </td>
        </tr>
        <tr>
        <td>
        <span >Po No</span>
        <asp:TextBox ID="txtPONo" runat ="server"  ></asp:TextBox>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span>Type </span>
       
           <asp:DropDownList ID="drpType" runat ="server" style="width: 140px" >
        <asp:ListItem Text ="Hardware" Value ="2" ></asp:ListItem>
        <asp:ListItem Text="SpareParts" Value="1" ></asp:ListItem>
        
        </asp:DropDownList>
        </td>
        </tr>
        <tr>
        <td >
        <span>PO Type</span>
        <asp:DropDownList ID="drbPoType" runat ="server" style="width: 140px" >
        <asp:ListItem Text ="RC" Value ="RC" ></asp:ListItem>
        <asp:ListItem Text="T&C" Value="T" ></asp:ListItem>
         <asp:ListItem Text="SP" Value="SP" ></asp:ListItem>
        
        </asp:DropDownList>
          
        </td>
        </tr>
         <tr>
            <td>
               <%-- From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
                To Date
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>--%>
                <%--<asp:Button ID="Button4" runat="server" Text="Show Report" />--%>
            </td>
           
        </tr>
        <tr>
        <td align="center">
            <%--Change Print Name to Show Order - Date 21/09/2012 
                <asp:Button ID="Button1" runat="server" Width="87px" 
                    Text="Print" OnClientClick ="funPrintPO();"></asp:Button>--%>

                <asp:Button ID="Button1" runat="server" Width="87px" 
                    Text="Show Order" OnClientClick ="funPrintPO();" OnClick="Showorder_Click"></asp:Button>             
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" 
                />
            </td>
        </tr>
        </table>
                 
            <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
  runat="server">
  
 <%-- <table id="Table3" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
        runat="server">--%>
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PMPML</span></strong></td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Swargate, Pune 411037&nbsp; </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
                Code No.<br />
                RECORD(Purchase Section Copy)
            </td>
            <td align="right" colspan="2" width="650px">
                Ph:2440417<br />
                &nbsp;Fax: 24445490
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
                TO,
            </td>
            <td align="right" colspan="2" width="650px">
                P.O.&nbsp; NO.&nbsp; :&nbsp; &nbsp;<asp:Label ID="lblPONoStr" runat="server" Font-Bold="true"></asp:Label>
                <asp:Label ID="lblPONo" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M/s. &nbsp;&nbsp;<asp:Label ID="lblVendorName" runat="server"
                    Font-Bold="true"></asp:Label>
            </td>
            <td align="right" colspan="2" width="650px">
                Date :
                <asp:Label ID="lblPoDate" runat="server" CssClass="lbtxt"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" class="style1" width="650px">
                &nbsp; &nbsp;
            </td>
            <td align="right" colspan="2" class="style1" width="650px">
                Our Ref. No.<asp:Label ID="lblORN" runat="server" Font-Bold="true"></asp:Label>
                Date<asp:Label ID="lblORD" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
                &nbsp; &nbsp;<asp:Label ID="lblAdd1" runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="right" colspan="2" width="650px">
                &nbsp;Your Ref. No.<asp:Label ID="lblYRN" runat="server" Font-Bold="true"></asp:Label>
                Date<asp:Label ID="lblYRD" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
                &nbsp; &nbsp;<asp:Label ID="lblAdd2" runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="center" colspan="2" width="650px">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                Please Supply the articles as per details ginven below on conditions state hereunder
                and overleaf as will as in accordance with the Terms and conditions in the acceptance
                of your tender
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
                    <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
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
                            <asp:TemplateColumn HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%></ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="Maker's identification or Code No.">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="item_name" HeaderText="NOMENCLATURE" ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false">
                                <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="item_Qty" HeaderText="Quantity" ItemStyle-HorizontalAlign="right">
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="item_rate" HeaderText="Rate" ItemStyle-HorizontalAlign="left">
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="Item_amt" HeaderText="Amount Rs"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4" style="font-weight: bold">
                INSTRUCTION
            </td>
        </tr>
    </table>
    <table align="center" cellspacing="0" border="1" style="width: 750px">
        <tr>
            <td align="left" colspan="3">
                <span style="font-size: 13px">(1) Bill and Challans should be sent in triplicate,</span>
            </td>
            <td align="left" colspan="1" rowspan="6" valign="top">
                <span style="font-size: 13px">This purchase is made under the
                    <br />
                    powers vested in me under the
                    <br />
                    B.P.M.C. Act, 1994 Chapter V,
                    <br />
                    Section(1)(i)(2) Exection
                    <br />
                    of contract waived</span>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3">
                <span style="font-size: 14px">(2) Payment will be made </span>
                <asp:Label ID="lblpayment" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3">
                <span style="font-size: 14px">(3) Discount</span>
                <asp:Label ID="lblDMA" runat="server" Font-Bold="true"></asp:Label>
                <span style="font-size: 14px">on Value of material /on total amount</span>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <span style="font-size: 14px">(4) Frighht will be borne by</span>
                <asp:Label ID="lblFright" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <span style="font-size: 14px">(5) Bank charges/commission will be borne by</span>
                <asp:Label ID="lblBCBB" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3">
                <span style="font-size: 14px">(6) Good to be sent by</span>
                <asp:Label ID="lblGSB" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3">
                <span style="font-size: 14px">(7) Delivert should be completed by</span>
                <asp:Label ID="lblDSC" runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="center" colspan="1">
                Store Officer</td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <span style="font-size: 14px">(8) Validity Period</span>
                <asp:Label ID="lblVP" runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="center" colspan="2">
                Pune Municipal Transport
            </td>
        </tr>
        <table align="center" cellspacing="0" border="1" style="width: 750px">
            <tr>
                <td align="left" style="width: 50%" rowspan="2" valign="top">
                    <span style="font-size: 14px">Total Commitment Rs.</span>
                    <asp:Label ID="lbltotal" runat="server" Font-Bold="true"></asp:Label>
                    Yr.<asp:Label ID="lblYear" runat="server" Font-Bold="true"></asp:Label>
                </td>
                <td align="left" style="width: 50%">
                    <span style="font-size: 14px">Rate sanctioned by TC/Transport Manager</span>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 50%">
                    <span style="font-size: 14px">Res.No.</span>
                    <asp:Label ID="lblRNO" runat="server" Font-Bold="true"></asp:Label>Dt&nbsp; :&nbsp;
                    <asp:Label ID="lblDTTM" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" rowspan="2" valign="top" style="width: 50%">
                    <span style="font-size: 14px">Entd in B/C Regr</span>
                    <asp:Label ID="lblBCR" runat="server" Font-Bold="true"></asp:Label>Sr.No.<asp:Label
                        ID="lblSN" runat="server" Font-Bold="true"></asp:Label>
                </td>
                <td align="left" style="width: 50%">
                    <span style="font-size: 14px">Purchase Authorised by</span>
                    <asp:Label ID="lblPAB" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 50%">
                    <span style="font-size: 14px">Budegt Account Hd</span>
                    <asp:Label ID="lblBAH" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" rowspan="2" valign="top" style="width: 50%">
                    <span style="font-size: 14px">Audited by</span>
                    <asp:Label ID="lblAuditedBy" runat="server" Font-Bold="true"></asp:Label>CL:<asp:Label
                        ID="lblCL" runat="server" Font-Bold="true"></asp:Label>DT:<asp:Label ID="lblDT" runat="server"
                            Font-Bold="true"></asp:Label>
                </td>
                <td align="left" style="width: 50%">
                    <span style="font-size: 14px">Prepared by</span>
                    <asp:Label ID="lblPB" runat="server" Font-Bold="true"></asp:Label>
                    <span style="font-size: 14px">Checked by</span>
                    <asp:Label ID="lblCB" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 50%">
                    <span style="font-size: 14px">Indent Ref No .</span>
                    <asp:Label ID="lblInReNo" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" rowspan="2" valign="top" style="width: 50%">
                    <span style="font-size: 14px">Audited Officer</span>
                    <asp:Label ID="lblauditoff" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
        </table>
    </table>
    <table align="center" cellspacing="0" border="1" style="width: 750px">
        <tr class="ctrl">
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button4" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
  
        <%--<tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED</span>
                </strong>
            </td>
        </tr>--%>
        <%--<tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">PO Order Report</span></strong>
            </td>
        </tr>--%>
        <%--<tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdPOOrder" Style="align: center; valign: middle;" runat="server"
                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                            <asp:BoundColumn DataField="item_name" HeaderText="Item" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_No" HeaderText="Part_No" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item_qty" HeaderText="Item_Qty " ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-Wrap="false"></asp:BoundColumn>
                                   <asp:BoundColumn DataField="item_rate" HeaderText="Item_Rate" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="item_amt" HeaderText="Item_amt" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                           
                            
                           
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>--%>
        
        
        <%-- %><tr class="ctrl">   
            <td  align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
              <%--  <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                </td>
        </tr>
        </table>--%>
    </div>
    </form>
</body>
</html>
