<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rpt_moving_bar_graph_report.aspx.vb"
    Inherits="kdmt.rpt_moving_bar_graph_report" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Item Moving report (Bar Chart)</title>
    <script src="<% =Session("host") %>scripts/highcharts.js" type="text/javascript"></script>
    <script src="<% =Session("host") %>scripts/data.js" type="text/javascript"></script>
    <script src="<% =Session("host") %>scripts/drilldown.js" type="text/javascript"></script>
    <script src="<% =Session("host") %>includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <a id="a_back_id" runat="server" visible="false" href="rpt_moving_bar_graph_report.aspx"
        class="ctrl">Back</a> <a id="a_backto_report" runat="server" visible="True" href="storereport.aspx"
            class="ctrl">Back To Main Report</a>
    <div>
        <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
            runat="server" class="ctrl">
            <tr>
                <td class="text3" align="center" style="height: 22px" colspan="4">
                    <strong><span style="font-size: 11pt; color: black">Item Moving Report &nbsp;</span></strong>
                </td>
            </tr>
            <tr>
                <td>
                    Type :
                </td>
                <td>
                    <asp:DropDownList ID="drbType" runat="server">
                        <asp:ListItem Text="SpareParts" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Hardware" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Kit Section" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Stationary" Value="4"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    Moving Type :
                </td>
                <td>
                    <asp:DropDownList ID="ddlmoving" runat="server">
                        <asp:ListItem Text="ALL" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btnshow" runat="server" Text="Show" />
                </td>
            </tr>
        </table>
    </div>
    <div id="container" runat="server" style="min-width: 310px; height: 400px; margin: 0 auto">
    </div>
    </form>
</body>
<script language="javascript">


<% =dynamic_item_moving_script  %>
    // Create the chart
 $(document).ready(function(){
   // var replaced = $("body").html().replace('Highcharts.com','');
    $(".highcharts-credits").hide();
});

</script>
</html>
