<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IRR.aspx.vb" Inherits="KDMT.IRR" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Indent For Repair / Replacement Item</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
     function validate()
    {
    var ab;
    ab=document.getElementById("txtmechanic").value;
//    alert(ab);
    
            if(ab == '')
        {
            alert('Select Deffect Type');
            document.getElementById ("txtmechanic").focus();
            return false;
        }
     }
     
//  

//function chkbusno()
//{

//    var xmlHttp;
//    try
//    {
//    // Firefox, Opera 8.0+, Safari
//    xmlHttp=new XMLHttpRequest();   
//    }
//    catch (e)
//    {
//    // Internet Explorer
//    try
//    {
//    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
//    }
//    catch (e)
//    {
//    try
//    { 
//    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
//    }
//    catch (e)
//    {
//    alert("Your browser does not support AJAX!");
//    return false;
//    }
//    }
//    }
//    xmlHttp.onreadystatechange=function()
//    {
//    if(xmlHttp.readyState==4)
//    {
//    resp = ""
//    resp = xmlHttp.responseText;
//    var ele1 = resp;

//    if(ele1=="NO-SUCH-ITEM")
//    {
////    alert("No Such Bus Present");
//    document.getElementById ("ddlbusno").focus();
//    }
//    }
//    }
//if (document.getElementById ("ddlbusno").value != '')
//    {
//    xmlHttp.open("GET","~/store/Ajaxstore.aspx?Action=chkbusno&busno="+document.getElementById ("ddlbusno").value,true);
//    xmlHttp.send(null);
//    }
//}

function test()
{
     alert("Your browser does not support AJAX........................!");
}

function chkbusdetails()
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
            document.getElementById("hdnjocid").value = ele[i];
            }
            if (i==1)
            {
            document.getElementById("ddljobno").value = ele[i];
            }
            if (i==2)
            {
            document.getElementById("txtmodel").value = ele[i];
            }
             if (i==3)
            {
            document.getElementById("txtchassis").value = ele[i];
            }
           
             if (i==4)
            {
            document.getElementById("txtkms").value = ele[i];
            }
             if (i==5)
            {
            document.getElementById("txtengine").value = ele[i];
            }
            
             if (i==6)
            {
            document.getElementById("txtjobmachanic").value = ele[i];
            }
             if (i==7)
            {
            document.getElementById("txtinspnote").value = ele[i];
            }
            
             if (i==8)
            {
            document.getElementById("txtdeffect").value = ele[i];
            }
            }
            }
            }
if (document.getElementById ("ddlbusno").value != '')
    {
    
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkbusdetailsIRR&busno="+document.getElementById ("ddlbusno").value,true);
    xmlHttp.send(null);
    }
}
function chkjobdetails()
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
            document.getElementById("hdnjocid").value = ele[i];
            }
            if (i==1)
            {
            document.getElementById("ddlbusno").value = ele[i];
            }
            if (i==2)
            {
            document.getElementById("txtmodel").value = ele[i];
            }
             if (i==3)
            {
            document.getElementById("txtchassis").value = ele[i];
            }
           
             if (i==4)
            {
            document.getElementById("txtkms").value = ele[i];
            }
             if (i==5)
            {
            document.getElementById("txtengine").value = ele[i];
            }
            
             if (i==6)
            {
            document.getElementById("txtjobmachanic").value = ele[i];
            }
            }
            }
            }
if (document.getElementById ("ddljobno").value != '')
    {
    
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkjocdetails&jocno="+document.getElementById ("ddljobno").value,true);
    xmlHttp.send(null);
    }
}

    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                                <span id="Label3">Indent For Unit Item</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td align="left">
                                <input id="hdnjocid" type="hidden" />
                            </td>
                            <td align="right">
                                IRR No
                            </td>
                            <td>
                                <asp:TextBox ID="txtirrno" runat="server" Width="50px" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Job Card No.
                            </td>
                            <td>
                                <%--<asp:TextBox ID="txtjobNo" runat="server" Width="140px" ReadOnly="false" 
                                    AutoPostBack="True"></asp:TextBox>--%><input type="text" id="ddljobno" style="width: 182px"
                                        class="textfield"  runat="server" readonly="readonly" />
                            </td>
                            <td align="right">
                                Bus No.
                            </td>
                            <td>
                                <%--<asp:TextBox ID="txtBusNo" runat="server" Width="140px" ReadOnly="false"></asp:TextBox>--%>
                                <input type="text" id="ddlbusno" style="width: 120px" class="textfield" onblur="chkbusdetails();"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Mechanic Name: :
                            </td>
                            <td align="left">
                                <%-- <asp:TextBox ID="txtmechanic" runat="server" Width="140px" ReadOnly="false"></asp:TextBox>--%>
                                <input type="text" id="txtmechanic" style="width: 120px" class="textfield" runat="server" />
                            </td>
                            <td align="right">
                                Job Time
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtjotime" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                Details of Job Card
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Model:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtmodel" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                            </td>
                            <td align="right">
                                Chassis:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtchassis" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                KMS:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtkms" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                            </td>
                            <td align="right">
                                Engine:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtengine" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Assign Mechanic Name:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtjobmachanic" runat="server" Width="140px" ReadOnly="true"></asp:TextBox>
                            </td>
                            <td align="right">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                          <tr>
                            <td align="right">
                                Deffect Details :</td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtdeffect" runat="server" ReadOnly="true" Width="449px" Height="50px"
                                    BackColor="White" Enabled="true" ForeColor="Black" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Inspection Note:
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtinspnote" runat="server" ReadOnly="true" Width="350px" Height="70px"
                                    BackColor="White" Enabled="true" ForeColor="Black" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Item Repair:                             </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlrepait" runat="server" Width="325px">
                                   <%-- <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Engine" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Electrical Section" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Unit" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Gearbox and Diff." Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Machine Shop" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Tyre Section" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="Radiator" Value="7"></asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Part No :
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtpartno" runat="server" Width="140px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Remark :
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtremark" runat="server" Width="350px" Height="70px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                <label>
                                    <!-- <input name="Save" type="button" id="btnSave" value="Save" onclick="ValidateSave();" /> -->
                                    <%--<asp:ImageButton ID="btnSave" runat="server" ImageUrl="../images/btn_h.gif" TabIndex="9" >
                                    </asp:ImageButton>--%>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" />
                                </label>
                                <%--<a href="../report/rptIRR.aspx">Save</a>--%>
                                <asp:Button ID="btnreset" runat="server" Text="Reset" Height="32px" Width="63px" />
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

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

$("#ddljobno").autocompleteArray(
		[<% =strJocno  %>],
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
	
	
	$("#ddlbusno").autocompleteArray(
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
	
	$("#txtmechanic").autocompleteArray(
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
