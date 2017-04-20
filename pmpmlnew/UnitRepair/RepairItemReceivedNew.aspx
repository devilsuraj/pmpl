<%@ Page Language="VB" AutoEventWireup="false"  CodeFile="RepairItemReceivedNew.aspx.vb"
    Inherits="KDMT.RepairItemReceivedNew" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Repair Item Receive</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

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
            var txtQty = document.getElementById('txtqty');
           
            var tbody = document.getElementById('tbodyIndent');
 
            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntSave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdItemName_' + rowcntSave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdSerialNo_' + rowcntSave);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdQty_' + rowcntSave);
            
            var cells4 = row.insertCell(3);


        
            cells1.innerHTML = txtItemName.value;
            cells2.innerHTML = txtSerialNo.value;
            cells3.innerHTML = txtQty.value;
       
           
            cells4.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntSave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            rowcntSave += 1;
                                   
            txtItemName.value = '';
            txtSerialNo.value = '';
            txtQty.value = '';
            

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


       function validate(){
       
   if (document.getElementById ("ddlvendor").selectedIndex == 0 )
    {
    alert ('Select Department Name.');
    document.getElementById ("ddlvendor").focus()
    return false;
    }

    if (document.getElementById ("txtSubmitted").value.length==0)
    {
    alert ('Please Enter Submitted By Name');
    document.getElementById ("txtSubmitted").focus()
    return false;
    }
    
    if (document.getElementById ("txtReceived").value.length==0)
    {
    alert ('Please Enter Receiver Name');
    document.getElementById ("txtReceived").focus()
    return false;
    }
       if (document.getElementById ("txtInwardNo").value.length==0)
    {
    alert ('Please Enter Inward No');
    document.getElementById ("txtInwardNo").focus()
    return false;
    }
    var grdvat = document.getElementById('<%= dgresult.clientID %>');
    var check = 0 ;
    var i = 0;
    var j = 0
    var value = 0;
    var vcount = grdvat.rows.length;

    for (i; i < vcount - 1; i++) {
    var rowel = grdvat.rows[i];
    //grddetail__ctl2_ + ''
    j = i + 2
    var id = 'dgresult__ctl' + j + '_chkselect'
    var chkselect = document.getElementById(id);
    if (chkselect.checked != false  )
    {
    check = 1
    }
    }
    if (check != 1 ){
    alert ('Please Tick atleast one box');
    document.getElementById('dgresult__ctl2_chkselect').focus();
     return false;
    }
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

//function ticFunction2()
// 
//{
////if (document.getElementById ("ddlitem").value == '')
////    {
////        alert("Please Enter Item ");
////        document.getElementById ("ddlitem").focus();
////        return false ;
////    }
//if (document.getElementById ("txtqty").value == '')
//    {
//        alert("Please Enter Quantity ");
//        document.getElementById ("txtqty").focus();
//        return false ;
//    }
//   
////if(IsNumeric(document.getElementById ("txtqty").value))
////    {
////        var qty1=parseInt(document.getElementById ("txtqty").value);
////        var bqty1=parseInt(document.getElementById ("txtbqty").value);
////        if(parseInt(qty1) > parseInt(bqty1)) 
////        {
////          alert("Enter Proper Value");
////          document.getElementById ("txtqty").focus();
////        }
////        else{
////            additemDetails();
////        }
////    }
////    else
////    {
////       alert("Enter Proper Value");
////        document.getElementById ("txtqty").focus();
////        return false ;
////    //}
// //}
//  additemDetails();
//}	

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
         additemDetails();
         }
    else
    {
       alert("Enter Proper Value");
        document.getElementById ("txtqty").focus();
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

//function getbusno()
//{
//debugger
//    if (document .getElementById ('txtjobno').value !=''  )
//    {
//    var job= document.getElementById('txtjob').value
//     var jobno= document.getElementById('txtjobno').value
//    xmlHttp.open("GET","AjaxStore.aspx?Action=getbusno&jobno=" + jobno,true);
//    xmlHttp.send(null);
//    }
//}

function vendor()
{
 var cont = document.getElementById('ddlvendor');
  var indent = document.getElementById('tblIndent'); 
   if (cont.options[cont.selectedIndex].value == '0')
    {
     indent.style.display = ''
    }
     else
    {
    indent.style.display = 'none'
    }
}


function getbusno()
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

    if(ele1=="empty")
    {

    alert("Job Card is not open");
   document.getElementById("txtjob").focus();

    }
    else
    document.getElementById("txtRefNo").value=resp;

    }
    }
 
    
     if (document.getElementById ('txtJobNo').value !=''  )
     {
    xmlHttp.open("GET","AjaxStore.aspx?Action=getbusno&newjob=" + document.getElementById("txtjob").value + "&newjobno=" + document.getElementById("txtJobNo").value, true);
    xmlHttp.send(null);
    }
}

 
    
    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="mpagetop">
                </div>
                <div class="mpage">
                    <table width="100%" >
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">Repair Item Received At Store&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                                            <%--<asp:Label ID="BDPLite1" runat="server" Text=""></asp:Label>--%>
                                            <%-- <BDP:BDPLite ID="BDPLite1" runat="server">
                                            </BDP:BDPLite>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Submitted By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtSubmitted" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Received By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtReceived" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Inward No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtInwardNo" runat="server" Width="75px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>
                                    <asp:DataGrid ID="dgresult" Width="90%" BorderStyle="Double" CellPadding="4" CellSpacing="0"
                                        BorderColor="#FFFFFF" border="2" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                        runat="server" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Sr No." ItemStyle-HorizontalAlign="right">
                                                <ItemTemplate>
                                                    <%#Container.ItemIndex + 1%>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:BoundColumn DataField="RepairWorkId" Visible="false"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="item_code" Visible="false"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="item_name" ItemStyle-HorizontalAlign="Left" HeaderText="Item Name">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="SerialNo" HeaderText="Serial No"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="qty" ItemStyle-HorizontalAlign="right" HeaderText="Actual Qty">
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Remark">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemark" TextMode="MultiLine" runat="server" Width="150px"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Done">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkselect" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trsave" runat="server" visible="false">
                            <td style="height: 22px" align="center">
                                &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"
                                    TabIndex="9"></asp:ImageButton>
                                <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="10">
                                </asp:ImageButton>
                            </td>
                        </tr>
                    </table>
              <%--      <asp:Label ID="lblmsg" runat="server"></asp:Label>--%>
                </div>
                <div class="mpagebottam">
                </div>
            </div>
        </div>
    </div>
    </form>
    <%--      <script type="text/javascript">
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

	
	$("#txtdept").autocompleteArray(
		[<% =strdept  %>],
		{
			delay:10,
			minChars:1,
			matchSubset:1,
			onItemSelect:selectItem,
			onFindValue:findValue,
			autoFill:true,
			maxItemsToShow:10
		}
	);--%>

    <script type="text/javascript">
      $(document).ready(function() {
         $("#txtItemName").autocomplete
           ({
            source: [<%= stritem  %>]
            });
      });
      
       
     
      
    </script>

</body>
</html>
