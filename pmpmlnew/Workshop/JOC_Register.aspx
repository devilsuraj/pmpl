<%@ Page Language="VB" AutoEventWireup="false" CodeFile="JOC_Register.aspx.vb" Inherits="KDMT.JOC_Register" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Job Order Card Register</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

</script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc:header ID="Header1" runat="server" />
            <div id="middal">
                <uc:leftmenu ID="Leftmenu1" runat="server" />
                <div class="contantbox">
                    <div class="orgtop">
                    </div>
                    <div class="orgmiddal">
                        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                        <div>
                            <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td colspan="4" class="innerheading">
                                        <span id="Label3">Job Order Card Register</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        From Date :
                                    </td>
                                    <td align="left">
                                        <BDP:BDPLite ID="dtformDate" runat="server" TextBoxStyle-Width="100px">
                                        </BDP:BDPLite>
                                    </td>
                                    <td align="right">
                                        To Date :
                                    </td>
                                    <td align="left">
                                        <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px">
                                        </BDP:BDPLite>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Supervisor :</td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlsuperv" runat="server">
                                    </asp:DropDownList></td>
                                    <td align="right">
                                        Bus No.
                                    </td>
                                    <td>
                                        <input id="txtBusNo" runat="server" type="text" name="textfield" />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td align="right" >
                                        JOC</td>
                                    <td align="left">
                                     <input id="txtjobNo" runat="server" type="text" name="textfield" />
                                       <%-- <select name="ddl1" id="Select1" size="0" onchange="showDetail();">
                                            <option value="1">Minor Deffect</option>
                                            <option value="2">Major Deffect</option>
                                            <option value="3">On Road Deffect</option>
                                            <option value="4">Docking Deffect</option>
                                        </select>--%>
                                    </td>
                                    <td align="right">
                                    </td>
                                    <td align="left">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <label>
                                            <%--<input name="Save" type="button" id="btnShow" value="Show" onclick="return btnShow_onclick()" />--%>
                                            <asp:Button ID="btnShow" runat="server" Text="Show" />
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        Job Card Register</td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4">
                                        <div align="center">
                                            <asp:DataGrid ID="grdjoclist" Style="align: center; valign: middle;" runat="server"
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
                                                    <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="JOC_id" HeaderText="JOC_id" Visible="False"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="joccode" HeaderText="JOC No"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="jobdate" HeaderText="Date"></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="busno" HeaderText="Bus No."></asp:BoundColumn>
                                                    <asp:BoundColumn DataField="supervisorname" HeaderText="Supervisor "></asp:BoundColumn> <asp:TemplateColumn>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hpfit" runat="server" ForeColor="#0066FF" meta:resourcekey="hpfitResource1">Print</asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                </Columns>
                                            </asp:DataGrid>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="orgbottam">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
     <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

//$("#txtBusNo").autocompleteArray(
//		[<% =strBusno  %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);

//$("#txtjobNo").autocompleteArray(
//		[<% =strjobno  %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	); 

$(document).ready(function() {
         $("#txtBusNo").autocomplete
           ({
            source: [<%= strBusno  %>]
            });
      });
      
      
//      $(document).ready(function() {
//         $("#txtjobNo").autocomplete
//           ({
//            source: [<%= strjobno  %>]
//            });
//      });
//      

    </script>
</body>
</html>
