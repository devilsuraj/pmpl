<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Defect_Details.aspx.vb"
    Inherits="KDMT.Defect_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Defect Details</title>

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
   

    function getDefect(){                 
        var url = '../tmtAjax/Common_ajax.aspx?action=getDefectDetails'               
        ajaxFunction()
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
            
//        var BusNo = document.getElementById('txtBusNo');        
//        if (BusNo.value == ''){
//            alert('Bus No. should not be empty')
//            BusNo.focus();
//            return false;
//        }
        
        var dtDefectDate = document.getElementById('dtDefectDate_TextBox').value;           
        var txtBusNo = document.getElementById('txtBusNo').value;
        var txtDriverNo = document.getElementById('txtDriverNo').value;                        
        var txtDefectTime = document.getElementById('txtDefectTime').value;
        var ddlDefPriority = document.getElementById('ddlDefPriority').value;     
        var txtDescription = document.getElementById('txtDescription').value;                        
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&DefectDate=" + dtDefectDate + "&BusNo=" + txtBusNo + "&DriverNo=" + txtDriverNo + "&DefectTime=" + txtDefectTime + "&DefPriority=" + ddlDefPriority + "&Description=" + txtDescription + "&Optype=" + Optype;                         
            
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&DefectDate=" + dtDefectDate + "&BusNo=" + txtBusNo + "&DriverNo=" + txtDriverNo + "&DefectTime=" + txtDefectTime + "&DefPriority=" + ddlDefPriority + "&Description=" + txtDescription + "&Optype=" + Optype;                                     
             Optype = 0;
        }
        sendRequest(url);
    }
 
    function Clean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var dtDefectDate = document.getElementById('dtDefectDate_TextBox');                
        var txtBusNo = document.getElementById('txtBusNo');        
        var txtDriverNo = document.getElementById('txtDriverNo');
        var txtDefectTime = document.getElementById('txtDefectTime');                        
        var ddlDefPriority = document.getElementById('ddlDefPriority');                
        var txtDescription = document.getElementById('txtDescription');
        
        
        ddlDefPriority.selectedIndex = 0;                
        txtBusNo.value = '';
        txtDriverNo.value = '';
        txtDefectTime.value = '';
        txtDescription.value = '';        
        
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
        if (resp.indexOf('PassDefectSearch')!= -1) {             
            document.getElementById('dvDefectMaster').innerHTML = resp.substring(16);
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');        
            getDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Defect No. is already exist.');                  
            getDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getDefect();            
            return false;
        }           
        
    }
}
    </script>

</head>
<body onload="return getDefect();">
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    </div>
    <div id="middal">
        <uc:leftmenu ID="Leftmenu1" runat="server" />
        <div class="contantbox">
            <div class="orgtop">
            </div>
            <div class="orgmiddal">
                <%--<table border="0" align="left" cellpadding="5" cellspacing="5">  
  <tr>
                <td style="height: 55px">
                    <ul>
						<li>
                            <div align="left">
                                <a href="Home.HTML">Home</a>
							</div>
						</li>
						     <li>
                            <div align="left">
                                <a href="Vehicle Master.HTML">Vehicle Master</a>
                            </div>
						</li>	
						</li>	
                        <li>
                            <div align="left">
                                <a href="Defect Details.HTML">Defect Details</a>
							</div>
						</li>
						 <li>
                            <div align="left">
                                <a href="View Defect Details.HTML">View Defect Details</a>
                            </div>
                        </li>
						<li>
                            <div align="left">
                                <a href="Indent Request Details.HTML">Indent Request Details</a>
                            </div>
						</li>		
						</li>		
						<li>
                            <div align="left">
                                <a href="Authenticate.HTML">Authentication</a>
							</div>
						</li>						
						</li>
						                        <li>
                            <div align="left">
                                <a href="View Indent Requests.HTML">View Indent Requests</a>
							</div>
						</li>
						</li>
                       	   <li>
                            <div align="left">
                                <a href="Part Master.HTML">Part Register Master</a>
							</div>
						</li>						
						</li>						
                        <li>
                            <div align="left">
                                <a href="Part History.HTML">Part History</a>
                            </div>
                        </li>
                     
                        <li>
                            <div align="left">
                                <a href="Part Repair_Details.HTML">Part Repair Details</a>
                            </div>
						</li>		
						<li>
                            <div align="left">
                                <a href="Retrading Detail.HTML">Retrading Details</a>
                            </div>
                        </li>
                        <li>
                            <div align="left">
                                <a href="Scrap Details.HTML">Scrap Details</a>
                            </div>
                        </li>
                        <li>
                            <div align="left">
                                <a href="Service Details.HTML">Schedule Service Details</a>
							</div>
						</li>                       							
                    </ul>
                </td>
            </tr>
               
           
		</table>--%>
                <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="4" class="innerheading">
                            <span id="Label3">Defect Details</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Defect Date
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtDefectDate" TextBoxStyle-Width="100px" runat="server">
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
                            Defect Time
                        </td>
                        <td>
                            <input id="txtDefectTime" runat="server" type="text" onblur="chkTime(this)" name="textfield" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Defect Priority
                        </td>
                        <td>
                            <select name="ddlDefPriority" runat="server" id="ddlDefPriority" size="0">
                                <option value="1">High</option>
                                <option value="2">Medium</option>
                                <option value="3">Low</option>                               
                            </select>
                        </td>
                        <td align="right">
                            Description
                        </td>
                        <td>
                            <textarea id="txtDescription" style="width:168px;" name="txtDescription"></textarea>                                                          
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <label>
                                <input name="Save" type="button" id="btnSave" value="Save" onclick="ValidateSave();" /></label>
                            <a href="Defect_Details.aspx">Reset</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="dvDefectMaster" class="task-al-box" style="width: 100%">
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
</body>
</html>
