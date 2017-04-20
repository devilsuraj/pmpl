<%@ Page Language="VB" AutoEventWireup="false" CodeFile="updateVendor.aspx.vb" Inherits="KDMT.store_updateVendor" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Update Vendor Details</title>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../../styles/KDMT.css" type="text/css" rel="stylesheet" />

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
                                <span id="Span1">Update Vendor Details</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                Vendor Name:
                                <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                                    runat="server" />
                                <asp:Button ID="btn_show" runat="server" Text="Show" Height="25px" />
                            </td>
                        </tr>
                       
                        
                        <tr>
                            <td align="left" colspan="2">
                                <asp:GridView ID="gvCustomers" class="gridhead" DataKeyNames="vendor_id" runat="server"
                                    AutoGenerateColumns="False" OnRowEditing="EditCustomer" OnRowUpdating="UpdateCustomer"
                                    OnRowCancelingEdit="CancelEdit" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                    Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" BackColor="White"
                                    Font-Underline="False">
                                    <FooterStyle Wrap="False" />
                                    <RowStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Height ="35px" Font-Overline="False" Font-Size="10pt"
                                        Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    <Columns>
                                    <%--     <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       --%>
                                        <asp:TemplateField HeaderText="Vendor Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblvendornm" runat="server" Text='<%# Eval("vendor_name")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="vendor_name" runat="server" Text='<%# Eval("vendor_name")%>' Width="160px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>                                                                          
                                       
                                        <asp:TemplateField HeaderText="Address 1">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladd" runat="server" Text='<%# Eval("add1")%>' ></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="add1" runat="server" Text='<%# Eval("add1")%>' Width="130px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address 2">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladd2" runat="server" Text='<%# Eval("add2")%>'></asp:Label>
                                            </ItemTemplate>                                            
                                            <EditItemTemplate>
                                                <asp:TextBox ID="add2" runat="server" Text='<%# Eval("add2")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Capital">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcap" runat="server" Text='<%# Eval("capital")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="capital" runat="server" Text='<%# Eval("capital")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contact Name ">
                                            <ItemTemplate>
                                                <asp:Label ID="lblconname" runat="server" Text='<%# Eval("contact_name")%>'></asp:Label>
                                            </ItemTemplate>
                                          <EditItemTemplate>
                                                <asp:TextBox ID="contact_name" runat="server" Text='<%# Eval("contact_name")%>' Width="95px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>    
                                         <asp:TemplateField HeaderText="Contact No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblconno" runat="server" Text='<%# Eval("contact_no")%>'></asp:Label>
                                            </ItemTemplate>
                                          <EditItemTemplate>
                                                <asp:TextBox ID="contact_no" runat="server" Text='<%# Eval("contact_no")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>                                
                                       
                                   
                                        <asp:CommandField ShowEditButton="True" EditImageUrl="~/images/edit.gif" ShowDeleteButton="false" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="trgrid" runat="server">
                            <td colspan="4">
                                &nbsp;</td>
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
