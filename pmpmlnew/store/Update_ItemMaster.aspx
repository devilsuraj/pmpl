<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Update_ItemMaster.aspx.vb" Inherits="KDMT.Update_ItemMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Update File wise Item</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .AutoCompleteExtenderClass {
            margin-top: 10px;
            padding: 0px;
            height: 300px;
            position: absolute;
            z-index: 999;
            color: Blue;
            overflow: scroll;
            cursor: pointer;
        }

            .AutoCompleteExtenderClass::-webkit-scrollbar {
                width: 1em;
            }

            .AutoCompleteExtenderClass::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            }

            .AutoCompleteExtenderClass::-webkit-scrollbar-thumb {
                background-color: darkgrey;
                outline: 1px solid slategrey;
            }
            
    </style>
   <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Update File Wise Item</h1>
    </div>
        <div align="center">
            
            <div id="middal">
                
                <div class="contantbox">
                    <div class="orgtop">
                    </div>
                    <div class="orgmiddal">
                        <table width="100%">
                         
                                <td align="right">
                                    <asp:Label ID="Label1" runat="server" Text="Select Option :"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:RadioButton ID="rdbupdate" runat="server" GroupName="rdbgroup" Text="Click To Update" Checked="true" AutoPostBack="True" />
                                    &nbsp;&nbsp;&nbsp;
                <asp:RadioButton ID="rdbview" runat="server" GroupName="rdbgroup" Text="Click To View" AutoPostBack="True" />
                                    <br />

                                    <asp:GridView ID="grditem" AllowPaging="true" PageSize="100"
                                        runat="server" AutoGenerateColumns="False" OnRowCommand="grditem_RowCommand" OnRowUpdating="OnRowUpdating">
                                        

                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No." ItemStyle-HorizontalAlign="right">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex + 1%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Item code" ItemStyle-HorizontalAlign="right">
                                                <ItemTemplate>
                                                    <asp:Label ID="item_code" runat="server" Text='<%# Eval("item_code")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="LF. No." ItemStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="LFno" runat="server" Text='<%# Eval("LFno")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Part No." ItemStyle-HorizontalAlign="right" ItemStyle-Width="120px">
                                                <ItemTemplate>
                                                    <asp:Label ID="part_no" runat="server" Text='<%# Eval("part_no")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Item Name" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="item_name" runat="server" Text='<%# Eval("item_name")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Select File Name" ItemStyle-Width="250px">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtfilename" runat="server" Width="250px"></asp:TextBox>
                                                    <asp:AutoCompleteExtender ID="AutoCompleteExtender1" CompletionListCssClass="AutoCompleteExtenderClass" runat="server" TargetControlID="txtfilename"
                                                        MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="1000"
                                                        ServiceMethod="GetAutoCompletefilename" UseContextKey="true">
                                                    </asp:AutoCompleteExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Update" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="Button1" CommandName="update" CommandArgument='<%# Container.DataItemIndex %>' Text="Update" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>

                                    <asp:GridView ID="grdview" AllowPaging="true" PageSize="100"
                                        runat="server" AutoGenerateColumns="False"  OnRowUpdating="OnRowUpdating">

                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No." ItemStyle-HorizontalAlign="right" ItemStyle-Width="100px">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex + 1%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Item code" ItemStyle-HorizontalAlign="right" ItemStyle-Width="150px">
                                                <ItemTemplate>
                                                    <asp:Label ID="item_code" runat="server" Text='<%# Eval("item_code")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="LF. No."  ItemStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="LFno" runat="server" Text='<%# Eval("LFno")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Part No." ItemStyle-HorizontalAlign="Left" ItemStyle-Width="120px">
                                                <ItemTemplate>
                                                    <asp:Label ID="part_no" runat="server" Text='<%# Eval("part_no")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Item Name" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px">
                                                <ItemTemplate>
                                                    <asp:Label ID="item_name" runat="server" Text='<%# Eval("item_name")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File Name" ItemStyle-Width="250px">
                                                <ItemTemplate>
                                                    <asp:Label ID="file_name" runat="server" Text='<%# Eval("file_name")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="File No." ItemStyle-HorizontalAlign="center" ItemStyle-Width="250px">
                                                <ItemTemplate>
                                                    <asp:Label ID="file_no" runat="server" Text='<%# Eval("file_no")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>


                                    <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                    </asp:ScriptManager>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                </div>
 </asp:Content>