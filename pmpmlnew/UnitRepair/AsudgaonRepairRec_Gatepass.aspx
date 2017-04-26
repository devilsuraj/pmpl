
<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="AsudgaonRepairRec_Gatepass.aspx.vb" Inherits="KDMT.AsudgaonRepairRec_Gatepass" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    
    <script src="../scripts/jquery-1.11.0.min.js"></script>
    <script src="../scripts/jquery-ui.js"></script>

    <title>GATEPASS OUT</title>
    

     <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

 

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<script language="javascript" src="../Scripts/LogSheet_repairoutward.js"></script>--%>
    <script language="javascript">


        function IsNumeric(strString) {
      
            var ValidChars = "123456789";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return true;
                }
            }

            return false;
        }


        function chkqty() {
    
        if(document.getElementById("txtqty1").value=="")
        {
        alert("Please Enter Qty");
        document.getElementById("txtqty1").focus();
                            return false;
                  }  
        if (document.getElementById("txtqty1").value.length >= 0) {
     
            if (IsNumeric(document.getElementById("txtqty1").value) == true) {
                    alert("Enter Proper Value");
                    document.getElementById("txtqty1").focus();
                    return false;
                }
            }
        }




        function chkSerialNo()
        
         {
     
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
                    var ele1 = resp;

                    if (ele1 == "Item With Serial") {

                        if (document.getElementById("txtPartNo").value == "") {

                            alert("Please enter valid Serail No");
                            document.getElementById("txtPartNo").focus();
                            return false;
                        }
                    }
                }
            }
            if (document.getElementById("txtitem1").value != '') {

                xmlHttp.open("GET", "Ajaxstore.aspx?Action=chkItemSerial&itemname=" + document.getElementById("txtitem1").value, true);
                xmlHttp.send(null);
            }

        }

