<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RepairStoreIssueNew.aspx.vb"
    Inherits="KDMT.RepairStoreIssueNew" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Repair Item Issue </title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript" language="javascript">
    
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    x
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script language="javascript">
    
     var ex = /^[0-9]+\.?[0-9]*$/;
     var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;
        var rowcntSave = 1;
        var dltcnt = 0
        

      function additemDetails() {

            var txtItemName = document.getElementById('txtItemName');
            var txtSerialNo = document.getElementById('txtSerialNo');
            var txtjob = document.getElementById('txtjob');
            var txtJobNo = document.getElementById('txtJobNo');
            var txtBusNo = document.getElementById('txtBusNo');
            var txtbqty = document.getElementById('txtbqty');
            var txtqty = document.getElementById('txtqty');
           
            var tbody = document.getElementById('tbodyIndent');
 
            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntSave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tditem_' + rowcntSave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdSerialNo_' + rowcntSave);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdjob_' + rowcntSave);
            cells3.setAttribute('id', 'tdJobNo_' + rowcntSave);


            var cells4 = row.insertCell(3); 
            cells4.setAttribute('id', 'tdBusNo_' + rowcntSave);
            
            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdbqty_' + rowcntSave);

            var cells6 = row.insertCell(5);
            cells6.setAttribute('id', 'tdqty_' + rowcntSave);

            var cells7 = row.insertCell(6);


        
            cells1.innerHTML = txtItemName.value;
            cells2.innerHTML = txtSerialNo.value;
            cells3.innerHTML = txtjob.value + '/' + txtJobNo.value;
            cells4.innerHTML = txtBusNo.value;
            //cells5.innerHTML = txtjobNo.value;
            cells5.innerHTML = txtbqty.value;
            cells6.innerHTML = txtqty.value;
           
            cells7.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntSave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            rowcntSave += 1;
                                   
            txtItemName.value = '';
            txtSerialNo.value = '';
            txtBusNo.value = '';
            txtjob.value = '';
            txtJobNo.value = '';
            txtbqty.value = '';
            txtqty.value = '';
            
            txtItemName.focus();
            document.getElementById('hdnrwcnt').value = rowcntSave;
            // alert(document.getElementById('hdnrwcnt').value)
        }


        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;
            dltcnt = dltcnt + 1

        }


       function validate (){

 if (document.getElementById ("ddlvendor").selectedIndex == 0 )
    {
    alert ('Select Department Name.');
    document.getElementById ("ddlvendor").focus()
    return false;
    }
     if (document.getElementById ("txtref").value.length==0)
    {
    alert ('Please Enter Indent No');
    document.getElementById ("txtref").focus()
    return false;
    }
     if (document.getElementById ("txtapproved").value.length==0)
    {
    alert ('Please Enter Approvedby Name');
    document.getElementById ("txtapproved").focus()
    return false;
    }
 

        
            var detvalues = '';
            var i = 0;
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            
            
                for (i = 1; i < hdnrwcnt ; i++) {
                    if (document.getElementById('tditem_' + i) != null) {

                        var Itemname = document.getElementById('tditem_' + i).innerHTML;
                        var Serialno = document.getElementById('tdSerialNo_' + i).innerHTML;
                        var jobno = document.getElementById('tdJobNo_' + i).innerHTML;
                        var Busno = document.getElementById('tdBusNo_' + i).innerHTML;
                        var bqty = document.getElementById('tdbqty_' + i).innerHTML;
                        var qty = document.getElementById('tdqty_' + i).innerHTML;

                        detvalues = detvalues + Itemname + '^' + Serialno + '^' + jobno + '^' + Busno + '^' + bqty + '^' + qty + '|';
                    }
                    }
                document.getElementById("Hid_Rec").value = detvalues
          return true;
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
        if(document.getElementById('ddlitem').value != "" || document.getElementById('txtSubRackNo').value != "" || document.getElementById('txtPartNo').value != "")
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
        var subrackno = document.getElementById('txtSubRackNo').value;
        var partno = document.getElementById('txtPartNo').value;

        xmlHttp.open("GET","AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.Form1.ddlitem.value + "&subrackno=" + subrackno + "&partno=" + partno ,true);

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
    var ValidChars = "0123456789";
    var Char;
    for (i = 0; i < strString.length; i++) 
    { 
    Char = strString.charAt(i); 
    if (ValidChars.indexOf(Char) == -1) 
    {
    return true;
    }
    }
    
    return false;
}


function ticFunction2()
  
{

if (document.getElementById ("txtItemName").value == '')
    {
        alert("Please Enter Item ");
        document.getElementById ("txtItemName").focus();
        return false ;
    }
    if (document.getElementById ("ispartno").value == 'True' && document.getElementById ("txtSerialNo").value == '')
    {
        alert("Please Enter serial No ");
        document.getElementById ("txtSerialNo").focus();
        return false ;
    }
    
if (document.getElementById ("txtqty").value == '')
    {
        alert("Please Enter Quantity ");
        document.getElementById ("txtqty").focus();
        return false ;
    }
     
var e = document.getElementById("ddlvendor");
var strUser1 = e.options[e.selectedIndex].text;
if((strUser1=="Automotive") &&  (document.getElementById ("txtJobNo").value == '')) 
{
alert("Please Enter Jobcard No ");
document.getElementById ("txtJobNo").focus();
return false ;
}

 
 
if (ex.test (document.getElementById("txtqty").value) != false  ){
  
        var qty1=parseInt(document.getElementById ("txtqty").value);
        //var bqty1=parseInt(document.getElementById ("txtbqty").value);
//         if( parseInt(bqty1) == 0) 
//        {
//          alert("Item Available Bal Is zero");
//          document.getElementById ("txtqty").focus();
//        }
        //else 
        if( parseInt(qty1) == 0) 
        {
          alert("zero is not a valid Qty");
          document.getElementById ("txtqty").focus();
        }
//        else if(parseInt(qty1) > parseInt(bqty1)) 
//        {
//          alert("Enter Proper Value");
//          document.getElementById ("txtqty").focus();
//        }
//        
        else{
            additemDetails();
        }
    }
    else
    {
       alert("Enter Proper Value");
        document.getElementById ("txtqty").focus();
        return false ;
    //}
    }
}
		
		


function validate_indent()
 
{
if (document.getElementById ("txtref").value == '')
    {
        alert("Please Enter Indent No.");
        document.getElementById ("txtref").focus();
        return false ;
    }
if (document.getElementById ("txtapproved").value == '')
    {
        alert("Please Enter Supervisor Name.");
        document.getElementById ("txtapproved").focus();
        return false ;
    }
    if (document.getElementById ("txtdept").value == '')
    {
        alert("Please Enter Department Name.");
        document.getElementById ("txtdept").focus();
        return false ;
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
 
function chkbus()
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
    //debugger
    resp = xmlHttp.reponseText;
    var ele1 = resp
    if (ele1 == "empty")
    {
    //alert("Please Enter Proper Bus No ");
    document.getElementById ("txtBusNo").focus();
    return false ;
  }

    }
    }
//    var itemname= document.getElementById('ddlitem').value  ;
//    var subrackno = document.getElementById('txtSubRackNo').value;
//    var partno = document.getElementById('txtPartNo').value;
     if(document.getElementById('txtBusNo').value !=""){
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkbus&busno=" + document.getElementById("txtBusNo").value ,true);
    xmlHttp.send(null);
    }
    else
    {
    alert("Please Enter Bus No ");
    document.getElementById ("txtBusNo").focus();
    return false ;
    }
}

  
  

