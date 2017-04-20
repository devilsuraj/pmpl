<%@ Page Language="VB" AutoEventWireup="false" CodeFile="update_tyre_status.aspx.vb" Inherits="update_tyre_status" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tyre Status Update</title>
    <script type="text/javascript" language="javascript">
       
    </script>
    <style type="text/css">
        .auto-style1 {
            height: 47px;
        }

        .auto-style2 {
            width: 270px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div align="center">
            <uc:header ID="Header1" runat="server" />
            <input id="hdnID" runat="server" type="hidden" name="hdnID" />
            <asp:HiddenField ID="hdnphid" runat="server" />
        </div>
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <%--<div class="orgtop">
            </div>--%>
                <div class="orgmiddal">

                    <table width="100%" border="1" cellpadding="5" cellspacing="5">
                        <tr>
                            <td colspan="4" class="innerheading">Tyre<span id="Label3"> Status Update</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">COMPANY No:
                            </td>
                            <td>
                                <asp:TextBox ID="txtcompanyno" Style="width: 160px" AutoPostBack="true" class="textfield"
                                    runat="server"></asp:TextBox>
                                <asp:AutoCompleteExtender ServiceMethod="SearchCustomers" MinimumPrefixLength="1"
                                    CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="txtcompanyno"
                                    ID="AutoCompleteExtender1" runat="server" FirstRowSelected="false">
                                </asp:AutoCompleteExtender>
                            </td>
                            <td align="right">Size:
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlPartType">
                                    <asp:ListItem Text="1000x20"> </asp:ListItem>
                                    <asp:ListItem Text="900x20"> </asp:ListItem>
                                    <asp:ListItem Text="VOLVO"> </asp:ListItem>
                                    <asp:ListItem Text="TATA Mini Bus"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">NMMT No:
                            </td>
                            <td class="auto-style2">
                                <asp:TextBox ID="txtPartNo" Style="width: 120px" class="textfield" name="txtPartNo"
                                    runat="server"></asp:TextBox>
                                <asp:ListBox ID="selectwsno" Style="display: none; align: left"
                                    runat="server"></asp:ListBox>
                            </td>
                            <td align="right">Status:
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlPartStatus">
                                    <asp:ListItem Text="Select" Value="0"> </asp:ListItem>
                                    <asp:ListItem Text="Remold" Value="1"> </asp:ListItem>
                                    <asp:ListItem Text="Puncture" Value="2"> </asp:ListItem>
                                    <asp:ListItem Text="Vendor" Value="3"> </asp:ListItem>
                                    <asp:ListItem Text="Done" Value="4"> </asp:ListItem>
                                    <asp:ListItem Text="Fitted" Value="5"> </asp:ListItem>
                                    <asp:ListItem Text="Docking" Value="6"> </asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            Bus No:
                        </td>
                        <td>
                            <asp:TextBox ID="txtBusNo" runat="server" type="text" name="txtBusNo"></asp:TextBox>
                        </td>
                            <td align="right">
                            </td>
                            <td>
                                
                            </td>
                        <tr>
                            <td align="center" colspan="4" class="auto-style1">
                                <asp:Button ID="Button1" runat="server" Text="Save" />
                                <a href="update_tyre_status.aspx">Reset</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
