<%@ Page EnableEventValidation="true" Language="VB" AutoEventWireup="false" CodeFile="deletereceiveitem.aspx.vb"
    Inherits="KDMT.deletereceiveitem" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Delete Receive Item</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/LogSheet.js">
    </script>

    <script language="javascript" src="../Scripts/BLogSheet.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />

    <script language="javascript">



function validate ()
{
var rowCount = document.getElementById("dgresult").rows.length;
var i=1;
var j=0;
    for (i=2;i<=rowCount;i++)
    {
    var id = 'dgresult__ctl' + i + '_delete'
    if (document.getElementById(id).checked == true )
    {
    j = 1
    }
    }
   
if (j== 0)
    {
    alert ('Please Tick The boxes if You want to Delete')
    return false 
    }

if(!confirm("Do you want to Delete Item"))
    {
    return(false);
    }

}

	

    </script>

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
                            <td class="innerheading" colspan="4">
                                <span id="Span1">Delete Receive item</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 1005px; height: 21px;">
                                Challan No :-
                                <asp:TextBox ID="txtchallan_no" runat="server" BackColor="#FFFFC0" Width="96px" ToolTip="Enter Challan No"></asp:TextBox>
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                        <tr id="trgrid" runat="server">
                            <td colspan="4">
                                <asp:DataGrid ID="dgresult" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                    runat="server" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:BoundColumn DataField="Store_detail_id" Visible="False" HeaderText="Store_detail_id">
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="part_no" HeaderText="Part No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="inward_no" HeaderText="Inward"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="po_no" HeaderText="PO"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Receive Qty">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.total_qty") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Receive Date (DD/MM/YY)">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.trans_date") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Challan date (DD/MM/YY)">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.challan_date") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Vendor Name">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vendor_name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="reject" HeaderText="Reject"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="drb_no" HeaderText="drb_No"></asp:BoundColumn>

                                        <asp:TemplateColumn HeaderText="delete">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="delete" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr id="trbtn" runat="server" style="height: 100px">
                            <td style="height: 22px">
                                <div align="center">
                                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton><asp:ImageButton
                                        ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="1"></asp:ImageButton></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="text3">
                                <asp:HiddenField ID="Hid_Rec" runat="server" />
                                <asp:HiddenField ID="from_km" runat="server" />
                                <asp:HiddenField ID="to_km" runat="server" />
                                <asp:HiddenField ID="hdnTotalKm" runat="server" />
                                <asp:HiddenField ID="BHid_Rec" runat="server" />
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

    <script type="text/javascript">
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

</script>

</body>
</html>
