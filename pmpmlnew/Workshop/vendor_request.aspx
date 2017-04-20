<%@ Page Language="VB" AutoEventWireup="false" CodeFile="vendor_request.aspx.vb" Inherits="KDMT.vendor_request" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%--<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Traffic - Log Sheet Submission</title>
   <%-- <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>--%>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script type="text/javascript" language="javascript" src="../Scripts/indent_request.js">
    </script>

     <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <%--<link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>--%>

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
     if (document.getElementById ("txtref").value.length==0)
    {
    alert ('Please Enter Request No');
    document.getElementById ("txtref").focus()
    return false;
    }
    return true;
}
      
      
function chkItemName()
{
    document.getElementById("Select1").style.display='none';
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
        //			                          

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
        newOpt.innerText  = ele[i];
        if (document.Form1.ddlitem.value==ele[i])
        {
        //temp.style.display="none";				               
        // return false;
        }
        if (ele[i]=="0")
        {
        //temp.style.display="none";				               
        // return false;
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
        var lfno = document.getElementById('txtlfno').value;
        var partno = document.getElementById('txtPartNo').value;
      
        xmlHttp.open("GET","AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&lfno=" + lfno + "&partno=" + partno ,true);

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
    document.getElementById("Select1").style.display='none';
    document.getElementById('ddlitem').focus();
    return false;
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
		    if(document.getElementById("txtqty").value.length>0)
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

    for (var i = 0; i < ele1.length-1; i++)
    {
    var temp=document.getElementById("ddlitem")
    newOpt = document.createElement("OPTION");
    document.getElementById("ddlitem").options.add(newOpt);
    newOpt.value = ele1[i];
    newOpt.innerText  = ele1[i];
    }
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

    
    document.getElementById('txtPartNo').value=ele1[2];
    document.getElementById('txtlfno').value=ele1[3];

        
    }
    }
    var itemname= document.getElementById('ddlitem').value  ;
    var lfno = document.getElementById('txtlfno').value;
    var partno = document.getElementById('txtPartNo').value;
    xmlHttp.open("GET","AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno ,true);
    xmlHttp.send(null);
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

    <style type="text/css">
        .style1
        {
            width: 197px;
        }
        .style2
        {
            height: 46px;
        }
    </style>

</head>
<body class="body" onload="StartClock();">
    <form id="Form1" runat="server">
    <div align="center">
        <%--<uc:header ID="Header1" runat="server" />--%>
        <div id="middal">
            <%--<uc:leftmenu ID="Leftmenu1" runat="server" />--%>
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">Request Indent</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align="right" class="style1">
                                            Request No:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtref" TabIndex ="1"  runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Date : -
                                        </td>
                                        <td align="left">
                                            <BDP:BDPLite ID="BDPLite1" TabIndex ="2"  runat="server">
                                            </BDP:BDPLite>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="style1">
                                            Remark :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtremark" TabIndex ="3"  TextMode="MultiLine" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td align="left">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="style1">
                                            &nbsp;</td>
                                        <td align="left">
                                            &nbsp;</td>
                                        <td align="right">
                                        </td>
                                        <td align="left">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="style1">
                                            &nbsp;</td>
                                        <td align="left">
                                            &nbsp;</td>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td align="left">
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Grd_Item" cellpadding="4" cellspacing="0" bordercolor="#FFFFFF" border="0"
                                    bgcolor="#f4f4f4" height="51" style="border-collapse: collapse; width: 100%"
                                    runat="server">
                                    <tr class="gridhead">
                                        <td class="style2">
                                             LF No                                       </td>
                                        <td class="style2">
                                            Part No.
                                        </td>
                                        <td class="style2">
                                            Item Name
                                        </td>
                                
                                        <td class="style2">
                                            Required
                                            <br />
                                            Qty.
                                        </td>
                                        <td class="style2">
                                        </td>
                                    </tr>
                                    <tr class="gridtxt">
                                        <td align="left" style="width: 100px; height: 28px;">
                                            <asp:TextBox class="textfield" ID="txtlfno" onblur="emptytext();ajaxFunction();"
                                              TabIndex ="4"  runat="server" Width="100px"></asp:TextBox>
                                        </td>
                                        <td align="left" style="width: 100px; height: 28px;">
                                            <asp:TextBox class="textfield" ID="txtPartNo" onblur="emptytextpart();ajaxFunction();"
                                               TabIndex ="5"  runat="server" Width="100px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="ddlitem" onpropertychange="ajaxFunction();" onblur="return check1();"
                                                TabIndex ="6" runat="server" Width="250px"></asp:TextBox>
                                            <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                runat="server"></asp:ListBox>
                                        </td>
                                    
                                        <td align="left" style="height: 28px;">
                                            <asp:TextBox ID="txtqty" onfocus="chkItemName()" onblur="ticFunction2()"   TabIndex ="7" runat="server" Width="56px"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                        <tr>
                            <td style="height: 22px">
                                <div align="center">
                                    &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"
                                        TabIndex="9"></asp:ImageButton><asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
                                            TabIndex="10"></asp:ImageButton></div>
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
