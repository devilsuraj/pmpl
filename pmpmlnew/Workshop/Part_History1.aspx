<%@ Page Language="VB" EnableEventValidation="False" AutoEventWireup="false" CodeFile="Part_History.aspx.vb" Inherits="KDMT.Part_Repair_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tyre History</title>

    <script language="javascript" type="text/javascript">

        var Optype = 0
        var Fuel
        var ID = 0;

        function DeleteUnitConfirm() {
            if (confirm("Are you sure you want to delete.")) { return true }
            else { return false }
        }


        function getPartHistory() {
            var url = '../tmtAjax/Common_ajax.aspx?action=getPartHistory'
            ajaxFunction();
            sendRequest(url);
            return false;
        }

        function chkbus() {
       // debugger

            document.getElementById('lblbusmsg').innerHTML = '';
            if (document.getElementById("txtBusNo").value != '')
{
            var url = "../store/Ajaxstore.aspx?Action=chkbus&busno=" + document.getElementById("txtBusNo").value 
            ajaxFunction();
            sendRequest(url);
            return false;
            }
        }  

        function DeleteHistory(ID) {
         
            if (Optype == 1) {
                alert('Please quit editing mode for deleting.');
                return false;
            }
            if (DeleteUnitConfirm() == true) {
           // debugger 
                Optype = 2;
                var url = "../tmtAjax/Master_ajax.aspx?action=PartHistory&Id=" + ID + "&Optype=" + Optype;
                sendRequest(url);
                return false;
            }
        }

        function ddlSelection(tdvalue, ddl) {
            for (i = 0; i < ddl.length; i++) {
                if (ddl.options[i].text == tdvalue) {
                    ddl.selectedIndex = i;
                }
            }
        }

        function editHistory(id) {

            document.getElementById('btnSave').value = 'Edit'
            var ddlPartType = document.getElementById('ddlPartType');
            var ddlPartPos = document.getElementById('ddlPartPosition');
            var ddlReason = document.getElementById('ddlReason');
            var ddlPartStatus = document.getElementById('ddlPartStatus');

            ddlSelection(document.getElementById('tdPartType_' + id).innerHTML, ddlPartType);
            ddlSelection(document.getElementById('tdPosition_' + id).innerHTML, ddlPartPos);
            ddlSelection(document.getElementById('tdReason_' + id).innerHTML, ddlReason);
            ddlSelection(document.getElementById('tdPartStatus_' + id).innerHTML, ddlPartStatus);

            document.getElementById('dtDate_TextBox').value = document.getElementById('tdDate_' + id).innerHTML;
            document.getElementById('txtPartNo').value = document.getElementById('tdPartNo_' + id).innerHTML;
            document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_' + id).innerHTML;
            document.getElementById('txtPartKm').value = document.getElementById('tdPartkm_' + id).innerHTML;

            document.getElementById('hdnID').value = id
            Optype = 1;
        }



        function ValidateSave() {
 

            var BusNo = document.getElementById('txtBusNo');
            var PartNo = document.getElementById('txtPartNo');
            var companyNo=document.getElementById('txtcompanyno');
            var objddlPartPos = document.getElementById('ddlPartPosition');
            var objddlReason = document.getElementById('ddlReason');
            var objtxtPartKm = document.getElementById('txtPartKm');

            if (BusNo.value == '' && objddlReason.value == 1) {
            
                alert('Bus No. should not be empty')
                BusNo.focus();
                return false;
            }

            if (PartNo.value == '' && companyNo.value == '' ) {
                alert('Part No. or Company No should not be empty')
                PartNo.focus();
                companyNo.focus();
                return false;
            }
            
            

            if (objddlPartPos.value == '0') {
                alert('Please Select Position')
                objddlPartPos.focus();
                return false;
            }
            if (objddlReason.value == '0') {
                alert('Please Select Reason')
                objddlReason.focus();
                return false;
            }

            if (objtxtPartKm.value == '') {
                alert('Please Enter KM')
                objtxtPartKm.focus();
                return false;
            }
 
            
        }


        function ddlCreation(obj) {
            var url = '../tmtAjax/Master_ajax.aspx?action=PartType&TypeId=' + obj.value;
            ajaxFunction();
            sendRequest(url);
            return false;
        }

        function optCreation(value) {
            var select = document.getElementById('ddlReason');
            select.options.length = 0;
            var arrOption = new Array();
            arrValue = value.split("|");
            for (i = 0; i < arrValue.length - 1; i++) {
                arrOption = arrValue[i].split("~");
                select.options[i] = new Option(arrOption[1], arrOption[0].substring(6));
            }
        }

        function Clean() {
         
            var dt = new Date();
            var ddlPartType = document.getElementById('ddlPartType');
            var ddlPartPos = document.getElementById('ddlPartPosition');
            var ddlReason = document.getElementById('ddlReason');
            var ddlPartStatus = document.getElementById('ddlPartStatus');
            var txtBusNo = document.getElementById('txtBusNo');
            var txtPartNo = document.getElementById('txtPartNo');
            var dtDate = document.getElementById('dtDate_TextBox');
            var txtPartkm = document.getElementById('txtPartKm');
            dtDate.value = dt.toString('dd-MMM-yyyy');
            ddlPartType.selectedIndex = 0;
            ddlPartPos.selectedIndex = 0;
            ddlReason.selectedIndex = 0;
            ddlPartStatus.selectedIndex = 0;
            txtPartNo.value = '';
            txtBusNo.value = '';
            txtPartkm.value = '';
            txtBusNo.focus();

            //        dtRTODate.value = currentDate;
            //        dtFitRenewalDate.value = currentDate;
            //        dtDepoDate.value = currentDate;
            //        dtPutDate.value = currentDate;

        }
        
         function chkcompanyno() {
          
            var url = '../store/Ajaxstore.aspx?action=companyNO&size=' + document.getElementById("ddlPartType").value  + "&parttype=" + '1' + "&companyno=" + document.getElementById("txtcompanyno").value;
            ajaxFunction();
            sendRequest(url);
            return false;
        }
           
