<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ItemReceiveForRepair.aspx.vb"
    Inherits="KDMT.ItemReceiveForRepair" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Item Received for Repair</title>
    
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

    <style type="text/css">
        .style1
        {
            height: 29px;
        }
    </style>

    x
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script language="javascript">
    
     var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;
        var rowcntSave = 1;
        var dltcnt = 0
        

      function additemDetails() {

            var txtItemName = document.getElementById('txtItemName');
            var txtSerialNo = document.getElementById('txtSerialNo');
            var txtBusNo = document.getElementById('txtBusNo');
            var txtqty = document.getElementById('txtqty');
             var txtremark = document.getElementById('txtremark');
           
            var tbody = document.getElementById('tbodyIndent');
 
            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntSave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tditem_' + rowcntSave);

//            var cells2 = row.insertCell(1);
//            cells2.setAttribute('id', 'tdSerialNo_' + rowcntSave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdBusNo_' + rowcntSave);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdqty_' + rowcntSave);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdremark_' + rowcntSave);
            
            var cells5 = row.insertCell(4);


        
            cells1.innerHTML = txtItemName.value;
            //cells2.innerHTML = txtSerialNo.value;
            cells2.innerHTML = txtBusNo.value;
            cells3.innerHTML = txtqty.value;
            cells4.innerHTML = txtremark.value;
            cells5.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntSave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            rowcntSave += 1;
                                   
            txtItemName.value = '';
            //txtSerialNo.value = '';
            txtBusNo.value = '';
            txtqty.value = '';
            txtremark.value = '';
            
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
    alert ('Please Select Department Name.');
    document.getElementById ("ddlvendor").focus()
    return false;
    }

    if (document.getElementById ("txtSupervisor").value.length==0)
    {
    alert ('Please Enter Supervisor Name.');
    document.getElementById ("txtSupervisor").focus()
    return false;
    }
    
    if (document.getElementById ("ddlshift").selectedIndex == 0 )
    {
    alert ('Please Select Shift.');
    document.getElementById ("ddlshift").focus()
    return false;
}
if (document.getElementById("ddlplace").selectedIndex == 0) {
    alert('Please Select place');
    document.getElementById("ddlplace").focus()
    return false;
}
//    if (document.getElementById ("txtdelivered").value.length==0)
//    {
//    alert ('Please Enter Delivered Person Name.');
//    document.getElementById ("txtdelivered").focus()
//    return false;
//    }
//    if (document.getElementById ("txtreceived").value.length==0)
//    {
//    alert ('Please Enter Receiver Name.');
//    document.getElementById ("txtreceived").focus()
//    return false;
//    }

        
            var detvalues = '';
            var i = 0;
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            
            
                for (i = 1; i < hdnrwcnt ; i++) {
                    if (document.getElementById('tditem_' + i) != null) {

                        var Itemname = document.getElementById('tditem_' + i).innerHTML;
                        //var Serialno = document.getElementById('tdSerialNo_' + i).innerHTML;
                        var Busno = document.getElementById('tdBusNo_' + i).innerHTML;
                        var qty = document.getElementById('tdqty_' + i).innerHTML;
                         var remark = document.getElementById('tdremark_' + i).innerHTML;
                        
                        detvalues = detvalues + Itemname +  '^' + Busno + '^' + qty + '^' + remark + '|';   //'^' + Serialno +
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
  
      
function chkRepairItem()
{

//    document.getElementById("Select1").style.display='none';
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

    alert("Please enter Proper Item");
    document.Form1.txtItemName.focus();

    }

    }
    }
    var cat=document.Form1.txtItemName.Text;
    //alert(cat);
    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkrepaiitem&itemName=" +document.getElementById("txtItemName").value,true);
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
if (document.getElementById ("txtqty").value == '')
    {
        alert("Please Enter Quantity ");
        document.getElementById ("txtqty").focus();
        return false ;
    }
     

          
    if(IsNumeric(document.getElementById ("txtqty").value))
    {
//        var qty1=parseInt(document.getElementById ("txtqty").value);
//        var bqty1=parseInt(document.getElementById ("txtbqty").value);
//        if(parseInt(qty1) > parseInt(bqty1)) 
//        {
          alert("Enter Proper Value");
          document.getElementById ("txtqty").focus();
//        }
//        else{
//            additemDetails();
//        }
    }
//    else
//    {
//       alert("Enter Proper Value");
//        document.getElementById ("txtqty").focus();
//        return false ;
//    //}
//}

else{
 additemDetails();
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
//    if (document.getElementById ("txtdept").value == '')
//    {
//        alert("Please Enter Department Name.");
//        document.getElementById ("txtdept").focus();
//        return false ;
//    }
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
    resp = xmlHttp.responseText;
    var ele1 = resp
    if (ele1 == "empty")
    {
    alert("This Bus No does not exists");
  document.getElementById ("txtBusNo").focus();
  }
//     if(document.getElementById('ddlitem').value=="")
//        {
//         document.getElementById('txtbqty').value="";
//    document.getElementById('txtPartNo').value="";
//    document.getElementById('txtSubRackNo').value="";
//        }
//        else{
//    resp = ""
//    resp = xmlHttp.responseText;
//    var ele1 = resp.split('|');

//    document.getElementById('txtbqty').value=ele1[0];
//    document.getElementById('txtPartNo').value=ele1[2];
//    document.getElementById('txtSubRackNo').value=ele1[3];
//}
    }
    }
