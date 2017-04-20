<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Retreading_Details.aspx.vb"
    Inherits="KDMT.Retreading_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Retreading Details</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0
var Fuel
var ID = 0;

function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you wan`t to delete.")){return true}
     else{return false}  
   }
   

    function getRetreading(){         
        var url = '../tmtAjax/Common_ajax.aspx?action=getRetreadingMaster'        
        ajaxFunction();
        sendRequest(url);                                
         return false;
    }
    
    function DeleteRetreading(ID){    
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
               Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=RetreadingDetails&Id=" + ID + "&Optype=" + Optype;
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
    
    function editRetreading(id){    
        var ddlVendorName = document.getElementById('ddlVendorName');        
        var ddlPartType = document.getElementById('ddlPartType');        
        var ddlProcessType = document.getElementById('ddlProcessType');        
        ddlSelection(document.getElementById('tdVenName_'+ id).innerHTML,ddlVendorName);                
        ddlSelection(document.getElementById('tdPartType_'+ id).innerHTML,ddlPartType);                
        ddlSelection(document.getElementById('tdProcessType_'+ id).innerHTML,ddlProcessType);                
        
        document.getElementById('dtDate_TextBox').value = document.getElementById('tdDate_'+ id).innerHTML;
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
        
        var ddlVendorName = document.getElementById('ddlVendorName').value;        
        var dtDate = document.getElementById('dtDate_TextBox').value;  
        var ddlPartType = document.getElementById('ddlPartType').value;
        var txtPartNo = document.getElementById('txtPartNo').value;    
        var ddlProcessType = document.getElementById('ddlProcessType').value;                            
        var txtDescription = document.getElementById('txtDescription').value;                      
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=RetreadingDetails&Id=" + ID + "&VendorName=" + ddlVendorName + "&Date=" + dtDate + "&PartType=" + ddlPartType + "&PartNo=" + txtPartNo + "&ProcessType=" + ddlProcessType +"&Description=" + txtDescription + "&Optype=" + Optype;
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=RetreadingDetails&Id=" + ID + "&VendorName=" + ddlVendorName + "&Date=" + dtDate + "&PartType=" + ddlPartType + "&PartNo=" + txtPartNo + "&ProcessType=" + ddlProcessType +"&Description=" + txtDescription + "&Optype=" + Optype;
             Optype = 0;
        }
        sendRequest(url);
    }
 
    function Clean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var ddlVendorName = document.getElementById('ddlVendorName');  
        var dtDate = document.getElementById('dtDate_TextBox');  
        var ddlPartType = document.getElementById('ddlPartType');
        var txtPartNo = document.getElementById('txtPartNo');
        var ddlProcessType = document.getElementById('ddlProcessType');
        var txtDescription = document.getElementById('txtDescription');
        
        ddlVendorName.selectedIndex = 0;        
        ddlPartType.selectedIndex = 0;        
        ddlProcessType.selectedIndex = 0;        
        txtPartNo.value = '';
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
        if (resp.indexOf('PassRetreadingSearch')!= -1) {                         
            document.getElementById('dvRetreadingMaster').innerHTML = resp.substring(20);
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');        
            getRetreading();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getRetreading();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Scrap No. is already exist.');                  
            getRetreading();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getRetreading();            
            return false;
        }           
        
    }
}
    </script>

</head>
<body onload="return getRetreading();">
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    </div>

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
                    <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                        <tr>
                            <td class="innerheading" colspan="4">
                                <span id="Label3">Retreading Details</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Vendor Name
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlVendorName">
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Date
                            </td>
                            <td>
                                <BDP:BDPLite ID="dtDate" TextBoxStyle-Width="100px" runat="server">
                                    <TextBoxStyle Width="100px" />
                                </BDP:BDPLite>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Part Type
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlPartType">
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Part No.
                            </td>
                            <td>
                                <input name="txtPartNo" type="text" id="txtPartNo" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Process Type
                            </td>
                            <td>
                                <select name="ddlProcessType" id="ddlProcessType" size="0">
                                    <option value="1">In</option>
                                    <option value="2">Out</option>
                                </select>
                            </td>
                            <td align="right">
                                Description
                            </td>
                            <td>
                                 <textarea cols="3" rows="5" id="txtDescription" style="width:168px;" name="txtDescription"></textarea>     
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                <label>
                                    <input name="Save" type="button" id="btnSave" value="Save" onclick="ValidateSave();" /></label>
                                <a href="Retreading_Details.aspx">Reset</a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="dvRetreadingMaster" class="task-al-box" style="width: 100%">
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
    <script type="text/javascript">

        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", { imgRight: "SpryAssets/SpryMenuBarRightHover.gif" });


    </script>
</body>
</html>
