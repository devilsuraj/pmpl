<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_depowisecost.aspx.vb" Inherits="KDMT.rpt_depowisecost" %>


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
                    <strong><span style="font-size: 11pt; color: black">Depot Wise Report</span></strong>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    From Date
                    <BDP:BDPLite ID="BDPLite1" runat="server">
                    </BDP:BDPLite>
                    To Date
                    <BDP:BDPLite ID="BDPLite2" runat="server">
                    </BDP:BDPLite>
                    <asp:Button ID="Button4" runat="server" Text="Show" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </div>
    <table id="Table1" align="center" border="1" style="width: 100%" runat="server">
        <tr>
         <td colspan="5" align="center">
                <strong><span style="font-size: 15pt"> </span>
                </strong>
            </td>
        </tr>   
        <tr>
        <td colspan="5" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span>
                </strong>
            </td>
         
        </tr>       
        <tr>
            <td colspan="5" align="center">
                <strong><span style="font-size: 15pt">DEPOT WISE REPORT </span>
                </strong>
            </td>
        </tr>
       <tr>
            <td align="left" style="height: 19px">
                From Date:- 
                <asp:Label ID="lblfromdate" runat="server" Text=""></asp:Label>
                </td>
          
            <td align="right" style="height: 19px">
                To Date :-   
                <asp:Label ID="lbltodate" runat="server" Text=""></asp:Label>
                </td>
        </tr>
      
     
     
        <tr>
            <td colspan="5" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock"  runat="server"  Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                            <asp:BoundColumn DataField="ContName" ItemStyle-HorizontalAlign="center" HeaderText="Depot Name"
                                HeaderStyle-HorizontalAlign="center"  ItemStyle-Width="150"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Spare_Amount" HeaderText="Spare Part Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false"  ItemStyle-Width="100"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Hardware_Amount" HeaderText="Hardware Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="100"
                                ItemStyle-Height="30"></asp:BoundColumn>
                            <asp:BoundColumn DataField="paintAmount" HeaderText="Paint Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Width="100"></asp:BoundColumn>
                                
                           <asp:BoundColumn ItemStyle-Width="100" DataField="stntotal" HeaderText="Stn Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center"></asp:BoundColumn>
                           <asp:BoundColumn DataField="tyreamount" HeaderText="New Tyre Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Width="100"></asp:BoundColumn>
                                <asp:BoundColumn DataField="" HeaderText="Remold Tyre(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Width="100"></asp:BoundColumn>
                           <asp:BoundColumn DataField="batterytotal" HeaderText="Battery Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="100">
                            </asp:BoundColumn>
                             <asp:BoundColumn DataField="tooltotal" HeaderText="Tool Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="100">
                            </asp:BoundColumn>
                              <asp:BoundColumn DataField="Kit_Amount" HeaderText="Kit Amount(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="100">
                            </asp:BoundColumn>
                              <asp:BoundColumn HeaderText="Total Amt(Rs.)" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ItemStyle-Width="100">
                            </asp:BoundColumn>                            
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