//    var itemname= document.getElementById('ddlitem').value  ;
//    var subrackno = document.getElementById('txtSubRackNo').value;
//    var partno = document.getElementById('txtPartNo').value;
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkbus&busno=" + document.getElementById("txtBusNo").value ,true);
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
     if(document.getElementById('ddlitem').value=="")
        {
         document.getElementById('txtbqty').value="";
    document.getElementById('txtPartNo').value="";
    document.getElementById('txtSubRackNo').value="";
        }
        else{
    resp = ""
    resp = xmlHttp.responseText;
    var ele1 = resp.split('|');

    document.getElementById('txtbqty').value=ele1[0];
    document.getElementById('txtPartNo').value=ele1[2];
    document.getElementById('txtSubRackNo').value=ele1[3];
}
    }
    }
    var itemname= document.getElementById('ddlitem').value  ;
    var subrackno = document.getElementById('txtSubRackNo').value;
    var partno = document.getElementById('txtPartNo').value;
    xmlHttp.open("GET","AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrackno=" + subrackno + "&partno=" + partno ,true);
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
    if (document .getElementById ('txtSubRackNo').value !='' && document .getElementById ('ddlitem').value !='' )
    {
    document .getElementById ('txtSubRackNo').value='';
    document .getElementById ('ddlitem').value='';
    }
}
    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
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
                                <span id="Span1">Item Receive For Repair  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </span>&nbsp;
                                <asp:Label ID="Label1" runat="server" Text="" Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        
                                        <%--<td align="right">
                                            Date:
                                        </td>--%>
                                        <td align="right">
                                            Department Name:
                                        </td>
                                        <td align="left">
                                            <%----%>
                                            <asp:DropDownList ID="ddlvendor" runat="server" Width="180px">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                           Date: 
                                        </td>
                                        <td align="left">
                                           <%-- <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                                           <BDP:BasicDatePicker ID="BDPLite1" runat="server" Width="160px">
                                            </BDP:BasicDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="style1">
                                            Supervisor Name: 
                                        </td>
                                        <td align="left" class="style1">
                                           <asp:TextBox ID="txtSupervisor" runat="server"></asp:TextBox>  
                                        </td>
                                        <td align="right" class="style1">
                                    Shift
                                </td>
                                <td align="left" class="style1">
                                    <%--<asp:TextBox ID="txtshift" runat="server" Width="140px" TabIndex="13"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlshift"  runat="server">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="I" Text="I"></asp:ListItem>
                                        <asp:ListItem Value="II" Text="II"></asp:ListItem>
                                        <asp:ListItem Value="III" Text="III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Delivered By:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtdelivered" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Received By:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtreceived" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="right">
                                           Place:
                                        </td>
                                        <td align="left">
                                           <asp:DropDownList ID="ddlplace"  runat="server">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Turbhe"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Asudgaon"></asp:ListItem>
                                       
                                    </asp:DropDownList>  
                                        </td>
                                        <td align="right">
                                           Challan No:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtchallanno" runat="server" Width="168px" MaxLength="5"></asp:TextBox>
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
                                            <%--<td>
                                                Serial No
                                            </td>--%>
                                            <td>
                                               Bus No
                                            </td>
                                            <td>
                                                Qty
                                            </td>
                                          <td>
                                                Remark
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr class="gridtxt" valign="top">
                                           
                                            <td>
                                                <asp:TextBox ID="txtItemName" runat="server" Width="250px"></asp:TextBox>
                                            </td>
                                            <%--<td align="left" style="width: 30px; height: 28px;">
                                                <asp:TextBox ID="txtSerialNo" runat="server" Width="150px"></asp:TextBox>
                                             </td>--%>
                                             <td style="height: 28px; width: 55px;">
                                                <asp:TextBox ID="txtBusNo"   runat="server" onblur="chkRepairItem();" maxlength="4" Width="56px"></asp:TextBox>
                                            </td>
                                            <td align="left" style="width: 43px; height: 28px;">
                                                <asp:TextBox ID="txtqty" runat="server" Width="56px" onblur="chkbus();"></asp:TextBox>
                                            </td>
                                             <td align="left" style="width: 70px; height: 28px;">
                                                <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="80px"></asp:TextBox>
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


//	$(document).ready(function() {
//         $("#txtItemName").autocomplete
//           ({
//            source: [<%= stritem  %>]
//            });
//      });

 $(document).ready(function() {
                SearchText();
                loadArrayDd();
        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);
           
            
            $("#txtItemName").autocomplete
           ({

               source: function(request, response) {
                   $.ajax
                    ({
                    
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ItemReceiveForRepair.aspx/GetAutoCompleteData",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "contid": document.getElementById ('ddlvendor').options[document.getElementById ('ddlvendor').selectedIndex].value, "SearchText": document.getElementById('txtItemName').value }),
                        //dataType: "json",
                        success: function(data) {
                            response(data.d);
                        },
                        error: function(result) {
                            alert("Error");
                        }
                    });

               }
           });

            
       
            
            $(document).ready(function(){
    $("#ddlvendor").change(function(){
       $("#txtItemName").val("") ;
    });

})
       }
       function loadArrayDd() {
         
                }
    
	

</script>
</body>
</html>
