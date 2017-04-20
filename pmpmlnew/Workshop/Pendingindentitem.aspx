<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pendingindentitem.aspx.vb" Inherits="KDMT.Workshop_Pendingindentitem" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Pending Indent</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<script language="javascript" src="../Scripts/LogSheet_repairoutward.js"></script>--%>

    <script>

        function validate() {}

        </script>

    <style type="text/css">
        #tblmain
        {
            width: 809px;
        }
        #Table1
        {
            width: 89%;
        }
    </style>
</head>
<body onload="MM_preloadImages('../images/btn_h.gif')">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <form id="Form1" runat="server">
    <asp:HiddenField ID="hdndepttype" runat="server" />
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassno" runat="server" type="hidden" name="hdngatepassno" />
    <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassid" runat="server" type="hidden" name="hdngatepassid" />
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table id="Table1" cellpadding="0" cellspacing="0" runat="server" align="center"
                        width="100%">
                        <tbody>
                            <tr style="height: 50px">
                                <td class="innerheading">
                                    <span id="Label3">Pending Indent Items</span>
                                    <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="innerheading">
                                    <asp:Label ID="lblmsg" ForeColor="REd" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                    
                            <tr>
                                <td>
                                    <div style="text-align: left">
                                        <table id="tblmain" runat="server">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div style="text-align: center">
                                                            <tr>
                                                                <asp:DataGrid ID="dgresult" Width="70%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                                                    runat="server" AutoGenerateColumns="False">
                                                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                                                    <Columns>
                                                                        <asp:TemplateColumn HeaderText="Sr No.">
                                                                            <ItemTemplate>
                                                                                <%#Container.ItemIndex + 1%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:BoundColumn DataField="pen_indid" Visible="false"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Indent_No" HeaderText="Indent No"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Indent_Item_code" Visible="False" ></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="part_no" HeaderText="Part No"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="avbqty" HeaderText="Available Qty"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="req_qty" HeaderText="Required Qty"></asp:BoundColumn>
                                                                       <%-- <asp:BoundColumn DataField="closereason" HeaderText="Remark"></asp:BoundColumn>--%>
                                                                        <asp:TemplateColumn HeaderText="Done" ItemStyle-Width="20px">
                                                                           <%-- <ItemTemplate>
                                                                                <BDP:BDPLite ID="bdpdonedate" TextBoxStyle-Width='80px' runat="server">
                                                                                </BDP:BDPLite>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="10px"></ItemStyle>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn HeaderText="Remark">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="150px"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn HeaderText="DONE">--%>
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkselect" runat="server" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                    </Columns>
                                                                </asp:DataGrid></tr>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                                border="0" Width="87" Height="38" AlternateText="Save" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="orgbottam1">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
