<%@ Page Language="VB" AutoEventWireup="false" CodeFile="print_po.aspx.vb" Inherits="KDMT.print_po" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Contractor Wise Issue Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <script language="javascript" type="text/javascript">
 
	   function printpage()
		{
		window.print();
		}
		
		
function chkvendorname()
{


    var xmlHttp;
    try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();   
    }
    catch (e)
    {
    // Internet Explorer
    try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e)
    {
    try
    { 
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    catch (e)
    {
    alert("Your browser does not support AJAX!");
    return false;
    }
    }
    }
    xmlHttp.onreadystatechange=function()
    {
    if(xmlHttp.readyState==4)
    {
    resp = ""
    resp = xmlHttp.responseText;
    var ele1 = resp;

    if(ele1=="NO-SUCH-ITEM")
    {
    alert("No Such Vendor Present");
    document.getElementById ("txtvendor").focus();
    }
    }
    }
    
if (document.getElementById ("txtvendor").value != '')
    {
  
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkvendorname&vendorname="+document.getElementById ("txtvendor").value,true);
    xmlHttp.send(null);
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
    <div>

        <script src="<% =session("host") %>SpryAssets/SpryMenuBar.js" type="text/javascript"></script>

        <link href="<% =session("host") %>SpryAssets/SpryMenuBarVertical.css" rel="stylesheet"
            type="text/css">

        <script src="<% =Session("host") %>includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>

        <script language="javascript" src="<% =Session("host") %>includes/scripts/jquery.autocomplete.js"></script>

        <link rel="stylesheet" href="<% =Session("host") %>css/jquery.autocomplete2.css" />

        <script type="text/javascript">


function findValue(li) {
	if( li == null ) return alert("No match!");

	// if coming from an AJAX call, let's use the CityId as the value
	if( !!li.extra ) var sValue = li.extra[0];

	// otherwise, let's just display the value in the text box
	else var sValue = li.selectValue;

	//alert("The value you selected was: " + sValue);
}

function selectItem(li) {
	findValue(li);
}
    
//-->
        </script>

    </div>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MUNICIPAL TRANSPORT</span></strong>
            </td>
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
    <table align="center" cellspacing="0" border="1" style="width: 650px">
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
                General Manager
            </td>
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
        <table align="center" cellspacing="0" border="1" style="width: 650px">
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
    <table align="center" cellspacing="0" border="1" style="width: 650px">
        <tr class="ctrl">
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript">




    </script>

</body>
</html>
