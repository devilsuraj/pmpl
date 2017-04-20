<%@ Page Language="VB" AutoEventWireup="false" CodeFile="View_Indent_Request.aspx.vb"
    Inherits="KDMT.Indent_Request_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View Indent Request</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0
var Fuel
var ID = 0;
 var rowcnt = 0;


function addEmpDetails() {
    
    var txtsubrack = document.getElementById('txtsubrack');
    var txtPartNo = document.getElementById('txtPartNo');
    var txtItemName = document.getElementById('txtItemName');
    var txtBusNo = document.getElementById('txtBusNo');
    var txtAvaiQty = document.getElementById('txtAvailableQty');
    var txtReqQty = document.getElementById('txtReqQty');
    var txtIssQty = document.getElementById('txtIssQty');
    var txtPenQty = document.getElementById('txtPenQty');
    var tbody = document.getElementById('tbodyRIndent');
    var tblIndent = document.getElementById('tblIndent');
    var hdnrwcnt = document.getElementById('hdnrwcnt');
    
    if (rowcnt==0){
        rowcnt = parseInt(hdnrwcnt.value);
    }           
    
    var row  = tbody.insertRow(rowcnt);
    row.setAttribute('id','trIndent_' + rowcnt);
    
    var cells1 = row.insertCell(0);
    cells1.setAttribute('id','tdSubRack_' + rowcnt);
    var cells2 = row.insertCell(1);
    cells2.setAttribute('id','tdPartNo_' + rowcnt);
    var cells3 = row.insertCell(2);
    cells3.setAttribute('id','tdItemName_' + rowcnt);
    var cells4 = row.insertCell(3);    
    cells4.setAttribute('id','tdBusNo_' + rowcnt);
    var cells5 = row.insertCell(4);    
    cells5.setAttribute('id','tdAvailQty_' + rowcnt);
    var cells6 = row.insertCell(5);
    cells1.setAttribute('id','tdReqQty_' + rowcnt);
    var cells7 = row.insertCell(6);
    cells2.setAttribute('id','tdIssQty_' + rowcnt);
    var cells8 = row.insertCell(7);
    cells3.setAttribute('id','tdPenQty_' + rowcnt);
    var cells9 = row.insertCell(8);     
    
   
    cells1.innerHTML = txtsubrack.value;
    cells2.innerHTML = txtPartNo.value;
    cells3.innerHTML = txtItemName.value;
    cells4.innerHTML = txtBusNo.value;    
    cells5.innerHTML = txtAvaiQty.value;
    cells6.innerHTML = txtReqQty.value;
    cells7.innerHTML = txtIssQty.value;
    cells8.innerHTML = txtPenQty.value;
    cells9.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trIndent_'+ rowcnt +'\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
    txtsubrack.value = '';
    txtPartNo.value = '';
    txtItemName.value = '';
    txtBusNo.value = '';
    txtReqQty.value = '';
    txtAvaiQty.value = '';
    txtIssQty.value = '';
    txtPenQty.value = '';
    txtsubrack.focus();        
    rowcnt = rowcnt + 1; 
    hdnrwcnt.value = rowcnt;   
    
}

function deleteRow(cnt,IndId) {    
    var tr = document.getElementById(cnt);
    document.getElementById('tbodyRIndent').removeChild(tr);
    var hdnrwcnt = document.getElementById('hdnrwcnt');
    //hdnrwcnt.value = hdnrwcnt.value -1;
    rowcnt = rowcnt - 1;    
    var url = "../tmtAjax/Master_ajax.aspx?action=ForceDeletetInd&Id=" + IndId;
    sendRequest(url);
}



