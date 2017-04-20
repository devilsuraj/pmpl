<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Part_Repair_Details.aspx.vb"
    Inherits="KDMT.Part_Repair_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Part Repair Details</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0;
var Fuel
var ID = 0;

function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you wan`t to delete.")){return true}
     else{return false}  
   }
   

    function getPartRepair(){         
        var url = '../tmtAjax/Common_ajax.aspx?action=getPartRepairDetails'        
        ajaxFunction();
        sendRequest(url);                                
         return false;
    }
    
    function DeleteRepair(ID){    
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
               Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=PartRepairDetails&Id=" + ID + "&Optype=" + Optype;
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
    
    function ddlCreation(obj){           
        var url = '../tmtAjax/Master_ajax.aspx?action=PartType&TypeId=' + obj.value;                
        ajaxFunction();
        sendRequest(url);                                
         return false;
    }
    
    function optCreation(value){                
        var select = document.getElementById('ddlRepairType');        
            select.options.length = 0;          
        var arrOption = new Array();
        arrValue = value.split("|");                      
            for (i=0;i<arrValue.length - 1;i++){
                arrOption = arrValue[i].split("~");                        
                select.options[i] = new Option(arrOption[1], arrOption[0].substring(6));                
        }
    }
    

    
    function editRepair(id){  
      
        var ddlPartType = document.getElementById('ddlPartType');        
        var ddlRepairType = document.getElementById('ddlRepairType');        
        ddlSelection(document.getElementById('tdPartType_'+ id).innerHTML,ddlPartType);                
        ddlSelection(document.getElementById('tdRepairType_'+ id).innerHTML,ddlRepairType);                
        
        document.getElementById('dtRepairDate_TextBox').value = document.getElementById('tdRepairDate_'+ id).innerHTML;
        document.getElementById('txtPartNo').value = document.getElementById('tdPartNo_'+ id).innerHTML;
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
        
        var ddlPartType = document.getElementById('ddlPartType').value;        
        var ddlRepairType = document.getElementById('ddlRepairType').value;
        var txtPartNo = document.getElementById('txtPartNo').value;                        
        var txtDescription = document.getElementById('txtDescription').value;
        var dtRepairDate = document.getElementById('dtRepairDate_TextBox').value;                
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=PartRepairDetails&Id=" + ID + "&PartType=" + ddlPartType + "&PartNo=" + txtPartNo + "&RepairDate=" + dtRepairDate + "&RepairType=" + ddlRepairType + "&Description=" + txtDescription + "&Optype=" + Optype;
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=PartRepairDetails&Id=" + ID + "&PartType=" + ddlPartType + "&PartNo=" + txtPartNo + "&RepairDate=" + dtRepairDate + "&RepairType=" + ddlRepairType + "&Description=" + txtDescription + "&Optype=" + Optype;
             Optype = 0;
        }
        sendRequest(url);
    }
 
    function Clean(){
        var dt = new Date();                
        var ddlPartType = document.getElementById('ddlPartType');        
        var ddlRepairType = document.getElementById('ddlRepairType');
        var txtPartNo = document.getElementById('txtPartNo');                        
        var txtDescription = document.getElementById('txtDescription');
        var dtRepairDate = document.getElementById('dtRepairDate_TextBox');                
                
        dtRepairDate.value = dt.toString('dd-MMM-yyyy');
        ddlPartType.selectedIndex = 0;        
        ddlPartType.selectedIndex = 0;        
        txtPartNo.value = '';
        txtDescription.value = '';        
        ddlPartType.focus();
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
        if (resp.indexOf('PassPartRepairSearch')!= -1) {             
            document.getElementById('dvPartRepairDetails').innerHTML = resp.substring(20);
            Clean();
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');        
            return getPartRepair();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getPartRepair();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Scrap No. is already exist.');                  
            getPartRepair();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getPartRepair();            
            return false;
        }           
        else if(resp.indexOf('Repair') != -1) {              
            optCreation(resp.substring(6));
        }   
    }
}
    </script>

</head>
<body onload="return getPartRepair();">
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
                            <span id="Label3">Part Repair Details</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" >
                            Part Type
                        </td>
                        <td>
                            <select id="ddlPartType" name="ddlPartType" onchange="ddlCreation(this);" runat="server">                            
                            </select>                                             
                            <%--<asp:DropDownList runat="server" ID="ddlPartType" AutoPostBack="true"  ></asp:DropDownList>--%>
                        </td>
                        <td align="right">
                            Part No.
                        </td>
                        <td>
                            <input id="txtPartNo" runat="server" type="text" name="textfield" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Repair Date
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtRepairDate" TextBoxStyle-Width="100px" runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
                        </td>
                        <td align="right">
                            Type of Repair
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlRepairType">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Description
                        </td>
                        <td>
                            <textarea cols="3" rows="5" id="txtDescription" style="width:168px;" name="txtDescription"></textarea>                                 
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
                            <a href="Part_Repair_Details.aspx">Reset</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="dvPartRepairDetails" class="task-al-box" style="width: 100%">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="orgbottam">
            </div>
        </div>
    </div>
    </form>
</body>
</html>
