<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Workshop_IndentFittingDetails.aspx.vb"
    Inherits="KDMT.Workshop_Workshop_IndentFittingDetails" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Indent Item Fitting </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
function Chkbusdetails()
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
            
            resp = xmlHttp.responseText;
            if (resp=="noval")
            {
            //alert("Job Already Opened")
            document.getElementById("txtfuel").value =""
            document.getElementById("txtkms").value ="" 
            } 
            else 
            {

            var ele = resp.split("!");

            for (var i = 0; i < ele.length; i++)
             {
            if (i==0)
            {
            document.getElementById("txtfuel").value = ele[i];
    
            }
             if (i==1)
            {
            document.getElementById("txtkms").value = ele[i];
            }
           
            }
            }
            }
            }
if (document.getElementById ("txtbusno").value != '')
    {

//    var date2=document.getElementById('bdpfittingDate_TextBox').value;
     var lDate = document.getElementById('bdpfittingDate_TextBox').value;
      var lDate1 = document.getElementById('bdpremovedate_TextBox').value;
      var bus=document .getElementById ("txtbusno").value ;
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkIndentbusdetails&busno="+document.getElementById ("txtbusno").value+"&fittingdate="+lDate+"&removeddate="+lDate1,true);
    xmlHttp.send(null);
    }
             
}
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
        .style4
        {
            width: 337px;
        }
        .style5
        {
            width: 137px;
        }
    </style>
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
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Indent Fitting Item Details</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 100px">
                                    Indent Item
                                </td>
                                <td align="left" colspan="3">
                                    <asp:DropDownList ID="drpindentitem" runat="server" Height="20px" Width="346px" AutoPostBack="True">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Tyre"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Starter"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Alternator"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Company No
                                </td>
                                <td align="left" class="style4">
                                    <input type="text" id="txtcompno" style="width: 222px" class="textfield" runat="server" />
                                </td>
                                <td align="right" class="style5">
                                    Workshop No
                                </td>
                                <td align="left">
                                    <input type="text" id="txtworkshopno" style="width: 204px" class="textfield" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Fitting Date
                                </td>
                                <td align="left" class="style4">
                                    <BDP:BDPLite ID="bdpfittingDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="right" class="style5">
                                    Remove Date
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="bdpremovedate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Bus No
                                </td>
                                <td colspan="3">
                                    <input type="text" id="txtbusno" style="width: 220px" class="textfield" runat="server"
                                        onblur="Chkbusdetails();" tabindex="11"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Fuel Used
                                </td>
                                <td align="left" class="style4">
                                    <asp:TextBox ID="txtfuel" runat="server" Width="190px" TabIndex="3"></asp:TextBox>
                                </td>
                                <td colspan="1" align="right" class="style5">
                                    Kms
                                </td>
                                <td>
                                    <asp:TextBox ID="txtkms" runat="server" Width="140px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <label>
                                        <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" TabIndex="5" />
                                        &nbsp;&nbsp;
                                    </label>
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" Height="32px" Width="63px"
                                        TabIndex="6" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <div align="center">
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
                                                <asp:BoundColumn DataField="Part_Type" HeaderText="Indent Item"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="compno" HeaderText="Company No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="wsno" HeaderText="Workshop No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="fittingdate" HeaderText="Fitting Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="removedate" HeaderText="Removed Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="fuelused" HeaderText="Fuel Used"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="kms" HeaderText="Kms"></asp:BoundColumn>
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
        </div>
    </div>
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->
	$("#txtcompno").autocompleteArray(
		[<% =strcompno  %>],
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
	$("#txtworkshopno").autocompleteArray(
		[<% =strwsno %>],
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
	$("#txtbusno").autocompleteArray(
		[<% =strVech  %>],
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