function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you wan`t to delete.")){return true}
        else{return false}  
   }
   
    function Issue(id){
        var AvailableQty = document.getElementById('tdAvailableQty_' + id);
        var RequiredQty = document.getElementById('tdRequiredQty_' + id);
        var IssuedQty = document.getElementById('txtIssuedQty_' + id);
        var PendingQty = document.getElementById('txtPendingQty_' + id);
        
        if(parseInt(IssuedQty.value) > parseInt(AvailableQty.innerHTML)){
            alert("Required Qty should be less than Availabe Qty");            
            IssuedQty.focus();
            return false;
        }

            if(parseInt(RequiredQty.innerHTML) < parseInt(IssuedQty.value)){
                alert("Issued Qty should be less then or equale to RequiredQty Qty");            
                IssuedQty.focus();
                return false;
            }
        if (IssuedQty.value != '' ){
            PendingQty.value = parseInt(RequiredQty.innerHTML) - parseInt(IssuedQty.value);
        }
        else{PendingQty.value = 0;}
    }

    function getIndent(){         
        var ddl = document.getElementById('ddlIndNo');               
        var url = '../tmtAjax/Common_ajax.aspx?action=getIndentDetails&IndNo=' +  ddl.options[ddl.selectedIndex].text + '&IndId=' + ddl.value;               
        sendRequest(url);                                
         return false;
    }
    
    function DeleteDefect(ID){    
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
               Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&Optype=" + Optype;
            sendRequest(url);
            return false;
        }     
    }
    
    function ddlSelection(tdvalue,ddl){        
        for (i=0;i<ddl.length;i++){         
             if(ddl.options[i].text == tdvalue){
                ddl.selectedIndex = i;
             }
         }
    }
    
    function editDefect(id){    
        var ddlDefPriority = document.getElementById('ddlDefPriority');         
        ddlSelection(document.getElementById('tdDefPriority_'+ id).innerHTML,ddlDefPriority);         
        document.getElementById('dtDefectDate_TextBox').value = document.getElementById('tdDefDate_'+ id).innerHTML;               
        document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_'+ id).innerHTML;
        document.getElementById('txtDriverNo').value = document.getElementById('tdDriverNo_'+ id).innerHTML;
        document.getElementById('txtDefectTime').value = document.getElementById('tdDefectTime_'+ id).innerHTML;
        document.getElementById('txtDescription').value = document.getElementById('tdDescription_'+ id).innerHTML;                                                          
        
        document.getElementById('hdnID').value = id
        Optype = 1;    
    }
    
    function ValidateSave(){ 
    var detvalues = '';
    var i = 0;    

        var hdnrwcnt = document.getElementById('hdnrwcnt').value;
        var ddlIndent = document.getElementById('ddlIndNo');
        var txtIndentNo = ddlIndent.options[ddlIndent.selectedIndex].text;
        var ddlvendor = document.getElementById('ddlvendor').value;        
        var dtIssueDate = document.getElementById('dtIssueDate_TextBox').value;                   
        var txtwname = document.getElementById('txtwname').value;         
        var txtapprovedby = document.getElementById('txtapproved').value;                        
        var txtPartBus = document.getElementById('txtPartBus').value;                                
        var txtgate = document.getElementById('txtgate').value;                                        
        var txtremark = document.getElementById('txtremark').value;                
        
        for (i=0;i<hdnrwcnt ;i++){  
            var IssQty = document.getElementById('txtIssuedQty_' + i);
            if(IssQty != null){
                if (IssQty.value == ''){
                    alert('Issued Qty. should not be empty')
                    IssQty.focus();  
                    return false;
                }
            }    
        }
        
        if( document.getElementById('ddlvendor').selectedIndex == 0){
            alert('Please select vendor');
            document.getElementById('ddlvendor').focus();
            return false;
        } 
              
        for (i=0;i<hdnrwcnt ;i++)
              {    
                if (document.getElementById('tdSubRackNo_' + i)!= null){
                var ID = document.getElementById('tdID_' + i).innerHTML;
                var SubRack = document.getElementById('tdSubRackNo_' + i).innerHTML;
                var PartNo = document.getElementById('tdPartNo_' + i).innerHTML;
                var ItemName = document.getElementById('tdItemName_' + i).innerHTML;
                var BusNo = document.getElementById('tdBusNo_' + i).innerHTML;                
                var AvaiQty = document.getElementById('tdAvailableQty_' + i).innerHTML;
                var ReqQty = document.getElementById('tdRequiredQty_' + i).innerHTML;
                var IssQty = document.getElementById('txtIssuedQty_' + i).value;
                var PenQty = document.getElementById('txtPendingQty_' + i).value; 
                
                detvalues = detvalues + ID + '^' + SubRack + '^' + PartNo + '^' + ItemName + '^' + BusNo + '^' + AvaiQty + '^' + ReqQty + '^' + IssQty + '^' + PenQty + '|';
                }
              }              
            
        //if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=IssueDetails&IndentNo=" + txtIndentNo + "&Vendor=" + ddlvendor + "&IssueDate=" + dtIssueDate + "&Wname=" + txtwname + "&Approvedby=" + txtapprovedby + "&PartBus="+ txtPartBus + "&Gate=" + txtgate + "&Remark=" + txtremark  + "&Indentdetails=" + detvalues  + "&Optype=" + Optype;                                                             
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=indentDetails&Id=" + ID +  "&txtindentdate=" + txtindentdate + "&txtapprovedby=" + txtapprovedby + "&txtremark=" + txtremark  + "&Optype=" + Optype;                         
             Optype = 0;
        }
        sendRequest(url);
    }
 
    function Clean(){
        window.location.href = "View_Indent_Request.aspx";
    }
    
function ajaxFunction() {

    try	{
        // Firefox, Opera 8.0+, Safari
        xmlHttp=new XMLHttpRequest();   
    }
    catch (e) {
        // Internet Explorer
        try {
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
	    catch (e) {
            try { 
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
		    catch (e) {
                alert("Your browser does not support AJAX!");
			    return false;
            }
            
        }
    }

    xmlHttp.onreadystatechange=handleresponse
}

ajaxFunction();

function sendRequest(url) {    
    url = url + '&t=' + new Date();    
    xmlHttp.open("GET",url );   
    xmlHttp.send(null);   
}



function handleresponse() { 
var arrApp = new Array();
    if(xmlHttp.readyState==4) {            
        resp = xmlHttp.responseText;                               
        if (resp.indexOf('PassIndent')!= -1) {                                                 
            arrApp =  resp.split("|");           
            resp = arrApp[0];
            document.getElementById('txtapproved').value = arrApp[1];          
            document.getElementById('hdnrwcnt').value = arrApp[2];                 
            if (arrApp.length > 3){                        
            document.getElementById('txtwname').value = arrApp[3];
            document.getElementById('txtgate').value = arrApp[4];          
            document.getElementById('txtPartBus').value = arrApp[5];                      
            document.getElementById('dtIssueDate_TextBox').value = arrApp[6];                      
            document.getElementById('txtremark').value = arrApp[8];
            document.getElementById('ddlvendor').value = arrApp[7];                        
            }
            else{
            var now = new Date();            
            document.getElementById('dtIssueDate_TextBox').value = '';                                              
            document.getElementById('txtwname').value = '';
            document.getElementById('txtgate').value = '';          
            document.getElementById('txtPartBus').value = '';                  
            document.getElementById('dtIssueDate_TextBox').value = now.toString('dd-MMM-yyyy');
            document.getElementById('txtremark').value = '';
            document.getElementById('ddlvendor').value = '';     
            }
            document.getElementById('dvRIndent').innerHTML = resp.substring(10); 
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');                    
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                              
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Defect No. is already exist.');                              
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                              
            return false;
        }           
        else if(resp.indexOf('indentno') != -1) {                                           
            document.getElementById('lblindent').innerHTML =  resp.substring(8)            
             Clean();          
            return false;
        }       
        else if(resp.indexOf('FailIndent') != -1) {              
            document.getElementById('dvRIndent').innerHTML = resp.substring(10);
            return false;
        }
        
    }
}

function addIndentReq(){

}



function getitemname()
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
while(document.getElementById("Select1").options.length > 0)
document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
if(document.getElementById('txtItemName').value != "" || document.getElementById('txtsubrack').value != "" || document.getElementById('txtPartNo').value != "")
{
for (var i = 0; i < ele.length; i++)
{
var temp=document.getElementById("Select1")
temp.style.display='';
temp.size=ele.length;
newOpt = document.createElement("option");
document.getElementById("Select1").options.add(newOpt);
newOpt.value = ele[i];
newOpt.text  = ele[i];
if (document.getElementById('txtItemName').value==ele[i])
{
}
if (ele[i]=="0")
{
}			
}
}
else
{
var temp=document.getElementById("Select1")
temp.size=0
temp.style.display='';
}
}
}
var txtsubrackno = document.getElementById('txtsubrack').value;
var partno = document.getElementById('txtPartNo').value;
xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" +  document.getElementById('txtItemName').value  + "&subrackno=" + txtsubrackno + "&partno=" + partno ,true);
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
    var objddl1 = document.getElementById('txtItemName');
    objddl1.value=resultStr;
    var x=document.getElementById('Select1');
       x.style.display="none";  
    document.getElementById('txtItemName').focus();
    return false;    
    } 
    } 

}


function emptytext()
{

    if (document .getElementById ('txtPartNo').value !='' && document .getElementById ('txtItemName').value !='' )
    {
    document .getElementById ('txtPartNo').value='';
    document .getElementById ('txtItemName').value='';
    }
}

function emptytextpart()
{
    if (document .getElementById ('txtsubrack').value !='' && document .getElementById ('txtItemName').value !='' )
    {
    document .getElementById ('txtsubrack').value='';
    document .getElementById ('txtItemName').value='';
    }
}

function display()
{

    var x=document.getElementById('Select1');
       x.style.display="none";  
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
    document.getElementById('txtsubrack').value=ele1[3];
    }
    }
    var itemname= document.getElementById('txtItemName').value  ;
    var txtsubrack = document.getElementById('txtsubrack').value;
    var partno = document.getElementById('txtPartNo').value;
    xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrack=" + txtsubrack + "&partno=" + partno ,true);
    xmlHttp.send(null);
}
			
///////////   for removing blaak spaces 
String.prototype.trim = function()
{

return this.replace(/^\s+|\s+$/g,"");
}
	

function  check1()
{
    var str = document.getElementById('txtItemName').value;
    if (str.trim() !='')
    {
    Fromcombo2();
    }
    return false;
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
						return true;
			}

function validateqty()
			{
			    if(document.getElementById ("txtReqQty").value.length>0)
                {

			        if(IsNumeric(document.getElementById ("txtReqQty").value))
                    {
			            addEmpDetails();
			        }
			        else
			        {
    			        
			            alert("Enter Proper Value");
			            document.getElementById ("txtReqQty").focus();
			        }
			    }
			      else
			        {
    			        
			            alert("Enter Proper Value");
			            document.getElementById ("txtReqQty").focus();
			        }
			}	
			
			

    </script>

</head>
<body>

    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    </div>
    <div id="middal">
        <uc:leftmenu ID="Leftmenu1" runat="server" />
      <div class="contantbox">     
               
            <%--<div class="orgtop">
            </div>--%>
            <div class="pagetop">
            </div>
            <%--<div class="orgmiddal">--%>
           <div class="page" > 
                <table width="100%" border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="4" class="innerheading">
                            <span id="Label3">View Indent Request</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label1" runat="server" Text="Your Indent No Is" ForeColor="black"></asp:Label></td>
                        <td>
                            <asp:DropDownList runat="server" onchange="getIndent();" ID="ddlIndNo">
                            </asp:DropDownList></td>
                        <td>
                            Contractor Name:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlvendor" runat="server" Width="216px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Issue Date : -
                        </td>
                        <td align="left">
                            <BDP:BDPLite ID="dtIssueDate" runat="server">
                            </BDP:BDPLite>
                        </td>
                        <td align="right">
                            Worker Name :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtwname" runat="server" Width="168px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Approved By :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtapproved" runat="server" Width="168px"></asp:TextBox>
                        </td>
                        <td align="right">
                            Part Of Bus :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtPartBus" runat="server" Width="168px"></asp:TextBox>
                        </td>
                    </tr>                    
                    <tr>
                        <td align="right">
                            Gate Pass No. :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtgate" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            Remark :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="168px"></asp:TextBox>
                        </td>
                    </tr>
                   
                    <tr>
                        <td id="tdindent" colspan="4">
                            <table id="tblIndent" width="100%" border="1" cellpadding="5" cellspacing="5">
                                <tbody runat="server" id="tbodyIndent">
                                    <tr class='gridhead'>
                                        <td>
                                            Sub rack No.
                                        </td>
                                        <td>
                                            Part No.
                                        </td>
                                        <td>
                                            Item Name
                                        </td>
                                        <td>
                                            Bus No
                                        </td>
                                        <td>
                                            Available Qty.
                                        </td>
                                        <td>
                                            Required Qty.
                                        </td>
                                        <td>
                                            Issued Qty.
                                        </td>
                                        <td>
                                            Pending Qty.
                                        </td>
                                        <td>
                                            Remove
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="9">
                                            <div id="dvRIndent">
                                            </div>
                                            <%--<table id="Table1" width="100%" border="1" cellpadding="5" cellspacing="5">
                                            <tbody runat="server" id="tbodyRIndent">
                                            
                                            </tbody>
                                            </table>--%>
                                        </td>
                                    </tr>
                                    <tr class='gridtxt'>
                                        <td>
                                            <input type="text" id="txtsubrack" onblur="emptytext();getitemname();" name="txtsubrack" />
                                        </td>
                                        <td>
                                            <input type="text" id="txtPartNo" name="txtPartNo" onblur="emptytextpart();getitemname();" />
                                        </td>
                                        <td>
                                            <input type="text" id="txtItemName" name="txtItemName" onpropertychange="getitemname();"
                                                onblur="return check1();" />
                                            <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                runat="server"></asp:ListBox>
                                        </td>
                                        <td>
                                            <input type="text" id="txtBusNo" onfocus="display();" name="txtBusNo" />
                                        </td>
                                        <td>
                                            <input type="text" id="txtAvailableQty" name="txtAvailableQty" />
                                        </td>
                                        <td>
                                            <input type="text" id="txtReqQty" name="txtReqQty" />
                                        </td>
                                        <td>
                                            <input type="text" id="txtIssQty" name="txtIssQty" />
                                        </td>
                                        <td>
                                            <input type="text" id="txtPenQty" name="txtPenQty" onblur="validateqty(this);" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <input name="btnsave" type="button" id="btnsave" value="Save" onclick="ValidateSave();" />
                            <a href="Indent_Request_Details.aspx">Reset</a>
                        </td>
                    </tr>
                </table>
                </div>
            <%--</div>--%>
            <div class="pagebottam">
            </div>
           <%--<div class="orgbottam">
            </div>--%>
     </div>
    </div>
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
    </script>

</body>
</html>