//        function chkcompanyno()
//       {
//       debugger
//         if (document.getElementById("txtcompanyno").value != '') {
//            var url = "../store/Ajaxstore.aspx?Action=companyNO&size=" + document.getElementById("ddlPartType").value + "&parttype=" + '1' + "&companyno=" + document.getElementById("txtcompanyno").value;
//            ajaxFunction();
//            sendRequest(url);
//            return false;
//        }
//        }
        

        function ajaxFunction() {

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

            xmlHttp.onreadystatechange = handleresponse
        }

        ajaxFunction();

        function sendRequest(url) {
            url = url + '&t=' + new Date();
            xmlHttp.open("GET", url);
            xmlHttp.send(null);
        }



        function handleresponse() {
      

            if (xmlHttp.readyState == 4) {
            
                resp = xmlHttp.responseText;
                if (resp.indexOf('PassPartRepairSearch') != -1) {
                    document.getElementById('dvPartHistory').innerHTML = resp.substring(20);
                    return false;
                }
                else if (resp.indexOf('OptFail') != -1) {
                    alert('Error Occur While Operation.');
                    return false;
                }
                else if (resp.indexOf('Add') != -1) {
                    alert('Data Added Successfully.');
                    getPartHistory();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Edit') != -1) {
                    alert('Data Updated Successfully.');
                    getPartHistory();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Duplicate') != -1) {
                    alert('This is already exist.');
                    return false;
                }

                else if (resp.indexOf('empty') != -1) {
              document.getElementById('lblbusmsg').innerHTML = 'This Bus is not exist';
                document.getElementById('txtBusNo').focus();
                    return false;
                }
                else if (resp.indexOf('Delete') != -1) {
                    alert('Data Deleted Successfully.');
                    getPartHistory();
                    return false;
                }
                else if (resp.indexOf('Repair') != -1) {
                    optCreation(resp.substring(6));
                }
                else if(resp.indexOf('passcompanyNo') != -1){
                alert('This No.does not exist');
                }
            }
           
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
      //  debugger
            if (document.getElementById('txtcompanyno').value == "") {
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
                                        //                                        document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                                        document.getElementById("Select1") == document.getElementById('txtPartNo').value
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
                if (document.getElementById('txtcompanyno').value == "") {
                var resultStr = "";
                objddl2 = document.getElementById('Select1');
                for (var i = 0; i < objddl2.options.length; i++) {
                    if (objddl2.options[i].selected) {
                        resultStr += (objddl2.options[i].text);
                        var objddl1 = document.getElementById('txtcompanyno');
                        objddl1.value = resultStr;
                        var x = document.getElementById('Select1');
                        x.style.display = "none";
                        document.getElementById('txtcompanyno').focus();
                        return false;
                        //alert(resultStr)
                    }
                }

            }
        }


        function getWSNo(id) {
       // debugger
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
                            document.getElementById("selectwsno").options.remove(document.getElementById("Select1").options.length - 1);
                        if (document.getElementById('txtcompanyno').value != "") {
                            for (var i = 0; i < ele.length; i++) {
                                var temp = document.getElementById("selectwsno")
                                temp.style.display = '';
                                temp.size = ele.length;
                                newOpt = document.createElement("option");
                                document.getElementById("selectwsno").options.add(newOpt);
                                newOpt.value = ele[i];
                                newOpt.text = ele[i];
                                if (ele[i].toLowerCase() != '') {
                             //   debugger
                                    if ((document.getElementById('txtcompanyno').value).toLowerCase() == (ele[i].toLowerCase())) {
                                        //                                        document.getElementById("selectwsno") == document.getElementById('txtcompanyno').value
                                        document.getElementById("selectwsno") == document.getElementById('txtcompanyno').value
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
                }
                if (id == 1) {
                    if (document.getElementById('txtcompanyno').value.length >= 3) {

                        var ddlsize = document.getElementById('ddlPartType');

                        var parcompanyno = document.getElementById('txtcompanyno').value;
                        xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=getWSNo&parcompanyno=" + document.getElementById('txtcompanyno').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value, true);
                        xmlHttp.send(null);
                    }
                    else {
                        document.getElementById("<%= selectwsno.clientID %>").style.display = 'none'
                    }
                }
                else {
                  //  debugger
                    var ddlsize = document.getElementById('ddlPartType');
                    var parcompanyno = document.getElementById('txtcompanyno').value;
                    xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=getWSNo&parcompanyno=" + document.getElementById('txtcompanyno').value + "&size=" + ddlsize.options[ddlsize.selectedIndex].value, true);
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
        function chktyrefittedbus() {

            //    document.getElementById("Select1").style.display='none';
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
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1;
                    if (document.getElementById("ddlPartStatus").selectedIndex == 1) {
                   // debugger
                        if (resp != "") {
                            document.getElementById("txtBusNo").value = resp;
                           // document.getElementById("txtBusNo").readOnly = true;
                        }
//                        else {
//                            document.getElementById("txtBusNo").readOnly = false;
//                        }
                        document.getElementById("txtBusNo").readOnly = true;
                    }



                }
            }
            // var cat = document.Form1.txtItemName.Text;
            //alert(cat);
            xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chktyrefittedbus&tyrewsno=" + document.getElementById("txtPartNo").value + "&tyrecompanyno=" + document.getElementById("txtcompanyno").value, true);
            xmlHttp.send(null);
        }


    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <asp:HiddenField ID="hdnphid" runat="server" />
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
                <table width="100%" border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="4" class="innerheading">
                            Tyre<span id="Label3"> History</span>
                        </td>
                    </tr>
                    <tr>

                     <td align="right">
                            Status:
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlPartStatus" >
                            <asp:ListItem Text="Select" Value="0"> </asp:ListItem>
                                <asp:ListItem Text="Remove" Value="1"> </asp:ListItem>
                                <asp:ListItem Text="Fitted" Value="2"> </asp:ListItem>
                            </asp:DropDownList>
                        </td>



                       
                        <td align="right">
                            Size:
                        </td>
                        <td>
                            <%--  <select id="ddlPartType" name="ddlPartType" onchange="ddlCreation(this);" runat="server" onclick="return ddlPartType_onclick()"> onblur="chktyrefittedbus();"                           
                            </select>   --%>
                            <asp:DropDownList runat="server" ID="ddlPartType">
                                <asp:ListItem Text="1000x20"> </asp:ListItem>
                                <asp:ListItem Text="900x20"> </asp:ListItem>
                                <asp:ListItem Text="VOLVO"> </asp:ListItem>
                            </asp:DropDownList>
                            <%--<asp:DropDownList runat="server" ID="ddlPartType" AutoPostBack="true"></asp:DropDownList>--%>
                        </td>
                    </tr>
                     <tr>
                     <td align="right">
                            NMMT No:
                        </td>
                        <td>
                        <asp:TextBox ID="txtPartNo" Style="width: 120px" class="textfield" name="txtPartNo"
                                onblur="getCompanyNo();" runat="server"></asp:TextBox>
                                 <asp:ListBox ID="selectwsno" Style="display: none; align: left" onclick="Selectws();"
                                                runat="server"></asp:ListBox>
                            <%--<input id="txtPartNo" runat="server" type="text" class="textfield" onblur="chkpartdetails();" /> onblur="chktyrefittedbus();"               --%>
                            <%--<asp:TextBox ID="txtcompanyno" Style="width: 120px" class="textfield" name="txtcompanyno" onblur="getWSNo();chktyrefittedbus();"
                                runat="server"></asp:TextBox>
                                 <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                runat="server"></asp:ListBox>--%>
                            <%--<asp:Label ID="lblmsgshow" runat="server" Text="" ForeColor="Red"></asp:Label>--%>
                        </td>
                        <td align="right">
                            COMPANY No:
                        </td>
                        <td>
                        <asp:TextBox ID="txtcompanyno" Style="width: 120px" class="textfield" name="txtcompanyno" onblur="getWSNo();chktyrefittedbus();"
                                runat="server"></asp:TextBox>
                                 <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                runat="server"></asp:ListBox>
                            <%--<input id="txtPartNo" runat="server" type="text" class="textfield" onblur="chkpartdetails();" />--%>
                            <%--<asp:TextBox ID="txtPartNo" Style="width: 120px" class="textfield" name="txtPartNo"
                                onblur="getCompanyNo();" runat="server"></asp:TextBox>
                                 <asp:ListBox ID="selectwsno" Style="display: none; align: left" onclick="Selectws();"
                                                runat="server"></asp:ListBox>--%>
                            <%--<asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label>--%>
                        </td>
                       
                    </tr>
                    <tr>
                        <td align="right">
                            Position:
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlPartPosition">
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            Bus No:
                        </td>
                        <td>
                            <asp:TextBox ID="txtBusNo" runat="server" type="text" name="txtBusNo" ></asp:TextBox>
                            <asp:Label ID="lblbusmsg" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                   
                    <tr>
                        <td align="right">
                            Out/In Reason:
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlReason">
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            Part(km):
                        </td>
                        <td>
                            <asp:TextBox ID="txtPartKm" runat="server" value='0' type="text" name="txtPartKm"></asp:TextBox>
                        </td>
                    </tr>
                     <tr>
                        <td align="right">
                            Place:
                        </td>
                        <td>
                             <asp:DropDownList runat="server" ID="ddlplace">
                                <asp:ListItem Text="Depot" Value="1"> </asp:ListItem>
                                <asp:ListItem Text="Brakedown" Value="2"> </asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                           
                        </td>
                        <td>
                           
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Remark:
                        </td>
                        <td>
                            <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            Date:
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtDate" TextBoxStyle-Width="100px" runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <asp:Button ID="btnsave" runat="server" Text="Save" />
                            <a href="Part_History.aspx">Reset</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="dvPartHistory" class="task-al-box" style="width: 100%">
                                <asp:DataGrid ID="grddetails" HeaderStyle-CssClass="gridhead" ItemStyle-CssClass="gridtxt"
                                    Style="align: center; valign: middle;" runat="server" Width="100%" AutoGenerateColumns="False"
                                    BackColor="White" BorderColor="Black" BorderWidth="1px" CellPadding="1" Font-Bold="False"
                                    Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" ForeColor="Black" Font-Size="11pt">
                                    <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                    <ItemStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                        Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr No">
                                            <ItemTemplate>
                                                <%# Container .ItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="ph_id" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Bus_No" HeaderText="Bus No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Part_size" HeaderText="Part Size"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Part_No" HeaderText="part No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Part_Company_No" HeaderText="Part Company No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Position_Name" HeaderText="Part Position"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Part_Status" HeaderText="Part Status"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Repair_Type" HeaderText="Out/In Reason"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="PH_Date" HeaderText="Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Part_KM" HeaderText="Part km"></asp:BoundColumn>
                                        <%--  <asp:TemplateColumn HeaderText="Edit">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="Edit" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.ph_id") %>'
                                                    CommandName="Edit" ImageUrl="../images/edit.gif" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>--%>
                                        <asp:TemplateColumn HeaderText="Delete">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="Delete" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.ph_id") %>'
                                                    CommandName="Delete" ImageUrl="../images/delete.gif" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="Part_OI_Reason" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="part_position" Visible="false"></asp:BoundColumn>
                                    </Columns>
                                </asp:DataGrid>
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
//	
//	
//	$("#txtcompanyno").autocompleteArray(
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
         $("#txtcompanyno").autocomplete
           ({
            source: [<%= strcompanyno  %>]
            });
      });

    </script>

</body>
</html>
