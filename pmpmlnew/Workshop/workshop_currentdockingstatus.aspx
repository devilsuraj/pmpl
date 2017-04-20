<%@ Page Language="VB" AutoEventWireup="false" CodeFile="workshop_currentdockingstatus.aspx.vb"
    Inherits="KDMT.Workshop_workshop_currentdockingstatus" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Current Docking Status</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js">

    <script type="text/javascript" language="JavaScript" src="../Scripts/FusionCharts.js"></script>

    <script type="text/javascript" language="JavaScript">
     
    </script>
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
<body>
    <form id="form1" runat="server">
     <a href="../report/allworkshopReport.aspx" class="ctrl">Back</a>
    <div>
        <table id= "table1" align="center" border="1" cellpadding="0" cellspacing="0" style="width: 50%" class="ctrl">
                <tr>
                                <td colspan="4" >
                                    <span id="Label3" style="font-weight: bold; font-size: large" align="center">Current Docking Status Report</span>
                                </td>
                            </tr>
                             <tr>
                            <td align="left">
                                Kilometers :
                               
                                <asp:DropDownList ID="ddlkms" runat="server">
                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem Value="1">Inspection</asp:ListItem>
                                       <asp:ListItem Value="2">Half Docking</asp:ListItem>
                                       <asp:ListItem Value="3">Full Docking</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <label>
                                        <asp:Button ID="btnshow" runat="server" Text="Show" />
                                    </label>
                                </td>
                            </tr></table>
                            <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 900px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">Navi Mumbai Municipal Transport,Turbhe Depot </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4" style="height: 25px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" Width="300px">Current Docking Status Report</asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left">
                Inspection Report Date :-
                            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
            </td>
            
        </tr>
        
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdinsp" Style="align: center; valign: middle;" runat="server"
                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                        Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                        ForeColor="Black">
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
                                                    <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="lastinsdate" HeaderText="Last Inspection Date" Visible="True">
                                                    </asp:BoundColumn>
                                                    <asp:BoundColumn DataField="inspno" HeaderText="Last Inspection"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="lastkm" HeaderText="Last Inspection Km"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="newdate" HeaderText="Current Date" Visible="True"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="currentkm" HeaderText="Km After last Insp"></asp:BoundColumn>
                                                 <asp:BoundColumn DataField="km" HeaderText="Km from 1st Insp"></asp:BoundColumn>
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
            </div>
                        
       
    </form>
</body>
</html>
