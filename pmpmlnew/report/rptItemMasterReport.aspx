<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptItemMasterReport.aspx.vb" Inherits="KDMT.rptcontractorwisereceive" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vendorwise Receive Report</title>
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
    </style>
    <style type="text/css">
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
                <strong><span style="font-size: 11pt; color: black">Item Master List&nbsp;</span></strong>
            </td>
        </tr>
        <tr>
        <td align="Right">
                    <asp:DropDownList ID="ddldepttype" runat="server">
                        <asp:ListItem Text="Spare Part" Value="1"> </asp:ListItem>
                        <asp:ListItem Text="Hardware" Value="2"> </asp:ListItem>
                        <asp:ListItem Text="KIT" Value="3"> </asp:ListItem>
                        <asp:ListItem Text="STN" Value="4"> </asp:ListItem>
                        
                    </asp:DropDownList>
                    </td>
            <td align="left">
                <asp:Button ID="btnshow" runat="server" Text="Show Item Master List" />
                <asp:Button ID="btnCry0" runat="server" Text="Convert To Excel" />
                <asp:Button ID="btncrystal" runat="server" Text="Crystal Report" />
            </td>
        </tr>
      <tr>
        <td></td>
        </tr>
    </table>
    <div id="divcry" runat ="server" >
        <CR:CrystalReportViewer ID="crst_item_master" runat="server" AutoDataBind="true" />
    </div>
    <table id="Table1" align="center" border="1" style="width: 700px" runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL 
                LIMITED  </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Item Master List Report
                </span></strong>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center" style="height: 19px">
               <div align="center">
                    <asp:DataGrid ID="grditemdetail" Style="align: center; valign: middle;" runat="server"
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
                            <asp:BoundColumn DataField="rack_no" ItemStyle-HorizontalAlign="left" HeaderText="LF No"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left" ItemStyle-Wrap="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="item_name" HeaderText="Item Name" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left" ItemStyle-Wrap="false"></asp:BoundColumn>
                                   <asp:BoundColumn DataField="Part_no" HeaderText="Part No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left" ItemStyle-Wrap="false"></asp:BoundColumn>
                             <asp:BoundColumn DataField="make" HeaderText="Make" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="right"></asp:BoundColumn>
                            
                               
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <%--<asp:BoundColumn DataField="vendor_name" HeaderText="Vendor"></asp:BoundColumn>--%>
                        </Columns>
                    </asp:DataGrid>
                </div>
                &nbsp;</td>
           
        </tr>
   
        <tr>
            <td class="style1">
    
            </td>
            <td class="style1">
            </td>
            <td class="style2">
            </td>
            <td class="style3">
                </td>
        </tr>

        
    </table>
    </form>
</body>
</html>
