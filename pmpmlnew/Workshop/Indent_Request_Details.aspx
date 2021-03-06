<%@ Page Language="VB" AutoEventWireup="false" EnableEventValidation="false" CodeFile="Indent_Request_Details.aspx.vb"
    Inherits="kdmt.Indent_Request_Details" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Indent Request</title>
    <script language="javascript" type="text/javascript">



        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;
        var rowcntSave = 1;
        var dltcnt = 0


        function addDetails() {

            if (document.getElementById('hdnsrno').value == '') {
                document.getElementById('hdnsrno').value = 0;
            }
            var srno = 0;
            var lblsrno = document.getElementById('lblsrno');
            var txtPartNo = document.getElementById('txtPartNo');
            var txtItemName = document.getElementById('txtItemName');
            var txtbqty = document.getElementById('txtbqty');
            var txtReqQty = document.getElementById('txtReqQty');


            var tbody = document.getElementById('tbodyIndent');
            var tblIndent = document.getElementById('tblIndent');
            var hdnrwcnt = document.getElementById('hdnrwcnt');


            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntSave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdsrno_' + rowcntSave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdPartNo_' + rowcntSave);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tditem_' + rowcntSave);

            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdavbqty_' + rowcntSave);

            var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'tdReqQty_' + rowcntSave);

            var cells6 = row.insertCell(5);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

            cells2.innerHTML = txtPartNo.value;
            cells3.innerHTML = txtItemName.value;
            cells4.innerHTML = txtbqty.value;
            cells5.innerHTML = txtReqQty.value;

            cells6.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntSave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt += 1;
            rowcntSave += 1;
            lblsrno.value = '';

            txtPartNo.value = '';
            txtItemName.value = '';
            txtbqty.value = '';
            txtReqQty.value = '';

            txtPartNo.focus();
            document.getElementById('hdnrwcnt').value = rowcntSave;
            // alert(document.getElementById('hdnrwcnt').value)
        }


        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;
            document.getElementById('hdnsrno').value = 0;

            for (i = 1; i < hdnrwcnt.value; i++) {
                if (document.getElementById('tditem_' + i) != null) {
                    document.getElementById('tdsrno_' + i).innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1
                    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

                }

            }
        }



        function DeleteUnitConfirm() {
            if (confirm("Are you sure you wan`t to delete.")) { return true }
            else { return false }
        }


        function getDefect() {
            var url = '../tmtAjax/Common_ajax.aspx?action=getDefectDetails'
            sendRequest(url);
            return false;
        }

        function getindent() {

            var url = "../store/AjaxStore.aspx?action=getindentno&date=" + document.getElementById('dtIndentDate_TextBox').value;
            sendRequest(url);
            return false;
        }

        function DeleteDefect(ID) {
            if (Optype == 1) {
                alert('Please quit editing mode for deleting.');
                return false;
            }
            if (DeleteUnitConfirm() == true) {
                Optype = 2;
                var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&Optype=" + Optype;
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

        function editDefect(id) {
            var ddlDefPriority = document.getElementById('ddlDefPriority');
            ddlSelection(document.getElementById('tdDefPriority_' + id).innerHTML, ddlDefPriority);
            document.getElementById('dtDefectDate_TextBox').value = document.getElementById('tdDefDate_' + id).innerHTML;

            document.getElementById('txtDriverNo').value = document.getElementById('tdDriverNo_' + id).innerHTML;
            document.getElementById('txtDefectTime').value = document.getElementById('tdDefectTime_' + id).innerHTML;
            document.getElementById('txtDescription').value = document.getElementById('tdDescription_' + id).innerHTML;

            document.getElementById('hdnID').value = id
            Optype = 1;
        }

        function ValidateSave() {
            var detvalues = '';
            var i = 0;


            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            // var txtindent = document.getElementById('txtindent').value;

            for (i = 1; i < rowcntSave; i++) {
                if (document.getElementById('tditem_' + i) != null) {
                    var PartNo = document.getElementById('tdPartNo_' + i).innerHTML;
                    var ItemName = document.getElementById('tditem_' + i).innerHTML;
                    var avbqty = document.getElementById('tdavbqty_' + i).innerHTML;
                    var ReqQty = document.getElementById('tdReqQty_' + i).innerHTML;

                    detvalues = detvalues + PartNo + '^' + ItemName + '^' + avbqty + '^' + ReqQty + '|';
                }
            }

            document.getElementById('Hid_Rec').value = detvalues
        }

        function Clean() {
            window.location.href = "View_Defect_Details.aspx";
        }

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

                if (resp.indexOf('PassDefectSearch') != -1) {
                    //            document.getElementById('dvDefectMaster').innerHTML = resp.substring(16);
                    return false;
                }
                else if (resp.indexOf('OptFail') != -1) {
                    alert('Error Occur While Operation.');
                    return false;
                }

                else if (resp.substring(0, 6) == 'indent') {
                    document.getElementById('lblindent').innerHTML = resp.substring(6, 15);
                    return false;
                }
                else if (resp.indexOf('Add') != -1) {
                    alert('Data Added Successfully.');
                    getDefect();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Edit') != -1) {
                    alert('Data Updated Successfully.');
                    getDefect();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Duplicate') != -1) {
                    alert('Defect No. is already exist.');
                    getDefect();
                    Clean();
                    return false;
                }

                else if (resp.indexOf('Delete') != -1) {
                    alert('Data Deleted Successfully.');
                    getDefect();
                    return false;
                }
                else if (resp.indexOf('indentno') != -1) {
                    alert('Your Indent No Is ' + resp.substring(8))
                    //document.getElementById('lblindent').innerHTML =  resp.substring(8)
                    Clean();

                    return false;
                }

            }
        }




        function getitemname(id) {

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
                    var select = document.getElementById('Select1');
                    select.innerHTML = "";  //  for removing all the items from the list
                    if (document.getElementById('txtItemName').value != "" || document.getElementById('txtPartNo').value != "") {
                        for (i = 0; i < ele.length - 1; i++) {
                            if (ele[i] == document.getElementById('txtItemName').value) {
                                select.innerHTML = "";
                            }
                            else {
                                select.options[select.options.length] = new Option(ele[i], i);
                                select.style.display = 'block';
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
                if (document.getElementById('txtItemName').value.length >= 0) {

                    var txtsubrackno = "";
                    var partno = document.getElementById('txtPartNo').value;
                    xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById('txtItemName').value + "&subrackno=" + txtsubrackno + "&partno=" + partno, true);
                    xmlHttp.send(null);
                }
                else {
                    document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                }
            }
            else {
                var txtsubrackno = "";
                var partno = document.getElementById('txtPartNo').value;
                xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById('txtItemName').value + "&subrackno=" + txtsubrackno + "&partno=" + partno, true);
                xmlHttp.send(null);
            }
        }


        function Select() {

            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtItemName');
                    objddl1.value = resultStr;
                    var x = document.getElementById('Select1');
                    x.style.display = "none";
                    document.getElementById('txtItemName').focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }


        function emptytext() {

            if (document.getElementById('txtPartNo').value != '' && document.getElementById('txtItemName').value != '') {
                document.getElementById('txtPartNo').value = '';
                document.getElementById('txtItemName').value = '';
            }
        }

        function emptytextpart() {
            if (document.getElementById('txtItemName').value != '') {
                document.getElementById('txtItemName').value = '';
            }
        }

        function display() {

            var x = document.getElementById('Select1');
            x.style.display = "none";
        }

        function Fromcombo2() {

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
                    var ele1 = resp.split('|');
                    document.getElementById('txtPartNo').value = ele1[2];
                    document.getElementById('txtbqty').value = ele1[0];
                }
            }
            var itemname = document.getElementById('txtItemName').value;
            var txtsubrack = ""
            var partno = document.getElementById('txtPartNo').value;
            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrack=" + txtsubrack + "&partno=" + partno, true);
            xmlHttp.send(null);
        }

        ///////////   for removing blaak spaces 
        String.prototype.trim = function () {

            return this.replace(/^\s+|\s+$/g, "");
        }


        function check1() {
            var str = document.getElementById('txtItemName').value;
            if (str.trim() != '') {
                Fromcombo2();
            }
            return false;
        }

        function IsNumeric(strString) {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }

        function validateqty() {

            if (document.getElementById("txtjobno").value == '') {
                alert("Please Enter Job No");
                document.getElementById("txtjobno").focus();
                return false;
            }

            if (document.getElementById("txtBusNo").value == '') {
                alert("Please Enter Bus No");
                document.getElementById("txtBusNo").focus();
                return false;
            }
            if (document.getElementById("txtItemName").value == '') {
                alert("Please Enter Item Name");
                document.getElementById("txtItemName").focus();
                return false;
            }
            if (document.getElementById("txtReqQty").value.length > 0) {

                if (IsNumeric(document.getElementById("txtReqQty").value)) {
                    addDetails();
                    ValidateSave();
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtReqQty").focus();
                    return false;
                }
            }
            else {

                alert("Enter Proper Value");
                document.getElementById("txtReqQty").focus();
                return false;
            }
        }	
 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="Hid_Rec" runat="server" type="hidden" name="Hid_Rec" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
    </div>
    <div id="middal">
        <uc:leftmenu ID="Leftmenu1" runat="server" />
        <div class="contantbox">
            <div class="orgtop">
            </div>
            <div class="orgmiddal">
                <table width="100%" border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="4" class="innerheading">
                            <span id="Label3">Indent Request Details</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Indent Date
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtIndentDate" onblur="getindent()" TextBoxStyle-Width="100px" runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
                        </td>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Your Indent No Is" ForeColor="black"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblindent" Font-Size="20px" runat="server" Text="" ForeColor="blue"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Approved By
                        </td>
                        <td>
                            <asp:TextBox ID="txtapprovedby" Width="30px" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            Remark
                        </td>
                        <td>
                            <asp:TextBox ID="txtremark" Width="168px" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Job Card No
                        </td>
                        <td>
                            <asp:TextBox ID="txtjob" Width="30px" runat="server"></asp:TextBox>
                            <asp:TextBox ID="txtjobno" Width="40px" MaxLength="4" AutoPostBack="True" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            Bus No
                        </td>
                        <td>
                            <asp:TextBox ID="txtBusNo" ReadOnly="true" Width="140px" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:Label ID="lblerror" Font-Size="20px" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdindent" colspan="4">
                            <table id="tblIndent" width="100%" border="1" cellpadding="5" cellspacing="5">
                                <tbody runat="server" id="tbodyIndent">
                                    <tr class='gridhead'>
                                        <td>
                                            SR No.
                                        </td>
                                        <td>
                                            Part No.
                                        </td>
                                        <td>
                                            Item Name
                                        </td>
                                        <td>
                                            Available<br />
                                            Qty.
                                        </td>
                                        <td>
                                            Required Qty.
                                        </td>
                                    </tr>
                                    <tr class='gridtxt'>
                                        <td>
                                            <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPartNo" Width="150px" onblur="emptytextpart();getitemname(0);"
                                                runat="server"></asp:TextBox>
                                            <asp:AutoCompleteExtender ServiceMethod="Search_partno" MinimumPrefixLength="1" CompletionInterval="100"
                                                EnableCaching="false" CompletionSetCount="10" TargetControlID="txtPartNo" ID="AutoCompleteExtender1"
                                                runat="server" FirstRowSelected="false">
                                            </asp:AutoCompleteExtender>
                                        </td>
                                        <td>
                                            <input type="text" id="txtItemName" style="width: 250px" size="100" name="txtItemName"
                                                onkeypress="getitemname(1);" onblur="return check1();" />
                                            <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                runat="server"></asp:ListBox>
                                        </td>
                                        <td align="left" style="width: 43px; height: 28px;">
                                            <asp:TextBox ID="txtbqty" runat="server" Width="56px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td>
                                            <input type="text" id="txtReqQty" style="width: 100px" name="txtReqQty" />
                                        </td>
                                        <td colspan="1" align="right">
                                            <asp:Button ID="btnadd" OnClientClick="return validateqty();" runat="server" Text="Add" />
                                        </td>
                                    </tr
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <asp:Button ID="btnaddandsave" runat="server" Text="AddandSave" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <div align="center">
                                <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                    Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                    BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                    Font-Size="11pt">
                                    <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                    <ItemStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                        Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                    <Columns>
                                        <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="hidejobno" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="hidebusno" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="jobno" HeaderText="jobno"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="partno" HeaderText="part No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="itemname" HeaderText="Item Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="avbqty" HeaderText="Avb Qty"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="reqqty" HeaderText="Req Qty"></asp:BoundColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                    <tr id="trsave" runat="server" visible="false">
                        <td align="center" colspan="4">
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" />
                            <a href="Indent_Request_Details.aspx">Reset</a>
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
        function addEventHandler(elem, eventType, handler) {
            if (elem.addEventListener)
                elem.addEventListener(eventType, handler, false);
            else if (elem.attachEvent)
                elem.attachEvent('onchange' + eventType, handler);


        }
        var sEventType = '';
        var b1 = document.getElementById('dtIndentDate_TextBox');

        addEventHandler(b1, sEventType, getindent);

    </script>
    <script type="text/javascript">
        //        function SetContextKey() {
        //            $find('<%=AutoCompleteExtender1.ClientID%>').set_contextKey($get("<%=txtPartNo.ClientID %>").value);

        //        }

        //        function fnsetfocus() {
        //            document.getElementById('txtItemName').focus();
        //        }
    </script>
</body>
</html>
