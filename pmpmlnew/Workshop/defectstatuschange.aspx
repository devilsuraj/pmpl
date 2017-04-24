<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="defectstatuschange.aspx.vb"
    Inherits="kdmt.defectstatuschange" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>Inspection Card</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>--%>
    <style type="text/css">
        .chkliststyle input
        {
            float: left;
            width: 20%;
        }
        .chkliststyle label
        {
            float: left;
            width: 70%;
            text-align: left;
            padding-left: 3px;
            padding-right: 5px;
        }
    </style>
   <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Inspection Card Master</h1>
    </div>
    <div class="form-horizontal" style="overflow:auto">
  
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel UpdateMode="Always" ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div id="middal">
               
                    <div class="contantbox">
                        <div class="orgtop">
                        </div>
                        <div class="orgmiddal">
                            <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                            <div>
                                <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">
                                  
                                    <tr>
                                        <td align="right" style="width: 500px">
                                            Bus No.
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBusNo" AutoPostBack="true" Width="140px" runat="server"></asp:TextBox>
                                            <%--<asp:TextBox ID="txtjocno" runat="server" Width="140px" class="textfield" onblur="Chkjobdetails();"></asp:TextBox>--%>
                                            <input type="text" id="txtjocno" style="display: none" class="textfield" onblur="Chkjobdetails();"
                                                runat="server" enableviewstate="True" readonly="readonly" />
                                        </td>
                                        <td align="right">
                                            Job Card No
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtjob" Width="30px" runat="server"></asp:TextBox>
                                            <asp:TextBox ID="txtjobno" Width="40px" MaxLength="4" TabIndex="1" AutoPostBack="True"
                                                runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Job Date
                                        </td>
                                        <td align="left">
                                            <%-- <BDP:BDPLite ID="dtjobDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>--%><asp:TextBox ID="dtjobDate" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        </td>
                                        <td align="right">
                                            Job Time
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtjotime" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Model :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtmodel" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Engine :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtengin" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Chassis :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtchassis" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            KMS. :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtkms" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Job Defect
                                        </td>
                                        <td colspan="3" align="center">
                                            <asp:TextBox ID="TextBox1" runat="server" Width="489px" ReadOnly="True" Height="69px"
                                                TextMode="MultiLine"></asp:TextBox>
                                            <%--<asp:Button ID="btnshow" runat="server" Text="Show Deffect Details" 
                                      style="height: 26px" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            New Defect Type :
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlnewdefect" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Old Defect Type
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblolddefect" Font-Bold="true" runat="server"></asp:Label>
                                        </td>
                                        <td id="tdbd" runat="server">
                                            BreakDownclosedtime
                                        </td>
                                        <td id="tdclosedtime" runat="server">
                                            <asp:TextBox ID="txtbdclosedtime" runat="server" Width="100px" MaxLength="5"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="left">
                                            <asp:CheckBoxList ID="Select1" Style="align: left; display: none;" runat="server"
                                                AutoPostBack="True" RepeatDirection="Horizontal" CellPadding="2" CellSpacing="2"
                                                CssClass="chkliststyle" Height="10%" RepeatColumns="4" Width="100%">
                                            </asp:CheckBoxList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <label>
                                                <%--<asp:ImageButton ID="btnSave" runat="server" ImageUrl="../images/btn_h.gif" TabIndex="9">
                                        </asp:ImageButton>--%>
                                                <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" />
                                            </label>
                                            &nbsp;<%--<a href="../report/rptJOC.aspx">Save</a> --%><asp:Button ID="btnreset" runat="server" Text="Reset" Height="32px" Width="63px" />
                                            <asp:Label runat="server" ID="lbl"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="orgbottam">
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>