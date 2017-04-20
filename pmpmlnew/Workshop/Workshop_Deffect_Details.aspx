<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Workshop_Deffect_Details.aspx.vb"
    Inherits="KDMT.Workshop_Workshop_Deffect_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Defect Details</title>

    <script language="javascript" type="text/javascript">
    
    </script>

    <style type="text/css">
        #txtmaindeffect
        {
            width: 562px;
        }
        #txtsubdeffect
        {
            width: 463px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    </div>
    <div id="middal">
        <uc:leftmenu ID="Leftmenu1" runat="server" />
        <div class="contantbox">
            <div class="orgtop">
            </div>
            <div class="orgmiddal">
                <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="4" class="innerheading">
                            <span id="Label3">Defect Details</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Main Defect
                        </td>
                        <td>
                            <input id="txtmaindeffect" runat="server" type="text" name="textfield1" size="20" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Sub Defect
                        </td>
                        <td>
                            <input id="txtsubdeffect" runat="server" type="text" name="textfield" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Type
                        </td>
                        <td>
                            <asp:DropDownList ID="ddltype" runat="server" Width="100px">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">Major</asp:ListItem>
                                <asp:ListItem Value="2">Minor</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <label>
                                <%--<input name="Save" type="button" id="btnSave" value="Save"/>--%>
                                <asp:Button ID="Save" runat="server" Text="Save" />
                                &nbsp;
                            </label>
                            <asp:Button ID="Reset" runat="server" Text="Reset" />
                            <%--<a href="Defect_Details.aspx">Reset</a>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div align="center" >
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
                                        <asp:BoundColumn DataField="deffect_id" HeaderText="deffect_id" Visible="false">
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="deffect_decr" HeaderText="Main Defect"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="subid" HeaderText="subdefect_id" Visible="false">
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="subdeffect" HeaderText="Sub Defect"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="deffectype" HeaderText="Defect Type"></asp:BoundColumn>
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
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

//$("#txtmaindeffect").autocompleteArray(
//		[<% =strmain  %>],
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


//$("#txtsubdeffect").autocompleteArray(
//		[<% =strsub  %>],
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
         $("#txtmaindeffect").autocomplete
           ({
            source: [<%= strmain  %>]
            });
      });
      
       $(document).ready(function() {
         $("#txtsubdeffect").autocomplete
           ({
            source: [<%= strsub  %>]
            });
      });
function btnSave_onclick() {

}

    </script>

</body>
</html>
