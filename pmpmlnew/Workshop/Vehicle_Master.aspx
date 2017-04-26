<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="Vehicle_Master.aspx.vb"
    Inherits="kdmt.Vehicle_Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Vehicle Master</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
    
var Optype = 0
var Fuel
var ID = 0;

    function DeleteUnitConfirm()
       {     
         if(confirm("Are you sure you wan`t to delete.")){return true}
         else{return false}  
       }
   
    function getVehicle(){    
        var url = '../tmtAjax/Common_ajax.aspx?action=getVehicleMaster'
        ajaxFunction();
        sendRequest(url);                                
         return false;
    }
    
    function DeleteVehicle(ID){  
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
            Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=VehicleMaster&Id=" + ID + "&Optype=" + Optype;
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
    
    function editVehicle(id){
        var ddlBusCompany = document.getElementById('ddlBusCompany')
        var ddlModelNo = document.getElementById('ddlModelNo')
        var ddlCurStatus = document.getElementById('ddlCurStatus')
        var ddlBusType = document.getElementById('ddlBusType')                 
        
        ddlSelection(document.getElementById('tdCompany_'+ id).innerHTML,ddlBusCompany)        
        ddlSelection(document.getElementById('tdBusType_'+ id).innerHTML,ddlBusType)        
        ddlSelection(document.getElementById('tdModelName_'+ id).innerHTML,ddlModelNo)        
        ddlSelection(document.getElementById('tdStatus_'+ id).innerHTML,ddlCurStatus)        
        
        document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_'+ id).innerHTML;                                
        if (document.getElementById('tdFuel_'+ id).innerHTML == 'CNG'){
            document.getElementById('rdbCNG').checked = true; 
        }
        else if(document.getElementById('tdFuel_'+ id).innerHTML == 'Diesel') {
           document.getElementById('rdbDiesel').checked = true;
        }    
        
        document.getElementById('dtRTODate_TextBox').value = document.getElementById('tdRTORegDate_'+ id).innerHTML;
        document.getElementById('dtFitRenewalDate_TextBox').value = document.getElementById('tdFitRenDate_'+ id).innerHTML;
        document.getElementById('dtDepoDate_TextBox').value = document.getElementById('tdDepoInDate_'+ id).innerHTML;
        document.getElementById('dtPutDate_TextBox').value = document.getElementById('tdPutInDate_'+ id).innerHTML;        
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
        
        var BusType = document.getElementById('ddlBusType').value;
        var BusCompany = document.getElementById('ddlBusCompany').value;
        var ModelNo = document.getElementById('ddlModelNo').value;        
        var CNG = document.getElementById('rdbCNG');
        var Diesel = document.getElementById('rdbDiesel');        
        if (CNG.checked == true){
            Fuel = 0; 
        }
        else if(Diesel.checked==true) {
           Fuel = 1;
        }    
        var RTODate = document.getElementById('dtRTODate').value;
        var FitRenewalDate = document.getElementById('dtFitRenewalDate').value;
        var DepoDate = document.getElementById('dtDepoDate').value;
        var PutDate = document.getElementById('dtPutDate').value;
        var CurStatus = document.getElementById('ddlCurStatus').value;
        var remark = document.getElementById('txtremark').value;         
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){
            var url = "../tmtAjax/Master_ajax.aspx?action=VehicleMaster&Id=" + ID + "&BusNo=" + BusNo.value + "&BusType=" + BusType + "&BusCompany=" + BusCompany + "&ModelNo=" + ModelNo + "&Fuel=" + Fuel + "&RTODate=" + RTODate + "&FitRenewalDate=" + FitRenewalDate + "&DepoDate=" + DepoDate + "&PutDate=" + PutDate + "&CurStatus=" + CurStatus + "&Optype=" + Optype + "&remark=" + remark;                         
        }
        else{
            var url = "../tmtAjax/Master_ajax.aspx?action=VehicleMaster&Id=" + ID + "&BusNo=" + BusNo.value + "&BusType=" + BusType + "&BusCompany=" + BusCompany + "&ModelNo=" + ModelNo + "&Fuel=" + Fuel + "&RTODate=" + RTODate + "&FitRenewalDate=" + FitRenewalDate + "&DepoDate=" + DepoDate + "&PutDate=" + PutDate + "&CurStatus=" + CurStatus + "&Optype=" + Optype + "&remark=" + remark;           
        }
        sendRequest(url);
    }
 
    function Clean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var ddlBusCompany = document.getElementById('ddlBusCompany');
        var ddlModelNo = document.getElementById('ddlModelNo');
        var ddlCurStatus = document.getElementById('ddlCurStatus');
        var ddlBusType = document.getElementById('ddlBusType');
        var txtBusNo = document.getElementById('txtBusNo');
        var rdbCNG = document.getElementById('rdbCNG');                           
        var dtRTODate = document.getElementById('dtRTODate_TextBox');
        var dtFitRenewalDate = document.getElementById('dtFitRenewalDate_TextBox');
        var dtDepoDate = document.getElementById('dtDepoDate_TextBox');
        var dtPutDate = document.getElementById('dtPutDate_TextBox');
        
        ddlBusCompany.selectedIndex = 0;
        ddlModelNo.selectedIndex = 0;
        ddlCurStatus.selectedIndex = 0;
        ddlBusType.selectedIndex = 0;
        txtBusNo.value = '';
        rdbCNG.checked = true;
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
    ajaxFunction();
    xmlHttp.open("GET",url );   
    xmlHttp.send(null);   
}



