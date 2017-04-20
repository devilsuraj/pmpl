<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_ClaimRejection.aspx.vb" Inherits="KDMT.rpt_ClaimRejection" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title>DRB Receive Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript"> 
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
        .Columnwidth
        {
            width: 100px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    &nbsp;<a href="../store/Authenticate_receive.aspx" class="ctrl">Back</a>
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

        <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 650px"
            runat="server" class="ctrl">
            <tr>
                <td class="text3" align="center" style="height: 22px">
                    <strong><span style="font-size: 11pt; color: black">RECEIPT CLAIM REPORT</span></strong>
                </td>
            </tr>
            <tr visible="true">
                <td>
                    Vendor Name
                    <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                        runat="server" />&nbsp; Challan No
                    <asp:TextBox ID="txtchallanno" runat="server"></asp:TextBox>
                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                </td>
            </tr>
            <tr visible="true">
                <td>
                    &nbsp;</td>
            </tr>
          <%--  <tr>
                <td>
                    &nbsp;</td>
            </tr>--%>
        </table>
    </div>
    <table id="Table1" align="center" border="1" style="width: 100%" runat="server">
        <tr>
            <td colspan="3">
            </td>
            <td align="center" colspan="2">
                <strong><span style="font-size: 14pt">
                    <asp:Label ID="lbldrbdate" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5">
                <strong><span style="font-size: 14pt">RECEIPT CLAIM REPORT
                    <asp:Label ID="Label3" runat="server" Width="168px" Text="" Font-Bold="True"></asp:Label>
                </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="4">
                Supplier's Name & Address:-
                <asp:Label ID="lblSupName" Font-Underline="true" Style='font-family: Times New Roman;
                    font-size: 12px;' runat="server" Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px" visible="false">
                Serial No.
                <asp:Label ID="lblSerNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                Claim No.:-
                <asp:Label ID="lblBlNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Challan No.:-
                <asp:Label ID="lblChNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Date:-
                <asp:Label ID="lblChDT" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                &nbsp;</td>
            <td align="left" style="height: 19px">
                PMPML Bill No.
                <asp:Label ID="lblPMPLNo" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                Claim
                Date :-
                <asp:Label ID="lblBlDT" Style='font-family: Times New Roman; font-size: 12px;' runat="server"
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Order No.:-
                <asp:Label ID="lblOrdNo" runat="server" Style='font-family: Times New Roman; font-size: 14px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Date :-
                <asp:Label ID="lblOrdDT" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Rec No.:-
                <asp:Label ID="lblRecNo" runat="server" Style='font-family: Times New Roman; font-size: 14px;'
                    Font-Bold="True"></asp:Label>
            </td>
            <td align="left" style="height: 19px">
                Date :-
                <asp:Label ID="lblRecDate" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td align="center" colspan="4">
                <asp:Label ID="Label2" runat="server" Style='font-family: Times New Roman; font-size: 12px;'
                    Font-Bold="True" Font-Names="Verdana" Width="224px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="5" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="align:center; valign:middle;" runat="server"
                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderStyle="None" BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False"
                        Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" ForeColor="Black">
                        <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                        <ItemStyle ForeColor="#000066" Font-Size="12px" />
                        <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                            Font-Size="10pt" Font-Strikeout="False" Font-Names="Times New Roman" Font-Underline="False"
                            Wrap="False" />
                        <Columns>
                            <asp:TemplateColumn HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="Item_Name" ItemStyle-HorizontalAlign="left" HeaderText="Description of the Article"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Part_No" HeaderText="Part No." ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rack_no" HeaderText="LF No" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="80"
                                ItemStyle-Height="30"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Subrack_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Width="60"></asp:BoundColumn>
                            <asp:BoundColumn ItemStyle-Width="100" DataField="recqty" HeaderText="Recived Qty" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="claimqty" HeaderText="Claim Qty" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Width="100"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Acctualqty" HeaderText="Actual Received Qty" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="100">
                            </asp:BoundColumn>
                             <asp:BoundColumn DataField="claimreason" HeaderText="Reason Of Claim" ItemStyle-HorizontalAlign="center"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="200">
                            </asp:BoundColumn>
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <%--<asp:BoundColumn DataField="vendor_name" HeaderText="Vendor"></asp:BoundColumn>--%>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="5">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="5" valign="top" style="height: 50px">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <span style="text-align: center">Store Clerk Kardex</span>
            </td>
            <td>
                <span style="text-align: center">Store Keeper Asstt Store Keeper </span>&nbsp;
            </td>
            <td>
                <span style="text-align: center">Bill Clerk</span>
            </td>
            <td>
                <span style="text-align: center">Ledger Clerk</span>
            </td>
            <td>
                <span style="text-align: center">Account And Statistication PMPML</span>
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="5" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript">

$("#txtvendor").autocompleteArray(
		[<% =strVendor  %>],
		{
			delay:10,
			minChars:1,
			matchSubset:1,
			onItemSelect:selectItem,
			onFindValue:findValue,
			autoFill:true,
			maxItemsToShow:10
		}
	);
	

    </script>

</body>
</html>
