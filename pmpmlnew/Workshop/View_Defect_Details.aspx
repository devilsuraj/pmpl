<%@ Page Language="VB" AutoEventWireup="false" CodeFile="View_Defect_Details.aspx.vb"
    Inherits="KDMT.Defect_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Defect Details</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0;
var Fuel 
var ID = 0;
var TypeID = 0;

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

function showStatus(id) {   
		 document.getElementById('tblStatus').style.display='';			
 		 document.getElementById('tblIns').style.display='none';	
 		 document.getElementById('hdnTypeID').value = document.getElementById('tdDefID_'+ id).innerHTML; 		 
 		 document.getElementById('txtMech').focus();
		}
 
	function showInspection(id) {   
		 document.getElementById('tblIns').style.display='';			
 		 document.getElementById('tblStatus').style.display='none';			
 		 document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_'+ id).innerHTML; 	
 		 document.getElementById('hdnTypeID').value = document.getElementById('tdDefID_'+ id).innerHTML; 		 
 		 document.getElementById('txtCheckBy').focus();
		}


function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you wan`t to delete.")){return true}
     else{return false}  
   }
   

    function getViewDefect(){         
        
        var url = '../tmtAjax/Common_ajax.aspx?action=getViewDefectDetails'        
        sendRequest(url);                                
         return false;
    }
    
        function getViewDefectCon(){                 
        var intStaID = document.getElementById('ddlStatus').value;        
        var intInspID = document.getElementById('ddlInspection').value;
        var intIndReq = document.getElementById('ddlIndentReq').value;
        var url = '../tmtAjax/Common_ajax.aspx?action=getViewDefectDetails&InspID=' + intInspID + '&StatusID=' +  intStaID + '&IndReq=' + intIndReq;
        ajaxFunction();
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
            var url = "../tmtAjax/Master_ajax.aspx?action=ViewDefectDetails&Id=" + ID + "&Optype=" + Optype;
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
    
    function ValidateStatusSave(){ 
            
//        var BusNo = document.getElementById('txtBusNo');        
//        if (BusNo.value == ''){
//            alert('Bus No. should not be empty')
//            BusNo.focus();
//            return false;
//        }
        
        var txtMech = document.getElementById('txtMech').value;
        var dtWorkDate = document.getElementById('dtWorkDate_TextBox').value;                   
        var ddlWorkStatus = document.getElementById('ddlWorkStatus').value;                        
        var txtWorkRemark = document.getElementById('txtWorkRemark').value;        
        
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        if (document.getElementById('hdnTypeID').value!=''){TypeID = document.getElementById('hdnTypeID').value}
        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=Status&Id=" + ID + "&Type=0&TypeID=" + TypeID + "&Mech=" + txtMech + "&WorkDate=" + dtWorkDate + "&WorkStatus=" + ddlWorkStatus + "&WorkRemark=" + txtWorkRemark + "&Optype=" + Optype;            
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=Status&Id=" + ID + "&Type=0&TypeID=" + TypeID + "&Mech=" + txtMech + "&WorkDate=" + dtWorkDate + "&WorkStatus=" + ddlWorkStatus + "&WorkRemark=" + txtWorkRemark + "&Optype=" + Optype;
             Optype = 0;
        }
        document.getElementById('tblStatus').style.display='none';			
        sendRequest(url);
    }
    
    function ValidateInspSave(){ 
            
//        var BusNo = document.getElementById('txtBusNo');        
//        if (BusNo.value == ''){
//            alert('Bus No. should not be empty')
//            BusNo.focus();
//            return false;
//        }        
        
        var txtBusNo = document.getElementById('txtBusNo').value;
        var txtCheckBy = document.getElementById('txtCheckBy').value;                        
        var dtCheckDate = document.getElementById('dtCheckDate_TextBox').value;                   
        var txtInspTime = document.getElementById('txtInspTime').value;        
        var txtDescription = document.getElementById('txtDescription').value;                        
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        if (document.getElementById('hdnTypeID').value!=''){TypeID = document.getElementById('hdnTypeID').value}      
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=Inspection&Id=" + ID +  "&Type=0&TypeID=" + TypeID + "&BusNo=" + txtBusNo + "&CheckBy=" + txtCheckBy + "&CheckDate=" + dtCheckDate + "&InspTime=" + txtInspTime + "&Description=" + txtDescription + "&Optype=" + Optype;
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=Inspection&Id=" + ID + "&Type=0&TypeID=" + TypeID + "&BusNo=" + txtBusNo + "&CheckBy=" + txtCheckBy + "&CheckDate=" + dtCheckDate + "&InspTime=" + txtInspTime + "&Description=" + txtDescription + "&Optype=" + Optype;
             Optype = 0;
        }
        document.getElementById('tblIns').style.display = 'none';			
        sendRequest(url);
    }
 
    function InspClean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var txtBusNo = document.getElementById('txtBusNo');
        var txtCheckBy = document.getElementById('txtCheckBy');
        var dtCheckDate = document.getElementById('dtCheckDate_TextBox');
        var txtInspTime = document.getElementById('txtInspTime');
        var txtDescription = document.getElementById('txtDescription');        
        
        
        txtBusNo.value = '';
        txtCheckBy.value = '';
        txtInspTime.value = '';
        txtDescription.value = '';        
        
//        dtRTODate.value = currentDate;
//        dtFitRenewalDate.value = currentDate;
//        dtDepoDate.value = currentDate;
//        dtPutDate.value = currentDate;
        
    }
    
    function Clean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var txtMech = document.getElementById('txtMech');
        var dtWorkDate = document.getElementById('dtWorkDate_TextBox');
        var ddlWorkStatus = document.getElementById('ddlWorkStatus');
        var txtWorkRemark = document.getElementById('txtWorkRemark');
        var txtBusNo = document.getElementById('txtBusNo');
        var txtCheckBy = document.getElementById('txtCheckBy');
        var dtCheckDate = document.getElementById('dtCheckDate_TextBox');
        var txtInspTime = document.getElementById('txtInspTime');
        var txtDescription = document.getElementById('txtDescription'); 


        ddlWorkStatus.selectedIndex = 0;                
        txtMech.value = '';        
        txtWorkRemark.value = '';
        txtBusNo.value = '';
        txtCheckBy.value = '';
        txtInspTime.value = '';
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
            getViewDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getViewDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Defect No. is already exist.');                  
            getViewDefect();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getViewDefect();            
            return false;
        }           
        
    }
}
    </script>

</head>
<body onload="return getViewDefect();">
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnTypeID" runat="server" type="hidden" name="hdnTypeID" />
    </div>
    <center>
        <div>
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
                        <table width="100%" border="0" cellpadding="5" cellspacing="5">
                            <tr>
                                <td class="innerheading">
                                    <span id="Label3">View Defect Details</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                Inspection
                                                <select onchange="getViewDefectCon();" name="ddlInspection" id="ddlInspection">
                                                    <option value="0">All</option>
                                                    <option value="1">Non Inspected</option>
                                                    <option value="2">Inspected</option>
                                                </select>
                                            </td>
                                            <td>
                                                Indent Req
                                                <select onchange="getViewDefectCon();" name="ddlIndentReq" id="ddlIndentReq">
                                                    <option value="0">All</option>
                                                    <option value="1">Remain</option>
                                                    <option value="2">Done</option>
                                                </select>
                                            </td>
                                            <td>
                                                Status
                                                <select onchange="getViewDefectCon();" name="ddlStatus" id="ddlStatus">
                                                    <option value="0">All</option>
                                                    <option value="1">Remain</option>
                                                    <option value="2">Done</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div id="dvDefectMaster" class="task-al-box" style="width: 100%">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <table id="tblStatus" style="display: none" width="100%" border="1" align="right"
                                            cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td colspan="4">
                                                    Status
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Mechanic Name
                                                </td>
                                                <td>
                                                    <input type="text" name="txtMech" id="txtMech" />
                                                </td>
                                                <td align="right">
                                                    Work Date
                                                </td>
                                                <td>
                                                    <BDP:BDPLite ID="dtWorkDate" TextBoxStyle-Width="100px" runat="server">
                                                        <TextBoxStyle Width="100px" />
                                                    </BDP:BDPLite>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Work Status
                                                </td>
                                                <td>
                                                    <select name="ddlWorkStatus" id="ddlWorkStatus" size="0">
                                                        <option value="1">Pending </option>
                                                        <option value="2">Done</option>
                                                    </select>
                                                </td>
                                                <td align="right">
                                                    Work Remark
                                                </td>
                                                <td>
                                                    <input type="text" name="txtWorkRemark" id="txtWorkRemark" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <label>
                                                        <input name="Save" class="submit-btn" type="button" id="Save" value="Save" onclick="ValidateStatusSave()" /></label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <table id="tblIns" style="display: none" width="100%" border="1" cellpadding="0"
                                            cellspacing="0">
                                            <tr>
                                                <td colspan="4">
                                                    Inspection
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Bus No.
                                                </td>
                                                <td>
                                                    <input type="text" name="txtBusNo" id="txtBusNo" />
                                                </td>
                                                <td align="right">
                                                    Check By
                                                </td>
                                                <td>
                                                    <input type="text" name="txtCheckBy" id="txtCheckBy" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Check Date
                                                </td>
                                                <td>
                                                    <BDP:BDPLite ID="dtCheckDate" TextBoxStyle-Width="100px" runat="server">
                                                        <TextBoxStyle Width="100px" />
                                                    </BDP:BDPLite>
                                                </td>
                                                <td align="right">
                                                    Inspection Time
                                                </td>
                                                <td>
                                                    <input type="text" name="txtInspTime" id="txtInspTime" onblur="chkTime(this);" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Description
                                                </td>
                                                <td>
                                                    <input type="text" name="txtDescription" id="txtDescription" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <label>
                                                        <input name="Save" class="submit-btn" type="button" id="Submit1" value="Save" onclick="ValidateInspSave()" /></label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="orgbottam">
                    </div>
                </div>
            </div>
    </center>
    </form>
</body>
</html>
