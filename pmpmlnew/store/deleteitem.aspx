<%@ Page EnableEventValidation="true" Language="VB" AutoEventWireup="false" CodeFile="deleteitem.aspx.vb"
    Inherits="KDMT.deleteitem" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Delete Issue Item</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/LogSheet.js">
    </script>

    <script language="javascript" src="../Scripts/BLogSheet.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />

    <script language="javascript">
var clockID = 0;

function UpdateClock() {
   if(clockID) {
      clearTimeout(clockID);
      clockID  = 0;
   }

   var tDate = new Date();

   lbltime.innerHTML = "" + tDate.getHours() + ":" + tDate.getMinutes() + ":" + tDate.getSeconds();
   
   clockID = setTimeout("UpdateClock()", 1000);
}
function StartClock() {
   clockID = setTimeout("UpdateClock()", 500);
}

function KillClock() {
   if(clockID) {
      clearTimeout(clockID);
      clockID  = 0;
   }
}


function Validate ()
{
   var rowCount = document.getElementById("dgresult").rows.length;
var i=1;
var j=0;
    for (i=2;i<=rowCount;i++)
    {
    var id = 'dgresult__ctl' + i + '_check'
    if (document.getElementById(id).checked == true )
    {
    j = 1
    }
    }
   
if (j== 0)
    {
    alert ('Please Tick The boxes if You want to Delete')
    return false 
    }
    
if(!confirm("Do you want to Delete Issue Item"))
    {
    return(false);
    }

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
                                <span id="Span1">Delet Issue Item</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 800px; height: 21px;">
                                Requistion No
                                <asp:TextBox ID="txtefno" runat="server" BackColor="#FFFFC0" ToolTip="Enter Demand No"></asp:TextBox>
                                Issue Date
                                <BDP:BDPLite ID="bdpDate" runat="server">
                                </BDP:BDPLite>
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                        <tr id="trgrid" runat="server">
                            <td style="height: 146px" colspan="4">
                                <asp:DataGrid ID="dgresult" Width="100%" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                    runat="server" AutoGenerateColumns="False" ItemStyle-CssClass="gridtxt">
                                    <Columns>
                                        <asp:BoundColumn Visible="false" DataField="issue_detail_id"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="part_no" HeaderText="Part No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="subrack_no" HeaderText="Bin No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="item_code" HeaderText="Item Code"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="total_qty" HeaderText="Issue Qty"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="refno" HeaderText="Refno"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="trans_date" HeaderText="Issue Date (DD/MM/YY)"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Delete">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="check" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr id="trbtn" runat="server">
                            <td style="height: 22px" align="center" colspan="4">
                                <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton><asp:ImageButton
                                    ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="1"></asp:ImageButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="text3">
                                <asp:HiddenField ID="Hid_Rec" runat="server" />
                                <asp:HiddenField ID="from_km" runat="server" />
                                <asp:HiddenField ID="to_km" runat="server" />
                                <asp:HiddenField ID="hdnTotalKm" runat="server" />
                                <asp:HiddenField ID="BHid_Rec" runat="server" />
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
