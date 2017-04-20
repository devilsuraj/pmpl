<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Insp_docking_list.aspx.vb"
    Inherits="KDMT.Workshop_Insp_docking_list" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>
    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>
    <!--[if IE] -->
    <script language="javascript">
        function printpage() {
            window.print();
        }


        function validate() {
            if (confirm("Are you sure you wan`t to Save.")) { return true }
            else { return false }
        }
    </script>
    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
    <style type="text/css">
        .style3
        {
            height: 29px;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <asp:HiddenField ID="hdnextra" Value="0" runat="server" />
    <a href="../Workshop/Deptwisedeffectrpt.aspx" class="ctrl">Back</a>
    <table id="Table2" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 850px"
        class="ctrl">
        <%--<tr>
            <td valign="top" align="center" colspan="4">
                <strong><span style="font-size: 16pt; color: black">Brakedown Bus Report</span></strong>
            </td>
        </tr>--%>
    </table>
    <table id="Table1" align="center" cellspacing="0" cellpsadding="0" border="1" style="width: 1155px;
        margin-bottom: 0px;" runat="server">
        <tr>
            <td align="center" colspan="4">
                <strong><span style="font-size: 14pt">Inspection Details</span></strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <asp:Label ID="Label1" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="left">
                <span>Please Click the Button if you want to skip</span>
                <%-- <asp:CheckBox ID="cdkskip" runat="server" />--%>
                <asp:Button ID="btnskip" runat="server" Text="Skip" />
                <asp:Button ID="btnextra" runat="server" Text="Extra Inspection" Visible="True" />
                <BDP:BDPLite ID="bdpinspdate" runat="server">
                </BDP:BDPLite>
            </td>
            <td>
                Your doing Inpection :
                <asp:Label ForeColor="Red" ID="lblinspno" Text="" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left" style="height: 50px">

                <div align="center">
                 <br />
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Item Issued:"></asp:Label>
                 <br />
                  <br />
                 <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                                    Width="90%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                                    BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                                    Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                                    ForeColor="Black" Font-Size="11pt">
                                                    <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                        Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    
                                                    
                                                  <Columns>
                                                      <asp:BoundColumn DataField="refno" HeaderText="Indent No"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name" ItemStyle-HorizontalAlign="left">
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="part_no" HeaderText="Part No" >
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="total_qty" HeaderText="Total Qty" ItemStyle-HorizontalAlign="right"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="wname" HeaderText="Worker Name" ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="approvedby" HeaderText="Approved By" ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="flag" HeaderText="Remark" ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                                                        
                                                        <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                                    </Columns>
                                                </asp:DataGrid>
                                                
                                                <br />
                                                 <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Work Done:"></asp:Label>
                                                 <br />
                                                 <br />
                                                
                    <asp:DataGrid ID="grddockinglist" Style="align: center; valign: middle;" runat="server"
                                                    Width="90%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                                    BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False" Font-Italic="False"
                                                    Font-Names="Verdana" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                                    ForeColor="Black" Font-Size="11pt">
                                                    <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                        Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn HeaderText="Sr No" DataField="srno"></asp:BoundColumn>
                            <asp:BoundColumn HeaderText="Docking List" DataField="dockingmain" ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn HeaderText="subdocking" Visible="false" DataField="docking_id">
                            </asp:BoundColumn>
                            <%--<asp:BoundColumn DataField="dockingmain" HeaderText="Docking List" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" Visible="false">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:BoundColumn>--%>
                            <%--<asp:BoundColumn DataField="partsregu" HeaderText="Parts Required" Visible="false">
                            </asp:BoundColumn>--%>
                            <%-- <asp:TemplateColumn HeaderText="Parts Required">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtfotpart" runat="server" Width="250px" MaxLength="50" Text='<%# DataBinder.Eval(Container, "DataItem.partsregu") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>--%>
                            <%--<asp:TemplateColumn HeaderText="Docking">
                                <ItemTemplate>
                                    <asp:CheckBox ID="ch1" runat="server" Width="250px" Checked='<%# DataBinder.Eval(Container, "DataItem.ch1") %>' />
                                </ItemTemplate>
                            </asp:TemplateColumn>--%>
                            <%--<asp:TemplateColumn HeaderText="Replace Qty" Visible="False">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtqty" Width="250px" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>--%>
                            <asp:TemplateColumn HeaderText="Note">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtnote" runat="server" Width="300px" Height="40"  MaxLength="500" Text="OK"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="partsregu1" HeaderText="partsregu1" Visible="false">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="subdocking" HeaderText="docking" Visible="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="isnpdtl_id" HeaderText="isnpdtl_ids" Visible="false">
                            </asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
        <%--<tr>
            <td align="center" style="font-weight: bold; text-decoration: underline">
                <div id="divother" runat="server" visible="False">
                    Others Inspection List
                    <asp:DataGrid ID="grdother" Style="align: left; valign: middle;" runat="server"
                        Width="90%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                        Font-Size="11pt">
                        <Columns>
                            <asp:BoundColumn HeaderText="Sr No" DataField="srno"></asp:BoundColumn>
                            <asp:BoundColumn HeaderText="Docking List" DataField="dockingmain"></asp:BoundColumn>
                            <asp:BoundColumn DataField="docking_id" HeaderText="dockingid" Visible="false"></asp:BoundColumn>
                            <asp:BoundColumn DataField="dockingmain" HeaderText="Docking List" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" Visible="false">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="partsregu" HeaderText="Parts Required" Visible="false">
                            </asp:BoundColumn>
                           <%-- <asp:TemplateColumn HeaderText="Parts Required">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtfotpart" runat="server" Width="250px" MaxLength="50" Text='<%# DataBinder.Eval(Container, "DataItem.partsregu") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Docking">
                                <ItemTemplate>
                                    <asp:CheckBox ID="ch1" runat="server" Width="250px" Checked='<%# DataBinder.Eval(Container, "DataItem.ch1") %>' />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Replace Qty" Visible="False">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtqty" Width="250px" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Note">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtnote" runat="server" Width="250px" MaxLength="50" Text='<%# DataBinder.Eval(Container, "DataItem.note") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="partsregu1" HeaderText="partsregu1" Visible="false">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="subdocking" HeaderText="subdocking" Visible="false">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="isnpdtl_id" HeaderText="isnpdtl_ids" Visible="false">
                            </asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>--%>
        <tr>
            <td align="center" colspan="4" valign="top" class="style3">
                <asp:Button ID="Button3" runat="server" Text="Save" />
                &nbsp;&nbsp;
                <%-- <asp:LinkButton ID="lnkid" runat="server" Text="Other"></asp:LinkButton>--%>
            </td>
        </tr>
    </table>
    </form>
</body>
