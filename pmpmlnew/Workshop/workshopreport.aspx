<%@ Page Language="VB" AutoEventWireup="false" CodeFile="workshopreport.aspx.vb"
    Inherits="KDMT.Workshop_workshopreport" EnableEventValidation="true" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Workshop Register</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script src="<% =session("host") %>Scripts/json2.js" type="text/javascript"></script>

    <script src="<% =session("host") %>includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>

    <script src="<% =session("host") %>Scripts/jquery-ui.min.js" type="text/javascript"></script>

    <link rel="stylesheet" href="<% =Session("host") %>css/jquery.autocomplete2.css" />
    <link href="<% =session("host") %>css/jquery-ui.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: WHITE">
    <form id="form1" runat="server">
    <a href="../report/allworkshopReport.aspx" class="ctrl">Back</a>
    <div>
        <div class="orgtop">
        </div>
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <div>
            <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                <tr>
                    <td colspan="4" class="innerheading" align="center">
                        Workshop Report
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        From Date :
                    </td>
                    <td align="left">
                        <BDP:BDPLite ID="dtformDate" runat="server" TextBoxStyle-Width="100px">
                        </BDP:BDPLite>
                    </td>
                    <td align="right">
                        To Date :
                    </td>
                    <td align="left">
                        <BDP:BDPLite ID="dttoDate" runat="server" TextBoxStyle-Width="100px">
                        </BDP:BDPLite>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        JOC No :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtjoc" runat="server" Width="140px"></asp:TextBox>
                    </td>
                    <td align="right">
                        Bus No.
                    </td>
                    <td>
                        <asp:TextBox ID="txtBusNo" runat="server" Width="140px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Status :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlstatus" runat="server">
                            <asp:ListItem Value="00">Select</asp:ListItem>
                            <asp:ListItem Value="0">Open</asp:ListItem>
                            <asp:ListItem Value="1">Close</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                        Defect Place :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddldeffectplace" runat="server">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="1">Deffect</asp:ListItem>
                            <asp:ListItem Value="2">Brakedown</asp:ListItem>
                            <asp:ListItem Value="3">Docking</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Supervisor :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlsuperv" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                        Shift :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlshift" runat="server">
                            <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                            <asp:ListItem Value="1" Text="I"></asp:ListItem>
                            <asp:ListItem Value="2" Text="II"></asp:ListItem>
                            <asp:ListItem Value="3" Text="III"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Defect Type:
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddldeffect" runat="server" Width="155px" ForeColor="Black">
                        </asp:DropDownList>
                         <asp:TextBox ID="ddlsubdefect" runat="server" Width="250px" EnableTheming="True"></asp:TextBox>
                    </td>
                    <td align="right">
                        Vehicle Type:
                    </td>
                    <td>
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
                    <td align="right">
                        Engineer :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="DropDownList1" runat="server">
                        </asp:DropDownList>
                        <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Con %>" 
                            SelectCommand="SELECT [EngId], [EngName] FROM [EngineerMaster]">
                        </asp:SqlDataSource>--%>
                    </td>
                    <td align="right">
                        Mechanic :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList2" runat="server">
                        </asp:DropDownList>
                        <%-- <asp:SqlDataSource ID="SqlDataSource2" runat="server"     DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Mech_id" 
                            ConnectionString="<%$ ConnectionStrings:Con %>"    DataSourceID="SqlDataSource1" DataTextField="EngName" DataValueField="EngId"
                            SelectCommand="SELECT [Name], [Mech_id] FROM [tbl_Mechanic_master] where Mech_id>7 ">
                        </asp:SqlDataSource>--%>
                    </td>
                </tr>

                 <tr>
                    <td align="right">
                        Driver No :
                    </td>
                    <td align="left">
                          <asp:TextBox ID="txtDriver" runat="server" Width="140px"></asp:TextBox>
                    </td>
                    <td align="right">
                      
                    </td>
                    <td>
                      
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <label>
                            <asp:Button ID="btnshow" runat="server" Text="Show" />
                        </label>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">

                        <div align="center">
                          <strong><asp:Label ID="Label1" runat="server" Text="Last Inspection Status" Visible="False"></asp:Label></strong>
                            <strong><asp:Label ID="LastInsp" runat="server" Text=""></asp:Label></strong>

                            <asp:DataGrid ID="grdjoclist" Style="align: center; valign: middle;" runat="server"
                                Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                ForeColor="Black" Font-Size="11pt" meta:resourcekey="grdirrlistResource1">
                                <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                <ItemStyle ForeColor="#000066" />
                                <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                    Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                <Columns>
                                    <asp:BoundColumn DataField="JOC_id" HeaderText="jobid" Visible="False"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="jobdate" HeaderText="Date" FooterStyle-Width="100px">
                                        <FooterStyle Width="100px"></FooterStyle>
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="joccode" HeaderText="Job Card No" Visible="true"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="deffectplace" HeaderText="Purpose of work" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="subdeffect" HeaderText="Defect" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="locid" HeaderText="Status" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="Supervisorname" HeaderText="Supervisor Name" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                                     <asp:BoundColumn DataField="engineer" HeaderText="Engineer Name" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="mechanic" HeaderText="Mechanic Name" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="shift" HeaderText="shift"></asp:BoundColumn>
                                    
                                    <%--<asp:BoundColumn DataField="lastinsp" HeaderText="Last Insp"></asp:BoundColumn>--%>
                                    <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="select" Text="Fit"></asp:ButtonColumn>--%>
                                    <asp:TemplateColumn>
                                        <ItemTemplate>
                                            <a href="../Workshop/rpt_workshopreport.aspx?id='1&jobid='<%#DataBinder.Eval(Container.DataItem,"JOC_id")%>'&busno='<%#DataBinder.Eval(Container.DataItem,"busno")%>'">
                                                Print</a>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn>
                                        <ItemTemplate>
                                            <a href="../report/rpt_dockingdtl.aspx?id='1&jobid='<%#DataBinder.Eval(Container.DataItem,"JOC_id")%>'">
                                                Docking</a>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn DataField="oldjoccode" Visible="False"></asp:BoundColumn>
                                    <%--<asp:BoundColumn DataField="job" Visible="False"></asp:BoundColumn>--%>
                                    <asp:BoundColumn DataField="inspection_no" Visible="False"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="remark" HeaderText="bus type"></asp:BoundColumn>
                                </Columns>
                            </asp:DataGrid>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Button ID="Button1" runat="server" Width="87px"  OnClientClick="printpage()" Text="Print"></asp:Button>
                        <asp:Button ID="btnExcel" runat="server" Text="Convert to Excel" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>

    <script>
   
//-->

    
        $(document).ready(function() {
                SearchText();
                loadArrayDd();
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
       function loadArrayDd() {
         
                }

                  function printpage() {
            window.print();
        }
        
    </script>

</body>
</html>
