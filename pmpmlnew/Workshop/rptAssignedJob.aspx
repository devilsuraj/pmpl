<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rptAssignedJob.aspx.vb"
    Inherits="KDMT.Workshop_rptAssignedJob" EnableEventValidation="true" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Assign Job Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%--<script language="javascript" src="<% =Session("host") %>includes/scripts/jquery.autocomplete.js"></script>
    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>--%>
     <script src="http://us-pc/nmmt_dev/includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>
<script language="javascript" src="http://us-pc/nmmt_dev/includes/scripts/jquery.autocomplete.js"></script>
<link rel="stylesheet" href="http://us-pc/nmmt_dev/css/jquery.autocomplete2.css" />

<script language="javascript"> 
    
function printpage()
{
    window.print();
}
function Mechdetails()
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
            
             if (i==8)
            {
            document.getElementById("txtmech").value = ele[i];
            }
            
            
            }
            }
            }
if (document.getElementById ("txtMechanicName").value != '')
    {
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=Mechdetails&jobno="+document.getElementById ("txtmech").value,true);
    xmlHttp.send(null);
    }
}

		</script>

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
                        <table id="Table1" width="100%" border="1" align="left" cellpadding="5" cellspacing="5" id="Table1">
                            <tr>
                                <td colspan="4" class="innerheading" align="center">
                                    Assigned Job Report
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    From Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dtfromDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="right">
                                    To Date :
                                </td>
                                <td align="left">
                                    <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                           
                             <tr>
                                <td colspan="4" align="center">
                                    Mechanic Name 
                                   <input type="text" id="txtMechanicName" style="width: 140px" class="textfield" 
                                        runat="server" />
                                </td>
                            </tr>
                               
                           
                            <tr>
                                <td colspan="4" align="center">
                                    <label>
                                        <asp:Button ID="btnshow" runat="server" Text="Show" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <div align="center">
                                        <asp:DataGrid ID="grdMechlist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                            Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                            ForeColor="Black" Font-Size="11pt" meta:resourcekey="grdirrlistResource1">
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
                                                <asp:BoundColumn DataField="joccode" HeaderText="Job No" Visible="true"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No" ></asp:BoundColumn>
                                                 <asp:BoundColumn DataField="mechid" HeaderText="Mechanic Name" Visible="true"></asp:BoundColumn>
                                                
                                               <%-- <asp:BoundColumn DataField="deffect_decr" HeaderText="Deffect" Visible="true"></asp:BoundColumn>--%>
                                                <asp:BoundColumn DataField="jobindate" HeaderText="Job In Date" FooterStyle-Width="100px"><FooterStyle Width="100px"></FooterStyle>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobclosedate" HeaderText="Job Close Date" FooterStyle-Width="100px"><FooterStyle Width="100px"></FooterStyle>
                                                </asp:BoundColumn>
                                                 <asp:BoundColumn DataField="closejob_remark" HeaderText="Status" FooterStyle-Width="100px"></asp:BoundColumn>
                                                
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="Button1" runat="server" Width="87px" Text="Print"></asp:Button>
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

	

	
	$("#txtMechanicName").autocompleteArray(
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
    </script>

</body>
</html>


