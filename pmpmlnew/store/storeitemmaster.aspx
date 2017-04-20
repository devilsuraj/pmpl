<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="storeitemmaster.aspx.vb" Inherits="KDMT.storeitemmaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true"  runat="Server">
    <div class="breadcrumbs">
        <h1>Item Master</h1>
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
    <div class="page-content-container" onload="StartClock();">
        <div class="page-content-row">
            <div class="page-content-col">
                <!-- BEGIN PAGE BASE CONTENT -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box">
                            <div class="portlet-body form form-horizontal">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Date</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="BDPLite1" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                                    PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                                </asp:ScriptManager>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Part Code</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txtcode" runat="server" CssClass="form-control input-sm" Enabled="false" Width="200px"></asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Part No</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txtPartNo" CssClass="form-control input-sm" runat="server" Width="200px"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Item Name</label>
                                            <div class="col-md-5">
                                                <asp:TextBox ID="txtname" CssClass="form-control input-sm" runat="server" Width="350px"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Category Name</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList ID="ddlvendor" CssClass="form-control input-sm" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-md-2 control-label">Item Type</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList CssClass="form-control input-sm" ID="ddlItemType" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Unit </label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txtunit" CssClass="form-control input-sm" placeholder="Nos" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-3 text-danger">
                                                Ft , Kg , Ltr , Mtr , Roll
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-1 control-label">Room No</label>
                                            <div class="col-md-1">
                                                <asp:TextBox ID="txtroomno" CssClass="form-control input-sm" placeholder="1" runat="server" MaxLength="1"></asp:TextBox>
                                            </div>
                                            <label class="col-md-1 control-label">LF No</label>
                                            <div class="col-md-1">
                                                <asp:TextBox ID="txtRackNo" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                            </div>
                                            <label class="col-md-1 control-label">BIN No</label>
                                            <div class="col-md-1">
                                                <asp:TextBox ID="txtsubrack" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                            </div>
                                            <asp:Label ID="Label2" runat="server" Text="Location Of The Item" ForeColor="red"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Toal Stock</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txttotal" placeholder="0" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Rate</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txtamt" placeholder="0" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Reorder</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txtreorder" CssClass="form-control input-sm" placeholder="0" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row text-center">
                                        <div class="form-actions right1">
                                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton>
                                <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"></asp:ImageButton>           </div>
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
       <script language="javascript">
        function redirect() {
            alert('this item already in stock');
            window.location.href('~/storeitemmaster.aspx');
        }
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
        function IsNumeric(strString) {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return;
        }
        function ticFunction2() {
            LogSheet2();
        }
        function ticFunction1() {
            BLogSheet();
        }
        function Fromcombo() {
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
                    var ele1 = resp.split("!");
                    while (document.getElementById("ddlitem").options.length > 0)
                        document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length - 1);
                    document.getElementById("ddlitem").value == "";
                    var temp = document.getElementById("ddlitem")
                    //if(document.Form1.txtroute.value !="")
                    // {
                    for (var i = 0; i < ele1.length - 1; i++) {
                        var temp = document.getElementById("ddlitem")
                        newOpt = document.createElement("OPTION");
                        document.getElementById("ddlitem").options.add(newOpt);
                        newOpt.value = ele1[i];
                        newOpt.innerText = ele1[i];
                        //								//if (document.Form1.txtroute.value==ele1[i])
                        //								//{
                        //								//    temp.style.display="none";				               
                        //				               //     return false;
                        //								}
                        //                               	if (ele1[i]=="0")
                        //								{
                        //								    temp.style.display="none";				               
                        //				                    return false;
                        //								}			                         
                    }
                    //}
                    //else
                    //{
                    //var temp=document.getElementById("ddlfrom")
                    //temp.size=0;
                    //temp.style.display="none";
                    //}
                }
            }
            var cat = document.Form1.ddlcat.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=itemname&itemid=" + document.Form1.ddlcat.value, true);
            xmlHttp.send(null);
        }
        function validate() {
          
            if (document.getElementById("ddlvendor").selectedIndex == 0) {
                alert('Select Category Name');
                document.getElementById("ddlvendor").focus()
                return false;
            }
            if (document.getElementById("ddlItemType").selectedIndex == 0) {
                alert('Select Item Type');
                document.getElementById("ddlItemType").focus()
                return false;
            }
            if (document.getElementById("txtroomno").value.length == 0) {
                alert('Please Enter Room No');
                document.getElementById("txtroomno").focus()
                return false;
            }
            if (document.getElementById("txtRackNo").value.length == 0) {
                //          alert ('Please Enter LF No');
                //          document.getElementById ("txtRackNo").focus()
                //          return false;
            }
            if (document.getElementById("txtname").value.length == 0) {
                alert('Please Enter Name');
                document.getElementById("txtname").focus()
                return false;
            }
            if (document.getElementById("txttotal").value.length == 0) {
                alert('Please Enter Balance Stock ');
                document.getElementById("txttotal").focus()
                return false;
            }
            if (IsNumeric(document.getElementById("txttotal").value) == false) {
                alert('Please Enter Numbers Only ');
                document.getElementById("txttotal").focus()
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
