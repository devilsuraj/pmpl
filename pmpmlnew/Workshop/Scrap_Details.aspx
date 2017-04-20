<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Scrap_Details.aspx.vb" Inherits="KDMT.Scrap_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Scrap Details</title>

    <script language="javascript" type="text/javascript">
    
var Optype = 0
var Fuel
var ID = 0;

function DeleteUnitConfirm()
   {     
     if(confirm("Are you sure you want to delete.")){return true}
     else{return false}  
   }
   

    function getScrap(){         
        var url = '../tmtAjax/Common_ajax.aspx?action=getScrapMaster'        
        ajaxFunction();
        sendRequest(url);                                
         return false;
    }
    
    function DeleteScrap(ID){    
        if (Optype==1){
            alert('Please quit editing mode for deleting.');
            return false;
        }    
        if (DeleteUnitConfirm()== true){    
               Optype = 2;        
            var url = "../tmtAjax/Master_ajax.aspx?action=ScrapDetails&Id=" + ID + "&Optype=" + Optype;
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
    
    function editScrap(id){    
        var ddlScrapType = document.getElementById('ddlScrapType');        
        var ddlScrapRsn = document.getElementById('ddlScrapRsn');        
        ddlSelection(document.getElementById('tdScrapType_'+ id).innerHTML,ddlScrapType);                
        ddlSelection(document.getElementById('tdScrapReason_'+ id).innerHTML,ddlScrapRsn);                
        
        document.getElementById('dtScrapDate_TextBox').value = document.getElementById('tdScrapDate_'+ id).innerHTML;
        document.getElementById('txtScrapCompNo').value = document.getElementById('tdScrapCompNo_'+ id).innerHTML;
        document.getElementById('txtDescription').value = document.getElementById('tdDescription_'+ id).innerHTML;                                                          
        
        document.getElementById('hdnID').value = id
        Optype = 1;    
    }
    
    function ValidateSave()
    { 
        debugger    
//        var BusNo = document.getElementById('txtBusNo');        
//        if (BusNo.value == ''){
//            alert('Bus No. should not be empty')
//            BusNo.focus();
//            return false;
//        }
            var PartNo = document.getElementById('txtPartNo');
            var companyNo=document.getElementById('txtCompanyNo');
            if (PartNo.value == '' && companyNo.value == '' ) {
                alert('Part No. or Company No should not be empty')
                PartNo.focus();
                companyNo.focus();
                return false;
            }
            
        
//        var ddlScrapType = document.getElementById('ddlScrapType').value;        
//        var ddlScrapRsn = document.getElementById('ddlScrapRsn').value;
        var ddlPartType = document.getElementById('ddlPartType').value;                        
        var txtPartNo = document.getElementById('txtPartNo').value;
        var txtCompanyNo = document.getElementById('txtCompanyNo').value;
        var dtScrapDate = document.getElementById('dtScrapDate_TextBox').value;
        var txtReason = document.getElementById('txtReason').value;               
        if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
        
        if (Optype==0){                       
             var url = "../tmtAjax/Master_ajax.aspx?action=ScrapDetails&Id=" + ID  + "&PartNo=" + txtPartNo + "&CompanyNo=" + txtCompanyNo + "&ScrapDate=" + dtScrapDate + "&Reason=" + txtReason + "&Optype=" + Optype;                         
        }
        else{
             var url = "../tmtAjax/Master_ajax.aspx?action=ScrapDetails&Id=" + ID  + "&PartNo=" + txtPartNo + "&CompanyNo=" + txtCompanyNo + "&ScrapDate=" + dtScrapDate + "&Reason=" + txtReason + "&Optype=" + Optype;            
             Optype = 0;
        }
        sendRequest(url);
    }
 
    function Clean(){
        var dt = new Date();
        var month = dt.getMonth();
        var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
        var ddlScrapType = document.getElementById('ddlScrapType');        
        var ddlScrapRsn = document.getElementById('ddlScrapRsn');
        var txtScrapCompNo = document.getElementById('txtScrapCompNo');                        
        var txtDescription = document.getElementById('txtDescription');
        var dtScrapDate = document.getElementById('dtScrapDate_TextBox');                
        
        ddlScrapType.selectedIndex = 0;        
        ddlScrapRsn.selectedIndex = 0;        
        txtScrapCompNo.value = '';
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

function chkcompanyno() {
          
            var url = '../store/Ajaxstore.aspx?action=ScrapcompanyNO&size=' + document.getElementById("ddlPartType").value  + "&companyno=" + document.getElementById("txtCompanyNo").value;
            ajaxFunction();
            sendRequest(url);
            return false;
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
        if (resp.indexOf('PassScrapSearch')!= -1) {             
            document.getElementById('dvScrapMaster').innerHTML = resp.substring(15);
            return false;
        }
        else if(resp.indexOf('OptFail') != -1) {  
            alert('Error Occur While Operation.');            
            return false;
        }
        else if(resp.indexOf('Add') != -1) {      
            alert('Data Added Successfully.');        
            getScrap();
            Clean();
            return false;
        }
        else if(resp.indexOf('Edit') != -1) {    
            alert('Data Updated Successfully.');                  
            getScrap();
            Clean();
            return false;
        }
        else if(resp.indexOf('Duplicate') != -1) {    
            alert('Scrap No. is already exist.');                  
            getScrap();
            Clean();
            return false;
        }
        else if(resp.indexOf('Delete') != -1) {              
            alert('Data Deleted Successfully.');                  
            getScrap();            
            return false;
        } 
        else if(resp.indexOf('passcompanyNo') != -1){
                alert('This No.does not exist');
                }          
        
    }
     document.getElementById('btnSave').value = 'Save'
}
 function chkpartdetails() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;

                    var ele1 = resp;

                    if (ele1 == "") {
                        //    alert("No Such Bus Present");

                        document.getElementById("lblmsg").innerHTML = 'This Part No does not Exist'
                        document.getElementById("txtPartNo").focus();
                    }
                    else {
                        document.getElementById("lblmsg").innerHTML = ''

                    }
                }
            }
            if (document.getElementById("txtPartNo").value != '') {

                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=partNO&size=" + document.getElementById("ddlPartType").value + "&parttype=" + '1' + "&PartNo=" + document.getElementById("txtPartNo").value, true);

                //                var url = "../tmtAjax/Master_ajax.aspx?action=PartHistory&Id=" + ID + "&PartType=" + ddlPartType + "&PartPosition=" + ddlPartPos + "&Reason=" + ddlReason + "&PartStatus=" + ddlPartStatus + "&BusNo=" + txtBusNo + "&PartNo=" + txtPartNo + "&PHDate=" + dtDate + "&PartKm=" + txtPartkm + "&Optype=" + Optype;
                xmlHttp.send(null);
            }
        }


        function getCompanyNo(id) {
            if (document.getElementById('txtCompanyNo').value == "") {
                var xmlHttp;
                try {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp = new XMLHttpRequest();
                }
                catch (e) {
                    // Internet Explorer
                    try {
                        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e) {
                        try {
                            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        catch (e) {
                            alert("Your browser does not support AJAX!");
                            return false;
                        }
                    }
                }
                xmlHttp.onreadystatechange = function () {

                    if (xmlHttp.readyState == 4) {
                        resp = xmlHttp.responseText;
                        if (resp == 0) {
                            document.getElementById("Select1").style.display = 'none';
                            return false;
                        }
                        var ele = resp.split("!");
                        while (document.getElementById("Select1").options.length > 0)
                            document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                        if (document.getElementById('txtPartNo').value != "") {
                            for (var i = 0; i < ele.length; i++) {
                                var temp = document.getElementById("Select1")
                                temp.style.display = '';
                                temp.size = ele.length;
                                newOpt = document.createElement("option");
                                document.getElementById("Select1").options.add(newOpt);
                                newOpt.value = ele[i];
                                newOpt.text = ele[i];
                                if (ele[i].toLowerCase() != '') {
                                    if ((document.getElementById('txtPartNo').value).toLowerCase() == (ele[i].toLowerCase())) {
                                        document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                                        return false;
                                    }
                                }
                                if (ele[i] == "0") {
                                    //temp.style.display="none";				               
                                    //  return false;
                                }


                            }

                        }
                        else {
                            var temp = document.getElementById("Select1")
                            temp.size = 0
                            temp.style.display = '';
                        }
                    }
                }
                if (id == 1) {
                    if (document.getElementById('txtPartNo').value.length >= 3) {

                        var ddlsize = document.getElementById('ddlPartType');

                        var partno = document.getElementById('txtPartNo').value;
                        xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=getCompanyNo&partno=" + document.getElementById('txtPartNo').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value, true);
                        xmlHttp.send(null);
                    }
                    else {
                        document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                    }
                }
                else {

                    var ddlsize = document.getElementById('ddlPartType');
                    var partno = document.getElementById('txtPartNo').value;
                    xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=getCompanyNo&partno=" + document.getElementById('txtPartNo').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value, true);
                    //xmlHttp.open("GET","AjaxStore.aspx?Action=getCompanyNo&partno=" + document.getElementById('txtPartNo').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value  ,true);
                    xmlHttp.send(null);
                }
            }
        }

        function Select() {
            if (document.getElementById('txtCompanyNo').value == "") {
                var resultStr = "";
                objddl2 = document.getElementById('Select1');
                for (var i = 0; i < objddl2.options.length; i++) {
                    if (objddl2.options[i].selected) {
                        resultStr += (objddl2.options[i].text);
                        var objddl1 = document.getElementById('txtCompanyNo');
                        objddl1.value = resultStr;
                        var x = document.getElementById('Select1');
                        x.style.display = "none";
                        document.getElementById('txtCompanyNo').focus();
                        return false;
                        //alert(resultStr)
                    }
                }

            }
        }


        function getWSNo(id) {
            if (document.getElementById('txtPartNo').value == "") {
                var xmlHttp;
                try {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp = new XMLHttpRequest();
                }
                catch (e) {
                    // Internet Explorer
                    try {
                        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e) {
                        try {
                            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        catch (e) {
                            alert("Your browser does not support AJAX!");
                            return false;
                        }
                    }
                }
                xmlHttp.onreadystatechange = function () {

                    if (xmlHttp.readyState == 4) {
                        resp = xmlHttp.responseText;
                        if (resp == 0) {
                            document.getElementById("selectwsno").style.display = 'none';
                            return false;
                        }
                        var ele = resp.split("!");
                        while (document.getElementById("selectwsno").options.length > 0)
                            document.getElementById("selectwsno").options.remove(document.getElementById("selectwsno").options.length - 1);
//                        if (document.getElementById('txtCompanyNo').value != "") {
                            for (var i = 0; i < ele.length; i++) {
                                var temp = document.getElementById("selectwsno")
                                temp.style.display = '';
                                temp.size = ele.length;
                                newOpt = document.createElement("option");
                                document.getElementById("selectwsno").options.add(newOpt);
                                newOpt.value = ele[i];
                                newOpt.text = ele[i];
                                if (ele[i].toLowerCase() != '') {
                                    if ((document.getElementById('txtCompanyNo').value).toLowerCase() == (ele[i].toLowerCase())) {
                                        document.getElementById("selectwsno") == document.getElementById('txtCompanyNo').value
                                        return false;
                                    }
                                }
                                if (ele[i] == "0") {
                                    //temp.style.display="none";				               
                                    //  return false;
                                }


                           }

                        }
                        else {
                            var temp = document.getElementById("selectwsno")
                            temp.size = 0
                            temp.style.display = '';
                        }
                    }
               // }
                if (id == 1) {
                    if (document.getElementById('txtCompanyNo').value.length >= 3) {

                        var ddlsize = document.getElementById('ddlPartType');

                        var parcompanyno = document.getElementById('txtCompanyNo').value;
                        xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=getWSNo&parcompanyno=" + document.getElementById('txtCompanyNo').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value, true);
                        xmlHttp.send(null);
                    }
                    else {
                        document.getElementById("<%= selectwsno.clientID %>").style.display = 'none'
                    }
                }
                else {
                    
                    var ddlsize = document.getElementById('ddlPartType');
                    var parcompanyno = document.getElementById('txtCompanyNo').value;
                    xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=getWSNo&parcompanyno=" + document.getElementById('txtCompanyNo').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value, true);
                    //xmlHttp.open("GET","AjaxStore.aspx?Action=getCompanyNo&partno=" + document.getElementById('txtPartNo').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value  ,true);
                    xmlHttp.send(null);
                }
            }
        }

        function Selectws() {
            if (document.getElementById('txtPartNo').value == "") {
                var resultStr = "";
                objddl2 = document.getElementById('selectwsno');
                for (var i = 0; i < objddl2.options.length; i++) {
                    if (objddl2.options[i].selected) {
                        resultStr += (objddl2.options[i].text);
                        var objddl1 = document.getElementById('txtPartNo');
                        objddl1.value = resultStr;
                        var x = document.getElementById('selectwsno');
                        x.style.display = "none";
                        document.getElementById('txtPartNo').focus();
                        return false;
                        //alert(resultStr)
                    }
                }

            }
        }
    </script>

</head>
<body onload="return getScrap();">
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
                            <td colspan="4" class="innerheading">
                                <span id="Label3">Scrap Details</span>
                            </td>
                        </tr>
                        <%--<tr>
                            <td align="right">
                                Scrap Type
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlScrapType">
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Scrap Company No.
                            </td>
                            <td>
                                <input id="txtScrapCompNo" runat="server" type="text" name="textfield" />
                            </td>
                        </tr>--%>
                        <tr>
                        <td align="right">
                            Part Type
                        </td>
                        <td>
                         
                            <asp:DropDownList runat="server" ID="ddlPartType">
                                <asp:ListItem Text="1000X20"> </asp:ListItem>
                                <asp:ListItem Text="900X20"> </asp:ListItem>
                                <asp:ListItem Text="VOLVO"> </asp:ListItem>
                            </asp:DropDownList>
                          
                        </td>
                        
                         <td align="right">
                                Scrap Date
                            </td>
                            <td>
                                <BDP:BDPLite ID="dtScrapDate" TextBoxStyle-Width="100px" runat="server">
                                    <TextBoxStyle Width="100px" />
                                </BDP:BDPLite>
                            </td>
                   
                       
                        </tr>
                        <tr>
                            <%--<td align="right">
                                Scrap Reason
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlScrapRsn">
                                </asp:DropDownList>
                            </td>--%>
                             <td align="right">
                            Part WS No.
                        </td>
                        <td>
                           
                            <input type="text" id="txtPartNo" style="width: 120px" class="textfield" name="txtPartNo"
                                onblur="getCompanyNo();" runat="server" />
                            <asp:ListBox ID="selectwsno" Style="display: none; align: left" onclick="Selectws();"
                                                runat="server"></asp:ListBox>
                        </td>
                            <td align="right">
                            Part Comapny No.
                        </td>
                        <td>
                           
                            <input type="text" id="txtCompanyNo" style="width: 120px" class="textfield" name="txtCompanyNo"
                                onblur="getWSNo();" runat="server" />
                                <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                runat="server"></asp:ListBox>
                           </td>
                         </tr>  
                       <tr>
                            <td align="right">
                               Reason
                            </td>
                            <td>                                
                                <textarea cols="3" rows="2" id="txtReason" style="width:168px;" name="txtReason"></textarea>     
                            </td>
                           
                           
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                <label>
                                    <input name="Save" type="button" id="btnSave" value="Save" onclick="ValidateSave();" /></label>
                                <a href="Scrap_Details.aspx">Reset</a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="dvScrapMaster" class="task-al-box" style="width: 100%">
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
    <script>
//    $("#txtPartNo").autocompleteArray(
//		[<% =strparttypedetails  %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);
//	$("#txtCompanyNo").autocompleteArray(
//		[<% =strcompanyno  %>],
//		{
//			delay:10,
//			minChars:1,
//			matchSubset:1,
//			onItemSelect:selectItem,
//			onFindValue:findValue,
//			autoFill:true,
//			maxItemsToShow:10
//		}
//	);

 $(document).ready(function() {
         $("#txtPartNo").autocomplete
           ({
            source: [<%= strparttypedetails  %>]
            });
      });
      
       $(document).ready(function() {
         $("#txtCompanyNo").autocomplete
           ({
            source: [<%= strcompanyno  %>]
            });
      });



    </script>
</body>
</html>
