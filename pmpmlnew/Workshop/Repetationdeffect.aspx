<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Repetationdeffect.aspx.vb"
    Inherits="KDMT.Workshop_Repetationdeffect" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Repetation of Work</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script language="javascript" type="text/javascript">
    </script>

    <style type="text/css">
        .style1
        {
            width: 167px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <a href="../report/allworkshopReport.aspx" class="ctrl">Back</a>
    <div>
      <%--  <uc:header ID="Header1" runat="server" />--%>
        <asp:HiddenField ID="hdnshowtype" runat="server" />
        <div id="middal">
           <%-- <uc:leftmenu ID="Leftmenu1" runat="server" />--%>
            <div class="contantbox">
                <div class="pagetop">
                </div>
                <div class="page">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                            <tr>
                                <td colspan="4" class="innerheading">
                                    <span id="Label3" style="font-weight: bold; font-size: large">Repetition of Work Report</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    From Date :
                                    <BDP:BDPLite ID="dtformDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                                <td align="left">
                                    To Date :
                                    <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="btnshowall" runat="server" Text="ShowAll" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Defect :
                                    <asp:DropDownList ID="ddldeffect" runat="server" AutoPostBack="false" TabIndex="1"
                                        ForeColor="Black">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="ddlsubdefect" runat="server" Width="250px"></asp:TextBox>
                                </td>
                                <td align="left" colspan="1">
                                    NO Of day : LAST
                                    <asp:TextBox ID="txtday" Width="20" MaxLength="2" runat="server"></asp:TextBox>
                                    DAYS
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Bus No:
                                    <input type="text" id="txtBusNo" style="width: 120px;" runat="server" tabindex="0" />
                                </td>
                                <td align="left">
                                    Deffect Place :
                                    <asp:DropDownList ID="ddldeffectplace" runat="server">
                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem Value="1">Defect</asp:ListItem>
                                        <asp:ListItem Value="2">Brakedown</asp:ListItem>
                                        <asp:ListItem Value="3">Docking</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <%--<asp:TextBox ID="txtBusNo" runat="server" Width="140px" onblur="validate();"></asp:TextBox>--%>
                            </tr>
                            <tr>
                              <td align="left">
                              Vehicle Type:
                                    <asp:DropDownList ID="ddlbustype" runat="server">
                                        <asp:ListItem Text="select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="CNG-JnNRUM" Value="CNG-JnNRUM"></asp:ListItem>
                                        <asp:ListItem Text="CNG-NON-JnNRUM" Value="CNG-NON-JnNRUM"></asp:ListItem>
                                        <asp:ListItem Text="CONVERTED CNG" Value="Converted CNG"></asp:ListItem>
                                         <asp:ListItem Text="ASUDGAON" Value="Asudgaon"></asp:ListItem>
                                         <asp:ListItem Text="VOLVO" Value="VOLVO"></asp:ListItem>
                                         <asp:ListItem Text="Tata Mini Bus" Value="Tata Mini Bus"></asp:ListItem>
                                          <asp:ListItem Text="Tata BS III" Value="Tata BS III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    Repetation of Work Report
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <div align="center">
                                        <asp:DataGrid ID="grdjoclist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" ShowFooter="False" Font-Bold="False" Font-Italic="False"
                                            Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                            ForeColor="Black" Font-Size="11pt">
                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                            <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="Black" Font-Italic="False"
                                                Font-Overline="False" Font-Size="10pt" Font-Strikeout="False" Font-Underline="False"
                                                Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="busno" HeaderText="Bus No."></asp:BoundColumn>
                                                <asp:BoundColumn DataField="joccode" HeaderText="Job Card No."></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobdate" HeaderText="Date"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="jobtime" HeaderText="Time" ItemStyle-HorizontalAlign="Left">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffectplace" HeaderText="Deffect Place " ItemStyle-HorizontalAlign="Left">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect_decr" HeaderText="Department" ItemStyle-HorizontalAlign="Left">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffect" HeaderText="Deffect" ItemStyle-HorizontalAlign="Left">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="mechname" HeaderText="Mechanic Name" ItemStyle-HorizontalAlign="Left">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="superv" HeaderText="Supervisor Name" ItemStyle-HorizontalAlign="Left">
                                                </asp:BoundColumn>
                                                <asp:ButtonColumn ButtonType="PushButton" CommandName="print" Text="Print" ItemStyle-HorizontalAlign="Left"
                                                    Visible="false"></asp:ButtonColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="Button1" runat="server" Width="87px" Text="Print"></asp:Button>
                                    <asp:Button ID="btnExcel" runat="server" Text="Convert to Excel" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pagebottam">
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>

    <script>
        $(document).ready(function() {
                SearchText();
                
        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);
           
            
            $("#ddlsubdefect").autocomplete
           ({

               source: function(request, response) {
                   $.ajax
                    ({
                    
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Job_Order_Card.aspx/GetAutoCompleteData",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": document.getElementById ('ddldeffect').options[document.getElementById ('ddldeffect').selectedIndex].value, "SearchText": document.getElementById('ddlsubdefect').value }),
                        //dataType: "json",
                        success: function(data) {
                            response(data.d);
                        },
                        error: function(result) {
                            alert("Error");
                        }
                    });

               }
           });
         
            $("#txtBusNo").autocomplete
           ({
            source: [<%= strBusno  %>]
            });
            
            
      
            
            $(document).ready(function(){
    $("#ddldeffect").change(function(){
       $("#ddlsubdefect").val("") ;
    });

})
       }
    </script>

</body>
</html>