function handleresponse() {   
    if(xmlHttp.readyState==4) {            
        resp = xmlHttp.responseText;                 
        if (resp.indexOf('PassVehicleSearch')!= -1) {             
            document.getElementById('dvVehicleMaster').innerHTML = resp.substring(17);
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');
            window.location.href = "Vehicle_Master.aspx";
           // getVehicle();
            //Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getVehicle();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Bus No. is already exist.');                  
            getVehicle();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getVehicle();            
            return false;
        }           
        
    }
}
    </script>

   <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Vehicle Master</h1>
    </div>
  <div class="form-horizontal" style="overflow:auto">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
        <div id="middal">
        
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                     
                            <tr>
                                <td align="right">
                                    Bus No.
                                </td>
                                <td>
                                    <input id="txtBusNo" runat="server" type="text" name="textfield" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Bus Type
                                </td>
                                <td>
                                    <select name="ddlBusType" runat="server" id="ddlBusType" size="0">
                                        <option value="1">Non A/C</option>
                                        <option value="2">A/C</option>
                                    </select>
                                </td>
                                <td align="right">
                                    Bus Company
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlBusCompany">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Model No.
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlModelNo">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    Fuel Type
                                </td>
                                <td>
                                    <input type="radio" id="rdbCNG" name="Fuel" value="0" checked="checked" />
                                    CNG
                                    <input type="radio" id="rdbDiesel" name="Fuel" value="1" />
                                    Diesel
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    RTO Registration Date
                                </td>
                                <td>
                                              <asp:TextBox ID="dtRTODate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="dtRTODate"
                                                    PopupButtonID="dtRTODate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                </td>
                                <td align="right">
                                    Fitness Renewal Date
                                </td>
                                <td>
                                  
                                              <asp:TextBox ID="dtFitRenewalDate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="dtFitRenewalDate"
                                                    PopupButtonID="dtFitRenewalDate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Depo In Date
                                </td>
                                <td>
                            
                                              <asp:TextBox ID="dtDepoDate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="dtDepoDate"
                                                    PopupButtonID="dtDepoDate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                </td>
                                <td align="right">
                                    Put In Service Date
                                </td>
                                <td>
                               
                                              <asp:TextBox ID="dtPutDate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="dtPutDate"
                                                    PopupButtonID="dtPutDate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Current Status
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlCurStatus">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">Remark:
                                     </td>
                                        <td align="left">
                                        <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server"></asp:TextBox>
                                    </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                
                                    <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" OnClientClick="ValidateSave()" />
                                    <a href="Vehicle_Master.aspx">Reset</a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div id="dvVehicleMaster" class="task-al-box" style="width: 100%">
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
    </div>
</asp:Content>