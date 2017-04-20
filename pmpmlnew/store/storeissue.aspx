<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="storeissue.aspx.vb" Inherits="KDMT.storeissue" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Item Issue</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/LogSheetIssue.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script language="javascript">
var Optype = 0
var Fuel
var ID = 0;
 var rowcnt = 2;    
                                                        
                                                        
function addissueDetails() {


    if (document.getElementById('hdnsrno').value == '')
    {
    document.getElementById('hdnsrno').value = 0;
    } 
    var srno = 0;
    var lblsrno = document.getElementById('lblsrno');
    var txtlfno = document.getElementById('txtlfno'); 
    var TxtBinNo=document.getElementById('TxtBinNo');
    var txtpartno = document.getElementById('txtPartNo');
    var txtname = document.getElementById('ddlitem');
    var txtavbqty = document.getElementById('txtbqty'); 
    var txtissueqty = document.getElementById('txtqty');
    var txtbalqty = document.getElementById('txtbalqty');
    var txtbus = document.getElementById('txtRefNo');
  
    

   
    var tbody = document.getElementById('tbodyIndent');  
    
    var row  = tbody.insertRow(rowcnt);
    row.setAttribute('id','trissue_' + rowcnt);
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdsrno_' + rowcnt);
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdtxtlfno_' + rowcnt);
    var cells3 = row.insertCell(2);
    cells3.setAttribute('id','TxtBinNo_' + rowcnt);
    var cells4 = row.insertCell(3);
    cells4.setAttribute('id','tdtxtpartno_' + rowcnt);
    var cells5 = row.insertCell(4);
    cells5.setAttribute('id','tdtxtname_' + rowcnt);
    var cells6 = row.insertCell(5);
    cells6.setAttribute('id','tdtxtavbqty_' + rowcnt);
    var cells7 = row.insertCell(6);
    cells7.setAttribute('id','tdtxtissueqty_' + rowcnt);
    var cells8 = row.insertCell(7);
    cells8.setAttribute('id','tdtxtbalqty_' + rowcnt);
    var cells9 = row.insertCell(8);
    cells9.setAttribute('id','tdtxtbus_' + rowcnt);   
    var cells10 = row.insertCell(9);
   
    cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
    cells2.innerHTML = txtlfno.value ;
    cells3.innerHTML=TxtBinNo.value ;
    cells4.innerHTML = txtpartno.value;
    cells5.innerHTML = txtname.value;
    cells6.innerHTML = txtavbqty.value;
    cells7.innerHTML = txtissueqty.value;
    cells8.innerHTML = txtbalqty.value;
    cells9.innerHTML = txtbus.value;
   
    cells10.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trissue_'+ rowcnt +'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    
   
   

              
   
    
    rowcnt = rowcnt + 1;
    txtlfno.value = '';
    //TxtBinNo.value='';
    txtpartno.value = '';
    txtname.value = '';
    txtavbqty.value = '';
    txtissueqty.value = '';
    txtbalqty.value = '';
    txtbus.value = '';
    //txtoiltype.value = '';  

    txtlfno.focus();        
    document.getElementById('hdnrwcnt').value = rowcnt;     
   // alert(document.getElementById('hdnrwcnt').value)
}

function deleteRow(cnt) { 
  
  
    var tr = document.getElementById(cnt);
    document.getElementById('tbodyIndent').removeChild(tr);
    var hdnrwcnt = document.getElementById('hdnrwcnt');
    //hdnrwcnt.value = hdnrwcnt.value -1;
    rowcnt = rowcnt - 1;   
   document.getElementById('hdnsrno').value = 0;
     for (i=1;i< hdnrwcnt.value  ;i++)
              {    
                if (document.getElementById('tdtxtname_' + i)!= null){
                document.getElementById('tdsrno_' + i).innerHTML = parseInt (document.getElementById('hdnsrno').value) + 1
                document.getElementById('hdnsrno').value = parseInt (document.getElementById('hdnsrno').value) + 1
                      
                }
            
              
              } 
              
 } 


function save()
{
var Recs = '';
    
   var hdnrwcnt = document.getElementById('hdnrwcnt').value;
  for (i=1;i<hdnrwcnt ;i++)
              {    
                if (document.getElementById('tdtxtname_' + i)!= null){
                
                var txtlfNo = document.getElementById('tdtxtlfno_' + i).innerHTML;
                var txtpart = document.getElementById('tdtxtpartno_' + i).innerHTML;
                var txtname = document.getElementById('tdtxtname_' + i).innerHTML;
                var txtavbqty = document.getElementById('tdtxtavbqty_' + i).innerHTML;
                var txtissueqty = document.getElementById('tdtxtissueqty_' + i).innerHTML; 
                var txtbalqty = document.getElementById('tdtxtbalqty_' + i).innerHTML;
                var txtbus = document.getElementById('tdtxtbus_' + i).innerHTML; 
                       
               
               Recs = Recs +''+ txtlfNo + '|' + txtpart + '|' + txtname +  '|'  + txtavbqty + '|' + txtissueqty + '|' + txtbalqty + '|' + txtbus +    '^'
                }
              }  
              
              document.getElementById("Hid_Rec").value = Recs;
              
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
    alert ('Select Contractor Name');
    document.getElementById ("ddlvendor").focus()
    return false;
    }

    if (document.getElementById ("txtapproved").value.length==0)
    {
    alert ('Please Enter Approvedby Name');
    document.getElementById ("txtapproved").focus()
    return false;
    }
    if (document.getElementById ("txtpart_of_bus").value.length==0)
    {
    alert ('Please Enter Part Of Bus');
    document.getElementById ("txtpart_of_bus").focus()
    return false;
    }
    if (document.getElementById ("txtref").value.length==0)
    {
    alert ('Please Enter Request No');
    document.getElementById ("txtref").focus()
    return false;
    }
  
    return save();
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
//		            LogSheet2();
 document.getElementById("txtbalqty").value = parseFloat(document.getElementById("txtbqty").value)  - parseFloat(document.getElementById("txtqty").value)
		        }
		        else
		        {
			        
		            alert("Enter Proper Value");
		            setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
		            
		        }
		    }
		}	

 function additem()
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
		            setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
		            
		        }
		    }
		}	

