<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Authentication.aspx.vb"
    Inherits="KDMT.Authentication" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Authentication</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0;
var Fuel 
var ID = 0;
var TypeID = 0;

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
   

    function getAuthentication(){          
        var url = '../tmtAjax/Common_ajax.aspx?action=getAuthentication'        
        sendRequest(url);                                
         return false;
    }
    
    

    
    function Authentic(ID){              
            var url = "../tmtAjax/Master_ajax.aspx?action=Authentication&Id=" + ID 
            sendRequest(url);    
            return false;             
    }
    
    function Details(ID){              
            var url = "../tmtAjax/Common_ajax.aspx?action=getAuthenticDetails&IndNo=" + ID 
            sendRequest(url);            
            return false;             
    }
    
    
    
    function ddlSelection(tdvalue,ddl){        
        for (i=0;i<ddl.length;i++){         
             if(ddl.options[i].text == tdvalue){
                ddl.selectedIndex = i;
             }
         }
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
    ajaxFunction()
    url = url + '&t=' + new Date();      
    xmlHttp.open("GET",url );   
    xmlHttp.send(null);   
}



function handleresponse() {   
    if(xmlHttp.readyState==4) {            
        resp = xmlHttp.responseText;                 
        if (resp.indexOf('PassAuthentication')!= -1) {                    
            document.getElementById('dvAuthenticMaster').innerHTML = resp.substring(18);            
            return false;
        }
        else if (resp.indexOf('PassAuthenticDetail')!= -1) {                                       
            document.getElementById('dvAuthenticDetail').innerHTML = resp.substring(19);            
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Authentication Successfully Done.');        
            getAuthentication();           
            return false;
        }                
    }
}
    </script>

</head>
<body onload="return getAuthentication();">
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
                        <table width="80%" border="0" cellpadding="5" cellspacing="5">
                            <tr>
                                <td class="innerheading">
                                    <span id="Label3">Authenticate</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <%--<tr>
                                            <td>
                                                Inspection
                                                <select onchange="getViewDefectCon(this);" name="ddlInspection" id="ddlInspection">
                                                    <option value="0">All</option>
                                                    <option value="1">Non Inspected</option>
                                                    <option value="2">Inspected</option>
                                                </select>
                                            </td>
                                            <td>
                                                Status
                                                <select onchange="getViewDefectCon(this);" name="ddlInspection" id="Select1">
                                                    <option value="0">All</option>
                                                    <option value="1">Remain</option>
                                                    <option value="2">Done</option>
                                                </select>
                                            </td>
                                        </tr>--%>
                                        <tr> 
                                            <td colspan="2">
                                                <div id="dvAuthenticMaster" class="task-al-box" style="width: 100%">
                                                </div>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div id="dvAuthenticDetail" class="task-al-box" style="width: 100%">
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
                                                    <input type="text" name="txtInspTime" id="txtInspTime" />
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
