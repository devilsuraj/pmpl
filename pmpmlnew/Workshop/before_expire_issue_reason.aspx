<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="before_expire_issue_reason.aspx.vb"
    Inherits="kdmt.before_expire_issue_reason" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Spare Issue Reason (Before Expiry )</title>

   <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>
Spare Issue Reason (Before Expiry )</h1>
    </div>
  <div class="form-horizontal" style="overflow:auto">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
        <asp:HiddenField ID="hdnstate" runat="server" />
        <div style="width: 1500px">
      
            <div>
                <table border="0" align="left" cellpadding="5" cellspacing="5">
                
                    <tr>
                        <td colspan="4" align="center">
                            <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                Width="800px" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                Font-Size="11pt">
                                <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                <ItemStyle Font-Names="Times New Roman" ForeColor="#000066" />
                                <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                    Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                <Columns>
                                    <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="busno" HeaderText="Bus No"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="item_name" ItemStyle-HorizontalAlign="Left" HeaderText="Item Name">
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="part_no" ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false"
                                        HeaderText="Part No"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="running_km" HeaderText="Running KM"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="expiry_km" HeaderText="Expiry KM"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="fit_date" HeaderText="Fit Date"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="change_date" HeaderText="Change Date"></asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="Reason">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtreason" TextMode="MultiLine" Width="300" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn DataField="buswise_spare_life_id" Visible="false"></asp:BoundColumn>
                                </Columns>
                            </asp:DataGrid>
                        </td>
                    </tr>
                    <tr id="trsave" runat="server">
                        <td style="height: 22px">
                            <div align="center">
                                <p>
                                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" TabIndex="9">
                                    </asp:ImageButton>
                                    <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="10">
                                    </asp:ImageButton>
                                </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>