<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="mtv.aspx.vb" Inherits="KDMT.MTV" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head"  Runat="Server">
     <script language="javascript">




        function checkqty(id, Avbqty, reqqty) {


            if ((document.getElementById(id).value == '')) {
                alert('Please Enter Proper Qty')
                setTimeout(function () { document.getElementById(id).focus() }, 10);
                return false;
            }

            if ((document.getElementById(id).value == '0') && parseFloat(Avbqty) != 0) {
                alert('Please Enter Proper Qty');
                setTimeout(function () { document.getElementById(id).focus() }, 10);

                return false;
            }
            if (IsNumeric(document.getElementById(id).value) == true) {
                if (parseFloat(document.getElementById(id).value) > parseFloat(reqqty)) {
                    alert('Should be less than or Equal to Request Qty')
                    setTimeout(function () { document.getElementById(id).focus() }, 10);
                    return false;
                }
            }
            else {
                alert('Please Enter Proper Qty')
                setTimeout(function () { document.getElementById(id).focus() }, 10);
                return false;
            }


            if (IsNumeric(document.getElementById(id).value) == true) {
                if (parseFloat(document.getElementById(id).value) > parseFloat(Avbqty)) {
                    alert('Should be less than or Equal to Available Qty')
                    setTimeout(function () { document.getElementById(id).focus() }, 10);
                    return false;
                }
            }
            else {
                alert('Please Enter Proper Qty')
                setTimeout(function () { document.getElementById(id).focus() }, 10);
                return false;
            }
        }

        function IsNumeric(strString) {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }
        function validate() {
            if (Right(10200, 2) == false) { return false; };

            if (IsValidDate(document.getElementById("txtissuedate").value) == false) {
                alert('Incorrect MTV Date Format');
                document.getElementById("txtissuedate").focus()
                return false;
            }

            //            if (document.getElementById("ddlvendor").selectedIndex == 0) {
            //                alert('Select Contractor Name');
            //                document.getElementById("ddlvendor").focus()
            //                return false;
            //            }

            if (document.getElementById("txtapproved").value.length == 0) {
                alert('Please Enter Approvedby Name');
                document.getElementById("txtapproved").focus()
                return false;
            }

            if (document.getElementById("ddlRef").value == 0) {
                alert('Please Select Request No');
                document.getElementById("ddlRef").focus()
                return false;
            }

            var grdvat = document.getElementById('grddetails');
            var i = 0;
            var j = 0
            var value = 9;
            var vcount = grdvat.rows.length;

            for (i; i < vcount - 1; i++) {
                var rowel = grdvat.rows[i];
                //grddetail__ctl2_ + ''
                j = i + 2


                var lblavbqty = 'grddetails__ctl' + j + '_lblavbqty'
                var reqid = 'grddetails__ctl' + j + '_lblreqqty'
                var id = 'grddetails__ctl' + j + '_txtissueqty'
                var issueqty = document.getElementById(id);
                var indentqty = document.getElementById(reqid);
                var objavbqty = document.getElementById(lblavbqty);





                if ((issueqty.value == '')) {
                    alert('Please Enter Proper Qty')
                    setTimeout(function () { issueqty.focus() }, 10);
                    return false;
                }

                if ((issueqty.value == '0') && parseFloat(objavbqty.innerHTML) != 0) {

                    alert('Please Enter Proper Qty ');
                    setTimeout(function () { issueqty.focus() }, 10);

                    return false;
                }
                if (IsNumeric(issueqty.value) == true) {
                    if (parseFloat(issueqty.value) > parseFloat(indentqty.innerHTML)) {
                        alert('Should be less than or Equal to Request Qty')
                        setTimeout(function () { issueqty.focus() }, 10);
                        return false;
                    }
                }
                else {
                    alert('Please Enter Proper Qty')
                    setTimeout(function () { issueqty.focus() }, 10);
                    return false;
                }


                if (IsNumeric(issueqty.value) == true) {
                    if (parseFloat(issueqty.value) > parseFloat(objavbqty.innerHTML)) {
                        alert('Should be less than or Equal to Available Qty')
                        setTimeout(function () { issueqty.focus() }, 10);
                        return false;
                    }
                }
                else {
                    alert('Please Enter Proper Qty')
                    setTimeout(function () { issueqty.focus() }, 10);
                    return false;
                }
            }


            return true;
        }
        


    </script>
    <style> 
   
        table{border-collapse:collapse!important; }
            table td, table th {
                background-color: #fff !important;
                text-align: left;
                padding: 10px;
                margin-top: 3px;
             font-family: "Open Sans",sans-serif;
             font-weight:400;
             font-size:14px;
            }
               

    table td input[type=number], input[type=text],input[type=date],input[type=time], input[type=password],input[type=email], select, textarea {
                width: 100%;
    height: 34px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #c2cad8;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            } 

    table td textarea{margin:0;font:inherit;color:inherit;overflow:auto;height:auto;}

     table td input[type=submit] {
                    color: #FFF;
    background-color: #3598dc;
    border-color: #3598dc;
                }

                table td input[type=submit] {
                    color: #666;
                    background-color: #c2cad8;
                    border-color: #bcc5d4;
                }
     

            table td lable{
                    font-weight: 400;
                        display: inline-block;
                        max-width:100%;
            }

 

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" Runat="Server">
     <div class="breadcrumbs">
        <h1>Issue To Sub Depot</h1>
    </div>
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <div align="center">

        <div id="middal">
            <div class="contantbox">
                <div class="mpagetop">
                </div>
                <div class="mpage">
                    <table width="100%">
                    
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align="right">
                                            Department Name:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList AutoPostBack="true" ID="ddlvendor" runat="server" Width="216px">
                                                <%--<asp:ListItem Value="0">Select</asp:ListItem>--%>
                                                <asp:ListItem Value="1">Sub-Depots</asp:ListItem>
                                                <%--<asp:ListItem Value="2">WorkShop</asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                            Date : -
                                        </td>
                                        <td align="left">
                                            <%-- <BDP:BDPLite ID="BDPLite1" runat="server">
                                            </BDP:BDPLite>--%>
                                            <asp:TextBox ID="txtissuedate" Width="80px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtissuedate"
                                                PopupButtonID="imgPopBtnissue" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                                            <asp:ImageButton ID="imgPopBtnissue" ImageAlign="AbsBottom" ImageUrl="~/images/imgCalendar.png"
                                                runat="server" />
                                            <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                            </asp:ScriptManager>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Depot :
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList AutoPostBack="true" ID="ddlDepot" runat="server" Width="216px">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                            Branch Indent. :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtMRVNo" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Indent No :
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlRef" runat="server" Width="216px">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                            Approved By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtapproved" Text="DY.GM (Store)" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Receiver Name :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtwname" runat="server" MaxLength="30" Width="200px"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Designation :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtdesig" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Gate Pass No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtgate" MaxLength="10" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Remark :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="168px"></asp:TextBox>
                                            <%--<asp:TextBox ID="txtpart_of_bus" runat="server" Width="168px"></asp:TextBox>--%>
                                            <%--<asp:DropDownList ID="ddlpartofbus" runat="server" Width="216px">
                                            </asp:DropDownList>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                        </td>
                                        <td align="left">
                                            <asp:ImageButton ID="btnShow" runat="server" ImageUrl="~/images/show.gif"></asp:ImageButton>
                                            <%--<asp:DropDownList ID="ddlremark" runat="server" Width="216px">
                                            </asp:DropDownList>--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <div align="center">
                                    <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                        Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                    <%--                        <asp:BoundColumn DataField="Indent_Bus_No" HeaderText="Bus No"></asp:BoundColumn>--%>
                                            <asp:BoundColumn DataField="Subrack_no" ItemStyle-HorizontalAlign="Left" HeaderText="Bin No">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="part_no" ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false"
                                                HeaderText="Part No"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="item_name" ItemStyle-HorizontalAlign="Left" HeaderText="Item Name">
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Avb Qty">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblavbqty" Text='<%# DataBinder.Eval(Container, "DataItem.avbqty") %>'
                                                        runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Req Qty">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblreqqty" Text='<%# DataBinder.Eval(Container, "DataItem.Inddet_reqqty") %>'
                                                        runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Issue Qty">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtissueqty" Style="text-align: right" Width="40px" Text='<%# DataBinder.Eval(Container, "DataItem.Inddet_reqqty") %>'
                                                        MaxLength="6" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Worker" Visible="false">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtworker" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:BoundColumn DataField="Inddet_itemcode" Visible="false"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="Inddet_id" Visible="false"></asp:BoundColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trsave" runat="server" visible="false">
                            <td style="height: 22px">
                                <div align="center">
                                    <p>
                                        <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/images/save.gif" TabIndex="9">
                                        </asp:ImageButton>
                                        <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="10">
                                        </asp:ImageButton>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="mpagebottam">
                </div>
            </div>
        </div>
    </div>
    <script>

        //-->


        $(document).ready(function () {
            SearchText();

        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);


            $("#txtwname").autocomplete
           ({

               source: function (request, response) {
                   $.ajax
                    ({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "MTV.aspx/GetAutoCompletereceivername",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": document.getElementById('ddlDepot').options[document.getElementById('ddlDepot').selectedIndex].value, "SearchText": document.getElementById('txtwname').value }),
                        //dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

               }
           });




        }
       
        
    </script>
</asp:Content>

