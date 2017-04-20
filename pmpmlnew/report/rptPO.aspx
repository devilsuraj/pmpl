<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="rptPO.aspx.vb" Inherits="KDMT.rptcontractorwise" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet">
   <script src="../scripts/jquery-1.11.0.min.js"></script>
            <script src="../scripts/jquery-ui.js"></script>
</asp:Content>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>
    <script language="javascript" type="text/javascript">
        function printpage() {
            window.print();
        }
        function chkvendorname() {
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
                    var ele1 = resp;
                    if (ele1 == "NO-SUCH-ITEM") {
                        alert("No Such Vendor Present");
                        document.getElementById("txtvendor").value="";
                        document.getElementById("txtvendor").focus();
                    }
                }
            }
            if (document.getElementById("txtvendor").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkvendorname&vendorname=" + document.getElementById("txtvendor").value, true);
                xmlHttp.send(null);
            }
        }
    </script>
    <style media="Print" type="text/css">
        .ctrl {
            display: none;
        }

        td, tr {
            padding: 5px;
        }
    </style>

    <div>
    

        <script type="text/javascript">
            function findValue(li) {
                if (li == null) return alert("No match!");
                // if coming from an AJAX call, let's use the CityId as the value
                if (!!li.extra) var sValue = li.extra[0];
                    // otherwise, let's just display the value in the text box
                else var sValue = li.selectValue;
                //alert("The value you selected was: " + sValue);
            }
            function selectItem(li) {
                findValue(li);
            }
            //-->
        </script>

        <table id="Table1" align="center" cellspacing="0" cellpadding="0" border="0" style="width: 650px"
            runat="server">
            <tr>
                <td colspan="4" align="center">
                    <strong><span style="font-size: 15pt;">
                        <asp:Label ID="Label1" runat="server" CssClass="lbtxt" Visible="false"></asp:Label>
                    </span>
                    </strong>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <strong><span style="font-size: 14pt">
                        <asp:Label ID="lblswargets" runat="server" CssClass="lbtxt" Visible="false"></asp:Label>
                        &nbsp; </span></strong>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    <span style='font-family: Times New Roman; font-size: 12px; width: auto;'>
                        <asp:Label ID="lblpmpadd" runat="server" CssClass="lbtxt" Visible="false"></asp:Label></span>
                    <br />
                    <span style='font-family: Times New Roman; font-size: 12px;'>
                        <asp:Label ID="lblpmpadd2" runat="server" CssClass="lbtxt" Visible="false"></asp:Label>
                    </span>
                </td>
                <td align="right" colspan="2">
                    <span style='font-family: Times New Roman; font-size: 12px;'>
                        <asp:Label ID="lblmail" runat="server" CssClass="lbtxt" Visible="false"></asp:Label></span>
                    </span>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2" width="650px">
                    <asp:Label ID="lblcodenos" Style='font-family: Times New Roman; font-size: 12px;'
                        runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    <br />
                    <asp:Label ID="lblprinttype" Style='font-family: Times New Roman; font-size: 12px;'
                        runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
                <td align="right" colspan="2" width="650px">
                    <asp:Label ID="lblphnos" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    <br />
                    &nbsp;<asp:Label ID="lblfax" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2" width="650px">
                    <asp:Label ID="lbltoms" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
                <td align="right" colspan="2" width="650px" style="font-weight: bold">
                    <asp:Label ID="lblponos" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    <asp:Label ID="lblPONoStr" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    <asp:Label ID="lblPONo" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2" width="650px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <asp:Label ID="lblms" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    &nbsp;&nbsp;<asp:Label ID="lblVendorName" Style='font-family: Times New Roman; font-size: 18px;'
                        runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
                <td align="right" colspan="2" width="650px">
                    <span style='font-family: Times New Roman; padding-right: 50px; font-size: 12px;'>
                        <asp:Label ID="lblpodates" runat="server" CssClass="lbtxt" Visible="false"></asp:Label>
                        <asp:Label ID="lblPoDate" runat="server" CssClass="lbtxt" Visible="false"></asp:Label></span>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2" class="style1" width="650px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblAdd1" Style='font-family: Times New Roman; font-size: 12px;'
                    runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    &nbsp; &nbsp;
            <asp:Label ID="lblAdd2" Style='font-family: Times New Roman; font-size: 12px;'
                runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
                <td align="right" colspan="2" width="650px" style="padding-right: 100px">
                    <span style='font-family: Times New Roman; font-size: 12px;'>
                        <asp:Label ID="lblourrefnos" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                        <asp:Label ID="lblORN" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    </span><span style='font-family: Times New Roman; font-size: 12px;'>
                        <asp:Label ID="lblorndates" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                        <asp:Label
                            ID="lblORD" runat="server" Font-Bold="true" Visible="false"></asp:Label></span>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2" width="650px">
                    <asp:Label ID="lblcontactnos" Style='font-family: Times New Roman; font-size: 12px;'
                        runat="server" Font-Bold="true" Visible="false"></asp:Label>
                    <asp:Label ID="lblContctno" Style='font-family: Times New Roman; font-size: 12px;'
                        runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
                <td align="right" colspan="2" width="650px" style="padding-right: 100px">
                    <span style='font-family: Times New Roman; font-size: 12px;'>
                        <asp:Label ID="lblyourrefnos" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                        <asp:Label ID="lblYRN" runat="server" Font-Bold="true" Visible="false"></asp:Label></span><span style='font-family: Times New Roman; font-size: 12px;'>
                            <asp:Label ID="lblrefdates" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                        </span>
                    <asp:Label ID="lblYRD" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="4">
                    <br />
                    <span style="font-family: Times New Roman; font-size: 12px;">
                        <asp:Label ID="lbltandc" runat="server" Visible="false"></asp:Label>
                    </span>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="left">
                    <span style='font-family: Times New Roman; font-size: 12px;'>
                        <asp:Label ID="lblrefrs" Style='font-family: Times New Roman; font-size: 12px;'
                            runat="server" Width="96px" Font-Bold="true" Visible="false"></asp:Label>
                        <asp:Label ID="lblref_asrtu" Style='font-family: Times New Roman; font-size: 12px;'
                            runat="server" Width="96px" Font-Bold="true" Visible="false"></asp:Label></span>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="left" valign="top">
                    <div align="center">
                        <asp:Literal ID="htmldetails" runat="server"></asp:Literal>
                    </div>
                </td>
            </tr>
        </table>
        <table id="tblback" align="center" cellspacing="0" runat="server" cellpadding="0"
            border="0" style="width: 650px">
            <tr>
                <td colspan="8" align="left" valign="top">
                    <div align="center">
                        <asp:Literal ID="htmldetailsback" runat="server"></asp:Literal>
                    </div>
                </td>
            </tr>
            <tr class="ctrl">
                <td align="center" colspan="4" rowspan="2" valign="top" style="height: 50px">
                    <asp:Button ID="Button1" runat="server" Width="87px" OnClientClick="printpage();"
                        Text="Print"></asp:Button>
                    <asp:Button ID="Button2" runat="server" Text="Close" Width="87px" />
                </td>
            </tr>
        </table>
    </div>
    <div class="breadcrumbs">
        <h1>PO Print</h1>
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
    <div class="page-content-container">
        <div class="page-content-row">
            <div class="page-content-col form-horizontal">
                <!-- BEGIN PAGE BASE CONTENT -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box">
                            <div class="portlet-body form">
                               
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">Vendor Name</label>
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblpmpmls" runat="server" CssClass="lbtxt" Visible="false"></asp:Label>
                                                    <asp:TextBox ID="txtvendor" class="form-control input-sm" placeholder="Vendor Name" onblur="chkvendorname()" runat="server" Width="216px">
                                                    </asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                 
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Type</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList ID="drpType" class="form-control input-sm" runat="server">
                                                    <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-md-2 control-label">PO Type</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList ID="drbPoType" class="form-control input-sm" runat="server">
                                                    <asp:ListItem Text="RC" Value="RC"></asp:ListItem>
                                                    <asp:ListItem Text="T&C" Value="T"></asp:ListItem>
                                                    <asp:ListItem Text="SP" Value="SP"></asp:ListItem>
                                                    <asp:ListItem Text="STN" Value="STN"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">PO No</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="txtPONo" class="form-control input-sm" placeholder="PO No" runat="server"></asp:TextBox>

                                            </div>
                                            <label class="col-md-2 control-label">PO Year</label>
                                            <div class="col-md-3">
                                                Po Year :
                    <BDP:BDPLite ID="bdppodate" Visible="false" runat="server">
                    </BDP:BDPLite>
                                                <asp:DropDownList class="form-control input-sm" ID="ddlfinancecalendar" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Print Type</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList class="form-control input-sm" ID="ddlprint" runat="server">
                                                    <asp:ListItem Text="RECORD(Purchase Section Copy)"></asp:ListItem>
                                                    <asp:ListItem Text="ORIGINAL"></asp:ListItem>
                                                    <asp:ListItem Text="A. S. R. T. U Copy"></asp:ListItem>
                                                    <asp:ListItem Text="TRIPLICATE(Receipt Cell Copy)"></asp:ListItem>
                                                    <asp:ListItem Text="DUPLICATE(Audit Section Copy)"></asp:ListItem>
                                                    <asp:ListItem Text="OFFICE COPY1"></asp:ListItem>
                                                    <asp:ListItem Text="OFFICE COPY2"></asp:ListItem>
                                                    <asp:ListItem Text="EXTRA COPY"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-md-2 control-label">Print Type</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList class="form-control input-sm" ID="ddlprinttype" runat="server">
                                                    <asp:ListItem Text="front"></asp:ListItem>
                                                    <asp:ListItem Text="back"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row text-center">
                                        <div class="right1">
                                            <asp:Button ID="btn_showpo" class="btn" runat="server" Text="Show" Height="26px" />
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row text-center">
                                        <div class="form-actions right1">
                                            <asp:Button ID="Button3" class="btn" runat="server" Width="87px" OnClientClick="printpage();"
                                                Text="Print"></asp:Button>
                                            <asp:Button ID="Button4" class="btn" runat="server" Text="Close" Width="87px" />
                                        </div>
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
      
    <script>
        $(document).ready(function () { 
            var data = [<% =strvendor  %>];
            $("#txtvendor").autocomplete(
                
		{
		    source: data,
		    minLength: 2
		   
		}
	);
        });
    </script>
  
</asp:Content>
