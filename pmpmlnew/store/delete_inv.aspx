<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="delete_inv.aspx.vb" Inherits="KDMT.delete_inv" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Delete Issue Item</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />

    <script language="javascript">
var clockID = 0;

function UpdateClock() {
   if(clockID) {
      clearTimeout(clockID);
      clockID  = 0;
   }

   var tDate = new Date();

   lbltime.innerHTML = "" + tDate.getHours() + ":" + tDate.getMinutes() + ":" + tDate.getSeconds();
   
   clockID = setTimeout("UpdateClock()", 1000);
}
function StartClock() {
   clockID = setTimeout("UpdateClock()", 500);
}

function KillClock() {
   if(clockID) {
      clearTimeout(clockID);
      clockID  = 0;
   }
}

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


function Validate ()
{
   var rowCount = document.getElementById("dgresult").rows.length;
var i=1;
var j=0;
    for (i=2;i<=rowCount;i++)
    {
    var id = 'dgresult__ctl' + i + '_check'
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
    
if(!confirm("Do you want to Delete Invoice Item"))
    {
    return(false);
    }

}


function chkall ()
{
    if (document.getElementById('dgresult__ctl1_chk_header').checked==true)
    {
        var rowCount = document.getElementById("dgresult").rows.length;
        var i=1;
        for (i=2;i<=rowCount;i++)
        {
        var id = 'dgresult__ctl' + i + '_check'
        document.getElementById(id).checked = true
        }
    }    
    else
    {
        var rowCount = document.getElementById("dgresult").rows.length;
        var i=1;
        for (i=2;i<=rowCount;i++)
        {
        var id = 'dgresult__ctl' + i + '_check'
        document.getElementById(id).checked = false 
        }
    }
}

    </script>

    <style type="text/css">
        .style1
        {
            height: 22px;
        }
    </style>
        <link href="../css/newmvc.css" rel="stylesheet" />
</asp:content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
      <div class="breadcrumbs">
        <h1>Delete Invoice Item </h1>
    </div>
    <asp:HiddenField ID="hdnrowcount" runat="server" />
    <div align="center">
    
        <div id="middal">
         
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                    
                        <tr>
                            <td align="right">
                                vendor Name
                            </td>
                            <td>
                                <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                                    runat="server" />
                            </td>
                            <td align="right">
                                Invoice No
                            </td>
                            <td>
                                <asp:TextBox ID="txtinvoice" runat="server" BackColor="#FFFFC0" ToolTip="Enter Invoice No"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Fromdate
                            </td>
                            <td align="left">
                           
                                            <asp:TextBox ID="bdpfromdate" Width="100px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="bdpfromdate"
                                                PopupButtonID="bdpfromdate" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                                           
                            </td>
                            <td align="right">
                                To Date
                            </td>
                            <td align="left">
                            
                                             <asp:TextBox ID="bdptodate" Width="100px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="bdptodate"
                                                PopupButtonID="bdptodate" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                                            <asp:ScriptManager ID="Scriptmanager2" runat="server">
                                            </asp:ScriptManager>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                    </table>
                    <table id="tblcontain" runat="server">
                        <tr runat="server">
                            <td colspan="2" align="center">
                                <asp:Literal ID="htmlchallan" runat="server"></asp:Literal>
                            </td>
                        </tr>
                       
                        <tr id="trbtn" runat="server">
                            <td align="center" colspan="2" class="style1">
                                <asp:Button ID="btn_del" Text="Delete" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">

$("#txtvendor").autocomplete(
		
		{
			source:[<% =strvendor  %>]
		}
	);



    </script>

</asp:content>