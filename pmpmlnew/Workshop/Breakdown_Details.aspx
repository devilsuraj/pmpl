<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Breakdown_Details.aspx.vb"
    Inherits="KDMT.Breakdown_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Breakdown</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0
var Fuel
var ID = 0;



function chkTime(obj){
    
    if(obj.value!=''){     
        var time = obj.value.charAt(2);
        if (time != ':')
        {
            alert("Please enter correct time format (hh:ss)");
            obj.value = '';	
            obj.focus();	
            return false;
        }

        var valTime = new RegExp("^([0-1][0-9]|[2][0-3]).([0-5][0-9])$");
        if (obj.value.match(valTime) == null) 
        {
            alert("Please enter correct time format (hh:ss)");
            obj.value = '';	
            obj.focus();
            return false;		
        } 
    }
}
        
        
function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you wan`t to delete.")){return true}
     else{return false}  
   }
   

    function getBreakdown(){         
        var url = '../tmtAjax/Common_ajax.aspx?action=getBreakdownDetails'        
        ajaxFunction()
        sendRequest(url);                                
         return false;
    }
    
    function DeleteBreakdown(ID){    
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
               Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=BreakdownDetails&Id=" + ID + "&Optype=" + Optype;
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
    
    function editBreakdown(id){    
        var splTime = new Array();      
        document.getElementById('txtBrkdwnPlace').value = document.getElementById('tdPlaceName_'+ id).innerHTML;     
        document.getElementById('dtBrkdwnDate_TextBox').value = document.getElementById('tdDate_'+ id).innerHTML;               
        document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_'+ id).innerHTML;
        document.getElementById('txtDriverNo').value = document.getElementById('tdDriverNo_'+ id).innerHTML;
        document.getElementById('txtConductor').value = document.getElementById('tdConductorNo_'+ id).innerHTML;
        document.getElementById('txtReason').value = document.getElementById('tdReason_'+ id).innerHTML;                                                          
        document.getElementById('txtInfoTime').value = document.getElementById('tdInfo_Time_'+ id).innerHTML;
        document.getElementById('txtMsgRcdTime').value = document.getElementById('tdMsg_Time_'+ id).innerHTML;
        document.getElementById('txtArrTime').value = document.getElementById('tdArrTime_'+ id).innerHTML;        
        splTime = document.getElementById('tdActTime_'+ id).innerHTML.split("To");                
        document.getElementById('txtActTimeFrom').value = splTime[0];
        document.getElementById('txtActTimeTo').value = splTime[1];
        document.getElementById('txtRemark').value = document.getElementById('tdRemark_'+ id).innerHTML;        
        document.getElementById('hdnID').value = id
        Optype = 1;    
    }
    
    function ValidateSave(){ 
            
        var BusNo = document.getElementById('txtBusNo');        
        if (BusNo.value == ''){
            alert('Bus No. should not be empty')
            BusNo.focus();
            return false;
        }
        
        var dtBrkdwnDate = document.getElementById('dtBrkdwnDate_TextBox').value;           
        var txtBusNo = document.getElementById('txtBusNo').value;
        var txtDriverNo = document.getElementById('txtDriverNo').value;                        
        var txtConductor = document.getElementById('txtConductor').value;
        var txtBrkdwnPlace = document.getElementById('txtBrkdwnPlace').value;
        var txtReason = document.getElementById('txtReason').value;                        
        var txtInfoTime = document.getElementById('txtInfoTime').value;         
        var txtMsgRcdTime = document.getElementById('txtMsgRcdTime').value;    
        var txtArrTime = document.getElementById('txtArrTime').value;        
        var txtActTimeFrom = document.getElementById('txtActTimeFrom').value;                        
        var txtActTimeTo = document.getElementById('txtActTimeTo').value;                        
        var txtRemark = document.getElementById('txtRemark').value;
                            
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=BreakdownDetails&Id=" + ID + "&BrkdwnDate=" + dtBrkdwnDate + "&BusNo=" + txtBusNo + "&DriverNo=" + txtDriverNo + "&Conductor=" + txtConductor + "&BrkdwnPlace=" + txtBrkdwnPlace + "&Reason=" + txtReason + "&InfoTime=" + txtInfoTime + "&MsgRcdTime=" + txtMsgRcdTime + "&ArrTime=" + txtArrTime + "&ActTimeFrom=" + txtActTimeFrom + "&ActTimeTo=" + txtActTimeTo + "&Remark=" + txtRemark + "&Optype=" + Optype;                         
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=BreakdownDetails&Id=" + ID + "&BrkdwnDate=" + dtBrkdwnDate + "&BusNo=" + txtBusNo + "&DriverNo=" + txtDriverNo + "&Conductor=" + txtConductor + "&BrkdwnPlace=" + txtBrkdwnPlace + "&Reason=" + txtReason + "&InfoTime=" + txtInfoTime + "&MsgRcdTime=" + txtMsgRcdTime + "&ArrTime=" + txtArrTime + "&ActTimeFrom=" + txtActTimeFrom + "&ActTimeTo=" + txtActTimeTo + "&Remark=" + txtRemark + "&Optype=" + Optype;                         
             Optype = 0;
        }
        sendRequest(url);
    }
 
    function Clean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var dtBrkdwnDate = document.getElementById('dtBrkdwnDate_TextBox');
        var txtBusNo = document.getElementById('txtBusNo');
        var txtDriverNo = document.getElementById('txtDriverNo');
        var txtConductor = document.getElementById('txtConductor');
        var txtBrkdwnPlace = document.getElementById('txtBrkdwnPlace');
        var txtReason = document.getElementById('txtReason');
        var txtInfoTime = document.getElementById('txtInfoTime');
        var txtMsgRcdTime = document.getElementById('txtMsgRcdTime');
        var txtArrTime = document.getElementById('txtArrTime');
        var txtActTimeFrom = document.getElementById('txtActTimeFrom');
        var txtActTimeTo = document.getElementById('txtActTimeTo');
        var txtRemark = document.getElementById('txtRemark');       
        
        
        txtBusNo.value = '';
        txtDriverNo.value = '';
        txtConductor.value = '';
        txtBrkdwnPlace.value = '';
        txtReason.value = '';
        txtInfoTime.value = '';
        txtMsgRcdTime.value = '';
        txtArrTime.value = '';
        txtActTimeFrom.value = '';
        txtActTimeTo.value = '';
        txtRemark.value = '';
        
        
//        dtRTODate.value = currentDate;
//        dtFitRenewalDate.value = currentDate;
//        dtDepoDate.value = currentDate;
//        dtPutDate.value = currentDate;
        
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
    if(xmlHttp.readyState==4) {            
        resp = xmlHttp.responseText;                 
        if (resp.indexOf('PassBreakdownSearch')!= -1) {             
            document.getElementById('dvBrkdwnMaster').innerHTML = resp.substring(19);
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');        
            getBreakdown();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getBreakdown();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Breakdown No. is already exist.');                  
            getBreakdown();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getBreakdown();            
            return false;
        }           
        
    }
}
    </script>

</head>
<body onload="return getBreakdown();">
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                        <tr>
                            <td class="innerheading" colspan="4" >
                                <span id="Label3">Breakdown Details</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Breakdown Date
                            </td>
                            <td>
                                <BDP:BDPLite ID="dtBrkdwnDate" TextBoxStyle-Width="100px" runat="server">
                                    <TextBoxStyle Width="100px" />
                                </BDP:BDPLite>
                            </td>
                            <td align="right">
                                Bus No.
                            </td>
                            <td>
                                <input id="txtBusNo" runat="server" type="text" name="textfield" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Driver No.
                            </td>
                            <td>
                                <input id="txtDriverNo" runat="server" type="text" name="textfield" />
                            </td>
                            <td align="right">
                                Conductor
                            </td>
                            <td>
                                <input id="txtConductor" runat="server" type="text" name="textfield" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Place of Breakdown
                            </td>
                            <td>
                               <%-- <asp:DropDownList runat="server" ID="ddlBrkdwnPlace">
                                </asp:DropDownList>--%>
                                
                                 <input id="txtBrkdwnPlace" runat="server" type="text" name="txtBrkdwnPlace" />
                            </td>
                            <td align="right">
                                Reason
                            </td>
                            <td>
                                <input id="txtReason" runat="server" type="text" name="textfield" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Informing Time
                            </td>
                            <td>
                                <input id="txtInfoTime" runat="server" type="text" onblur="chkTime(this);" name="textfield" />
                            </td>
                            <td align="right">
                                Massage Recieved Time
                            </td>
                            <td>
                                <input id="txtMsgRcdTime" runat="server" type="text" onblur="chkTime(this);" name="textfield" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Arrival Time
                            </td>
                            <td>
                                <input id="txtArrTime" runat="server" type="text" onblur="chkTime(this);" name="textfield" />
                            </td>
                            <td align="right">
                                Actual Time
                            </td>
                            <td>
                                From<input id="txtActTimeFrom" runat="server" onblur="chkTime(this);" style="width: 50px" type="text" name="textfield" />
                                To<input id="txtActTimeTo" runat="server"  onblur="chkTime(this);" style="width: 50px" type="text" name="textfield" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Remark
                            </td>
                            <td>
                                <textarea id="txtRemark" style="width:168px;" name="txtRemark"></textarea>                              
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                <label>
                                    <input name="Save" type="button" id="btnSave" value="Save" onclick="ValidateSave();" /></label>
                                <a href="Breakdown_Details.aspx">Reset</a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="dvBrkdwnMaster" class="task-al-box" style="width: 100%">
                                </div>
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

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
    </script>

</body>
</html>
