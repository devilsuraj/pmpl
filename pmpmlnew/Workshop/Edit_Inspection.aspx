<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Edit_Inspection.aspx.vb"
    Inherits="KDMT.Workshop_Edit_Inspection" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Inspection Card</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
    </script>

    <style>
        .chkliststyle input
        {
            float: left;
            width: 20%;
        }
        .chkliststyle label
        {
            float: left;
            width: 70%;
            text-align: left;
            padding-left: 3px;
            padding-right: 5px;
        }
    </style>
</head>
<body onload="MM_preloadImages('../images/btn_h.gif');">
    <form id="form1" runat="server">
    <div>
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="orgmiddal">
                    <asp:UpdatePanel ID="updtselect" runat="server">
                    </asp:UpdatePanel>
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Update Inspection Card Master</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Bus No.
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="txtBusNo" runat="server" Width="140px" onblur="validate();"></asp:TextBox>--%>
                                    <input type="text" id="txtBusNo" style="width: 140px" class="textfield"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                            <td colspan="4" align="center">
                                <asp:Button ID="btnshow" runat="server" Text="Show" 
                                    style="font-style: italic" />
                            </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 500px">
                                    Job Card No
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="txtjocno" runat="server" Width="140px" class="textfield" onblur="Chkjobdetails();"></asp:TextBox>--%>
                                    <input type="text" id="txtjocno" style="width: 140px" class="textfield"
                                        runat="server" enableviewstate="True" readonly="readonly" />
                                </td>
                                <td align="right" style="display: none">
                                    <%--Deffect Type--%>
                                </td>
                                <td align="left" style="display: none">
                                    <%--<asp:TextBox ID="txtdeffect" runat="server" Width="140px" ReadOnly="True" AutoPostBack="True"></asp:TextBox>--%>
                                    <%--<asp:DropDownList ID="ddldeffect" runat="server" Width="125px" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="00"></asp:ListItem>
                                        <asp:ListItem Text="Minor Deffect" Value="01"></asp:ListItem>
                                        <asp:ListItem Text="Major Deffect" Value="02"></asp:ListItem>
                                        <asp:ListItem Text="On Road Deffect" Value="03"></asp:ListItem>
                                        <asp:ListItem Text="Docking Deffect" Value="04"></asp:ListItem>
                                    </asp:DropDownList>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Model :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtmodel" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Chassis :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtchassis" runat="server" Width="190px" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td align="right">
                                    KMS. :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtkms" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Engine :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtengin" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Job Date
                                </td>
                                <td align="left">
                                    <%-- <BDP:BDPLite ID="dtjobDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>--%><asp:TextBox ID="dtjobDate" runat="server" Width="140px" ReadOnly="True"
                                        AutoPostBack="True"></asp:TextBox>
                                </td>
                                <td align="right">
                                    Job Time
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtjotime" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Deffect Type
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddldeffect" runat="server" Width="155px" AutoPostBack="true"
                                        TabIndex="1">
                                        <%-- <asp:ListItem Text="Select" Value="00"></asp:ListItem>
                                        <asp:ListItem Text="Minor Deffect" Value="01"></asp:ListItem>
                                        <asp:ListItem Text="Major Deffect" Value="02"></asp:ListItem>--%>
                                        <%--<asp:ListItem Text="On Road Deffect" Value="03"></asp:ListItem>
                                        <asp:ListItem Text="Docking Deffect" Value="04"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2" align="center">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Job Deffect
                                </td>
                                <td colspan="3" align="center">
                                    <asp:TextBox ID="txtjobdeffect" runat="server" Width="489px" ReadOnly="True" Height="69px"
                                        TextMode="MultiLine"></asp:TextBox>
                                    <%-- <asp:ListItem Text="Select" Value="00"></asp:ListItem>
                                        <asp:ListItem Text="Minor Deffect" Value="01"></asp:ListItem>
                                        <asp:ListItem Text="Major Deffect" Value="02"></asp:ListItem>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    Jobs Deatils
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:CheckBoxList ID="Select1" Style="align: left" runat="server" AutoPostBack="True"
                                                RepeatDirection="Horizontal" CellPadding="2" CellSpacing="2" CssClass="chkliststyle"
                                                Height="10%" RepeatColumns="4" Width="100%">
                                            </asp:CheckBoxList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <div align="center">
                                        <asp:DataGrid ID="grddeffectlist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                            Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                            ForeColor="Black" Font-Size="11pt">
                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                            <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffectid" HeaderText="subdeffect_id" Visible="false">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffectid" HeaderText="deffecttypeid" Visible="false">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect_decr" HeaderText="Deffect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffect" HeaderText="Sub Deffect Type"></asp:BoundColumn>
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" rowspan="0">
                                    Mechanic
                                </td>
                                <td align="left">
                                    <input type="text" id="txtmech" style="width: 140px" class="textfield" onblur="Chkmechdetails();"
                                        runat="server" />
                                    <%--<asp:ListItem Text="On Road Deffect" Value="03"></asp:ListItem>
                                        <asp:ListItem Text="Docking Deffect" Value="04"></asp:ListItem>--%>                                    <%--<asp:Button ID="btnshow" runat="server" Text="Show Deffect Details" 
                                      style="height: 26px" />--%>
                                </td>
                                <td colspan="2">
                                    <table id="Table1" width="100%" border="1" align="right" cellpadding="5" cellspacing="5">
                                        <tr>
                                            <td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                border-left-style: none; width: 700px;">
                                                Inspection Note
                                            </td>
                                            <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                border-left-style: none;">
                                                <asp:TextBox ID="txtinspectionnote" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                border-left-style: none;">
                                                Note
                                            </td>
                                            <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                border-left-style: none;">
                                                <asp:TextBox ID="txtnote" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <label>
                                    <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                        <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" />
                                    </label>
                                    &nbsp;<%-- <asp:TextBox ID="txtmech" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>--%>
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" Height="32px" Width="63px" />
                                    <asp:Label runat="server" ID="lbl"></asp:Label>
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
$("#txtBusNo").autocompleteArray(
		[<% =strBusno  %>],
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
