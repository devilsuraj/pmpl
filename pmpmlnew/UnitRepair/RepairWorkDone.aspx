<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RepairWorkDone.aspx.vb"
    Inherits="KDMT.RepairWorkDone" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Repair Items</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<script language="javascript" src="../Scripts/LogSheet_repairoutward.js"></script>--%>

    <script language="javascript">

 var ex = /^[0-9]+\.?[0-9]*$/;

 function checkqty(id, claimqty,reqqty) {

 if (document.getElementById(id).value != '')
 {
           if (ex.test (document.getElementById(id).value) == false  ){
            alert('please Enter numbers Only.');
            document.getElementById(id).focus();
            return false;
        }
         
            if (parseFloat (document.getElementById(id).value) > parseFloat(claimqty)) {
                alert('Should be less than Available Qty')
                document.getElementById(id).focus();
                return false;
            }
            if (parseFloat(document.getElementById(id).value) > parseFloat(reqqty)) {
                alert('Should be less than Request Qty')
                document.getElementById(id).focus();
                return false;
            }
            
            if (parseFloat(document.getElementById(id).value) == 0) {
                alert('Qty can not be zero')
                document.getElementById(id).focus();
                return false;
            }
            
        }
}
function IsNumeric(strString)
{
    var ValidChars = "123456789";
    var Char;
    for (i = 0; i < strString.length; i++) 
    { 
    Char = strString.charAt(i); 
    if (ValidChars.indexOf(Char) == -1) 
    {
    return true;
    }
    }
    
    return false;
    
    
    
}


  function validate() {

            

            var grdvat = document.getElementById('<%= dgresult.clientID %>');
            var i = 0;
            var j = 0
            var value = 0;
            var vcount = grdvat.rows.length;

            for (i; i < vcount - 1; i++) {
                var rowel = grdvat.rows[i];
                //grddetail__ctl2_ + ''
                j = i + 2
                var id = 'dgresult__ctl' + j + '_chkselect'
                var txtqtyid = 'dgresult__ctl' + j + '_txtqty'
                var ddlreason = 'dgresult__ctl' + j + '_ddlResult'
          
                 
                var chkselect = document.getElementById(id);
                var txtqty = document.getElementById(txtqtyid);
//               if ((chkselect.checked == true )&& (txtqty.value == '') ){
//               if (txtqty.value == '')
  
                 if (chkselect.checked != false && txtqty.value == '' )
                 {
                alert('Please Enter Issue Qty ');
                document.getElementById(txtqtyid).focus();
                return false;
                }
                if (chkselect.checked != false && document.getElementById(ddlreason).selectedIndex == 0 )
                {
                alert('Please select reason');
                document.getElementById(ddlreason).focus();
                return false;
                }
     
        }}
        
        
    </script>

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
                                    <span id="Label3">Repair Items</span>
                                    <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="innerheading">
                                    <asp:Label ID="lblmsg" ForeColor="REd" runat="server" Text="" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tblmain" runat="server">
                                        <tbody>
                                            <tr>
                                                <td align="left">
                                                    Department:
                                                    <asp:DropDownList ID="ddlvendor" runat="server" Width="216px">
                                                    </asp:DropDownList>
                                                    <asp:Button ID="btnShow" runat="server" Text="Show" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DataGrid ID="dgresult" Width="100%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                                        HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                                        runat="server" AutoGenerateColumns="False">
                                                        <Columns>
                                                            <asp:TemplateColumn HeaderText="Sr No." ItemStyle-HorizontalAlign="right">
                                                                <ItemTemplate>
                                                                    <%#Container.ItemIndex + 1%>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:BoundColumn DataField="RepairRecDtlId" Visible="false"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="itemid" Visible="false"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="jobno" ItemStyle-HorizontalAlign="Left" HeaderText="Job No">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="item_name" ItemStyle-HorizontalAlign="Left" HeaderText="Item Name">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="SerialNo" HeaderText="Serial No"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="BusNo" HeaderText="Bus No"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="qty" ItemStyle-HorizontalAlign="right" HeaderText="Actual Qty">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="qtytobedone" ItemStyle-HorizontalAlign="right" HeaderText="Qty to be done">
                                                            </asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Qty">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtqty" runat="server" MaxLength="4" Width="30px"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <%--<asp:TemplateColumn HeaderText="From Date" ItemStyle-Width="20px">
                                                                            <ItemTemplate>
                                                                                <BDP:BDPLite ID="bdpfromdate" TextBoxStyle-Width='80px'   runat="server">
                                                                                </BDP:BDPLite>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="10px"></ItemStyle>
                                                                        </asp:TemplateColumn>--%>
                                                            <asp:BoundColumn DataField="recdate" HeaderText="Received Date"></asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Done Date" ItemStyle-Width="20px">
                                                                <ItemTemplate>
                                                                    <BDP:BDPLite ID="bdpTodate" TextBoxStyle-Width='80px' runat="server">
                                                                    </BDP:BDPLite>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="10px"></ItemStyle>
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn HeaderText="Work Done">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtWrkDone" TextMode="MultiLine" runat="server" Width="150px"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn HeaderText="Reason">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddlResult" runat="server">
                                                                        <asp:ListItem Text="SELECT" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Text="Repaired" Value="Repaired"></asp:ListItem>
                                                                        <asp:ListItem Text="Scrap" Value="Scrap"></asp:ListItem>
                                                                        <asp:ListItem Text="Reusable Scrap" Value="Reusable Scrap"></asp:ListItem>
                                                                        <asp:ListItem Text="Vendor" Value="Vendor"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn HeaderText="Done">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkselect" runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:BoundColumn DataField="receivedate" Visible="false" HeaderText="From Date">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="flag" Visible="false"></asp:BoundColumn>
                                                        </Columns>
                                                    </asp:DataGrid>
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

    <script type="text/javascript">
//        function getindent() { if (a> b) ( alert('123'); }
        function addEventHandler(elem, handler) {

            // var b1 = document.getElementById(id);
            //            if (b1.addEventListener)
            //                b1.addEventListener(handler, false);
            //            else
            if (elem.attachEvent)
                elem.attachEvent('onchange', handler);


        }
    </script>

    <script type="text/javascript">        
   <%=sb.ToString() %>
    </script>

    </form>
</body>
</html>
