<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IRR_Repair_Fit.aspx.vb"
    Inherits="KDMT.Workshop_IRR_Repair_Fit" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Indent for Repair/Replacement Item Register</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>
    <script language="javascript" type="text/javascript">
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
                                <td colspan="4" class="innerheading" align="center">
                                    <span id="Label3">Repair Unit Item Fit</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    IRR No :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtirrno" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                </td>
                                <td align="right">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Job Card No. :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtjocNo" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                </td>
                                <td align="right">
                                    Deffect Type :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtdeffecttype" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Bus No. :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBusNo" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                </td>
                                <td align="right">
                                </td>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                    border-left-style: none;" colspan="4">
                                    <table width="70%" border="1" align="center" cellpadding="5" cellspacing="5">
                                        <tr>
                                            <td align="Center" colspan="6">
                                            Details of Job Card
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Model :
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtmodel" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                                Chassis :
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtchassis" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                KMS. :
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtkms" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                                Engine :
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtengine" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 160px">
                                                Mechanic Name:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtmechanic" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                            </td>
                                            <td align="right">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="Center" colspan="4" style="border-bottom-style: none; border-right-style: none;
                                    border-top-style: none; border-left-style: none;">
                                    <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                                        <tr>
                                            <td align="right">
                                                Item Name :
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtitemname" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                                Replace Item No. :
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtpartno" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Repair Reg. No :
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtregno" runat="server" Width="140px" ReadOnly="false"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                                Mechanic Name:
                                            </td>
                                            <td align="left">
                                               <%-- <asp:TextBox ID="txtrepairmechanic" runat="server" Width="140px" ReadOnly="false"></asp:TextBox>--%>
                                                <input type="text" id="txtrepairmechanic" style="width: 120px" class="textfield"
                                    runat="server" />
                                            </td>
                                        </tr>
                                       
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                    border-left-style: none;">
                                    <table width="60%" border="1" align="left" cellpadding="5" cellspacing="5">
                                        <tr>
                                            <td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                border-left-style: none;">
                                                Remark :
                                            </td>
                                            <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                border-left-style: none;">
                                                <asp:TextBox ID="txtremark" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <label>
                                        <asp:Button ID="btnsave" runat="server" Text="Save" />
                                    </label>
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

	$("#txtrepairmechanic").autocompleteArray(
		[<% =strmech %>],
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
