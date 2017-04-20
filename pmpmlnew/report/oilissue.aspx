<%@ Page Language="VB" AutoEventWireup="false" CodeFile="oilissue.aspx.vb" Inherits="KDMT.oilissue" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
    <link rel="stylesheet" type="text/css" href="../store/menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="../store/menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<HTML>
	<HEAD>
		<title>Ticket & Cash Management</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<LINK href="../styles/KDMT.css" type="text/css" rel="stylesheet"> <!--[if IE]>
<STYLE type=text/css>P.iepara {
	PADDING-TOP: 1em
}
</STYLE>
<![endif]-->
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

function add()
		{
		       
		var   row   =   document.all.DataGrid1.insertRow(DataGrid1.rows.length);   
        var   cell   =   row.insertCell();   
        cell.innerHTML   = "<select style='WIDTH: 73px'><option value='4.75'>4.75</option><option value='5.75'>5.75</option></select>";   
        var   cell2   =   row.insertCell();   
        cell2.innerHTML   =   "<input   type='TextBox' id='txtSrNo' style='WIDTH: 121px; HEIGHT: 22px'  name='test'>";   
        var   cell3   =   row.insertCell();   
        cell3.innerHTML   =   "<input   type='TextBox' id='txtEndSrNo' style='WIDTH: 121px; HEIGHT: 22px' onchange='add()'  name='test'>";
        var   cell4   =   row.insertCell();   
        cell4.innerHTML   =   "<input   type='TextBox' id='no' style='WIDTH: 121px; HEIGHT: 22px' readonly = 'true'  name='test'>";   
        var   cell5   =   row.insertCell();   
        cell5.innerHTML   =   "<input   type='TextBox' style='WIDTH: 121px; HEIGHT: 22px text-align=right' id='no2' readonly = 'true' name='test'>";
      }
      
      // textfield vaidations
      
   
      function validate()
      {
      if (document.Form1.txtemp.value==false)
      {
      alert("Please Enter Employee code");
      document.Form1.txtemp.focus();
      return false;
      }
      if (IsNumeric(Form1.txtemp.value) == false)
      {
      alert("Please Enter numbers only");
      document.Form1.txtemp.focus();
      return false;
      } 
       if (document.Form1.txttray.value==false)
      {
      alert("Please Enter tray no");
      document.Form1.txttray.focus();
      return false;
      }
      if (IsNumeric(Form1.txttray.value) == false)
      {
      alert("Please Enter numbers only");
      document.Form1.txttray.focus();
      return false;
      } 
      if (document.Form1.txtduty.value==false)
      {
      alert("Please Enter duty no");
      document.Form1.txtduty.focus();
      return false;
      }
//      if (IsNumeric(Form1.txtduty.value) == false)
//      {
//      alert("Please Enter numbers only");
//      document.Form1.txtduty.focus();
//      return false;
//      } 
      if (document.Form1.txtcon.value==false)
      {
      alert("Please Enter Conductors Name.");
      document.Form1.txtcon.focus();
      return false;
      }
      if (document.Form1.txtwaycode.value==false)
      {
      alert("Please Enter way bill no");
      document.Form1.txtwaycode.focus();
      return false;
      }
      if (IsNumeric(Form1.txtwaycode.value) == false)
      {
      alert("Please Enter numbers only");
      document.Form1.txtwaycode.focus();
      return false;
      } 
      } 
      
      
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
						//var resp=xmlHttp.responseText
						
							//document.frmRF.Txt2.value=xmlHttp.responseText;
							//var resp;
                            resp = xmlHttp.responseText;
                           
                            if (resp == 0)
                            {
                            alert("No Such Employee")
                            return false;
                            }
                            
                            //alert(resp)
                            var ele = resp.split("!");
							                            
                           //alert(resp)
                            // -- Clear all old values of task drop down.
                           // while(document.getElementById("Select1").options.length > 0)
                            //document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
                             // -- Add new values
                           
                           //if (document.getElementById("cmbDis").value == 0)
                           //{
                           //alert("Please select District")
                           //return false;
                           //}
                           //alert( ele.length)
                           if (document.Form1.txtemp.value != "")
                           {
                            for (var i = 0; i < ele.length; i++)
                             {
                                //var temp=document.getElementById("Select1")
				                //temp.style.display="block";
				                //temp.size=ele.length;
								//newOpt = document.createElement("OPTION");
								//document.getElementById("Select1").options.add(newOpt);
								//alert(i)
								//alert(ele[i])
								if (i==0)
								{
								document.Form1.txtcon.value=ele[i];
								}
								if (i==1)
								{
								document.Form1.txtduty.value=ele[i];
								}
								if (i==2)
								{
								document.Form1.txttray.value=ele[i];
								}
								
								//str=ele[i];
								//newOpt.value = ele[i];
								//newOpt.innerText  = ele[i];
                               				                         
                              }
                             }
                             else
                             {
                             document.Form1.txtwaycode.value="";
                             document.Form1.txtcon.value="";
                             document.Form1.txtduty.value="";
                             document.Form1.txtemp.value="";
                             document.Form1.txttray.value="";
                                                    
                             }	
							}
							else
							{
							//temp.size=0
							//temp.style.display="none";
							}
						
					}
					var mydate=new Date();
					var day=mydate.getDate();
					var month=mydate.getMonth();
					var year=mydate.getYear();
					month=month+1;
					var date=day/month/year;			
							                           
					//alert(document.Form1.txtemp.value)
					xmlHttp.open("GET","AjaxServer.aspx?Action=waybill&emp="+document.Form1.txtemp.value,true);
					xmlHttp.send(null);
				    //alert(document.frmRF.txtlocation.value)
			}
			
			
			

			function cleartxt()
			{
			document.Form1.txtemp.value="";
			document.Form1.txttray.value="";
			document.Form1.txtduty.value="";
			document.Form1.txtcon.value="";
			document.Form1.txttray.value="";
			}
			</script>
	</HEAD>
	<body class="body">
		<form id="Form1" runat="server">
			<table cellSpacing="0" cellPadding="0" width="1002" border="0">
				<tr>
					<td vAlign="top" background="../images/top.jpg" height="114">&nbsp;
						<TABLE id="Table8" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD align="right">
									<TABLE id="Table9" cellSpacing="0" cellPadding="0" width="70%" border="0">
										<TR>
                                         <TD width=532></TD>
                                                <TD><asp:label id=Label1  runat="server" Width="65px"></asp:label></TD>
                                                <TD><a href="../forms/login.aspx"> Sign Out </a></TD></TR>
										<TR>
											<TD width="532"></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD width="532"></TD>
											<TD></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
					</td>
				</tr>

				<tr>
					<td vAlign="top">
					<table class="text3" cellspacing="0" cellpadding="0" align="center" border="0" width="100%"
                        id="TABLE1" >
                        <tbody>
                            <tr class="heading1" style="font-weight: bold">
                                <td bgcolor="#286381">
                                    <a href="../store/storeitemmaster.aspx" style="color: #fff; text-decoration: none;">Master</a>
                                </td>
                                <td>
                                    <a class="heading1" href="../store/storemaster.aspx">Stock Received</a></td>
                                <td>
                                    <a class="heading1" href="../store/storeissue.aspx">Stock Issue</a></td>
                                <td>
                                    <a href="#" class="anchorclass" style="color: #fff; text-decoration: none;" rel="submenu2">
                                        Item</a>
                                    <div id="submenu2" class="anylinkcss">
                                        <ul>
                                            <li><a href="../store/Updateitem.aspx">Update Item</a></li>
                                            <li><a href="../store/itemrepair.aspx">Repair Item</a></li>
                                            <li><a href="../store/itemdamag.aspx">Damage Item</a></li>
                                            <li><a href="../store/deletereceiveitem.aspx">Delete Receive/Reject Item</a></li>
                                            <li><a href="../report/Storereport.aspx">Issue Item</a></li>
                                        </ul>
                                    </div>
                                </td>
                                <td>
                                    <a class="heading1" href="../report/storereport.aspx">Store Report</a></td>
                            </tr>
                        </tbody>
                    </table>
						<table cellSpacing="0" cellPadding="0" width="780" align="center" border="0">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td vAlign="top">
									<table cellSpacing="0" cellPadding="0" width="100%" align="right" border="0">
										<tr>
											<td align="right">
												<div align="right"><A href="#"><IMG height="51" src="../images/admin.gif" width="82" border="0"></A></div>
											</td>
										</tr>
										<tr>
											<td height="4"></td>
										</tr>
										<tr>
											<td align="right"><A href="../forms/ticket.aspx"></A></td>
										</tr>
									</table>
								</td>
								<td colSpan="6">
									<table cellSpacing="0" cellPadding="0" width="98%" border="0">
										<tr>
											<td vAlign="top" background="../images/bg_T1.gif" height="61">
												<table height="30" cellSpacing="0" cellPadding="0" width="688" align="left" border="0">
													<tr class="heading1" style="font-weight: bold">
														<td bgColor="#286381" height="27" colspan="15">
                                                            <span style="font-size: 14pt">Report</span></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td vAlign="top" background="../images/bg_M1.gif">
												<table cellSpacing="0" cellPadding="0" width="100%" border="0">
													<TR>
														<TD class="text3" align="center" style="height: 34px">
															<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
																<TR>
																	<TD align="left" width="244" style="height: 15px">&nbsp;
																		</TD>
																	<TD align="center" style="height: 15px"></TD>
																	<TD align="right" style="height: 15px">&nbsp;&nbsp;</TD>
																</TR>
															</TABLE>
														</TD>
													</TR>
													<TR>
														<TD class="text3" align="center" style="height: 32px">
                                                            <strong><span style="font-size: 15pt; color: #0033ff">Oil Issue Report<br />
                                                                <br />
                                                                <br />
                                                                <br />
                                                                <br />
                                                            </span></strong></TD>
													</TR>
                                                    <%--<tr>
                                                        <td align="center" class="text3" style="height: 25px">
                                                            <asp:Label ID="Label2" runat="server" Style="z-index: 102; left: 240px; position: absolute;
                                                                top: 358px" Text="select oil"></asp:Label>
                                                            &nbsp;
                                                            <asp:DropDownList ID="DropDownList1" runat="server" Width="168px" style="z-index: 101; left: 318px; position: absolute; top: 355px" Height="36px">
                                                                <asp:ListItem>Engine Oil</asp:ListItem>
                                                                <asp:ListItem>Gear Oil HP 90 </asp:ListItem>
                                                                <asp:ListItem>Gear Oil HP 140</asp:ListItem>
                                                                <asp:ListItem>Coolant Oil </asp:ListItem>
                                                                <asp:ListItem>Coolant</asp:ListItem>
                                                                <asp:ListItem>Grease WB</asp:ListItem>
                                                                <asp:ListItem>Grease MP</asp:ListItem>
                                                                <asp:ListItem>Grease MP 3</asp:ListItem>
                                                                <asp:ListItem>Power Steering Oil</asp:ListItem>
                                                            </asp:DropDownList></td>
                                                    </tr>--%>
													<TR>
													<tr>
														<td class="text3" align="right" style="height: 15px">&nbsp;&nbsp;&nbsp;</td>
													</tr>
													<TR>
														<TD align="center">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="width: 116px" align="right">
                                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;From Date</td>
                                                                    <td style="width: 100px">
                                                                        <bdp:bdplite id="BDPLite1" runat="server"></bdp:bdplite>
                                                                    </td>
                                                                    <td style="width: 169px" align="right">
                                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; To Date</td>
                                                                    <td style="width: 73px">
                                                                        <bdp:bdplite id="BDPLite2" runat="server"></bdp:bdplite>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            </TD>
													</TR>
													<tr>
														<td style="height: 134px">
															<table class="text3" cellSpacing="0" cellPadding="0" align="center" border="0" style="height: 115px" width="100%">
																<TBODY>
													                <tr><td colSpan="6" style="height: 15px"></td><tr>
													                <tr><td colSpan="6" style="height: 15px" align="center">
                                                                        <asp:Button ID="Button1" runat="server" Text="Show Report" /></td></tr>
												                    <tr><td colSpan="6" style="height: 8px" align="center"></td></tr>
												 		        </TBODY>
												 		</table>
												 		</td>
													</tr>
												</table>
											</td>
										</tr>
							<tr>
								<td><IMG height="27" src="../images/bg_B1.gif" width="710"></td>
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
</HTML>