function addissueitem ()
{
    if (parseFloat(document.getElementById("txtbalqty").value) < 0)
    {
        alert("Issue Qty sholuld be less than or equal to available qty");
        setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
        return false ;
    }

    if(document.getElementById("txtqty").value.length>0)
    {
        if(IsNumeric(document.getElementById ("txtqty").value))
        {
        addissueDetails();
        }
        else
        {
        alert("Enter Proper Value");
        setTimeout(function(){document.getElementById('txtqty').focus()}, 10);
        return false ;
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

    document.getElementById('txtbqty').value=ele1[0];
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

function Minus_qty()
{
if(document.getElementById("txtqty").value.length>0)
            {
            document.getElementById("txtbalqty").value = parseFloat(document.getElementById("txtbqty").value)  - parseFloat(document.getElementById("txtqty").value)
            
            } 
}


    </script>
          <link href="../css/newmvc.css" rel="stylesheet" />
</asp:content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
      <div class="breadcrumbs">
        <h1><span id="Span1">Item Issue ( <asp:Label ID ="lbldepttype" Text = "" ForeColor ="red" runat = "server"  ></asp:Label> )</span> </h1>
    </div>
    <div align="center">
       
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
        <div id="middal">
          
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                   
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align="right">
                                            Depot Name:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlvendor" TabIndex="1" runat="server" Width="216px" 
                                                Font-Size="Medium">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                            Date : -
                                        </td>
                                        <td align="left">
                                        
                                                <asp:TextBox ID="BDPLite1" Width="100px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                                PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                                            <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                            </asp:ScriptManager>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Worker Name :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtwname" TabIndex="3" runat="server" Width="168px" 
                                                Font-Size="Medium"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Approved By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtapproved" TabIndex="4" runat="server" Width="168px" 
                                                Font-Size="Medium"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Indent No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtref" TabIndex="5" runat="server"  Font-Size="Medium"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Part Of Bus :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtpart_of_bus" TabIndex="6" runat="server" Width="168px" 
                                                Font-Size="Medium"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Gate Pass No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtgate" TabIndex="7" runat="server"  Font-Size="Medium"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Remark :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtremark" TabIndex="8" TextMode="MultiLine" runat="server" Width="168px"
                                                 Font-Size="Medium"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Grd_Item" width="100%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbodyIndent">
                                        <tr class="gridhead">
                                            <td>
                                                SR No.
                                            </td>
                                            <td>
                                                LF No
                                            </td>
                                            <td>
                                                Bin No
                                            </td>
                                            <td>
                                                Part No.
                                            </td>
                                            <td>
                                                Item Name
                                            </td>
                                            <td>
                                                Available<br />
                                                Qty.
                                            </td>
                                            <td>
                                                Issue
                                                <br />
                                                Qty.
                                            </td>
                                            <td>
                                                Bal
                                                <br />
                                                Qty.
                                            </td>
                                            <td>
                                                Bus No
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr class="gridtxt">
                                            <td>
                                                <input type="text" style ="display :none " id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                            </td>
                                            <td align="left" style="width: 100px; height: 28px;">
                                                <asp:TextBox class="textfield" ID="txtlfno" TabIndex="9" onblur="emptytext();ajaxFunction();"
                                                    runat="server" Width="100px"  Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="TxtBinNo" runat="server" readonly="false" size="15" onblur="ajaxFunction();"></asp:TextBox>
                                            </td>
                                            <td align="left" style="width: 100px; height: 28px;">
                                                <asp:TextBox class="textfield" ID="txtPartNo" onblur="emptytextpart();ajaxFunction();"
                                                    runat="server" Width="100px"  Font-Size="Medium"></asp:TextBox>
                                            </td>
                                          
                                            <td>
                                                <asp:TextBox ID="ddlitem" onpropertychange="ajaxFunction();" TabIndex="10" onblur="return check1();"
                                                    runat="server"></asp:TextBox>
                                                <asp:ListBox ID="Select1" Style="display: none;" onclick="Select();"
                                                    runat="server"></asp:ListBox>
                                            </td>
                                            <td align="left" style="width: 43px; height: 28px;">
                                                <asp:TextBox ID="txtbqty" onfocus="chkItemName()" TabIndex="11" runat="server" Width="56px"
                                                    ReadOnly="True"  Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtqty" onblur="ticFunction2()" TabIndex="12" runat="server" Width="56px"
                                                     Font-Size="Medium"> </asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtbalqty" ReadOnly="true" runat="server" Width="56px" 
                                                    Font-Size="Medium"> </asp:TextBox>
                                            </td>
                                            <td style="height: 28px; width: 55px;">
                                                <asp:TextBox ID="txtRefNo" TabIndex="13" onblur="addissueitem ()" runat="server"
                                                    Width="56px"  Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                &nbsp;
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
                                    &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" TabIndex="14" ImageUrl="../images/btn_h.gif">
                                    </asp:ImageButton><asp:ImageButton ID="btnclear" TabIndex="15" runat="server" ImageUrl="../images/cancel.gif">
                                    </asp:ImageButton></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>


</asp:content>