<%@ Page Language="vb" AutoEventWireup="false" Inherits="KDMT.Login" CodeFile="login.aspx.vb" %>

<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Ticket & Cash Management</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        .solidblockmenu
        {
            border-right: #625e00 0px solid;
            padding-right: 0px;
            border-top: #625e00 1px solid;
            padding-left: 0px;
            background: url(../images/blockdefault.gif) #ffffff repeat-x center center;
            padding-bottom: 0px;
            margin: 0px;
            font: bold 13px Arial;
            border-left: #625e00 0px solid;
            width: 100%;
            padding-top: 0px;
            border-bottom: #625e00 1px solid;
        }
        .solidblockmenu LI
        {
            display: inline;
        }
        .solidblockmenu LI A
        {
            border-right: white 1px solid;
            padding-right: 13px;
            padding-left: 13px;
            float: left;
            padding-bottom: 9px;
            color: white;
            padding-top: 9px;
            text-decoration: none;
        }
        .solidblockmenu LI A:visited
        {
            color: white;
        }
        .solidblockmenu LI A:hover
        {
            background: url(../images/blockactive.gif) repeat-x center center;
            color: white;
        }
        .solidblockmenu LI .current
        {
            background: url(../images/blockactive.gif) repeat-x center center;
            color: white;
        }
    </style>
    <!--[if IE]>
<STYLE type=text/css>P.iepara {
	PADDING-TOP: 1em
}
</STYLE>
<![endif]-->

    <script language="javascript">
          

            
      

    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <table width="1002" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="83">
                            &nbsp;
                        </td>
                        <td colspan="6">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <div align="right">
                                            <a href="wayregister.aspx"></a>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="ticket.aspx"></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="6">
                            <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="64" valign="top" background="../images/bg_T1.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <tr>
                                        <td background="../images/bg_M1.gif">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="text3" align="center">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" style="height: 19px">
                                                        &nbsp;
                                                        <asp:Label ID="lblinfo" runat="server" Width="332px" ForeColor="Red"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table width="486" border="0" align="right" class="text3" cellpadding="0" cellspacing="0"
                                                            style="width: 486px; height: 95px">
                                                            <tr>
                                                                <td height="8" colspan="3" width="232">
                                                                    &nbsp;
                                                                </td>
                                                                <td width="15" height="8">
                                                                </td>
                                                                <td width="365" height="8">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="height: 33px" width="81">
                                                                    Department
                                                                </td>
                                                                <td style="height: 33px" width="163">
                                                                    &nbsp;
                                                                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                                                                        DataTextField="KDMT_DEPT_DESC" DataValueField="KDMT_DEPT_CODE">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Con %>"
                                                                        SelectCommand="SELECT [KDMT_DEPT_CODE], [KDMT_DEPT_DESC] FROM [KDMT_DEPT_MASTER] WHERE  kdmt_dept_code<=7">
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                                <td style="height: 33px" width="3">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="height: 6px" width="81">
                                                                    &nbsp;
                                                                </td>
                                                                <td style="height: 6px" width="163">
                                                                </td>
                                                                <td style="height: 6px" width="3">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="81" height="26">
                                                                    User Name
                                                                </td>
                                                                <td width="163" height="26">
                                                                    &nbsp;
                                                                    <input id="txtusername" type="text" name="textfield4" runat="server" tabindex="0">
                                                                </td>
                                                                <td width="3" height="26">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="8" colspan="3" width="232">
                                                                    &nbsp;
                                                                </td>
                                                                <td width="15" height="8">
                                                                </td>
                                                                <td width="365" height="8">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="81" style="height: 24px">
                                                                    Password
                                                                </td>
                                                                <td width="163" style="height: 24px">
                                                                   
                                                                    <asp:TextBox ID="txtpass" runat="server" TextMode="Password"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr style ="height :50px">
                                                                <td align="center" colspan ="2">
                                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../images/save.gif">
                                                                    </asp:ImageButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div align="right">
                                                            <p class="tableheader">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 40px">
                                            <img src="../images/bg_B1.gif" width="710" height="27">
                                        </td>
                                    </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
