<%@ Page Language="VB" AutoEventWireup="false" CodeFile="updatePoAll.aspx.vb"  Inherits="KDMT.updatePoAll" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Update PO Details</title>
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
///////////////////////////////////////
function CalculateTotals() 
{ 
 var table = document.getElementById("gvCustomers");
 
            if (table.rows.length > 0) {
                //loop the gridview table
                for (var i = 1; i < table.rows.length; i++)
                {
                    //get all the input elements
                    var inputs = table.rows[i].getElementsByTagName("input");
                    for (var j = 0; j < inputs.length; j++) {
                        //get the textbox1
                        inputs[1].id.indexOf("item_qty");                         
                         var itemqty =inputs[1].value;
                        
                        inputs[3].id.indexOf("item_rate");                         
                         var itemrate =inputs[3].value;
                        
                         var total = parseFloat(itemqty * itemrate)                       
                       
                     inputs[4].id.indexOf("item_amt").innerHTML; 
                      inputs[4].value = total.toFixed(2);
                      
                      inputs[5].id.indexOf("TextBox4").innerHTML; 
                      inputs[5].value = total.toFixed(2);;
                     inputs[9].id.indexOf("base_rate").innerHTML; 
                      inputs[9].value = parseInt(itemrate);                     
                                                              
                } 
              }
            } 
}
//////////////////////////////////////////////
function CalculateQty() 
{ 
 var table = document.getElementById("gvCustomers");
 
            if (table.rows.length > 0) {
                //loop the gridview table
                for (var i = 1; i < table.rows.length; i++)
                {
                    //get all the input elements
                    var inputs = table.rows[i].getElementsByTagName("input");
                   
                    for (var j = 10; j < inputs.length; j++) {
                        //get the textbox1                       
                        inputs[1].id.indexOf("item_qty");                         
                         var itemqty =inputs[1].value;
                         
                         
                         inputs[2].id.indexOf("TextBox1");  //////////////////                        
                         var itemqty1 =inputs[2].value;     ////////////////// item_qty
                        
                        inputs[6].id.indexOf("pen_qty");                         
                         var pen_qty =inputs[6].value;
                         
                         inputs[7].id.indexOf("TextBox2");  //////////////////                        
                         var pen_qty1 =inputs[7].value;     ////////////////// pen_qty                        
                      
                         var order_total = itemqty - itemqty1
                         var pen_total = Number(order_total) + parseInt(pen_qty1)                                              
                     if(pen_qty > 0)
                     {                     
                     inputs[6].id.indexOf("pen_qty").innerHTML; 
                      inputs[6].value = pen_total;    
                                                  
                      inputs[8].id.indexOf("TextBox3").innerHTML; 
                      inputs[8].value = pen_total;                                
                       
                     inputs[2].id.indexOf("TextBox1").innerHTML;                         
                     inputs[2].value = itemqty1;
                      inputs[7].id.indexOf("TextBox2").innerHTML;                         
                     inputs[7].value = pen_qty1;
                     }
                     else
                     {
                      inputs[10].id.indexOf("po_flag").innerHTML; 
                      inputs[10].value = 1; 
                     }                    
                } 
              }
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
                                <span id="Span1">Update PO Details</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2">
                                Vendor Name:
                                <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Type :
                                <asp:DropDownList ID="drpType" runat="server">
                                    <asp:ListItem Text="SpareParts" Value="SpareParts"></asp:ListItem>
                                    <asp:ListItem Text="Hardware" Value="Hardware"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <span>PO Type</span>
                                <asp:DropDownList ID="drbPoType" runat="server">
                                    <asp:ListItem Text="RC" Value="RC"></asp:ListItem>
                                    <asp:ListItem Text="T&C" Value="T"></asp:ListItem>
                                    <asp:ListItem Text="SP" Value="SP"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <span>Po No</span>
                                <asp:TextBox ID="txtPONo" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Po Date :
                                <BDP:BDPLite ID="bdppodate" runat="server">
                                </BDP:BDPLite>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                        <tr id="trgrid" runat="server">
                            <td colspan="4">
                                <asp:GridView ID="gvCustomers" class="gridhead" DataKeyNames="po_detail_id" runat="server"
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
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:TemplateField HeaderText="Item Code">
                                            <ItemTemplate>
                                                <asp:Label ID="lblitemcode" runat="server" Text='<%# Eval("item_code")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="item_code" runat="server" Text='<%# Eval("item_code")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>                                                                          
                                       
                                        <asp:TemplateField HeaderText="Order Qty">
                                            <ItemTemplate>
                                                <asp:Label ID="lblorder" runat="server" Text='<%# Eval("item_qty")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="item_qty" runat="server" onblur="CalculateQty(); CalculateTotals();" Text='<%# Eval("item_qty")%>' Width="80px"></asp:TextBox>
                                                 <asp:TextBox ID="TextBox1" Visible="true" runat="server" Text='<%# Eval("item_qty")%>' Width="0px" Height="0px" BorderStyle=None></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rate">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_item_rate" runat="server" Text='<%# Eval("item_rate")%>'></asp:Label>
                                            </ItemTemplate>                                            
                                            <EditItemTemplate>
                                                <asp:TextBox ID="item_rate" runat="server" onblur="CalculateTotals();" Text='<%# Eval("item_rate")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount Rs">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_item_amt" runat="server" Text='<%# Eval("item_amt")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="item_amt" runat="server" Text='<%# Eval("item_amt")%>' Width="80px" ReadOnly="true"></asp:TextBox>
                                                 <asp:TextBox ID="TextBox4" runat="server" Text='<%# Eval("item_amt")%>' Width="0px"  Height="0px" BorderStyle="None"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Pen Qty">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpen_qty" runat="server" Text='<%# Eval("pen_qty")%>'></asp:Label>
                                            </ItemTemplate>
                                          <EditItemTemplate>
                                                <asp:TextBox ID="pen_qty" runat="server" Text='<%# Eval("pen_qty")%>' Width="80px" ReadOnly="true"></asp:TextBox>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("pen_qty")%>' Width="0px" Height="0px" BorderStyle="None"></asp:TextBox>                                               
                                                 <asp:TextBox ID="TextBox3" runat="server" Text='<%# Eval("pen_qty")%>' Width="0px"  Height="0px" BorderStyle="None"></asp:TextBox>                                               
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Base Rate">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_base_ate" runat="server" Text='<%# Eval("base_rate")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="base_rate" runat="server" Text='<%# Eval("base_rate")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate> 
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Po Flag">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_po_flag" runat="server" Text='<%# Eval("po_flag")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="po_flag" runat="server" Text='<%# Eval("po_flag")%>' Width="80px"></asp:TextBox>
                                            </EditItemTemplate> 
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
