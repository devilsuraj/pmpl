<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Close_JobCard.aspx.vb" Inherits="KDMT.Close_JobCard" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Closing Job Card</title>
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
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkbusdetailsjobclose&busno="+document.getElementById ("txtBusNo").value+"&deffectp="+document.getElementById ("ddldeffectplace").value,true);
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
                <div class="orgtop">
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3">Closing Job Details</span>
                                </td>
                            </tr>
                            <tr>
                            <td align="right">
                                    Deffect Place :
                                </td>
                                <td colspan="3">
                                    <asp:DropDownList ID="ddldeffectplace" runat="server">
                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem Value="1">Deffect</asp:ListItem>
                                        <asp:ListItem Value="2">Brakedown</asp:ListItem>
                                        <asp:ListItem Value="3">Docking</asp:ListItem>
                                    </asp:DropDownList>
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
                                    <input type="text" id="txtjocno" style="width: 190px" class="textfield" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center" id="td1" runat="server">
                                    <div align="left">
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
                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:BoundColumn DataField="srno" HeaderText="Sr No" ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="joccode" HeaderText="Job No" ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobdate" HeaderText="Job In Date" ItemStyle-Width="100px"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No" ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobclosedate" HeaderText="Job Close Date" ItemStyle-Width="100px"></asp:BoundColumn>
                                                <%-- <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>--%>
                                                <%--<asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="false"></asp:BoundColumn>--%>
                                                <asp:TemplateColumn HeaderText="Note">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtnote" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Brakedown Close Time">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtbraketime" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="save" Text="Save"></asp:ButtonColumn>
                                                <asp:BoundColumn DataField="closeassign" HeaderText="closeassign" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="closejob_remark" HeaderText="closejob_remark" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobclosetime" HeaderText="Job Out Time" ItemStyle-Width="100px"
                                                    Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffectplace" HeaderText="deffectplace" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="dckstatus" HeaderText="dckstatus" Visible="false"></asp:BoundColumn>
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

//$("#txtjocno").autocompleteArray(
//		[<% =strjobno %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);
//	$("#txtmech").autocompleteArray(
//		[<% =strmech %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);
//	$("#txtBusNo").autocompleteArray(
//		[<% =strBusno  %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);      
  $(document).ready(function() {
         $("#txtjocno").autocomplete
           ({
            source: [<%= strjobno  %>]
            });
      });
      
        $(document).ready(function() {
         $("#txtmech").autocomplete
           ({
            source: [<%= strmech  %>]
            });
      });
      
        $(document).ready(function() {
         $("#txtBusNo").autocomplete
           ({
            source: [<%= strBusno  %>]
            });
      });
      
    </script>

</body>
</html>
