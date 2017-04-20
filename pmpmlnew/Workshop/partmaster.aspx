<%@ Page Language="VB" AutoEventWireup="false" CodeFile="partmaster.aspx.vb" Inherits="kdmt.partmaster" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Part Master</title>
    <script language="javascript" type="text/javascript">
    


    </script>
    <style type="text/css">
        .style1
        {
            height: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    </div>
    <div id="middal">
        <uc:leftmenu ID="Leftmenu1" runat="server" />
        <div class="contantbox">
            <div class="orgtop">
            </div>
            <div class="orgmiddal">
                <%--<table border="0" align="left" cellpadding="5" cellspacing="5">  
  <tr>
                <td style="height: 55px">
                    <ul>
						<li>
                            <div align="left">
                                <a href="Home.HTML">Home</a>
							</div>
						</li>
						     <li>
                            <div align="left">
                                <a href="Vehicle Master.HTML">Vehicle Master</a>
                            </div>
						</li>	
						</li>	
                        <li>
                            <div align="left">
                                <a href="Defect Details.HTML">Defect Details</a>
							</div>
						</li>
						 <li>
                            <div align="left">
                                <a href="View Defect Details.HTML">View Defect Details</a>
                            </div>
                        </li>
						<li>
                            <div align="left">
                                <a href="Indent Request Details.HTML">Indent Request Details</a>
                            </div>
						</li>		
						</li>		
						<li>
                            <div align="left">
                                <a href="Authenticate.HTML">Authentication</a>
							</div>
						</li>						
						</li>
						                        <li>
                            <div align="left">
                                <a href="View Indent Requests.HTML">View Indent Requests</a>
							</div>
						</li>
						</li>
                       	   <li>
                            <div align="left">
                                <a href="Part Master.HTML">Part Register Master</a>
							</div>
						</li>						
						</li>						
                        <li>
                            <div align="left">
                                <a href="Part History.HTML">Part History</a>
                            </div>
                        </li>
                     
                        <li>
                            <div align="left">
                                <a href="Part Repair_Details.HTML">Part Repair Details</a>
                            </div>
						</li>		
						<li>
                            <div align="left">
                                <a href="Retrading Detail.HTML">Retrading Details</a>
                            </div>
                        </li>
                        <li>
                            <div align="left">
                                <a href="Scrap Details.HTML">Scrap Details</a>
                            </div>
                        </li>
                        <li>
                            <div align="left">
                                <a href="Service Details.HTML">Schedule Service Details</a>
							</div>
						</li>                       							
                    </ul>
                </td>
            </tr>
               
           
		</table>--%>
                <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="4" class="innerheading">
                            <span id="Label3">Part Register Master</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlPartType" AutoPostBack="True" Style="height: 22px">
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            Bus No
                        </td>
                        <td>
                            <asp:TextBox ID="txtbusno" runat="server">  </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part Company No.
                        </td>
                        <td>
                            <asp:TextBox ID="txtPartCompNo" runat="server">  </asp:TextBox>
                        </td>
                        <td align="right">
                            Part Company
                        </td>
                        <td>
                            <asp:TextBox ID="txtPartComp" runat="server">  </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part W/S No.
                        </td>
                        <td>
                            <asp:TextBox ID="txtPartWSNo" runat="server">  </asp:TextBox>
                        </td>
                        <td align="right">
                            Part Size
                        </td>
                        <td>
                            <asp:TextBox ID="txtPartSize" runat="server">  </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Part Company Date
                        </td>
                        <td>
                            <BDP:BDPLite ID="dtCompDate" TextBoxStyle-Width="100px" runat="server">
                                <TextBoxStyle Width="100px" />
                            </BDP:BDPLite>
                        </td>
                        <td align="right">
                            Part W/S Date
                        </td>
                        <td>
                            <BDP:BDPLite TextBoxStyle-Width="100px" ID="dtWSDate" runat="server">
                            </BDP:BDPLite>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="drptype" AutoPostBack="False">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">Dry</asp:ListItem>
                                <asp:ListItem Value="2">Liquid</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            Remark:
                        </td>
                        <td>
                            <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4" class="style1">
                            <label>
                                <asp:Button ID="Button1" runat="server" Text="Save" />
                            </label>
                            <a href="Part_Master.aspx">Reset</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="dvPartMaster" class="task-al-box" style="width: 100%">
                                <tr id="trgrid" runat="server">
                                    <td colspan="4">
                                        <asp:GridView ID="gvCustomers" DataKeyNames="part_id" runat="server" AutoGenerateColumns="False"
                                            OnRowEditing="EditCustomer" OnRowUpdating="UpdateCustomer" OnRowCancelingEdit="CancelEdit"
                                            CellPadding="2" GridLines="None" BackColor="LightGoldenrodYellow" BorderColor="Tan"
                                            BorderWidth="1px" ForeColor="Black">
                                            <FooterStyle BackColor="Tan" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="ID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblid" runat="server" Text='<%# Eval("part_id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="part Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblpartype" runat="server" Text='<%# Eval("part_type")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Bus No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblbusno" runat="server" Text='<%# Eval("busno")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtbusno" runat="server" Text='<%# Eval("busno")%>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Battery Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblbattery" runat="server" Text='<%# Eval("typeB")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Part Company No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblpart_no" runat="server" Text='<%# Eval("part_company_no")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Part Company Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcompany" runat="server" Text='<%# Eval("part_company")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Part W/S No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblwsno" runat="server" Text='<%# Eval("part_ws_no")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Part Size">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblsize" runat="server" Text='<%# Eval("part_size")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Part Company Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcompdate" runat="server" Text='<%# Eval("part_comp_date")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Part W/S Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblesdate" runat="server" Text='<%# Eval("part_ws_date")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:CommandField ShowEditButton="True" />
                                            </Columns>
                                            <HeaderStyle BackColor="Tan" Font-Bold="True" />
                                            <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                            <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </div>
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
