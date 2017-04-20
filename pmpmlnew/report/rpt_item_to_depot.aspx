<%@ Page Language="VB" AutoEventWireup="false" EnableEventValidation="false" CodeFile="rpt_item_to_depot.aspx.vb"
    Inherits="KDMT.rpt_item_to_depot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<html>
<head>
    <title>Depot Wise Summary Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->

    <script language="javascript"> 
	   function printpage()
		{
		window.print();
		}
		
		
		
///////////   for removing blaak spaces 
String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
}


function  check()
{
    var str = document.getElementById('ddlitem').value;
    if (str.trim() !='')
    {
    ajaxFunction();
    }
    return false;
}
        
function  check1()
{
document.getElementById('Select1').style.display="none";  
    var str = document.getElementById('ddlitem').value;
    if (str.trim() !='')
    {
    Fromcombo2();
    }
    return false;
}
        
        
             		

function Fromcombo2()
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
    var ele1 = resp.split('|');

    document.getElementById('txtPartNo').value=ele1[2];
    document.getElementById('txtlfno').value=ele1[3];
    }
    }
    var itemname= document.getElementById('ddlitem').value  ;
    var lfno = document.getElementById('txtlfno').value;
    var partno = document.getElementById('txtPartNo').value;
    if (document.getElementById('ddlitem').value  != '')
    {
    xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno  + "&partno=" + partno ,true);
   
   //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
    xmlHttp.send(null);
     }
}
					
		
function ajaxFunction()
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

if (resp == 0)
{
document.getElementById("Select1").style.display='none';
return false;
}

var ele = resp.split("!");

while(document.getElementById("Select1").options.length > 0)

document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
if(document.getElementById('ddlitem').value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtPartNo').value != "")
{

for (var i = 0; i < ele.length; i++)
{

var temp=document.getElementById("Select1")
temp.style.display='';
temp.size=ele.length;
newOpt = document.createElement("option");
document.getElementById("Select1").options.add(newOpt);

newOpt.value = ele[i];
newOpt.text  = ele[i];
if (document.Form1.ddlitem.value==ele[i])
{
// temp.style.display="none";				               
// return false;
}
if (ele[i]=="0")
{
//temp.style.display="none";				               
//  return false;
}			
                         
}

}
else
{
var temp=document.getElementById("Select1")
temp.size=0
//temp.style.display="none";
temp.style.display='';
}
}
}
var lfno = document.getElementById('txtlfno').value;
var partno = document.getElementById('txtPartNo').value;
if(lfno == "" && partno == "")
{
if(document.getElementById('ddlitem').value.length >=3)
{
url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
}
else
{
document.getElementById("<%= Select1.clientID %>").style.display='none'
}

}
else
{
    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
}
//xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&lfno=" + lfno + "&partno=" + partno ,true);
	//	xmlHttp.open("GET","../store/AjaxStore.aspx?Action=item&itemname="+document.Form1.txtitem.value,true);

//xmlHttp.send(null);

}



function Select()
{

    var resultStr = ""; 
    objddl2 =document.getElementById('Select1');
    for(var i = 0; i < objddl2.options.length; i++ )
    {  
    if( objddl2.options[i].selected ) 
    {    
    resultStr+= (objddl2.options[i].text);
    var objddl1 = document.getElementById('ddlitem');
    objddl1.value=resultStr;
    var x=document.getElementById('Select1');
  //  x.style.visibility="hidden"
     setTimeout(function(){document.getElementById('ddlitem').focus()}, 10);
//temp.style.display="none";
//x.style.display='';
    document.getElementById('Select1').style.display="none";  
    //return false;
    //alert(resultStr)
    } 
    } 

}
						
									
function emptytext()
{
    if (document .getElementById ('txtPartNo').value !='' && document .getElementById ('ddlitem').value !='' )
    {
    document .getElementById ('txtPartNo').value='';
    document .getElementById ('ddlitem').value='';
    }
}

function emptytextpart ()
{
    if (document .getElementById ('txtlfno').value !='' && document .getElementById ('ddlitem').value !='' )
    {
    document .getElementById ('txtlfno').value='';
    document .getElementById ('ddlitem').value='';
    }
}

    </script>

    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server" class="ctrl">
        <tr>
            <td class="text3" align="center" style="height: 22px">
                <strong><span style="font-size: 11pt; color: black">Item Issued To All Depots Report
                    &nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td align="left">
                LF NO :
                <asp:TextBox class="textfield" ID="txtlfno" onblur="emptytext();ajaxFunction();"
                    runat="server" Width="100px" Height="22px"></asp:TextBox>
            </td>
            <td>
                Part No :
                <asp:TextBox class="textfield" ID="txtPartNo" onblur="emptytextpart();ajaxFunction();"
                    runat="server" Width="100px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                Select Item Name
                <asp:TextBox ID="ddlitem" onpropertychange="return check();" onblur="return check1();"
                    runat="server" Width="400px"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:ListBox ID="Select1" Style="display: none; align: center"
                    onclick="Select();" runat="server" onchange="Select();"></asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
                To Date
                <BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
                <asp:Button ID="btnshow" runat="server" Text="Show" />
            
            </td>
            <td>
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
            </td>
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Item Issued To All Depots Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="Center" colspan="4">
                <asp:Label ID="lblcat" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <asp:Label ID="lblname" runat="server"></asp:Label>
            </td>
            <td align="right" colspan="2">
                <asp:Label ID="lbllf" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <asp:Label ID="lblbin" runat="server"></asp:Label>
            </td>
            <td align="right" colspan="2">
                <asp:Label ID="lblpart" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px" colspan="2">
                <asp:Label ID="Label4" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                <asp:Label ID="lblfrom" runat="server" Width="168px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="height: 19px" colspan="2">
                <asp:Label ID="Label5" runat="server" Width="168px" Font-Bold="True"></asp:Label>
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
                        Width="750px" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderStyle="None" BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False"
                        Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" ForeColor="Black">
                        <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                        <ItemStyle ForeColor="#000066" />
                        <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                            Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <Columns>
                            <asp:TemplateColumn HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="cont_name" HeaderText="Depot Name" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <%-- <asp:BoundColumn DataField="cont_name" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="quantity" HeaderText="Qunatity" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <%--<tr class="ctrl">
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>--%>
    </table>
    </form>
</body>
</html>
