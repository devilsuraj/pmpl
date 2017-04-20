<%@ Page Language="VB" AutoEventWireup="false" CodeFile="R_Y_G_summery.aspx.vb" Inherits="KDMT.report_R_Y_G_summery" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Red Yellow Green Summery</title>
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
if(document.Form1.ddlitem.value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtPartNo').value != "")
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
xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&lfno=" + lfno + "&partno=" + partno ,true);
	//	xmlHttp.open("GET","../store/AjaxStore.aspx?Action=item&itemname="+document.Form1.txtitem.value,true);

xmlHttp.send(null);

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
    x.style.display="none";  
    return false;
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
            <td class="text3" align="center" style="height: 22px" colspan="4">
                <strong><span style="font-size: 11pt; color: black"> Red/Yellow/Green Level 
                Items Summery Report &nbsp;</span></strong>
            </td>
        </tr>
        
           
        <%--<tr>
            <td>
                Consumption and Stock :
            </td>
            <td>
                <asp:DropDownList ID="ddl_cons_stock" runat="server">
                    <asp:ListItem Text="ALL" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Both Nil" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Consumption Nil But Stock Not Nil" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Consumption Not Nil But Stock  Nil" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Both Not Nil" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr> --%>
        <tr>
        <td> Category :&nbsp;
                <asp:DropDownList ID="drbType" runat="server">
                    <%-- <asp:ListItem Text="All" Value="0"></asp:ListItem>--%>
                    <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Kit Section" Value="3"></asp:ListItem>
                    <asp:ListItem Text="STN" Value="4"></asp:ListItem>
                </asp:DropDownList>
                </td>
        </tr>
        <tr>
            <td>
                From Date :&nbsp;
                <bdp:bdplite ID="BDPLite1" runat="server">
                </bdp:bdplite>
            </td>
            <td>
                &nbsp;</td>
            <td>
                To Date             </td>
            <td>
                <bdp:bdplite ID="BDPLite2" runat="server">
                </bdp:bdplite>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnshow" runat="server" Text="Show" />
                <asp:Button ID="btnCry0" runat="server" Text="Convert To Excel" />
                <asp:Button ID="btnCry" runat="server" Text="Crystal Report" />
            </td>
        </tr>
    </table>
    <div id="crydv" runat="server" >
        <CR:CrystalReportViewer ID="crst_item_act" runat="server" AutoDataBind="true" />
    </div>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL 
                LIMITED        </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">&nbsp;R/Y/G Report </span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <asp:Label ID="lblcategory" runat="server"></asp:Label>
            </td>
            <td align="right" colspan="2">
                <asp:Label ID="lblimovingtype" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                <asp:Label ID="lblcons_stock" runat="server"></asp:Label>
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
                            <asp:BoundColumn DataField="months" HeaderText="MONTHS(2015-2016)" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="red_list" HeaderText="Red List Items " ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="yellow_list" HeaderText="Yellow List Items" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="green_list" HeaderText="Green List Items" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="total_items" HeaderText="Total Items" ItemStyle-HorizontalAlign="right">
                            </asp:BoundColumn>                            
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
