<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Itemrepair.aspx.vb" Inherits="KDMT.Itemrepair" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Traffic - Log Sheet Submission</title>
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

   //lbltime.innerHTML = "" + tDate.getHours() + ":" + tDate.getMinutes() + ":" + tDate.getSeconds();
   
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

//function add()
//		{
//		       
//		var   row   =   document.all.DataGrid1.insertRow(DataGrid1.rows.length);   
//        var   cell   =   row.insertCell();   
//        cell.innerHTML   = "<select style='WIDTH: 73px'><option value='4.75'>4.75</option><option value='5.75'>5.75</option></select>";   
//        var   cell2   =   row.insertCell();   
//        cell2.innerHTML   =   "<input   type='TextBox' id='txtSrNo' style='WIDTH: 121px; HEIGHT: 22px'  name='test'>";   
//        var   cell3   =   row.insertCell();   
//        cell3.innerHTML   =   "<input   type='TextBox' id='txtEndSrNo' style='WIDTH: 121px; HEIGHT: 22px' onchange='add()'  name='test'>";
//        var   cell4   =   row.insertCell();   
//        cell4.innerHTML   =   "<input   type='TextBox' id='no' style='WIDTH: 121px; HEIGHT: 22px' readonly = 'true'  name='test'>";   
//        var   cell5   =   row.insertCell();   
//        cell5.innerHTML   =   "<input   type='TextBox' style='WIDTH: 121px; HEIGHT: 22px text-align=right' id='no2' readonly = 'true' name='test'>";
//      }
      
      // textfield vaidations
      
   
      
      // check for numeric fields only
      
              function IsNumeric(strString)
				{
				var ValidChars = "0123456789.";
				var Char;
					for (i = 0; i < strString.length; i++) 
				{ 
					Char = strString.charAt(i); 
					if (ValidChars.indexOf(Char) == -1) 
					{
					return false;
					}
				}
				return;
				}
				
				

				
				
		
			
			
            function ticFunction2()
			{
			 LogSheet2();
			}
			function ticFunction1()
			{
			 BLogSheet();
			}
			
			
			function Fromcombo()
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
                            var ele1 = resp.split("!");
                            while(document.getElementById("ddlitem").options.length > 0)
                            document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length-1);
                            document.getElementById("ddlitem").value=="";
                            var temp=document.getElementById("ddlitem")
                           //if(document.Form1.txtroute.value !="")
                          // {
                             for (var i = 0; i < ele1.length-1; i++)
                             {
                               var temp=document.getElementById("ddlitem")
				           		newOpt = document.createElement("OPTION");
								document.getElementById("ddlitem").options.add(newOpt);
								newOpt.value = ele1[i];
								newOpt.innerText  = ele1[i];
//								//if (document.Form1.txtroute.value==ele1[i])
//								//{
//								//    temp.style.display="none";				               
//				               //     return false;
//								}
//                               	if (ele1[i]=="0")
//								{
//								    temp.style.display="none";				               
//				                    return false;
//								}			                         
                              }
                             
							//}
							
							//else
							//{
							//var temp=document.getElementById("ddlfrom")
							//temp.size=0;
							//temp.style.display="none";
							//}
						}
					}
					var cat=document.Form1.ddlcat.value;
					//alert(cat);
					xmlHttp.open("GET","Ajaxstore.aspx?Action=itemname&itemid="+document.Form1.ddlcat.value,true);
					xmlHttp.send(null);
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
                            var ele1 = resp;
                            
//                            while(document.getElementById("ddlitem").options.length > 0)
//                            document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length-1);
//                            document.getElementById("ddlitem").value=="";
                            Form1.txtbqty.value=ele1
                                                    
						}
					}
					var cat=document.Form1.ddlitem.value;
					//alert(cat);
					xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+document.Form1.ddlitem.value,true);
					xmlHttp.send(null);
			}
			
			

    </script>

