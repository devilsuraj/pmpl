<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmDamagedStock.aspx.vb"
    Inherits="KDMT.frmDamagedStock" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Traffic - Damaged Stock</title>

    <script language="javascript" src="../Scripts/LogSheetDamage.js">
    </script>

    <script language="javascript" src="../Scripts/BLogSheet.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

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
      function fillItemName()
      {
                objddl2 =document.getElementById('Select1');
                if(document.getElementById("ddlitem").value!="" && objddl2.options.length>0)
                {
                    document.getElementById("ddlitem").value=objddl2.options[0].text;
                    document.getElementById("txtqty").focus();
                }

      }
 function validate ()
      {
      
         if (document.getElementById ("ddlvendor").selectedIndex == 0 )
          {
          alert ('Select Contractor name');
           document.getElementById ("ddlvendor").focus()
          return false;
          }
         if (document.getElementById ("txtwname").value.length==0)
          {
          alert ('Please Enter Worker Name');
           document.getElementById ("txtwname").focus()
          return false;
          }
          
          if (document.getElementById ("txtchalan").value.length==0)
          {
          alert ('Please Enter Vehicle no');
           document.getElementById ("txtchalan").focus()
          return false;
          }
                   return true;
      }
function chkItemName()
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
                               
                                alert("No Such Item Present");
                                document.Form1.ddlitem.focus();
                                
                            }
                 
						}
					}
					var cat=document.Form1.ddlitem.value;
					//alert(cat);
					xmlHttp.open("GET","Ajaxstore.aspx?Action=chkitemname&itemid="+document.Form1.ddlitem.value,true);
					xmlHttp.send(null);
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
                            //alert("No Such item")
                            return false;
                            }
                       
                            var ele = resp.split("!");
//			                          
            
		        while(document.getElementById("Select1").options.length > 0)
                document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
            
                          if(document.Form1.ddlitem.value !="")
                          
                             {
                           
                            for (var i = 0; i < ele.length; i++)
                             {
                             
                               var temp=document.getElementById("Select1")
				                temp.style.display="block";
				                temp.size=ele.length;
				                //alert("asdasd")
								newOpt = document.createElement("OPTION");
								document.getElementById("Select1").options.add(newOpt);
								
								//str=ele[i];
								//alert (ele[i] + "ravi")
								newOpt.value = ele[i];
								newOpt.innerText  = ele[i];
								if (document.Form1.ddlitem.value==ele[i])
								{
								  //alert("ravi")
								temp.style.display="none";				               
				                return false;
								}
                               	if (ele[i]=="0")
								{
								//alert("raviwewerwer")
								temp.style.display="none";				               
				                return false;
								}			
                               				                         
                              }
                             
							}
							else
							{
							var temp=document.getElementById("Select1")
							temp.size=0
							temp.style.display="none";
							
							}
						}
					}
					xmlHttp.open("GET","AjaxStore.aspx?Action=itemname1&itemid="+document.Form1.ddlcat.value+"&item="+document.Form1.ddlitem.value,true);
					//xmlHttp.open("GET","Ajaxwaytrip.aspx?Action=Fair&&start="+document.Form1.ddlfrom.value+"&end="+document.Form1.ddlto.value+"&value="+document.Form1.txtroute.value+"&age="+document.Form1.txtAge.value+"&Passtype="+'ST'+"&direction="+'N'+"&month="+document.Form1.hidmonth.value,true);
					//xmlHttp.open("GET","../store/AjaxStore.aspx?Action=item&itemname="+document.Form1.txtitem.value,true);
					xmlHttp.send(null);
				    //alert(document.frmRF.txtlocation.value)
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
									document.getElementById('ddlitem').focus();
									return false;
									//alert(resultStr)
								} 
							} 
							
						}

