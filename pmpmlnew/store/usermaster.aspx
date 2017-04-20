<%@ Page Language="vb" AutoEventWireup="false" Inherits="KDMT.UserMaster" CodeFile="UserMaster.aspx.vb" %>

<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>User Master</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        .style1
        {
            height: 41px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" type="text/javascript">
function validate ()
{
if (document.getElementById ("txtfname").value == 0)
{
alert ("Please Enter First Name");
document.getElementById ("txtfname").focus();
return false;
}

if (document.getElementById ("txtlast").value == 0)
{
alert ("Please Enter Last Name");
document.getElementById ("txtlast").focus();
return false;
}

if (document.getElementById ("txtname").value == 0)
{
alert ("Please Enter User Name");
document.getElementById ("txtname").focus();
return false;
}
if (document.getElementById ("txtpass").value == 0)
{
alert ("Please Enter password");
document.getElementById ("txtpass").focus();
return false;
}
if (document.getElementById ("txtcpass").value == 0)
{
alert ("Please Confirm password");
document.getElementById ("txtcpass").focus();
return false;
}
if (document.getElementById ("txtcpass").value != document.getElementById ("txtpass").value)
{
alert ("Please Enter Same Password");
document.getElementById ("txtcpass").focus();
return false;
}
return true;
}


    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading" colspan="4">
                                <span id="Span1">User Master</span>
                            </td>
                        </tr>
                        <tr>
                            <td id="Td1" runat="server" align="right">
                                Dept Acess:-
                            </td>
                            <td id="Td2" runat="server" align="left">
                                <asp:DropDownList ID="ddldept" runat="server" Width="160px">
                                  
                                    <asp:ListItem Text="SparePart Section" Value="1" ></asp:ListItem>
          <asp:ListItem Text="Hardware Section" Value="2" ></asp:ListItem>
          <asp:ListItem Text="Receipt Section" Value="3" ></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                First Name :-
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtfname" runat="server" Width="159px"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Last Name :-
                                <asp:TextBox ID="txtlast" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                User Name :-
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtname" runat="server" Width="160px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style1" align="right">
                                Password :-
                            </td>
                            <td class="style1" align="left">
                                <asp:TextBox ID="txtpass" runat="server" Width="160px" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Confirm Password:-
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtcpass" runat="server" Width="160px" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td align="left">
                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="../images/btn_h.gif">
                                </asp:ImageButton>
                                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="../images/cancel.gif">
                                </asp:ImageButton>
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
