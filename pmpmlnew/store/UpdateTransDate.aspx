<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UpdateTransDate.aspx.vb" Inherits="KDMT.store_UpdateTransDate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update TransDate</title>
     <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />
    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/LogSheetIssue.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

</head>
<body  class="body">
    <form id="form1" runat="server">
     <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                
                
   
    <table width ="100%" align="center" >
    <tr>
    <td>
    
     Challan No :-
 
    <asp:TextBox ID="txtChallanNo" runat ="server" ></asp:TextBox>
    </td>
    </tr>
    <tr>
    <td>Date : -
  <BDP:BDPLite ID="BDPLite1"  runat="server"></BDP:BDPLite></td>
    </tr>
     <tr>
      <td>
       <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif">
       </asp:ImageButton><asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"
        ></asp:ImageButton>
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
</body>
</html>
