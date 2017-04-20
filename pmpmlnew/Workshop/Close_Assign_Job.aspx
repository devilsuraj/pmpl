<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Close_Assign_Job.aspx.vb"
    Inherits="KDMT.Workshop_Close_Assign_Job" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Closing Job Card List</title>
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
            if (i==1)
            {
            document.getElementById("txtjocno").value = ele[i]; 
           
            }
            }
            }
            }
if (document.getElementById ("txtBusNo").value != '')
    {
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkbusdetailsjobcloseassign&busno="+document.getElementById ("txtBusNo").value,true);
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
        .style2
        {
            width: 155px;
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
                <div class="pagetop">
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="page">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Closing Assign Job Details</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 100px">
                                    Bus No
                                </td>
                                <td class="style2">
                                    <input type="text" id="txtBusNo" style="width: 120px" class="textfield" onblur="Chkbusdetails();"
                                        runat="server" />
                                </td>
                                <td align="right" style="width: 100px">
                                    Job Card No
                                </td>
                                <td>
                                    <input type="text" id="txtjocno" style="width: 190px" class="textfield" 
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center" id="td1" runat="server">
                                    <div align="center">
                                        <asp:DataGrid ID="grdjobdetails" Style="align: center; valign: middle;" runat="server"
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
                                                <asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="joccode" HeaderText="Job No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobdate" HeaderText="Job In Date" ItemStyle-Width="100px">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobtime" HeaderText="Job In Time" ItemStyle-Width="100px">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="drvname" HeaderText="Driver Name" ItemStyle-Width="90px">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="inspmechname" HeaderText="Inspection Mechanic" ItemStyle-Width="90px">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="inspnote" HeaderText="Inspection Note" ItemStyle-Width="90px">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobclosedate"  HeaderText="Job Close Date" ItemStyle-Width="100px">
                                                </asp:BoundColumn>
                                                <%--<asp:BoundColumn DataField="" HeaderText="Job Out Time" ItemStyle-Width="100px">
                                                </asp:BoundColumn>--%>
                                               <%-- <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>--%>
                                                <%--<asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="false"></asp:BoundColumn>--%>
                                                <asp:BoundColumn DataField="insp_job_dtl_id" HeaderText="insp_job_dtl_id" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="insp_job_id" HeaderText="insp_job_id" Visible="false">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect" HeaderText="Deffect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffect" HeaderText="Sub Deffect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="mechname" HeaderText="Assign Mechnic Name" ItemStyle-Width="150px"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="dept" HeaderText="Assign Note" ItemStyle-Width="150px"></asp:BoundColumn>
                                               <%-- <asp:TemplateColumn>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtnote" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>--%>
                                               
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="save" Text="Save"></asp:ButtonColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
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
	$("#txtmech").autocompleteArray(
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