function getbalqty()
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
     if(document.getElementById('txtItemName').value=="")
        {
         document.getElementById('txtbqty').value="";
            }
        else{
    resp = ""
    resp = xmlHttp.responseText;
    var ele1 = resp.split('|');

    document.getElementById('txtbqty').value=ele1[0];
    document.getElementById('ispartno').value=ele1[1];
}
    }
    }
    var itemname= document.getElementById('txtItemName').value  ;
    xmlHttp.open("GET","AjaxStore.aspx?Action=ritemqty&itemid=" + itemname  ,true);
    xmlHttp.send(null);
}

//+ "&subrackno=" + subrackno + "&partno=" + partno


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
    if (document .getElementById ('txtSubRackNo').value !='' && document .getElementById ('ddlitem').value !='' )
    {
    document .getElementById ('txtSubRackNo').value='';
    document .getElementById ('ddlitem').value='';
    }
}


function getjobno()
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
   
 
    var ele1 = resp.split('!');
    if(ele1[0]=="empty")
    {

    alert("Job Card is not open");
    document.getElementById("txtjob").value="";
    document.getElementById("txtJobNo").value="";
    document.getElementById("txtjob").focus();
    return false;
    }
    else
    document.getElementById("txtjob").value=ele1[0];
    document.getElementById("txtJobNo").value=ele1[1];
    }
    }
 
    
     if (document.getElementById ('txtBusNo').value !=''  )
     {
    xmlHttp.open("GET","AjaxStore.aspx?Action=getjobno&busno=" + document.getElementById("txtBusNo").value , true);
    xmlHttp.send(null);
    }
}
//+ "&newjobno=" + document.getElementById("txtJobNo").value