//////////////   end  filteration   ///////////////////////////
      
      
   
      
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
						return true;
			}
				
				

				
				
		
			
			
   
            function ticFunction2()
			{
			    if(document.getElementById ("txtqty").value.length>0)
                {

			        if(IsNumeric(document.getElementById ("txtqty").value))
                    {
			            LogSheet2();
			        }
			        else
			        {
    			        
			            alert("Enter Proper Value");
			            document.getElementById ("txtqty").focus();
			        }
			    }
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
                            var ele1 = resp.split('|');
                            Form1.txtbqty.value=ele1[0];
                        
                                                    
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
                                           <a href="../store/login.aspx">Sign Out </a>
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
                <td style="height: 35px">
                    <ul class="solidblockmenu">
                        <li>
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
                    <table cellspacing="0" cellpadding="0" width="780" align="center" border="0">
                        <tr>
                            <td colspan="6" style="width: 731px">
                                <table cellspacing="0" cellpadding="0" border="0" style="width: 98%">
                                    <tr>
                                        <td valign="top" background="../images/bg_M1.gif" style="width: 726px">
                                            <table cellspacing="0" cellpadding="0" border="0" width="98%">
                                                <tr>
                                                    <td valign="top" background="../images/bg_M1.gif" style="height: 524px;">
                                                        <table cellspacing="0" cellpadding="0" width="102%" border="0">
                                                            <tr>
                                                            </tr>
                                                            <tr>
                                                                <tr>
                                                                    <td style="height: 187px">
                                                                        <table class="text3" cellspacing="0" cellpadding="0" align="center" border="0" width="100%">
                                                                            <tbody>
                                                                                <tr class="heading1" style="font-weight: bold">
                                                                                    <td width="auto" bgcolor="#286381" style="height: 27px">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="storemaster.aspx">Stock Receive</a></td>
                                                                                    <td width="auto" bgcolor="#286381" style="height: 27px">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="storeitemmaster.aspx">Item Master</a></td>
                                                                                    <td width="auto" bgcolor="#286381" style="height: 27px">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="stockin.aspx">Stock In</a></td>
                                                                                    <td bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="storeissue.aspx">Stock Issue</a></td>
                                                                                    <td bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="frmdamagedstock.aspx">Item Damage</a></td>
                                                                                    <td bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="itemrepair.aspx">Item Repair</a></td>
                                                                                    <td bgcolor="#286381" style="width: auto; height: 27px;">
                                                                                        <span style="font-size: 14pt"><a class="heading1" href="Updateitem.aspx">Update Item</a></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="4" style="height: 7px">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="7" style="height: 7px" align="center">
                                                                                        <asp:Label ID="Label3" runat="server" Text="Damaged Stock" Font-Size="14"></asp:Label></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="7" style="height: 45px">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td style="width: 100px" align="right">
                                                                                                    <asp:Label ID="Label2" runat="server" Text="Type"></asp:Label></td>
                                                                                                <td style="width: 100px" align="left">
                                                                                                    <asp:DropDownList ID="ddlType" runat="server" Width="216px" TabIndex="1">
                                                                                                        <asp:ListItem Text="Disposed" Value="1"></asp:ListItem>
                                                                                                        <asp:ListItem Text="Sold" Value="2"></asp:ListItem>
                                                                                                    </asp:DropDownList></td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td style="width: 100px;" align="right">
                                                                                                    Description</td>
                                                                                                <td style="width: 100px;" align="left">
                                                                                                    <asp:TextBox ID="txtDescription" runat="server" Width="168px" TabIndex="2"></asp:TextBox></td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td style="width: 100px" align="right">
                                                                                                    Date</td>
                                                                                                <td style="width: 100px" align="left">
                                                                                                    <BDP:BDPLite ID="BDPLite1" runat="server" TabIndex="3">
                                                                                                    </BDP:BDPLite>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="height: 7px" colspan="7">
                                                                                        &nbsp;<table id="Grd_Item" border="1" cellpadding="1" cellspacing="1" class="heading1"
                                                                                            height="51" style="width: 715px" runat="server">
                                                                                            <tr>
                                                                                                <td style="width: 173px; height: 24px">
                                                                                                    Category</td>
                                                                                                <td style="width: 147px; height: 24px">
                                                                                                    Item Name</td>
                                                                                                <td style="width: 43px; height: 24px">
                                                                                                    Available<br />
                                                                                                    Qty.</td>
                                                                                                <td style="height: 24px">
                                                                                                    Ref. no
                                                                                                </td>
                                                                                                <td style="height: 24px">
                                                                                                    Remark&nbsp;</td>
                                                                                                <td style="height: 24px">
                                                                                                    SP</td>
                                                                                                <td style="width: 55px; height: 24px">
                                                                                                    <br />
                                                                                                    Qty.</td>
                                                                                                <td>
                                                                                                    &nbsp</td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td align="left" style="width: 173px; height: 28px;">
                                                                                                    <asp:DropDownList ID="ddlcat" runat="server" Width="181px" TabIndex="5">
                                                                                                    </asp:DropDownList></td>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="ddlitem" onpropertychange="ajaxFunction();" onblur="fillItemName();Fromcombo2()"
                                                                                                        runat="server" TabIndex="6" Width="200px"></asp:TextBox>
                                                                                                    <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                                                                        runat="server"></asp:ListBox>
                                                                                                </td>
                                                                                                <td align="left" style="width: 43px; height: 28px;">
                                                                                                    <asp:TextBox ID="txtbqty" runat="server" Width="56px" TabIndex="7" ReadOnly="True"></asp:TextBox></td>
                                                                                                <td style="height: 28px; width: 55px;">
                                                                                                    <asp:TextBox ID="txtRefNo" runat="server" Width="56px" TabIndex="8"></asp:TextBox></td>
                                                                                                <td style="height: 28px">
                                                                                                    <asp:TextBox ID="txtRemark" runat="server" TabIndex="8" Width="56px"></asp:TextBox></td>
                                                                                                <td align="left" style="height: 28px;">
                                                                                                    <asp:TextBox ID="txtSP" runat="server" TabIndex="8" Width="56px"></asp:TextBox></td>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="txtqty" onfocus="chkItemName()" onblur="ticFunction2()" runat="server"
                                                                                                        Width="56px" TabIndex="8"></asp:TextBox></td>
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
                                                                    <td colspan="5" style="height: 22px">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 22px">
                                                                        <div align="center">
                                                                            &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif"
                                                                                TabIndex="9"></asp:ImageButton><asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
                                                                                    TabIndex="10"></asp:ImageButton></div>
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
