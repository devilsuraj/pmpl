<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Itemupdatemaster.aspx.vb"
    Inherits="KDMT.Itemupdatemaster" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Update Item Category and Type</title>
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
                                <span id="Span1">Update Item Category and Type</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Type :
                                <asp:DropDownList ID="drpType" runat="server">
                                    <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Kit Section" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="STN" Value="4"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Moving Type:
                                <asp:DropDownList ID="drbMoveCategory" runat="server">
                                    <asp:ListItem Value="9" Text="All"></asp:ListItem>
                                    <asp:ListItem Value="0" Text="NO Category"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Fast"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Meddium"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Slow"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Dead Stock"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                            </td>
                        </tr>
                        <tr id="trgrid" runat="server">
                            <td colspan="4">
                                <asp:GridView ID="gvCustomers"  AllowPaging ="true" PageSize ="100"  class="gridhead" DataKeyNames="item_code" runat="server"
                                    AutoGenerateColumns="False" OnRowEditing="EditCustomer" OnRowUpdating="UpdateCustomer"
                                    OnRowCancelingEdit="CancelEdit" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                    Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" BackColor="White"
                                    Font-Underline="False">
                                    <FooterStyle Wrap="False" />
                                    <RowStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Height="35px" Font-Overline="False"
                                        Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Nomenclature" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblitemcode" runat="server" Text='<%# Eval("Item_Code")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Nomenclature">
                                            <ItemTemplate>
                                                <asp:Label ID="lblname" runat="server" Text='<%# Eval("Item_name")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="L/F No">
                                            <ItemTemplate>
                                                <asp:Label ID="lbllf" runat="server" Text='<%# Eval("rack_no")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bin No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblbin" runat="server" Text='<%# Eval("subrack_no")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Part No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpart" runat="server" Text='<%# Eval("Part_No")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dept Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcategory" runat="server" Text='<%# Eval("category")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Moving Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmovcategory" runat="server" Text='<%# Eval("movingcat")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Store Name">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="drbstoreName" runat="server">
                                                    <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Spare Part"></asp:ListItem>
                                                    <asp:ListItem Value="2" Text="Hardware"></asp:ListItem>
                                                    <asp:ListItem Value="3" Text="Kit Section"></asp:ListItem>
                                                    <asp:ListItem Value="4" Text="STN"></asp:ListItem>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Moiving Category">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="drbMoveCate" runat="server">
                                                    <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Fast"></asp:ListItem>
                                                    <asp:ListItem Value="2" Text="Meddium"></asp:ListItem>
                                                    <asp:ListItem Value="3" Text="Slow"></asp:ListItem>
                                                    <asp:ListItem Value="4" Text="Dead Stock"></asp:ListItem>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" EditImageUrl="~/images/edit.gif" ShowDeleteButton="false" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="trbtn" runat="server" style="height: 100px">
                            <td style="height: 22px">
                                <div align="center">
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
    </form>

    <script type="text/javascript">
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

$("#txtvendor").autocompleteArray(
		[<% =strVendor  %>],
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
