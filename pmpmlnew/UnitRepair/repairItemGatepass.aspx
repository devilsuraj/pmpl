<%@ Page Language="VB" AutoEventWireup="false" CodeFile="repairItemGatepass.aspx.vb" Inherits="KDMT.repairItemGatepass" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Repair Item Gatepass</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<script language="javascript" src="../Scripts/LogSheet_repairoutward.js"></script>--%>

    <script>

        function validate() {

//            if (document.getElementById("nmmtdept").selectedIndex == 0) {
//                alert('Please Select Dept');
//                document.getElementById("nmmtdept").focus()
//                return false;
//            }
//            if (document.getElementById("ddltoloc").selectedIndex == 0) {
//                alert('Please Select location');
//                document.getElementById("ddltoloc").focus()
//                return false;
//            }
//            if (document.getElementById("ddlgatepasstype").selectedIndex == 0) {
//                alert('Please Select Gatepass Type');
//                document.getElementById("ddlgatepasstype").focus()
//                return false;
//            }
//            if (document.getElementById("ddltoloc").selectedIndex == 2) {
//                if (document.getElementById("txtvendor").value == "") {
//                    alert('Please Enter Vendor name');
//                    document.getElementById("txtvendor").focus()
//                    return false;
//                }
//            }
            
            document.getElementById('lblerrormsg').innerHTML = ''
            var rowCount = document.getElementById("dgresult").rows.length;
            var i = 1;
            var j = 0;
            for (i = 2; i <= rowCount; i++) {
                var id = 'dgresult__ctl' + i + '_chkselect'
//                var ddlhotcold = 'dgresult__ctl' + i + '_ddlhotcold'
//                var ddlplaintype = 'dgresult__ctl' + i + '_ddlptype'
//                var txtmfgyear = 'dgresult__ctl' + i + '_txtmfgyear'
                if (document.getElementById(id).checked == true) {
                    j = j + 1;
//                    if (document.getElementById(txtmfgyear).value == 0) {
//                        document.getElementById('lblerrormsg').innerHTML = 'Please Enter Mfg Year'
//                        document.getElementById(txtmfgyear).focus();
//                        return false;
//                    }
//                    if (document.getElementById(ddlplaintype).value == 0) {
//                        document.getElementById('lblerrormsg').innerHTML = 'Please Select Plain Type'
//                        document.getElementById(ddlplaintype).focus();
//                        return false;
//                    }
//                    if (document.getElementById(ddlhotcold).value == 0) {
//                        document.getElementById('lblerrormsg').innerHTML = 'Please Select Process Type'
//                        document.getElementById(ddlhotcold).focus();
//                        return false;
//                    }
                }
            }

            if (j == 0) {
                alert('Please Tick The boxes if You want to make a gatepass')
                return false
            }

            if (!confirm("Do you want to make a Gatepass for " + j + "Repair Items")) {
                return (false);
            }

        }




        function IsNumeric(strString) {
            var ValidChars = "0123456789";
            var Char;
            for (i = 0; i < strString.length; i++) {

                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }

//        function checkyear(objyear) {
//            if (objyear.value.length > 0) {

//                if (IsNumeric(objyear.value) == true) {

//                }
//                else {

//                    alert("Enter Proper Value");
//                    objyear.focus();
//                    return false;
//                }
//                if (objyear.value.length != 4) {
//                    alert("Enter Proper Value");
//                    objyear.focus();
//                    return false;
//                }

//            }

//        }
        
    </script>

    <style type="text/css">
        .style1
        {
            height: 25px;
            width: 191px;
        }
        #tblmain
        {
            width: 809px;
        }
        .style2
        {
            width: 50px;
        }
        .style3
        {
            width: 133px;
        }
        #Table1
        {
            width: 89%;
        }
        .style20
        {
            width: 106px;
        }
        .style21
        {
            height: 27px;
        }
    </style>
</head>
<body onload="MM_preloadImages('../images/btn_h.gif')">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <form id="Form1" runat="server">
    <asp:HiddenField ID="hdndepttype" runat="server" />
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassno" runat="server" type="hidden" name="hdngatepassno" />
    <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassid" runat="server" type="hidden" name="hdngatepassid" />
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table id="Table1" cellpadding="0" cellspacing="0" runat="server" align="center"
                        width="100%">
                        <tbody>
                            <tr style="height: 50px">
                                <td class="innerheading">
                                    <span id="Label3">REPAIR ITEM GATEPASS OUT</span>
                                    <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                   <asp:Button ID="print" Text="print" runat="server" Visible="false" />
                                    <asp:RadioButtonList RepeatDirection="Horizontal" ID="radtype" runat="server" AutoPostBack="True">
                                        <asp:ListItem Value="0">create gatepass</asp:ListItem>
                                        <asp:ListItem Value="1">update security info</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="text-align: left">
                                        <table id="tblmain" visible="false" runat="server">
                                            <tbody>
                                                <tr visible="false">
                                                    <td align="right">
                                                        Nmmt Challan
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtnmmtchalan" onblur="checkchallan()" MaxLength="5" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        From Dept :
                                                    </td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="nmmtdept" runat="server" AutoPostBack="true">
                                                        <asp:ListItem Text="Repair" Value="11"></asp:ListItem>
                                                        </asp:DropDownList>
                                                      
                                                    </td>
                                                    <td align="right">
                                                        Challan Date :
                                                    </td>
                                                    <td align="left">
                                                        <%-- <asp:Label ID="BDPLite1" runat="server" Text=""></asp:Label>--%><BDP:BDPLite
                                                            ID="BDPLite1" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td class="style20">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Gatepass No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtchallanno" runat="server" class="textfield" ReadOnly="True"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        To Place :
                                                    </td>
                                                    <td align="left" style="margin-left: 40px">
                                                           <asp:DropDownList ID="ddltoloc" runat="server" AutoPostBack="true">
                                                            <%--<asp:ListItem Text="Select" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="Nmmt Location" Value="0"></asp:ListItem>--%>
                                                            <asp:ListItem Text="Vendor" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="ddlgatepasstype" runat="server">
                                                        <asp:ListItem Text="Repairing Material" Value="3"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="tdven" runat="server">
                                                        Vendor
                                                    </td>
                                                    <td align="left" id="tdvendor" runat="server">
                                                        <asp:TextBox ID="txtvendor" MaxLength="100" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                               <%-- <tr>
                                                    <td align="right" class="style21">
                                                        Indent No
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtreq" MaxLength="50" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Req Date
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <BDP:BDPLite ID="BDPreqdate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td align="right" class="style21">
                                                        Authorised Person :
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtauthperson" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Designation :
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtaudesign" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Id No :
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtauid" MaxLength="5" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Vechicle No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbusno" MaxLength="12" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                    <td align="right">
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        Driver Name :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtissuename" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Designation :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtissuedesig" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Id No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtissueid" MaxLength="5" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style21">
                                                        Note :
                                                    </td>
                                                    <td align="left" class="style21" colspan="2">
                                                        <asp:TextBox ID="txtnote" MaxLength="250" Width="300" Height="30" TextMode="MultiLine"
                                                            runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="lblerrormsg" Font-Bold="true" ForeColor='Red' runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trother" runat="server" visible="True">
                                                    <td style="height: 7px" colspan="9" align="center">
                                                        <table id="tblother" width="100%" border="1" cellpadding="2" cellspacing="2">
                                                            <tbody runat="server" id="tbodyother">
                                                                <tr class="gridhead">
                                                                    <td>
                                                                        Part No
                                                                    </td>
                                                                    <td>
                                                                        Item
                                                                    </td>
                                                                    <td>
                                                                        Qty
                                                                    </td>
                                                                    <td>
                                                                        Unit
                                                                    </td>
                                                                    <td>
                                                                        Remark
                                                                    </td>
                                                                   <%-- <td>
                                                                        Is Return
                                                                    </td>--%>
                                                                </tr>
                                                                <tr class="gridtxt">
                                                                    <td align="left" style="width: 100px; height: 28px;">
                                                                        <asp:TextBox ID="txtPartNo" MaxLength="100" Width="300px" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left" style="width: 100px; height: 28px;">
                                                                        <asp:TextBox ID="txtitem1" MaxLength="100" Width="300px" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtqty1" MaxLength="3" onblur="chkqty();" runat="server" Width="165px"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlunit1" runat="server">
                                                                            <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="Ltr" Value="Ltr"></asp:ListItem>
                                                                            <asp:ListItem Text="Kg" Value="Kg"></asp:ListItem>
                                                                            <asp:ListItem Text="Nos" Value="Nos"></asp:ListItem>
                                                                            <asp:ListItem Text="Mtr" Value="Mtr"></asp:ListItem>
                                                                            <asp:ListItem Text="Roll" Value="Roll"></asp:ListItem>
                                                                            <asp:ListItem Text="Set" Value="Set"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtremark1" MaxLength="250" runat="server" EnableTheming="True"></asp:TextBox>
                                                                    </td>
                                                                    <%--<td align="left">
                                                                        <asp:CheckBox ID="chkreturn1" runat="server" Width="20px"></asp:CheckBox>
                                                                    </td>--%>
                                                                    <td>
                                                                        <asp:Button ID="btnadd" runat="server" Text="ADD" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <div style="text-align: center">
                                                         
                                                                <asp:DataGrid ID="dgresult" Width="75%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                                                    runat="server" AutoGenerateColumns="False" >
                                                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                                                    <Columns>
                                                                        <asp:BoundColumn DataField="RepairWorkId" Visible="false"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Itemid" Visible="false"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="serialNo" HeaderText="Serial No"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Qty" HeaderText="ACT Qty"></asp:BoundColumn>
                                                                         <asp:TemplateColumn HeaderText="Qty">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtqty" runat="server"  MaxLength="4" Width="30px"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                             <asp:TemplateColumn HeaderText="Unit">
                                                                            <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlunit2" runat="server">
                                                                            <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="Ltr" Value="Ltr"></asp:ListItem>
                                                                            <asp:ListItem Text="Kg" Value="Kg"></asp:ListItem>
                                                                            <asp:ListItem Text="Nos" Value="Nos"></asp:ListItem>
                                                                            <asp:ListItem Text="Mtr" Value="Mtr"></asp:ListItem>
                                                                            <asp:ListItem Text="Roll" Value="Roll"></asp:ListItem>
                                                                            <asp:ListItem Text="Set" Value="Set"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                  </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn HeaderText="Remark">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="150px"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn HeaderText="Select">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkselect" runat="server" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:BoundColumn DataField="RepairRecDtlId" Visible="false"></asp:BoundColumn>
                                                                    </Columns>
                                                                </asp:DataGrid>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="6" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                                border="0" Width="87" Height="38" AlternateText="Save" />
                                                        </a><a class="canceltxt" href="#">Cancel</a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table id="tblsecurity" runat="server" visible="false">
                                            <tbody>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Challan No :
                                                    </td>
                                                    <td align="left" colspan="5">
                                                        <asp:TextBox ID="txtoutchallanno" runat="server" class="textfield" AutoPostBack="True"></asp:TextBox>
                                                        <asp:Label ID="lblmsg" Text="" ForeColor="red" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Security (Depot) :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtsecname" ReadOnly="true" Text="Turbhe,Depot" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                    </td>
                                                    <td align="left" class="style1">
                                                    </td>
                                                    <td align="right" class="style2">
                                                        Date :
                                                    </td>
                                                    <td align="left">
                                                        <BDP:BDPLite ID="secdate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Gate No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtgateno" MaxLength="1" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                    </td>
                                                    <td align="left" class="style1">
                                                    </td>
                                                    <td align="right" class="style2">
                                                        Time :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txttime" MaxLength="5" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style3">
                                                        Checked By :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtcheckedby" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px">
                                                        Designation :
                                                    </td>
                                                    <td align="left" class="style1">
                                                        <asp:TextBox ID="txtdesig" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style2">
                                                        Id No :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtsecid" MaxLength="5" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="7" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="ImageButtonupdate" runat="server" ImageUrl="../images/btn_h.gif"
                                                                align="absmiddle" border="0" Width="87" Height="38" AlternateText="Update" />
                                                        </a><a class="canceltxt" href="#">Cancel</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" align="center">
                                                        <asp:GridView ID="gvgatepass" runat="server" AutoGenerateColumns="False" Width="80%">
                                                            <Columns>
                                                                <asp:BoundField DataField="item_name" HeaderText="particulars" ItemStyle-HorizontalAlign="Left" />
                                                                <asp:BoundField DataField="qty" HeaderText="Qty" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="orgbottam1">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
