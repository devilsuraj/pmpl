<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="claimreceive.aspx.vb" Inherits="KDMT.claimreceive" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">


        function checkqty(id, claimqty) {
            if (document.getElementById(id).value > claimqty) {
                alert('Should be less than Pending Qty')
                document.getElementById(id).focus();
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
            return true;
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
                        document.getElementById("txtvendor").focus();
                    }
                    else {


                    }
                }
            }
            if (document.getElementById("txtvendor").value != '') {
                xmlHttp.open("GET", "Ajaxstore.aspx?Action=chkvendorname&vendorname=" + document.getElementById("txtvendor").value, true);
                xmlHttp.send(null);
            }
        }

        function validate() {
            if (document.getElementById("txtvendor").value == '') {
                alert('Please Enter Vendor Name');
                document.getElementById("txtvendor").focus();
                return false;
            }
            if (document.getElementById("txtchalan").value == '') {
                alert('Please Enter Challan No');
                document.getElementById("txtchalan").focus();
                return false;
            }

            var grdvat = document.getElementById('<%= dgresult.clientID %>');
        var i = 0;
        var j = 0
        var value = 0;
        var vcount = grdvat.rows.length;

        for (i; i < vcount - 1; i++) {
            var rowel = grdvat.rows[i];
            //grddetail__ctl2_ + ''
            j = i + 2
            var id = 'dgresult__ctl' + j + '_txtclaimrejqty'
            var claimqty = document.getElementById(id);
            if (claimqty.value != '') {
                value = 1
            }
        }

        if (value == '0') {
            alert('Please Enter Claim Qty ');
            document.getElementById('dgresult__ctl2_txtclaimrejqty').focus();
            return false;
        }


        return true;
    }
    </script>


    <title>Claim Register</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script src="popcalendar.js"></script>

    <link href="popcalendar.css" rel="stylesheet" type="text/css" />
    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Claim Receive</h1>
    </div>
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <div align="center">

        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnPOtype" runat="server" type="hidden" name="hdnPOtype" />
        <input id="hdnPoNo" runat="server" type="hidden" name="hdnPoNo" />
        <input id="hdndetail" runat="server" type="hidden" name="hdndetail" />
        <input id="hdnPoDate" runat="server" type="hidden" name="hdnPoDate" />
        <div id="middal">

            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table id="Table1" align="left" width="100%" cellpadding="0" cellspacing="0" runat="server">
                        <tbody>

                            <tr>
                                <td>
                                    <div style="text-align: left">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td></td>
                                                    <td align="left">
                                                        <asp:Label ID="lblType" runat="server" Text="" ForeColor="REd"></asp:Label>
                                                        <asp:RadioButtonList ID="radparttype" AutoPostBack="true" RepeatDirection="Horizontal"
                                                            runat="server">
                                                            <asp:ListItem Text="Shortage" Selected="True" Value="0"> </asp:ListItem>
                                                            <asp:ListItem Text="Reject" Value="1"> </asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table id="tblmain" runat="server">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label2" runat="server" Text="  Vendor Name"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtvendor" onblur="chkvendorname();" Style="width: 220px" class="textfield"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Challan No
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtchalan" runat="server" class="textfield"></asp:TextBox>
                                                </td>
                                                <td align="right">Challan Date
                                                </td>
                                                <td align="left">

                                                    <asp:TextBox ID="BDPLite2" Width="100px" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="BDPLite2"
                                                        PopupButtonID="BDPLite2" Format="dd-MMM-yyyy">
                                                    </asp:CalendarExtender>
                                                    <asp:ScriptManager ID="Scriptmanager2" runat="server">
                                                    </asp:ScriptManager>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Rec No
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtRecNo" ForeColor="red" ReadOnly="true" runat="server" class="textfield"></asp:TextBox>
                                                </td>
                                                <td align="right">Rec Date
                                                </td>
                                                <td align="left">

                                                    <asp:TextBox ID="bdpRecDate" Width="100px" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="bdpRecDate"
                                                        PopupButtonID="bdpRecDate" Format="dd-MMM-yyyy">
                                                    </asp:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td align="left">
                                                    <asp:Button ID="btnshow" runat="server" Text="Show" Height="26px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <asp:DataGrid ID="dgresult" Width="100%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                                        HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                                        runat="server" AutoGenerateColumns="False" ItemStyle-CssClass="gridtxt">
                                                        <Columns>
                                                            <asp:TemplateColumn HeaderText="Sr No">
                                                                <ItemTemplate>
                                                                    <%#Container.ItemIndex + 1%>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:BoundColumn Visible="false" DataField="claimid"></asp:BoundColumn>
                                                            <asp:BoundColumn Visible="false" DataField="item_code"></asp:BoundColumn>
                                                            <asp:BoundColumn Visible="false" DataField="pen_qty"></asp:BoundColumn>
                                                            <asp:BoundColumn Visible="false" DataField="po_detail_id"></asp:BoundColumn>
                                                            <asp:BoundColumn Visible="false" DataField="po_date"></asp:BoundColumn>
                                                            <asp:BoundColumn Visible="false" DataField="po_type"></asp:BoundColumn>
                                                            <asp:BoundColumn Visible="false" DataField="po_no"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="vendor_name" HeaderText="Vendor Name" ItemStyle-Width="150px"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="PO" HeaderText="PO NO"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="claimdate" HeaderText="claim Date"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="part_no" HeaderText="Part No"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="recqty" HeaderText="Rec Qty"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="Avaibleqty" HeaderText="Actual Qty"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="claimqty" HeaderText="Claim Qty"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="penqty" HeaderText="Pen Qty"></asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Claim Rec Qty">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID='txtclaimrejqty' Width='80px' runat="server"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                    </asp:DataGrid>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnsubmit" runat="server" Visible="false" Text="Submit" Height="26px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">


        $("#txtvendor").autocomplete(
                {
                    source: [<% =strVendor  %>]
		}
	);

/*

var txtSecDate = document.getElementById('BDPLite1_TextBox');
    txtSecDate.readOnly = true;   
var txtChlnDate = document.getElementById('BDPLite2_TextBox');
    txtChlnDate.readOnly = true;
var txtBillDate = document.getElementById('bdpbilldate_TextBox');
    txtBillDate.readOnly = true;
var txtRecDate = document.getElementById('bdpRecDate_TextBox');
    txtRecDate.readOnly = true;     
*/
    </script>

</asp:Content>
