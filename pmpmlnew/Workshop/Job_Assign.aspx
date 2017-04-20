<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Job_Assign.aspx.vb" Inherits="KDMT.Workshop_Job_Assign" %>

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
    function validate()
    {
    var ab;
    ab=document.getElementById("ddldeffect").value;
//    alert(ab);
    
            if(ab == '00')
        {
            alert('Select Deffect Type');
            document.getElementById ("ddldeffect").focus();
            return false;
        }
     }
function Chkjobdetails()
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

            var ele = resp.split("!");

            for (var i = 0; i < ele.length; i++)
             {
                         if (i==1)
            {
            document.getElementById("txtBusNo").value = ele[i];
            }
           
            }
            }
            }
if (document.getElementById ("txtjocno").value != '')
    {
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkjobdetails&jobno="+document.getElementById ("txtjocno").value,true);
    xmlHttp.send(null);
    }
}
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

            var ele = resp.split("!");

            for (var i = 0; i < ele.length; i++)
             {
            if (i==0)
            {
            document.getElementById("txtjocno").value = ele[i];
            }
             
            
            }
            }
            }
if (document.getElementById ("txtBusNo").value != '')
    {
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkjobbusdetails&busno="+document.getElementById ("txtBusNo").value,true);
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
        .style1
        {
            width: 248px;
        }
        .style2
        {
            width: 142px;
        }
        .style3
        {
            width: 76px;
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
                <div class="pagetop">
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                <Services>
                
                </Services>
                </asp:ScriptManager>
                
                <div class="page">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="85%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Assign Job</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style3">
                                    Bus No
                                </td>
                                <td class="style2">
                                    <input type="text" id="txtBusNo" style="width: 120px" class="textfield" onblur="Chkbusdetails();"
                                        runat="server" />
                                </td>
                                <td align="right" style="width: 100px">
                                    Job Card No
                                </td>
                                <td class="style1">
                                    <input type="text" id="txtjocno" style="width: 190px" class="textfield" onblur="Chkjobdetails();"
                                        runat="server" onclick="return txtjocno_onclick()" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Label ID="lbl" runat="server" Style="color: Red;"> </asp:Label>
                                    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    Inspection Mechnic Name
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="lblinspmech" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center" id="td1" runat="server">
                                    <div align="center">
                                        <asp:DataGrid ID="grdjobdetails" Style="align: center; valign: middle;" runat="server"
                                            Width="80%" AutoGenerateColumns="False" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="3" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Font-Size="11pt"
                                            BorderStyle="None" CellSpacing="2">
                                            <FooterStyle  ForeColor="#8C4510" Wrap="False" />
                                            <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle ForeColor="#8C4510" HorizontalAlign ="Center"  Mode="NumericPages" />
                                            <ItemStyle ForeColor="Black" />
                                            <HeaderStyle Font-Bold="True"  Font-Size="10pt" Wrap="False" ForeColor="Black" />
                                            <Columns>
                                                <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="joccode" HeaderText="Job No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Deffect Details">
                                                    <ItemTemplate>
                                                        <asp:DataGrid ID="grddeffect" Style="align: center; valign: middle;" runat="server"
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
                                                                <asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="false"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="insp_job_dtl_id" HeaderText="insp_job_dtl_id" Visible="false"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="insp_job_id" HeaderText="insp_job_id" Visible="false">
                                                                </asp:BoundColumn>
                                                                <asp:BoundColumn DataField="deffect" HeaderText="Deffect Type"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="subdeffect" HeaderText="Sub Deffect Type"></asp:BoundColumn>
                                                                <asp:BoundColumn DataField="inspnote" HeaderText="Note"></asp:BoundColumn>
                                                                <asp:TemplateColumn HeaderText="Mechnic Name">
                                                                    <ItemTemplate>
                                                                        <%-- <asp:TextBox ID="txtmech" runat="server"></asp:TextBox>--%>
                                                                        <%--<asp:DropDownList ID="drpmech" runat="server">
                                                                        </asp:DropDownList>--%>
                                                                        <input type="text" id="txtmech" style="width: 190px" class="textfield" runat="server" />
                                                                        
                                                                    </ItemTemplate>
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Note">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtNote" runat="server"></asp:TextBox>
                                                                        <%-- <input type="text" id="txtNote" style="width: 190px" class="textfield" runat="server" />--%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="ch1" runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateColumn>
                                                            </Columns>
                                                        </asp:DataGrid>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn>
                                                    <ItemTemplate>
                                                        <asp:RadioButton ID="rd1" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4" id="td2" runat="server">
                                    <label>
                                        <%--<asp:ImageButton ID="btnSave" runat="server" ImageUrl="../images/btn_h.gif" TabIndex="9">
                                        </asp:ImageButton>--%>
                                        <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" />
                                    </label>
                                    &nbsp;<%--<a href="../report/rptJOC.aspx">Save</a> --%>
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" Height="32px" Width="63px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pagebottam">
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

$("#txtjocno").autocompleteArray(
		[<% =strjobno %>],
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
	$("grddeffect_#txtmech").autocompleteArray(
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
