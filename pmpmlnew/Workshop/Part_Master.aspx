<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Part_Master.aspx.vb" Inherits="KDMT.Part_Master" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Part Master</title>
    <script language="javascript" type="text/javascript">

        var Optype = 0
        var Fuel
        var ID = 0;

        function DeleteUnitConfirm() {
            if (confirm("Are you sure you wan`t to delete.")) { return true }
            else { return false }
        }


        function getPart() {

            var PartType = document.getElementById('ddlPartType').value;

            var url = "../tmtAjax/Common_ajax.aspx?action=getPartMaster&PartType=" + PartType;
            ajaxFunction();
            sendRequest(url);
            return false;
        }

        function DeletePart(ID) {
            if (Optype == 1) {
                alert('Please quit editing mode for deleting.');
                return false;
            }
            if (DeleteUnitConfirm() == true) {
                Optype = 2;
                var url = "../tmtAjax/Master_ajax.aspx?action=PartMaster&Id=" + ID + "&Optype=" + Optype;
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

        function editPart(id) {

            var ddlPartType = document.getElementById('ddlPartType');
            ddlSelection(document.getElementById('tdPartType_' + id).innerHTML, ddlPartType)
            var drptype = document.getElementById('drptype');
            ddlSelection(document.getElementById('tdBType_' + id).innerHTML, drptype)
            document.getElementById('txtbusno').value = document.getElementById('tdBusNo_' + id).innerHTML;
            document.getElementById('txtPartCompNo').value = document.getElementById('tdPartCompNo_' + id).innerHTML;
            document.getElementById('txtPartComp').value = document.getElementById('tdPartComp_' + id).innerHTML;
            document.getElementById('txtPartWSNo').value = document.getElementById('tdPartWSNo_' + id).innerHTML;
            document.getElementById('txtPartSize').value = document.getElementById('tdPartSize_' + id).innerHTML;
            document.getElementById('dtCompDate_TextBox').value = document.getElementById('tdPartCompDate_' + id).innerHTML;
            document.getElementById('dtWSDate_TextBox').value = document.getElementById('tdPartWSDate_' + id).innerHTML;
            document.getElementById('hdnID').value = id
            Optype = 1;
        }

        function ValidateSave() {

            //        var BusNo = document.getElementById('txtBusNo');        
            //        if (BusNo.value == ''){
            //            alert('Bus No. should not be empty')
            //            BusNo.focus();
            //            return false;
            //        }

            var PartType = document.getElementById('ddlPartType').value;
            var PartCompNo = document.getElementById('txtPartCompNo').value;
            var PartComp = document.getElementById('txtPartComp').value;
            var PartWSNo = document.getElementById('txtPartWSNo').value;
            var PartSize = document.getElementById('txtPartSize').value;
            var CompDate = document.getElementById('dtCompDate_TextBox').value;
            var WSDate = document.getElementById('dtWSDate_TextBox').value;
            var Busno = document.getElementById('txtbusno').value;
            var Type = document.getElementById('drptype').value;

            if (document.getElementById('hdnID').value != '') { ID = document.getElementById('hdnID').value }

            if (PartCompNo != '' || PartWSNo != '') {
                if (Optype == 0) {
                    var url = "../tmtAjax/Master_ajax.aspx?action=PartMaster&Id=" + ID + "&PartType=" + PartType + "&PartCompanyNo=" + PartCompNo + "&PartCompany=" + PartComp + "&PartWSNo=" + PartWSNo + "&PartSize=" + PartSize + "&CompDate=" + CompDate + "&WSDate=" + WSDate + "&Optype=" + Optype + "&Busno=" + Busno + "&Type=" + Type;
                }
                else {
                    var url = "../tmtAjax/Master_ajax.aspx?action=PartMaster&Id=" + ID + "&PartType=" + PartType + "&PartCompanyNo=" + PartCompNo + "&PartCompany=" + PartComp + "&PartWSNo=" + PartWSNo + "&PartSize=" + PartSize + "&CompDate=" + CompDate + "&WSDate=" + WSDate + "&Optype=" + Optype + "&Busno=" + Busno + "&Type=" + Type;
                }
            }
            sendRequest(url);
            Clean();


        }

        function Clean() {
            var dt = new Date();
            var month = dt.getMonth();
            var currentDate = dt.getDate() + "-" + month + "-" + dt.getFullYear();
            var ddlPartType = document.getElementById('ddlPartType');
            var txtPartCompNo = document.getElementById('txtPartCompNo');
            var txtPartComp = document.getElementById('txtPartComp');
            var txtPartWSNo = document.getElementById('txtPartWSNo');
            var txtPartSize = document.getElementById('txtPartSize');
            var dtCompDate = document.getElementById('dtCompDate_TextBox');
            var dtWSDate = document.getElementById('dtWSDate_TextBox');

            var ddlBType = document.getElementById('drptype');
            var txtBusNo = document.getElementById('txtbusno');

            //        ddlPartType.selectedIndex = 0;        
            txtPartCompNo.value = '';
            txtPartComp.value = '';
            txtPartWSNo.value = '';
            txtPartSize.value = '';
            ddlBType.selectedIndex = 0;
            txtBusNo.value = '';

            //        dtRTODate.value = currentDate;
            //        dtFitRenewalDate.value = currentDate;
            //        dtDepoDate.value = currentDate;
            //        dtPutDate.value = currentDate;

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
                if (resp.indexOf('PassPartSearch') != -1) {
                    document.getElementById('dvPartMaster').innerHTML = resp.substring(14);
                    return false;
                }
                else if (resp.indexOf('OptFail') != -1) {
                    alert('Error Occur While Operation.');
                    return false;
                }
                else if (resp.indexOf('Add') != -1) {
                    alert('Data Added Successfully.');
                    getPart();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Edit') != -1) {
                    alert('Data Updated Successfully.');
                    getPart();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Duplicate') != -1) {
                    alert('Part No. is already exist.');
                    getPart();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Delete') != -1) {
                    alert('Data Deleted Successfully.');
                    getPart();
                    return false;
                }

            }
        }
        function btnSave_onclick() {

        }

    </script>
    <style type="text/css">
        .style1
        {
            height: 14px;
        }
    </style>
</head>
<body onload="return getPart();">
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
                            <span id="Label3">Part Register Master</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlPartType" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            Bus No
                        </td>
                        <td>
                            <input id="txtbusno" runat="server" type="text" name="textfield" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part Company No.
                        </td>
                        <td>
                            <input id="txtPartCompNo" runat="server" type="text" name="textfield" />
                        </td>
                        <td align="right">
                            Part Company
                        </td>
                        <td>
                            <input id="txtPartComp" runat="server" type="text" name="textfield" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part W/S No.
                        </td>
                        <td>
                            <input id="txtPartWSNo" runat="server" type="text" name="textfield" />
                        </td>
                        <td align="right">
                            Part Size
                        </td>
                        <td>
                            <input id="txtPartSize" runat="server" type="text" name="textfield" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part Company Date
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtCompDate" TextBoxStyle-Width="100px" runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
                        </td>
                        <td align="right">
                            Part W/S Date
                        </td>
                        <td>
                            <BDP:BDPLite TextBoxStyle-Width="100px" ID="dtWSDate" runat="server">
                            </BDP:BDPLite>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="drptype" AutoPostBack="False">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">Dry</asp:ListItem>
                                <asp:ListItem Value="2">Liquid</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                       <td>Remark</td>
                       <td><asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine"  height="50px" class="textfield"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4" class="style1">
                            <label>
                                <input name="Save" type="button" id="btnSave" value="Save" onclick="ValidateSave(); getPart();"
                                    onclick="return btnSave_onclick()" />
                            </label>
                            <a href="Part_Master.aspx">Reset</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="dvPartMaster" class="task-al-box" style="width: 100%">
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
    </form>
    <script type="text/javascript">

        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", { imgRight: "SpryAssets/SpryMenuBarRightHover.gif" });


    </script>
</body>
</html>
