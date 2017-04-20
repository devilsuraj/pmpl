<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Remoldreceive.aspx.vb" Inherits="KDMT.Remoldreceive" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Repair Challan Outward</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<script language="javascript" src="../Scripts/LogSheet_repairoutward.js"></script>--%>

    <script>

        function validate() {

            if (document.getElementById("txtinchallannno").value == '') {
                alert('Please Enter Challan No');
                document.getElementById("txtinchallannno").focus();
                return false;
            }
 


            var rowCount = document.getElementById("dgresult").rows.length;
            var i = 1;
            var j = 0;
            for (i = 2; i <= rowCount; i++) {
                var id = 'dgresult__ctl' + i + '_chkselect'

                if (document.getElementById(id).checked == true) {
                    j = j + 1;

                }
            }

            if (j == 0) {
                alert('Please Tick The boxes if You have received Remold Tyres')
                return false
            }

            if (!confirm("Do you Received " + j + " Tyres")) {
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

        function checkyear(objyear) {
            if (objyear.value.length > 0) {

                if (IsNumeric(objyear.value) == true) {

                }
                else {

                    alert("Enter Proper Value");
                    objyear.focus();
                    return false;
                }
                if (objyear.value.length != 4) {
                    alert("Enter Proper Value");
                    objyear.focus();
                    return false;
                }

            }

        }
        
    </script>

    <style type="text/css">
        #tblmain
        {
            width: 809px;
        }
        #Table1
        {
            width: 89%;
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
                                    <span id="Label3">REMOLD RECEIVE</span>
                                    <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblmsg" ForeColor="REd" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="text-align: left">
                                        <table id="tblmain" runat="server" visible="false">
                                            <tbody>
                                                <tr>
                                                    <td align="left">
                                                        Challan No :-
                                                        <asp:TextBox ID="txtinchallannno" MaxLength ='20' runat="server" BackColor="#FFFFC0" Width="96px"
                                                            ToolTip="Enter Challan No"></asp:TextBox>
                                                        Received Date :-
                                                        <BDP:BDPLite ID="BDPrecdate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="text-align: center">
                                                            <tr>
                                                                <asp:DataGrid ID="dgresult" Width="70%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                                                    runat="server" AutoGenerateColumns="False">
                                                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                                                    <Columns>
                                                                        <asp:TemplateColumn HeaderText="Sr No.">
                                                                            <ItemTemplate>
                                                                                <%#Container.ItemIndex + 1%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:BoundColumn DataField="Part_ID" Visible="false"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="part_size" HeaderText="Part Size"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Part_Company_No" HeaderText="Part Company No"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Part_WS_No" HeaderText="Workshop No"></asp:BoundColumn>
                                                                        <asp:BoundColumn DataField="Part_Company" HeaderText="Company Name"></asp:BoundColumn>
                                                                          <asp:TemplateColumn HeaderText="Status">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                                                 <asp:ListItem Text="Repaired" Value="4"></asp:ListItem>
                                                                                <asp:ListItem Text="Reject" Value="1"></asp:ListItem>
                                                                               <asp:ListItem Text="F.O.C" Value="2"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn HeaderText="Remark">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="150px"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn HeaderText="DONE">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkselect" runat="server" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                    </Columns>
                                                                </asp:DataGrid></tr>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" style="height: 50px">
                                                        <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                                border="0" Width="87" Height="38" AlternateText="Save" />
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
    <script type="text/javascript">

        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", { imgRight: "SpryAssets/SpryMenuBarRightHover.gif" });


    </script>
</body>
</html>