function getbusno() {
    

    var xmlHttp;
    try {
        // Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
    }
    catch (e) {
        // Internet Explorer
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4) {
            resp = ""
            resp = xmlHttp.responseText;

            var ele1 = resp.split('|');
            
            if (ele1 == "empty") {

                alert("Job Card is not open");
                document.getElementById("txtjob").focus();

            }
            else
                document.getElementById("txtBusNo").value = ele1[0];

        }
    }


    if (document.getElementById('txtJobNo').value != '') {
        xmlHttp.open("GET", "AjaxStore.aspx?Action=getbusno&newjob=" + document.getElementById("txtjob").value + "&newjobno=" + document.getElementById("txtJobNo").value, true);
        xmlHttp.open("GET", "AjaxStore.aspx?Action=getbusno&newjob=" + document.getElementById("txtjob").value + "&newjobno=" + document.getElementById("txtJobNo").value + "&itemcode=0", true);
        xmlHttp.send(null);
    }
}


    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <asp:HiddenField ID="ispartno" runat="server" />
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="mpagetop">
                </div>
                <div class="mpage">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">Repair Item Issue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </span>&nbsp;
                                <asp:Label ID="Label1" runat="server" Text="" Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align="right">
                                            Department Name:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlvendor" AutoPostBack="True" runat="server" Width="216px">
                                            </asp:DropDownList>
                                            <%--<input type="text" id="txtdept" style="width: 220px" class="textfield" runat="server" />--%>
                                        </td>
                                        <td align="right">
                                            Date : -
                                        </td>
                                        <td align="left">
                                        <BDP:BDPLite ID="BDPLite1" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                            <%--<asp:Label ID="lblissuedate" runat="server" Text=""></asp:Label>--%>
                                            <%-- <BDP:BDPLite ID="BDPLite1" runat="server">
                                            </BDP:BDPLite>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Indent No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtref" MaxLength="5" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Approved By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtapproved" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Gate Pass No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtgate" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Remark :
                                        </td>
                                        <td align="left" colspan="3">
                                            <asp:TextBox ID="txtRemark" TextMode="MultiLine" runat="server" Width="550px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="tblIndent" width="100%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbodyIndent">
                                        <tr class="gridhead">
                                            <td>
                                                Item Name
                                            </td>
                                            <td>
                                                Serial No
                                            </td>
                                            <td>
                                                Job No
                                            </td>
                                            <td>
                                                Bus No
                                            </td>
                                            <td>
                                                Available Qty
                                            </td>
                                            <td>
                                                Qty
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr class="gridtxt" valign="top">
                                            <td>
                                                <asp:TextBox ID="txtItemName" runat="server" onblur="getbalqty();" Width="250px"></asp:TextBox>
                                            </td>
                                            <td align="left" style="width: 30px; height: 28px;">
                                                <asp:TextBox ID="txtSerialNo" runat="server" Width="150px"></asp:TextBox>
                                            </td>
                                            <td class="style2">
                                                <asp:TextBox ID="txtjob" Width="30px" runat="server"></asp:TextBox>
                                                <asp:TextBox ID="txtJobNo" onblur="getbusno();" runat="server" Width="56px" MaxLength="4"></asp:TextBox>
                                            </td>
                                            <td style="height: 28px; width: 55px;">
                                                <asp:TextBox ID="txtBusNo" runat="server" Width="56px"></asp:TextBox>
                                            </td>
                                            <td style="height: 28px; width: 55px;">
                                                <asp:TextBox ID="txtbqty" ReadOnly="true" runat="server" Width="56px"></asp:TextBox>
                                            </td>
                                            <td align="left" style="width: 43px; height: 28px;">
                                                <asp:TextBox ID="txtqty" runat="server" Width="56px" ></asp:TextBox>
                                            </td>
                                            <td>
                                                <input type="button" id="btnadd" value="ADD" onclick="ticFunction2()" name="btnadd" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                        <tr>
                            <td style="height: 22px">
                                <div align="center">
                                    <p>
                                        &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"
                                            TabIndex="9"></asp:ImageButton>
                                        <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="10">
                                        </asp:ImageButton>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="mpagebottam">
                </div>
            </div>
        </div>
    </div>
    </form>

    <script type="text/javascript">

//var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});


	$(document).ready(function() {
         $("#txtItemName").autocomplete
           ({
            source: [<%= stritem  %>]
            });
      });
      
      $(document).ready(function() {
         $("#txtSerialNo").autocomplete
           ({
            source: [<%= strserialNo  %>]
            });
      });
	
    </script>

</body>
</html>
