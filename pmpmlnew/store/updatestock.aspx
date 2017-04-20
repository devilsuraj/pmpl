<%@ Page Language="VB" AutoEventWireup="false" CodeFile="updatestock.aspx.vb" Inherits="KDMT.updatestock" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Update Stock Master</title>
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

function StartClock()
 {
clockID = setTimeout("UpdateClock()", 500);
}

function KillClock() {
if(clockID) {
clearTimeout(clockID);
clockID  = 0;
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
            
            return false;
            }

            var ele = resp.split("!");
            
            while(document.getElementById("Select1").options.length > 0)
            document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
            if(document.Form1.txtitem.value !="")
            {

            for (var i = 0; i < ele.length; i++)
            {

            var temp=document.getElementById("Select1")
            temp.style.display="block";
            temp.size=ele.length;
            
            newOpt = document.createElement("OPTION");
            document.getElementById("Select1").options.add(newOpt);

            newOpt.value = ele[i];
            newOpt.innerText  = ele[i];
            if (document.Form1.txtitem.value==ele[i])
            {
            temp.style.display="none";				               
            return false;
            }
            if (ele[i]=="0")
            {
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
            //alert(document.Form1.txtitem.value)
            //alert(document.Form1.txttest.value)
            xmlHttp.open("GET","../store/AjaxStore.aspx?Action=item&itemname="+document.Form1.txtitem.value,true);
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
        
            var objddl1 = document.getElementById('txtitem');
            
            objddl1.value=resultStr;
            var x=document.getElementById('Select1');
            x.style.display="none";  
            return false;
            //alert(resultStr)
            } 
            } 

        }




function itemdetail(type)
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
      
            if (resp == "")
            {
            document.getElementById("txtitem").value = "";
            document.getElementById("txtcode").value = "";
            document.getElementById("txtcode").disabled =false  ;
            document.getElementById("txtlfno").focus ();
            alert ('No such LF NO exists')
            }
            else
            {

            var ele = resp.split("!");
            for (var i = 0; i < ele.length; i++)
            {
            if (i==0)
            {
            document.getElementById("txtitem").value = ele[i];
            }
             if (i==1)
            {
            document.getElementById("txtcat").value = ele[i];
            }
             if (i==2)
            {
            document.getElementById("txtcurrentstock").value = ele[i];
         
            }
            if (i==3)
            {
            document.getElementById("HiddenField1").value = ele[i];
            document.getElementById("txtcode").value = ele[i];
            document.getElementById("txtcode").disabled =true ;
            }
             if (i==4)
            {
            document.getElementById("Txtpartno").value = ele[i];
            }
             if (i==5)
            {
            document.getElementById("txtroomno").value = ele[i];
            }
               if (i==7)
            {
            document.getElementById("txtlfno").value = ele[i];
            }
            }
            }
            }
            }

          
          
            // room = document.getElementById("txtroomno").value;
            // xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemdetailrack&room="+room+"&subrack="+document.getElementById("txtsubrack").value ,true);
            // xmlHttp.send(null);
          
           if ( document.getElementById("txtitem").value == ""  && type == 2 )
           {
             room = document.getElementById("txtroomno").value;
             xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemdetailrack&room="+room+"&lfno="+document.getElementById("txtlfno").value ,true);
             xmlHttp.send(null);
             }
             else if ( document.getElementById("txtitem").value != ""  && type == 1 )
             {
            xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemdetail&itemname="+document.Form1.txtitem.value,true);
            xmlHttp.send(null);
            }

        }			


function IsNumeric(strString)
{
    var ValidChars = "123456789";
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
				
function validate ()
{
    if (document .getElementById ('txtroomno').value == '')
    {
    alert ('Please Enter Room No')
    document .getElementById ('txtroomno').focus();
    return false;
    }
    if (document .getElementById ('txtlfno').value == '')
    {
    alert ('Please Enter LF No')
    document .getElementById ('txtlfno').focus();
    return false;
    }
    if (document .getElementById ('txtstock').value == '')
    {
    alert ('Please Enter Stock')
    document .getElementById ('txtstock').focus();
    return false;
    }
}

function emptytext ()
{

document.getElementById("txtitem").value = '';
}



    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading" colspan="4">
                                <span id="Span1">Update Stock Master</span>
                            </td>
                        </tr>
                        <tr style="width: 100%">
                            <td align="right">
                                Item name
                            </td>
                            <td>
                                <asp:TextBox ID="txtitem" onpropertychange="ajaxFunction();" runat="server" Width="400px"></asp:TextBox>
                                <asp:ListBox ID="Select1" Style="display: none; align: center" onclick="Select();"
                                    runat="server" onchange="Select();itemdetail(1);"></asp:ListBox>
                            </td>
                            <td>
                                <asp:Label ID="lblcat" runat="server" Text=" " ForeColor="red" Font-Size="14"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtcat" ReadOnly="true" ForeColor="red" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Part No
                            </td>
                            <td style="height: 26px">
                                <asp:TextBox ID="Txtpartno"  Width="400px" AutoPostBack="true" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Item Code                             </td>
                            <td>
                                <asp:TextBox ID="txtcode" Width="50px" runat="server" AutoPostBack="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Room No
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtroomno" onblur="if (!IsNumeric(this.value)){this.focus();alert('Enter Proper Room No');return false}"
                                    runat="server" MaxLength="1" Text ="1" Width="20px"></asp:TextBox>
                                LF No
                                <asp:TextBox ID="txtlfno"  onchange="emptytext();itemdetail(2);" runat="server" Width="80px"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label3" runat="server" Text="Location Of The Item" ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Date
                            </td>
                            <td align="left" colspan="2">
                                <BDP:BDPLite ID="BDPLite1" runat="server">
                                </BDP:BDPLite>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Last Stock
                            </td>
                            <td style="height: 26px">
                                <asp:TextBox ID="txtstock" Width="100px" runat="server"></asp:TextBox>
                                Current Stock
                                <asp:TextBox ID="txtcurrentstock" ReadOnly ="true"  ForeColor ="red" Width="100px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <tr>
                            <td style="height: 22px" align="center" colspan="4">
                                &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif">
                                </asp:ImageButton><asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
                                    TabIndex="1"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>
    </form>

    <script type="text/javascript">
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

</script>

</body>
</html>
