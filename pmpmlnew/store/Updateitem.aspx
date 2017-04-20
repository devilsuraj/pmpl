<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Updateitem.aspx.vb" Inherits="KDMT.Updateitem" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <!-- BEGIN BREADCRUMBS -->
    <div class="breadcrumbs">
        <h1>Update Item Master</h1>
        <!-- Sidebar Toggle Button -->
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".page-sidebar">
            <span class="sr-only">Toggle navigation</span>
            <span class="toggle-icon">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </span>
        </button>
        <!-- Sidebar Toggle Button -->
    </div>
    <div class="page-content-container ">
        <div class="page-content-row">
            <div class="page-content-col">
                <!-- BEGIN PAGE BASE CONTENT -->
                <div class="row form-horizontal">
                    <div class="col-md-12">
                        <div class="portlet box">
                            <div class="portlet-body form">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Old Item Name</label>
                                            <div class="col-md-3">
                                                <asp:TextBox    class="form-control input-sm" onkeyup="ajaxFunction();" runat="server" ID="txtitem" ></asp:TextBox>
                                                <asp:ListBox ID="Select1" class="form-control" Style="display: none; align: center; position:absolute; height:200px; overflow-y:scroll; z-index:999999999999999999999999" onclick="Select();"
                                                    runat="server" onchange="Select();itemdetail(1);"></asp:ListBox>
                                                 
                                            </div>
                                            <label class="col-md-2 control-label">Category </label>
                                            <div class="col-md-3">
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                   <asp:DropDownList class="form-control" ID="ddlCategory" runat="server">
                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">Item Code</label>
                                                <div class="col-md-3">
                                                       <asp:TextBox class="form-control input-sm" ID="txtcode"  runat="server" AutoPostBack="true"></asp:TextBox>
                                                
                                                </div>
                                                <label class="col-md-2 control-label">New Item Name</label>
                                                <div class="col-md-3">
                                                   <asp:TextBox class="form-control input-sm" ID="txtname" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Part No 1</label>
                                            <div class="col-md-3">
                                                  <asp:TextBox class="form-control input-sm" ID="Txtpartno"  runat="server"></asp:TextBox>   
                                            </div>
                                            <label class="col-md-2 control-label">Part No 2</label>
                                            <div class="col-md-3">
                                                <asp:TextBox class="form-control input-sm" ID="txtPartNo2"  runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Part No 3</label>
                                            <div class="col-md-3">
                                                  <asp:TextBox class="form-control input-sm" ID="txtPartNo3"  runat="server"></asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Part No 4</label>
                                            <div class="col-md-3">
                                                   <asp:TextBox class="form-control input-sm" ID="txtPartNo4"  runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Consumption</label>
                                            <div class="col-md-3">
                                                <asp:TextBox class="form-control input-sm" ID="txtConsumation"  runat="server"></asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Rate</label>
                                            <div class="col-md-3">
                                                 <asp:TextBox class="form-control input-sm" ID="txtRate"  runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-1 control-label">Room No</label>
                                            <div class="col-md-2">
                                                 <asp:TextBox class="form-control input-sm" ID="txtroomno" Text ="1" ReadOnly ="true"  onblur="if (!IsNumeric(this.value)){this.focus();alert('Enter Proper Room No');return false}"
                                    runat="server" MaxLength="1" ></asp:TextBox>
                                            </div>
                                            <label class="col-md-1 control-label">LF No</label>
                                            <div class="col-md-2">
                                                 <asp:TextBox class="form-control input-sm" ID="txtlfno" onchange="itemdetail(2);"   runat="server" ></asp:TextBox>
                                            </div>
                                            <label class="col-md-1 control-label">BIN No</label>
                                            <div class="col-md-2">
                                               <asp:TextBox class="form-control input-sm" ID="txtsubrack" runat="server"  onchange="itemdetail(2);"></asp:TextBox>
                                            </div>
                                              <asp:Label ID="Label3" runat="server" Text="Location Of The Item" ForeColor="red"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Reorder</label>
                                            <div class="col-md-1">
                                                    <asp:TextBox class="form-control input-sm" ID="txtreorder" onblur="if (!IsNumericall(this.value)){this.focus();alert('Enter Proper Value');return false}"
                                    runat="server" Width="50px"></asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Max Level</label>
                                            <div class="col-md-1">
                                                 <asp:TextBox class="form-control input-sm" ID="txtmax" runat="server" onblur="if (!IsNumericall(this.value)){this.focus();alert('Enter Proper Value');return false}"
                                    ></asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Min Level</label>
                                            <div class="col-md-1">
                                               
                                    <asp:TextBox class="form-control input-sm" ID="txtmin" runat="server"
                                    Width="200px"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Unit</label>
                                            <div class="col-md-3">
                                               <asp:TextBox class="form-control input-sm" ID="txtunit"  runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-3 text-danger">
                                                Ft , Kg , Ltr , Mtr , Roll
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Make</label>
                                            <div class="col-md-3">
                                                   <asp:TextBox class="form-control input-sm" ID="txtmake"  runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row text-center">
                                        <div class="form-actions right1">
                                          <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif">
                                </asp:ImageButton><asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
                                    TabIndex="1"></asp:ImageButton>
                                        </div>
                                    </div>
                                
                                </div>
                            </div>
                            <!--form body ends-->
                        </div>
                    </div>
                </div>
            </div>
            <!-- END PAGE BASE CONTENT -->
        </div>
    </div>
    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>
    <script language="javascript" src="../Scripts/LogSheet.js">
    </script>
    <script language="javascript" src="../Scripts/BLogSheet.js">
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <script language="javascript">
        var clockID = 0;
        function UpdateClock() {
            if (clockID) {
                clearTimeout(clockID);
                clockID = 0;
            }
            var tDate = new Date();
            //lbltime.innerHTML = "" + tDate.getHours() + ":" + tDate.getMinutes() + ":" + tDate.getSeconds();
            clockID = setTimeout("UpdateClock()", 1000);
        }
        function StartClock() {
            clockID = setTimeout("UpdateClock()", 500);
        }
        function KillClock() {
            if (clockID) {
                clearTimeout(clockID);
                clockID = 0;
            }
        }
        function ajaxFunction() {
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
                        return false;
                    }
                    var ele = resp.split("!");
                    while (document.getElementById("Select1").options.length > 0)
                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.getElementById('txtitem').value != "") {
                        for (var i = 0; i < ele.length; i++) {
                            var temp = document.getElementById("Select1")
                            temp.style.display = "block";
                            temp.size = ele.length;
                            newOpt = document.createElement("OPTION");
                            document.getElementById("Select1").options.add(newOpt);
                            newOpt.value = ele[i];
                            newOpt.innerText = ele[i];
                            if (document.getElementById('txtitem').value == ele[i]) {
                                temp.style.display = "none";
                                return false;
                            }
                            if (ele[i] == "0") {
                                temp.style.display = "none";
                                return false;
                            }
                        }
                    }
                    else {
                        var temp = document.getElementById("Select1")
                        temp.size = 0
                        temp.style.display = "none";
                    }
                }
            }
            //alert(document.getElementById('txtitem').value)
            //alert(document.Form1.txttest.value)
            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=item&itemname=" + document.getElementById('txtitem').value, true);
            xmlHttp.send(null);
            //alert(document.frmRF.txtlocation.value)
        }
        function Select() {
            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtitem');
                    objddl1.value = resultStr;
                    var x = document.getElementById('Select1');
                    x.style.display = "none";
                    return false;
                    //alert(resultStr)
                }
            }
        }
        function itemdetail(type) {
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
                    var ele = resp.split("!");
                    for (var i = 0; i < ele.length; i++) {
                        if (i == 0) {
                            document.getElementById("txtname").value = ele[i];
                        }
                        if (i == 1) {
                            //            document.getElementById("txtcat").value = ele[i];
                            document.getElementById("ddlCategory").value = ele[i];
                        }
                        if (i == 3) {
                            document.getElementById("HiddenField1").value = ele[i];
                            document.getElementById("txtcode").value = ele[i];
                            document.getElementById("txtcode").disabled = true;
                        }
                        if (i == 4) {
                            document.getElementById("Txtpartno").value = ele[i];
                        }
                        if (i == 5) {
                            document.getElementById("txtroomno").value = ele[i];
                        }
                        if (i == 7) {
                            document.getElementById("txtlfno").value = ele[i];
                        }
                        if (i == 6) {
                            document.getElementById("txtsubrack").value = ele[i];
                        }
                        if (i == 8) {
                            document.getElementById("txtreorder").value = ele[i];
                        }
                        if (i == 9) {
                            document.getElementById("txtmax").value = ele[i];
                        }
                        if (i == 10) {
                            document.getElementById("txtmin").value = ele[i];
                        }
                        if (i == 11) {
                            document.getElementById("txtunit").value = ele[i];
                        }
                        if (i == 12) {
                            document.getElementById("txtPartNo2").value = ele[i];
                        }
                        if (i == 13) {
                            document.getElementById("txtPartNo3").value = ele[i];
                        }
                        if (i == 14) {
                            document.getElementById("txtPartNo4").value = ele[i];
                        }
                        if (i == 15) {
                            document.getElementById("txtRate").value = ele[i];
                        }
                        if (i == 16) {
                            document.getElementById("txtConsumation").value = ele[i];
                        }
                    }
                }
            }
            if (document.getElementById("txtitem").value == "" && type == 2) {
                room = document.getElementById("txtroomno").value;
                //comment by shital
                //xmlHttp.open("GET","../store/AjaxStore.aspx?Action=itemdetailrack&room="+room+"&lfno="+document.getElementById("txtlfno").value ,true);
                xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemdetailrack&room=" + room + "&lfno=" + document.getElementById("txtlfno").value + "&bin=" + document.getElementById("txtsubrack").value, true);
                xmlHttp.send(null);
            }
            else if (document.getElementById("txtitem").value != "" && type == 1) {
                xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemdetail&itemname=" + document.getElementById('txtitem').value, true);
                xmlHttp.send(null);
            }
        }
        function IsNumeric(strString) {
            var ValidChars = "123456789";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }
        function IsNumericall(strString) {
            var ValidChars = ".0123456789";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }
        function validate() {
            if (document.getElementById('txtroomno').value == '') {
                alert('Please Enter Room No')
                document.getElementById('txtroomno').focus();
                return false;
            }
            if (document.getElementById('txtsubrack').value == '') {
                alert('Please Enter Bin No')
                document.getElementById('txtsubrack').focus();
                return false;
            }
            if (document.getElementById('txtunit').value == '') {
                alert('Please Enter Unit')
                document.getElementById('txtunit').focus();
                return false;
            }
        }
    </script>
</asp:Content>
