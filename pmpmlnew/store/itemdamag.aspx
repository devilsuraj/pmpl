<%@ Page Language="VB" AutoEventWireup="false" CodeFile="itemdamag.aspx.vb" Inherits="KDMT.itemdamag" %>

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
//							
						}
					}
					var cat=document.Form1.ddlcat.value;
					//alert(cat);
					xmlHttp.open("GET","Ajaxstore.aspx?Action=itemname&itemid="+document.Form1.ddlcat.value,true);
					xmlHttp.send(null);
			}
			
			

    </script>

</head>
<body class="body">
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
                                        <asp:Label ID="Label1" runat="server" Width="65px"></asp:Label>
                                    </td>
                                    <td>
                                        <a href="../store/login.aspx">Sign Out </a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" align="center" border="1" style="width: 800px">
                    <tr>
                        <td style="height: 187px">
                            <table class="text3" cellspacing="0" cellpadding="0" align="center" border="0" width="100%">
                                <tbody>
                                    <tr class="heading1" style="font-weight: bold">
                                        <td width="110" bgcolor="#286381" style="height: 27px">
                                            <a href="storeitemmaster.aspx" style="color: #fff; text-decoration: none;">Master</a>
                                        </td>
                                        <td width="140" bgcolor="#286381" style="width: auto; height: 27px;">
                                            <a class="heading1" href="storemaster.aspx">Stock rceived</a>
                                        </td>
                                        <td width="140" bgcolor="#286381" style="width: auto; height: 27px;">
                                            <a class="heading1" href="storeissue.aspx">Stock Issue</a>
                                        </td>
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
                                </tbody>
                            </table>
                            <table border="1" width="800px">
                                <tr style ="height:50px">
                                    <td align="center"  colspan ="2">
                                        <asp:Label ID="Label2" runat="server" Text="Item Damage" Font-Size="14pt"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Category Name:-
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlvendor" runat="server" Width="194px" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Date :-
                                    </td>
                                    <td align="left">
                                        <BDP:BasicDatePicker ID="BDPLite1" runat="server" Width="1px">
                                        </BDP:BasicDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Item Name :-
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlitemname" runat="server" Width="168px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Quantity :-
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtqty" runat="server" Width="128px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Worker Name :-
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtworker" runat="server" Width="168px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 22px" align="right">
                                        <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif"></asp:ImageButton>
                                    </td>
                                    <td align="left">
                                        <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="1">
                                        </asp:ImageButton>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </td> </tr> </table> </td> </tr> </table> </td> </tr> </table>
    </form>
</body>
</html>
