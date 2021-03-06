<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="rptoilpo.aspx.vb"
    Inherits="kdmt.rptoilpo" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Po Print</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <script language="javascript" type="text/javascript">
 
	   function printpage()
		{
		window.print();
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

    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Job Order Card Master</h1>
    </div>
    <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
 
 
    <a href="../fuel/oilPO.aspx" class="ctrl">Back</a>
     <div class="form-horizontal">>

        <script src="<% =session("host") %>SpryAssets/SpryMenuBar.js" type="text/javascript"></script>

        <link href="<% =session("host") %>SpryAssets/SpryMenuBarVertical.css" rel="stylesheet"
            type="text/css">

        <script src="<% =Session("host") %>includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>

        <script language="javascript" src="<% =Session("host") %>includes/scripts/jquery.autocomplete.js"></script>

        <link rel="stylesheet" href="<% =Session("host") %>css/jquery.autocomplete2.css" />

        <script type="text/javascript">


function findValue(li) {
	if( li == null ) return alert("No match!");

	// if coming from an AJAX call, let's use the CityId as the value
	if( !!li.extra ) var sValue = li.extra[0];

	// otherwise, let's just display the value in the text box
	else var sValue = li.selectValue;

	//alert("The value you selected was: " + sValue);
}

function selectItem(li) {
	findValue(li);
}
    
//-->
        </script>

        <table id="Table2" align="center" cellspacing="0" class="ctrl" cellpadding="0" border="1"
            style="width: 650px" runat="server">
            <tr>
                <td align="ledt" colspan="2">
                    Vendor Name:
                    <asp:TextBox ID="txtvendor" onblur="chkvendorname()" runat="server" Width="216px">
                    </asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <span>Po No</span>
                    <asp:TextBox ID="txtPONo" runat="server"></asp:TextBox>
                </td>
                <td>
                    Po Year :
                    <asp:DropDownList ID="ddlfinancecalendar" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Print Type :
                    <asp:DropDownList ID="ddlprint" runat="server">
                        <asp:ListItem Text="RECORD(Purchase Section Copy)"></asp:ListItem>
                        <asp:ListItem Text="ORIGINAL"></asp:ListItem>
                        <asp:ListItem Text="A. S. R. T. U Copy"></asp:ListItem>
                        <asp:ListItem Text="TRIPLICATE(Receipt Cell Copy)"></asp:ListItem>
                        <asp:ListItem Text="DUPLICATE(Audit Section Copy)"></asp:ListItem>
                        <asp:ListItem Text="OFFICE COPY1"></asp:ListItem>
                        <asp:ListItem Text="OFFICE COPY2"></asp:ListItem>
                        <asp:ListItem Text="EXTRA COPY"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    Print Type :
                    <asp:DropDownList ID="ddlprinttype" runat="server">
                        <asp:ListItem Text="front"></asp:ListItem>
                        <asp:ListItem Text="back"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btn_showpo" runat="server" Text="Show" />
                </td>
            </tr>
        </table>
    </div>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="0" style="width: 650px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt;">
                 <asp:Label ID="Label18" runat="server" Text="Pune Mahanagar Parivahan Mahamandal Limited" Visible=false ></asp:Label>
                 </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">
                <asp:Label ID="Label19" runat="server" Text="Swargate, Pune 411037" Visible=false ></asp:Label>
                &nbsp; </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <span style='font-family: Times New Roman; font-size: 12px; width: auto;'>
                 <asp:Label ID="Label3" runat="server" Text="Main Bldg.Near
                    IncomeTax Office" Visible=false ></asp:Label>  
                </span><br />
                <span style='font-family: Times New Roman; font-size: 12px;'>
                <asp:Label ID="Label4" runat="server" Text=" Shankarseth Road" Visible=false ></asp:Label>  
               </span>
            </td>
            <td align="right" colspan="2">
                <span style='font-family: Times New Roman; font-size: 12px;'>
                 <asp:Label ID="Label5" runat="server" Text="Email :pmpmlstore@yahoo.com" Visible=false ></asp:Label>  
               </span>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
               <br />
                 <asp:Label ID="Label2" runat="server" Text="Code No." Visible=false ></asp:Label>  
                <asp:Label ID="lblprinttype" Style='font-family: Times New Roman; font-size: 12px;'
                    runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="right" colspan="2" width="650px">
             <asp:Label ID="Label6" runat="server" Text="Ph :24503307/220" Visible=false ></asp:Label> 
              
                <br />&nbsp;
                <asp:Label ID="Label7" runat="server" Text="Fax: 24441268" Visible=false ></asp:Label> 
               
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
              <asp:Label ID="Label1" runat="server" Text=TO, Visible=false ></asp:Label>  
            </td>
            <td align="right" colspan="2" width="650px" style="font-weight: bold">
            <asp:Label ID="Label8" runat="server" Text=" P.O.  NO.  :" Visible=false ></asp:Label>
               &nbsp; &nbsp;<asp:Label ID="lblPONoStr" runat="server" Font-Bold="true"></asp:Label>
                <asp:Label ID="lblPONo" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
              <asp:Label ID="Label9" runat="server" Text="     M/s." Visible=false ></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;<asp:Label ID="lblVendorName" Style='font-family: Times New Roman;
                    font-size: 18px;' runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="right" colspan="2" width="650px">
                <span style='font-family: Times New Roman; padding-right: 50px; font-size: 12px;'>
                 <asp:Label ID="Label10" runat="server" Text=" Date:" Visible=false ></asp:Label>
                
                    <asp:Label ID="lblPoDate" runat="server" CssClass="lbtxt"></asp:Label></span>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" class="style1" width="650px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblAdd1" Style='font-family: Times New Roman;
                    font-size: 12px;' runat="server" Font-Bold="true"></asp:Label>
                &nbsp; &nbsp;
            </td>
            <td align="right" colspan="2" width="650px" style="padding-right: 100px">
                <span style='font-family: Times New Roman; font-size: 12px;'>
                 <asp:Label ID="Label11" runat="server" Text="Our Ref. No." Visible=false ></asp:Label>
              
                    <asp:Label ID="lblORN" runat="server" Font-Bold="true"></asp:Label>
                </span><span style='font-family: Times New Roman; font-size: 12px;'>
                 <asp:Label ID="Label12" runat="server" Text=" Date" Visible=false ></asp:Label>
               <asp:Label
                    ID="lblORD" runat="server" Font-Bold="true"></asp:Label></span>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblAdd2" Style='font-family: Times New Roman;
                    font-size: 12px;' runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="right" colspan="2" width="650px" style="padding-right: 100px">
                <span style='font-family: Times New Roman; font-size: 12px;'>
                 <asp:Label ID="Label13" runat="server" Text="Your Ref. No." Visible=false ></asp:Label>
                
                    <asp:Label ID="lblYRN" runat="server" Font-Bold="true"></asp:Label></span><span style='font-family: Times New Roman;
                        font-size: 12px;'>
                         <asp:Label ID="Label14" runat="server" Text=" Date" Visible=false ></asp:Label>
                        </span>
                <asp:Label ID="lblYRD" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" width="650px">
             <asp:Label ID="Label15" runat="server" Text="Contact No :-" Visible=false ></asp:Label>
                
                <asp:Label ID="lblAdd3" Style='font-family: Times New Roman;
                    font-size: 12px;' runat="server" Font-Bold="true"></asp:Label>
            </td>
            <td align="center" colspan="2" width="650px">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                <span style="font-family: Times New Roman; font-size: 12px;">
                <asp:Label ID="Label16" runat="server" Text="Please Supply the articles
                    as per details given below on conditions state hereunder and overleaf as will as
                    in accordance with the Terms and conditions in the acceptance of your tender" Visible=false ></asp:Label>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left">
                <span style='font-family: Times New Roman; font-size: 12px;'>
                <asp:Label ID="Label17" runat="server" Text="Ref :" Visible=false ></asp:Label>
                </span>
                <asp:Label ID="lblref_asrtu" Style='font-family: Times New Roman; font-size: 12px;'
                    runat="server" Width="96px" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" valign="top">
                <div align="center">
                    <asp:Literal ID="htmldetails" runat="server"></asp:Literal>
                </div>
            </td>
        </tr>
    </table>
    <table id="tblback" align="center" cellspacing="0" runat="server" cellpadding="0"
        border="0" style="width: 650px">
        <tr>
            <td colspan="8" align="left" valign="top">
                <div align="center">
                    <asp:Literal ID="htmldetailsback" runat="server"></asp:Literal>
                </div>
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>


    <script>
  

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

</asp:Content>