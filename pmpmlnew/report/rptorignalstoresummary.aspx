<%@ Page Language="VB" EnableEventValidation="false" AutoEventWireup="false" CodeFile="rptorignalstoresummary.aspx.vb"
    Inherits="KDMT.rptorignalstoresummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<html>
<head>
    <title>Item Summary Report</title>
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
//if(document.Form1.ddlitem.value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtPartNo').value != "")
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

if (lfno == "" && partno == "")
{
    if (document.getElementById ('ddlitem').value.length >=3 )
    {
    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
    }
    else
    {
   // document.getElementById("<%= Select1.clientID %>").options.length = 0;
     document.getElementById("<%= Select1.clientID %>").style.display='none'
    }
}
else
{
    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
    xmlHttp.open("GET",url ,true);
    xmlHttp.send(null);
}
}
//xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&lfno=" + lfno + "&partno=" + partno ,true);
	//	xmlHttp.open("GET","../store/AjaxStore.aspx?Action=item&itemname="+document.Form1.txtitem.value,true);

//xmlHttp.send(null);





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
    <style type="text/css">
        .style1
        {
            width: 350px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <table style="width: 750px" align="center" cellspacing="0" cellpadding="0" runat="server"
        class="ctrl" border="1">
        <tr style="height: 50px">
            <td class="text3" align="center" style="height: 22px" colspan="2">
                <strong><span style="font-size: 11pt; color: black">Item Summary Report &nbsp;</span></strong>
            </td>
        </tr>
        <tr>
            <td align="left" class="style1">
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
            <td class="style1">
                From Date
                <BDP:BDPLite ID="BDPLite1" runat="server">
                </BDP:BDPLite>
            </td>
            <td>
                To Date<BDP:BDPLite ID="BDPLite2" runat="server">
                </BDP:BDPLite>
                <asp:Button ID="btnshow" runat="server" Text="Show" />
            </td>
        </tr>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style="font-size: 15pt">PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED</span>
                </strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4" style="height: 30px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" Width="224px">Item Summary Report</asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 19px">
                <asp:Label ID="Label3" runat="server" Width="96px" Font-Bold="True">From Date:</asp:Label>
            </td>
            <td align="left" style="height: 19px">
                &nbsp;<asp:Label ID="lblfrom" runat="server" Width="225px" Font-Bold="True"></asp:Label>
            </td>
            <td align="right" style="width: 223px; height: 19px;">
                &nbsp;<asp:Label ID="Label4" runat="server" Width="96px" Font-Bold="True">To Date:</asp:Label>
            </td>
            <td align="right" style="height: 19px; width: 97px;">
                <asp:Label ID="lbltodate" runat="server" Width="96px" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="height: 18px">
                &nbsp; &nbsp; &nbsp; Item Name
            </td>
            <td style="height: 18px">
                <asp:Label ID="Label5" runat="server" Font-Bold="true" Text="Label"></asp:Label>
            </td>
            <td style="width: 223px; height: 18px;" align="right">
                <asp:Label ID="Label6" runat="server" Text="Opening Balance Qty "></asp:Label>
            </td>
            <td style="width: 97px; height: 18px;">
                <asp:Label ID="Label2" runat="server" Font-Bold="true" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                        Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                        ForeColor="Black">
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
                            <asp:BoundColumn DataField="trans_date" HeaderText="Date Of Receipt" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <%--<asp:BoundColumn DataField="item_name" HeaderText="Item"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="challan" HeaderText="Challan" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="vendor" HeaderText="Vendors" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="receive" HeaderText=" Received Qty" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="rate" HeaderText=" Rate" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="total" HeaderText="Total" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="vehicle" HeaderText="Vehicle" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="gatepass" HeaderText="GatePass No" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="refno" HeaderText="Ref No" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="trans_date1" HeaderText="Issue Date" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="contractor" HeaderText="Issued To" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <%-- <asp:BoundColumn DataField="item_name" HeaderText="Item"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="quantity" HeaderText="Issued Qty" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                            <%--   <asp:BoundColumn DataField="contractor" HeaderText="Contractor Name"></asp:BoundColumn>--%>
                            <asp:BoundColumn DataField="updatebalance" HeaderText="Balance" HeaderStyle-HorizontalAlign="Center">
                            </asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <tr class="ctrl">
            <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                <asp:Button ID="Button3" runat="server" Text="Convert to Excel" />
                <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                    Text="Print"></asp:Button>
                <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