//        function qty
//        {
//        if(document.getElementById("txtqty1")=="")
//        {
//        alert("Please Enter Qty");
//        document.getElementById("txtqty1").focus();
//                            return false;
//                  }          
//        }
                
    </script>
    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Other Depot Gatepass IN</h1>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <div class="form-horizontal">
    <asp:HiddenField ID="hdndepttype" runat="server" />
    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdngatepassno" runat="server" type="hidden" name="hdngatepassno" />
    <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdnIsChecked" runat="server" type="hidden" name="hdnrwcnt" value="1" />
    <input id="hdngatepassid" runat="server" type="hidden" name="hdngatepassid" />
    <div align="center">
     
        <div id="middal">
           
            <div class="contantbox">
                <div class="orgtop1">
                </div>
                <div class="orgmiddal1">
                    <table id="Table1" cellpadding="0" cellspacing="0" runat="server" align="center"
                        width="100%">
                        <tbody>
                          
                                
                           
                            <tr>
                                <td align="left">
                                        <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                                    <asp:Button ID="print" Text="print" runat="server" />
                                   <%-- <asp:RadioButtonList RepeatDirection="Horizontal" ID="radtype" runat="server" AutoPostBack="True">
                                        <asp:ListItem Value="0">create gatepass</asp:ListItem>
                                        <asp:ListItem Value="1">update security info</asp:ListItem>
                                    </asp:RadioButtonList>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="text-align: left">
                                        <table id="tblmain"  runat="server">
                                            <tbody>
                                                <tr>
                                                    <td align="right">
                                                        &nbsp;</td>
                                                    <td align="left">
                                                        &nbsp;</td>
                                                    <td align="right">
                                                        &nbsp;</td>
                                                    <td align="left">
                                                        &nbsp;</td>
                                                    <td>
                                                    </td>
                                                    <td class="style20">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    
                                                    <td align="right">
                                                        From Place :
                                                    </td>
                                                    <td align="left" style="margin-left: 40px">
                                                        <asp:DropDownList ID="ddltoloc" runat="server" AutoPostBack="True">
                                                            <asp:ListItem Text="Select" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="Asudgaon" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Vendor" Value="1"></asp:ListItem>
                                                           
                                                        </asp:DropDownList>
                                                        <%--<asp:DropDownList ID="ddlgatepasstype" runat="server">
                                                        </asp:DropDownList>--%>
                                                    </td>
                                                    <td  id="tdven" runat="server">
                                                        Vendor
                                                    </td>
                                                    <td align="left" id="tdvendor" runat="server">
                                                        <asp:TextBox ID="txtvendor" MaxLength="100" runat="server" class="textfield" Width="110px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style21">
                                                        Challan No
                                                    </td>
                                                    <td align="left" class="style21">
                                                        <asp:TextBox ID="txtChallan" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" class="style21">
                                                        Challan Date
                                                    </td>
                                                    <td align="left" class="style21">
                                                    
                                                           <asp:TextBox ID="BDPChalldate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPChalldate"
                                        PopupButtonID="BDPChalldate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                               <%-- <tr>
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
                                                        Name :
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
                                                    <td align="right">
                                                        Bus In Kms :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbusinkm" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        Bus Out Kms :
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbusoutkm" MaxLength="20" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>--%>
                                               <%-- <tr>
                                                    <td align="right" class="style21">
                                                        Note :
                                                    </td>
                                                    <td align="left" class="style21" colspan="4">
                                                        <asp:TextBox ID="txtnote" MaxLength="250" Width="300" Height="30" TextMode="MultiLine"
                                                            runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td colspan="6">
                                                        <div style="text-align: center">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="trother" runat="server" >
                                                    <td style="height: 7px" colspan="6" align="center">
                                                        <table id="tblother" width="100%" border="1" cellpadding="2" cellspacing="2">
                                                            <tbody runat="server" id="tbodyother">
                                                                <tr class="gridhead">
                                                                    <td>
                                                                       Item 
                                                                    </td>
                                                                    <td>
                                                                         Serial No
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
                                                                    <td>
                                                                        Is Return
                                                                    </td>
                                                                </tr>
                                                                <tr class="gridtxt">
                                                                  <td align="left" style="width: 100px; height: 28px;">
                                                                        <asp:TextBox ID="txtitem1" Width="300px" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left" style="width: 100px; height: 28px;">
                                                                        <asp:TextBox ID="txtPartNo"  onblur="chkSerialNo();" MaxLength="100" Width="300px" runat="server"></asp:TextBox>
                                                                    </td>
                                                                  
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtqty1" MaxLength="3"  runat="server" Width="165px"></asp:TextBox>
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
                                                                        <asp:TextBox ID="txtremark1" onblur="chkqty();"  MaxLength="250" runat="server" EnableTheming="True"></asp:TextBox>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:CheckBox ID="chkreturn1" runat="server" Width="20px"></asp:CheckBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnadd" runat="server" Text="ADD" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                </td>
                            </tr>
                            <tr id="trgate" runat="server">
                                <td style="height: 9px" colspan="4" align="center">
                                    <asp:DataGrid ID="dgresult" Width="100%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                        HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                        runat="server" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="issue_id" Visible="false"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="part_no" ItemStyle-HorizontalAlign="center" HeaderText="Serial No">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="item_name" ItemStyle-HorizontalAlign="center" HeaderText="Item Name">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="total_qty" ItemStyle-HorizontalAlign="left" HeaderText="Qty">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="unit" HeaderText="Unit"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Remark">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemark" Text='<%# DataBinder.Eval(Container, "DataItem.txtRemark") %>'
                                                        TextMode="MultiLine" runat="server" Width="150px"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:BoundColumn DataField="ischeck" Visible="False"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Is Return">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkreturn" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Done">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkselect" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr> 
                            <tr>
                                <td colspan="4" align="center">
                                    <div align="center">
                                        <tr>
                                            <td align="center" colspan="7" style="height: 50px">
                                                <a href="" onmouseover="MM_swapImage('Image3','','../images/btn.gif',1)" onmouseout="MM_swapImgRestore()">
                                                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                        border="0" Width="87" Height="38" AlternateText="Save" />
                                                </a><a class="canceltxt" href="#">Cancel</a>
                                            </td>
                                        </tr>
                                    </div>
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
                             
                                       <asp:TextBox ID="secdate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="secdate"
                                        PopupButtonID="secdate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
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
            </div>
            <div class="orgbottam1">
            </div>
        </div>
    </div>
   <%-- </div>--%>

    
   
    </form>


     <script type="text/javascript">

//var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});


	$(document).ready(function() {
         $("#txtitem1").autocomplete
           ({
            source: [<%= stritem  %>]
            });
      });
      
	
    </script>
</asp:Content>
