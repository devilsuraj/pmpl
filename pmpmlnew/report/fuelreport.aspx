<%@ Page Language="VB" AutoEventWireup="false" CodeFile="fuelreport.aspx.vb" Inherits="fuelreport" %>

<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Fuel Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>
    <link rel="stylesheet" type="text/css" href="../store/menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="../store/menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <!--[if IE] -->
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table bgcolor="#f4f4f4" border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="top" class="gridhead" align="center" colspan="2">
                                <strong><span style="font-size: 16pt; color: white">Fuel Operation Reports</span></strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptfuelsummary.aspx"><span><font color="black">Fuel Summary Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptshortage.aspx"><span><font color="black">Shortage Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptolirecive.aspx"><span><font color="black">Oil Recived Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptOilindentreport.aspx"><span><font color="black">Oil Indent Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptoilrecieveregister.aspx"><span><font color="black">Oil Recieve Register</span></a>
                            </td>
                            <td align="center">
                                <a href="rptoilissuereport.aspx"><span><font color="black">Oil Issue Register </span></a>
                            </td>
                        </tr>
                        
                          <tr>
                            <td align="center">
                                <a href="rptoilcardexreport.aspx"><span><font color="black">Oil Cardex Report</span></a>
                            </td>
                            <td align="center">
                                <%--<a href="rptoilissuereport.aspx"><span><font color="black">Oil Issue Register </span></a>--%>
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
<!--
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

</script>

</body>
</html>
