
<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="repairItemGatepassIn.aspx.vb" Inherits="KDMT.repairItemGatepassIn" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">



<script language="javascript">



    var ex = /^[0-9]+\.?[0-9]*$/;

    function checkqty(id, claimqty, reqqty) {

        if (document.getElementById(id).value != '') {
            if (ex.test(document.getElementById(id).value) == false) {
                alert('please Enter numbers Only.');
                document.getElementById(id).focus();
                return false;
            }

            if (parseFloat(document.getElementById(id).value) > parseFloat(claimqty)) {
                alert('Should be less than Balance Qty')
                document.getElementById(id).focus();
                return false;
            }
//            if (parseFloat(document.getElementById(id).value) > parseFloat(reqqty)) {
//                alert('Should be less than Request Qty')
//                document.getElementById(id).focus();
//                return false;
//            }

            if (parseFloat(document.getElementById(id).value) == 0) {
                alert('Qty can not be zero')
                document.getElementById(id).focus();
                return false;
            }

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


    function validate() {

        if (document.getElementById("txtinchallannno").value.length == '') {
            alert("Enter Challan No");
            document.getElementById("txtinchallannno").focus();
            return false;
        }


        var rowCount = document.getElementById("dgresult").rows.length;
        var i = 1;
        var j = 0;
        for (i = 2; i <= rowCount; i++) {
            var id = 'dgresult__ctl' + i + '_txtqty'

            if (IsNumeric(document.getElementById(id).value) == false) {

                alert("Enter Proper Value");
                document.getElementById(id).focus();
                return false;
            }

        }


        if (!confirm("Do you want to Save")) {
            return (false);
        }

    }
        
    

</script>

<link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>GATEPASS IN</h1>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="form-horizontal">
    
        <div id="middal">
         
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table>
                        <tr style="height: 30px">
                            <td align="left">
                                <span><b>GATE PASS RETURN ITEM</b></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 21px;" colspan="2">
                                GatePass No :-
                                <asp:TextBox ID="txtoutchallanno" runat="server" BackColor="#FFFFC0" Width="96px"
                                    ToolTip="Enter Challan No"></asp:TextBox>
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                    </table>
                    <table id="trgrid" runat="server">
                        <tr>
                            <td align="left">
                                Challan No :-
                                <asp:TextBox ID="txtinchallannno" runat="server" BackColor="#FFFFC0" Width="96px"
                                    ToolTip="Enter Challan No"></asp:TextBox>
                            </td>
                            <td align="left">
                                Received Date :-
                            
                                    <asp:TextBox ID="BDPrecdate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPrecdate"
                                        PopupButtonID="BDPrecdate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server">
                            <td colspan="2">
                                <asp:DataGrid ID="dgresult" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                    runat="server" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:BoundColumn DataField="gatepassdetid" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="RepairWorkId" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="itemid" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="serialno" HeaderText="Serial No"></asp:BoundColumn>
                                         <asp:BoundColumn DataField="qty" HeaderText="Actual Qty"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="BalQty" HeaderText="Balance Qty "></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Received qty">
                                         <ItemTemplate>
                                          <asp:TextBox ID="txtqty" MaxLength="6" runat="server" Text='0' Width="50px"></asp:TextBox>
                                          </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Reason">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddlResult" runat="server">
                                                                        <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Text="Repaired" Value="2"></asp:ListItem>
                                                                        <asp:ListItem Text="Not Repaired" Value="3"></asp:ListItem>
                                                                      
                                                                     </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Remark">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" MaxLength="200" Width="100px"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Done">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkselect" runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:BoundColumn DataField="RepairRecId" Visible="false"></asp:BoundColumn>
                                    </Columns>
                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr id="trbtn" runat="server" style="height: 100px">
                            <td style="height: 22px">
                                <div align="center">
                                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton><asp:ImageButton
                                        ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="1"></asp:ImageButton></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="orgbottam1">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
