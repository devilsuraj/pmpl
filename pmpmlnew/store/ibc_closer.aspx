<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="ibc_closer.aspx.vb" Inherits="KDMT.ibc_closer" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>IBC close</title>
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
    
if(!confirm("Do you want to Delete Issue Item"))
    {
    return(false);
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


    </script>
        <link href="../css/newmvc.css" rel="stylesheet" />
</asp:content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
      <div class="breadcrumbs">
        <h1>IBC Close</h1>
    </div>
    <div align="center">
       
        <div id="middal">
           
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table width="100%">
                            <td>
                                vendor Name
                                <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                                    runat="server" />
                            </td>
                            <td>
                                Bank
                                <asp:DropDownList ID="ddlbank" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                IBC From Date
                         
                                 <asp:TextBox ID="dtibc" Width="100px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="dtibc"
                                                PopupButtonID="dtibc" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                                            <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                            </asp:ScriptManager>
                            </td>
                            <td>
                                IBC To Date
                            
                                 <asp:TextBox ID="dtibctodate" Width="100px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="dtibctodate"
                                                PopupButtonID="dtibctodate" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnshow" runat="server" Text="Show" />
                            </td>
                        </tr>
                    </table>
                    <table id="tblcontain" runat="server">
                        <tr id="trgrid" runat="server">
                            <td style="height: 146px" colspan="4">
                                <asp:DataGrid ID="dgresult" Width="100%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                    runat="server" AutoGenerateColumns="False" ItemStyle-CssClass="gridtxt">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <%#Container.ItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn Visible="false" DataField="ibcid"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="ibc_date" HeaderText="IBC Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="bank_name" HeaderText="Bank name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="intimateno" HeaderText="Int No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="intimate_date" HeaderText="Int Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="intimate_rec_date" HeaderText="Int Rec Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="amt_involved" HeaderText="Amt Involved"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="last_payment_date" HeaderText="Last Pay date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="material_detail" HeaderText="Material Detail"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="vendor_name" HeaderText="Vendor"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="invoice_no" HeaderText="Invoice No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="invoice_date" HeaderText="Invoice Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="invoice_amt" HeaderText="Invoice Amt"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="release_amt" HeaderText="Release Amt"></asp:BoundColumn>
                                        
                                        <asp:BoundColumn DataField="rate_po" HeaderText="PO Rates"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="chng_rate" HeaderText="Change in Rates"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="qty_dmnd" HeaderText="Qty Demand"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="qty_rec" HeaderText="Received Qty"></asp:BoundColumn>
                                        
                                        <asp:BoundColumn DataField="po_no" HeaderText="PO"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="po_date" HeaderText="PO Date"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="close">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="check" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr id="trbtn" runat="server">
                            <td style="height: 22px" align="center" colspan="4">
                                <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam1">
                </div>
            </div>
        </div>
    </div>
  

    <script type="text/javascript">
$("#txtvendor").autocomplete(

		{
		source:	[<% =strvendor  %>]
		}
	);



    </script>

</asp:content>
