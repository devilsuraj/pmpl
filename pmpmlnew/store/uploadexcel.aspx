<%@ Page Language="VB" AutoEventWireup="false" CodeFile="uploadexcel.aspx.vb" Inherits="Kdmt.uploadexcel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Item Issue</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/LogSheetIssue.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">Indent Upload </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:FileUpload ID="MyFile" runat="server" />
                                <asp:Button ID="btnfilesave" runat="server" Text="FileSave" />
                            </td>
                        </tr>
                    </table>
                    <table id="tblmain" runat="server">
                        <tr>
                            <td align="right">
                                Indent No
                            </td>
                            <td align="left">
                                <asp:Label ID="lblindno" ForeColor="red" runat="server"></asp:Label>
                            </td>
                            <td align="right">
                                Indent Date
                            </td>
                            <td align="left">
                                <asp:Label ID="lblinddate" ForeColor="red" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Indent Location
                            </td>
                            <td align="left">
                                <asp:Label ID="lblloc" ForeColor="red" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:DataGrid ID="dgresult" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Style="border-collapse: collapse"
                                    runat="server" Width="100%" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr No">
                                            <ItemTemplate>
                                                <%#Container.ItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="indent_dtl_id" Visible="False"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="lfno" HeaderText="Lf No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="item_name" HeaderText="Nomenclature"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="part_no" HeaderText="Part No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="reqqty" HeaderText="Required Qty"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="remark" HeaderText="Remark"></asp:BoundColumn>
                                    </Columns>
                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                </asp:DataGrid>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