</head>
<body class="body" onload="StartClock();">
    <form id="Form1" runat="server">
        <table cellspacing="0" cellpadding="0" width="1002" border="0">
            <tr>
                <td valign="top" background="../images/top.jpg" height="114">
                    &nbsp;
                    <table id="Table8" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td align="right">
                                <table id="Table9" cellspacing="0" cellpadding="0" width="70%" border="0">
                                    <tr>
                                        <td width="532">
                                        </td>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Width="65px"></asp:Label></td>
                                        <td>
                                            <a href="login.aspx">Sign Out </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="532">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="532">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 55px">
                    <ul class="solidblockmenu">
                        <li>
                            <div align="center">
                                <a href="../store/storemaster.aspx">Store Mangment</a></div>
                            <li>
                                <div align="center">
                                    <a href="../report/Storereport.aspx">Reports</a>
                                </div>
                                <li>
                                    <div align="center">
                                        <a href="#">Admin</a>
                                    </div>
                                </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" align="center" border="0" style="width: 760px">
                        <tr>
                            <td colspan="6" style="width: 731px">
                                <table cellspacing="0" cellpadding="0" width="98%" border="0">
                                    <tr>
                                        <td valign="top" background="../images/bg_M1.gif" style="width: 726px">
                                            <table cellspacing="0" cellpadding="0" width="98%" border="0">
                                                <tr>
                                                    <td valign="top" background="../images/bg_M1.gif" style="height: 524px">
                                                        <table cellspacing="0" cellpadding="0" border="0" style="width: 102%">
                                                            <tr>
                                                            </tr>
                                                            <tr>
                                                                <tr>
                                                                    <td style="height: 187px">
                                                                        <table class="text3" cellspacing="0" cellpadding="0" align="center" border="0" width="100%">
                                                                            <tbody>
                                                                                <tr class="heading1" style="font-weight: bold">
                                                                                    <td width="110" bgcolor="#286381" style="height: 27px">
                                                                                        <a href="storeitemmaster.aspx" style="color: #fff; text-decoration: none;">Master</a>
                                                                                    </td>
                                                                                    <td width="140" bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <a class="heading1" href="storemaster.aspx">Stock rceived</a></td>
                                                                                    <td width="140" bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <a class="heading1" href="storeissue.aspx">Stock Issue</a></td>
                                                                                    <td width="90" bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <a href="#" class="anchorclass" style="color: #fff; text-decoration: none;" rel="submenu2">
                                                                                            Item</a>
                                                                                        <div id="submenu2" class="anylinkcss">
                                                                                            <ul>
                                                                                                <li><a href="Updateitem.aspx">Update Item</a></li>
                                                                                                <li><a href="itemrepair.aspx">Repair Item</a></li>
                                                                                                <li><a href="itemdamag.aspx">Damage Item</a></li>
                                                                                                <li><a href="deletereceiveitem.aspx">Delete Receive/Reject Item</a></li>
                                                                                                <li><a href="deleteitem.aspx">Delete Issue Item</a></li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;" align="center">
                                                                                        <asp:Label ID="Label2" runat="server" Text="Item Repair" Font-Size="14pt"></asp:Label></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 45px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                        &nbsp; Contractor Name:-
                                                                                        <asp:DropDownList ID="ddlcont" runat="server" Width="176px" AutoPostBack="True">
                                                                                        </asp:DropDownList></td>
                                                                                    <td colspan="10" style="height: 7px; width: 9px;" align="left">
                                                                                        &nbsp;&nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <%-- <tr>
                                                                        <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                            &nbsp;Category Name:-
                                                                            <asp:DropDownList ID="ddlvendor" runat="server" Width="160px" AutoPostBack="True">
                                                                            </asp:DropDownList></td>
                                                                        <td colspan="10" style="height: 7px; width: 9px;" align="left"  >
                                                                            &nbsp;&nbsp;
                                                                            </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" colspan="10" style="height: 6px; width: 716px;">
                                                                        </td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td colspan="10" style="height: 7px; width: 716px;" align="center">
                                                                         &nbsp; &nbsp;             &nbsp; Item Name :-
                                                                            <asp:DropDownList ID="ddlitemname" runat="server" Width="160px">
                                                                            </asp:DropDownList></td>
                                                                    </tr>--%>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;" align="center">
                                                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Date
                                                                                        :-
                                                                                        <BDP:BasicDatePicker ID="BDPLite1" runat="server" Width="160px">
                                                                                        </BDP:BasicDatePicker>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10" style="height: 7px; width: 716px;" align="center">
                                                                                        &nbsp; &nbsp; &nbsp; item in/out:-
                                                                                        <asp:DropDownList ID="ddlin" runat="server" Width="160px">
                                                                                            <asp:ListItem Value="1">IN</asp:ListItem>
                                                                                            <asp:ListItem Value="2">OUT</asp:ListItem>
                                                                                        </asp:DropDownList></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="height: 8px; width: 716px;" colspan="10">
                                                                                        &nbsp;</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                        &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; Quantity :-
                                                                                        <asp:TextBox ID="txtamount" runat="server" Width="160px"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                        &nbsp;&nbsp; GatePass No :-
                                                                                        <asp:TextBox ID="txtgate" runat="server" Width="160px"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; Vehicle No :-
                                                                                        <asp:TextBox ID="TextBox1" runat="server" Width="176px"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" colspan="10" style="height: 7px; width: 716px;">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="height: 7px" colspan="7">
                                                                                        &nbsp;<table id="Grd_Item" border="1" cellpadding="1" cellspacing="1" class="heading1"
                                                                                            height="51" style="width: 704px" runat="server">
                                                                                            <tr>
                                                                                                <td style="width: 25%; height: 24px">
                                                                                                    Category</td>
                                                                                                <td style="width: 25%; height: 24px">
                                                                                                    Item Name</td>
                                                                                                <td style="width: 25%; height: 24px">
                                                                                                    Available Quantity</td>
                                                                                                <td style="width: 25%; height: 24px">
                                                                                                    Quantity</td>
                                                                                                <td style="height: 24px">
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td align="left" style="width: 316px; height: 28px;">
                                                                                                    <asp:DropDownList ID="ddlcat" runat="server" onchange="Fromcombo()" Width="248px">
                                                                                                    </asp:DropDownList></td>
                                                                                                <td align="left" style="width: 427px; height: 28px;">
                                                                                                    <asp:DropDownList ID="ddlitem" onblur="Fromcombo2()" runat="server" Width="176px">
                                                                                                    </asp:DropDownList></td>
                                                                                                <td align="left" style="width: 400px; height: 28px;">
                                                                                                    <asp:TextBox ID="txtbqty" runat="server" Width="56px"></asp:TextBox></td>
                                                                                                <td align="left" style="width: 400px; height: 28px;">
                                                                                                    <asp:TextBox ID="txtqty" onblur="ticFunction2()" runat="server" Width="56px"></asp:TextBox></td>
                                                                                                <td style="height: 28px">
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="5" style="height: 12px">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 22px">
                                                                        <div align="center">
                                                                            &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif"></asp:ImageButton><asp:ImageButton
                                                                                ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="1"></asp:ImageButton></div>
                                                                    </td>
                                                                </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 729px; height: 27px;">
                                                        <img height="27" src="../images/bg_B1.gif" width="712"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 748px; height: 19px;">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
