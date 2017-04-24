<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Job_Order_Card.aspx.vb"
    Inherits="kdmt.Job_Order_Card" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../scripts/jquery-1.11.0.min.js"></script>
    <script src="../scripts/jquery-ui.js"></script>
    <script language="javascript" type="text/javascript">
        function validate() {
            var ab;
            ab = document.getElementById("ddldeffect").value;
            //    alert(ab);

            if (ab == '00') {
                alert('Select Deffect Type');
                document.getElementById("ddldeffect").focus();
                return false;
            }
        }

        function chkdate() {
            //debugger
            var currentdate = Date.parse(new Date())
            var prevdate = currentdate - 1
            if ((document.getElementById("dtjobDate_TextBox").value != currentdate) && (document.getElementById("dtjobDate_TextBox").value != prevdate))
                alert('Select Correct Date');
            document.getElementById("dtjobDate_TextBox").focus();
            return false;
        }

        function Chkbusdetails(id) {


            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange = function () {

                if (xmlHttp.readyState == 4) {

                    resp = xmlHttp.responseText;
                    if (resp == "noval") {
                        //alert("Job Already Opened")
                        document.getElementById("txtBusNo").value = ""
                        document.getElementById("txtmodel").value = ""
                        document.getElementById("txtchassis").value = ""
                        document.getElementById("txtkms").value = ""
                        document.getElementById("txtengin").value = ""
                        document.getElementById("lblinsp").value = ""
                        document.getElementById("txtjocno").value = ""
                    }
                    else if (resp == "") {

                        if (id != "1") {
                            alert("Job Already Opened");
                        }


                        document.getElementById("txtBusNo").value = ""
                        document.getElementById("txtmodel").value = ""
                        document.getElementById("txtchassis").value = ""
                        document.getElementById("txtkms").value = ""
                        document.getElementById("txtengin").value = ""
                        document.getElementById("lblinsp").value = ""
                        document.getElementById("txtjocno").value = ""
                    }

                    else {

                        var ele = resp.split("!");

                        for (var i = 0; i < ele.length; i++) {
                            if (i == 0) {
                                document.getElementById("txtmodel").value = ele[i];
                            }
                            if (i == 1) {
                                document.getElementById("txtchassis").value = ele[i];
                            }

                            if (i == 2) {
                                document.getElementById("txtkms").value = ele[i];
                            }
                            if (i == 3) {
                                document.getElementById("txtengin").value = ele[i];
                            }

                            if (i == 4) {
                                document.getElementById("lblinsp").value = ele[i];

                            }
                            if (i == 5) {
                                document.getElementById("txtjob").value = ele[i];

                            }
                            if (i == 6) {
                                document.getElementById("txtjobno").value = ele[i];

                            }
                            if (i == 7) {
                                document.getElementById("txtjocno").value = ele[i];

                            }
                        }
                    }
                }
            }
            if (document.getElementById("txtBusNo").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkbusdetails&busno=" + document.getElementById("txtBusNo").value + "&deffpl=" + document.getElementById("rd3").checked, true);
                xmlHttp.send(null);
            }

        }


        function chkbus() {

            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    //debugger
                    resp = xmlHttp.responseText;
                    var ele1 = resp
                    if (ele1 == "empty") {
                        alert("This Bus No does not exists");
                        document.getElementById("txtBusNo").focus();
                    }

                }
            }

            xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkbus&busno=" + document.getElementById("txtBusNo").value, true);
            xmlHttp.send(null);
        }


        function chkbusdefect() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    //debugger
                    resp = xmlHttp.responseText;
                    var ele1 = resp
                    if (ele1 != "empty") {
                        alert("Job card for this Bus was created in last 7 days");
                        // document.getElementById("txtBusNo").focus();
                    }

                }
            }
            xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkbusDefect&busno=" + document.getElementById("txtBusNo").value, true);
            xmlHttp.send(null);
        }



        function breakdown_validations() {

            if (document.getElementById("txtrt").value == "") {
                alert("Please Enter Route No");
            }

            if (document.getElementById("txtplc").value == "") {
                alert("Please Enter Breakdown Place");
            }


            if (document.getElementById("txtdrvcode").value == "") {
                alert("Please Enter Driver Code");
            }


        }





    </script>

    <link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Job Order Card Master</h1>
    </div>
    <div class="form-horizontal">

        <asp:HiddenField ID="hdnstate" runat="server" />
        <div id="middal">

            <div class="contantbox" style="overflow: auto">
                <div class="orgtop">
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="orgmiddal">
                    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
                    <div>
                        <table width="100%" border="1" align="left" cellpadding="5" cellspacing="5">

                            <tr>
                                <td align="right" style="width: 100px">Defect Place
                                </td>
                                <td align="left">
                                    <asp:RadioButton ID="rd1" runat="server" Text="Depot" GroupName="place" AutoPostBack="True" />
                                    <asp:RadioButton ID="rd2" runat="server" Text="On Road" GroupName="place" AutoPostBack="True" />
                                    <asp:RadioButton ID="rd3" runat="server" Text="Docking" GroupName="place" AutoPostBack="True" />
                                    <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <strong>Supervisor :
                                        <asp:Label ID="lblsup" runat="server" Text=""></asp:Label></strong>--%>
                                </td>
                                <td>Shift Engineer
                                </td>
                                <td>
                                    <asp:Label ID="lblsupervisor" ForeColor="Red" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <%--<asp:TextBox ID="txtjocno" runat="server" Width="210px" ReadOnly="true"></asp:TextBox>--%>
                                    Job No
                                </td>
                                <td>
                                    <input type="text" id="txtjob" style="width: 60px" readonly="readonly" runat="server"
                                        class="textfield" runat="server" />
                                    <input type="text" id="txtjobno" style="width: 40px" readonly="readonly" runat="server"
                                        class="textfield" runat="server" />
                                </td>
                                <td align="right">Bus No
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="txtBusNo" runat="server" Width="140px" onblur="validate();"></asp:TextBox>--%>
                                    <input type="text" id="txtBusNo" style="width: 120px; background-color: LightYellow;"
                                        onblur="Chkbusdetails(0);chkbusdefect();" maxlength="4" runat="server" />
                                    <asp:Label ID="lbl" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="display: none">Job Card No &nbsp;<input type="text" id="txtjocno" style="display: none" class="textfield"
                                    runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Supervisor Name
                                </td>
                                <td align="left">
                                    <%-- <BDP:BDPLite ID="dtjobDate" runat="server" TextBoxStyle-Width="100px">
                                    </BDP:BDPLite>--%>
                                    <%-- <asp:TextBox ID="txtsupername" runat="server" Width="140px"  onblur="chkbus();"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlsupervisor" runat="server" Width="150px">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">Shift
                                </td>
                                <td align="left">
                                    <%--<asp:TextBox ID="txtshift" runat="server" Width="140px" TabIndex="13"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlshift" runat="server">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="I"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="II"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Defect Type
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddldeffect" runat="server" Width="155px" ForeColor="Black">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">Subdefect
                                </td>
                                <td>
                                    <asp:TextBox ID="ddlsubdefect" runat="server" Width="250px" EnableTheming="True"></asp:TextBox>
                                    <asp:Button ID="btnadd" runat="server" Text="ADD" /><br />
                                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Driver Code
                                </td>
                                <td>
                                    <asp:TextBox ID="txtdrvcode" runat="server" Width="190px"></asp:TextBox>
                                    <asp:TextBox ID="txtdrvname" Visible="false" runat="server" Width="190px"></asp:TextBox>
                                </td>
                                <td align="center"></td>
                                <td>
                                    <%--<asp:Label ID="lblinsp" runat="server" ForeColor="Black"></asp:Label>--%>
                                    <%--<input id="lblinsp" 
                                        style="border-style: none; width: 100%; font-weight: bold; height: 38px;" 
                                        runat="server" />--%>
                                    <asp:TextBox ID="lblinsp" runat="server" Width="100%" ReadOnly="true" Font-Bold="True"
                                        TextMode="MultiLine" ForeColor="Black"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Job Date
                                </td>
                                <td align="left">

                                    <asp:TextBox ID="dtjobDate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="dtjobDate"
                                        PopupButtonID="dtjobDate" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>

                                    <%-- <asp:TextBox ID="dtjobDate" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>--%>
                                </td>
                                <td align="right">Job Time
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtjotime" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Chassis :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtchassis" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td align="right">Model :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtmodel" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Engine :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtengin" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td align="right">KMS. :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtkms" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="onroad" runat="server" visible="false">
                                <td colspan="4" class="style3">
                                    <table>
                                        <tr id="first" visible="false">
                                            <td align="right">Route No:
                                            </td>
                                            <td align="left" class="style1">
                                                <asp:TextBox ID="txtrt" runat="server" Width="140px" Visible="true" EnableViewState="False"></asp:TextBox>
                                            </td>
                                            <td align="right">Place :
                                            </td>
                                            <td align="left" class="style2">
                                                <asp:TextBox ID="txtplc" runat="server" Width="236px" Visible="true" EnableViewState="False"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Defect Time:
                                            </td>
                                            <td align="left" class="style1">
                                                <asp:TextBox ID="txtdt" runat="server" Width="140px" Visible="true" EnableViewState="False"></asp:TextBox>
                                            </td>
                                            <td align="right">Workshop Time :
                                            </td>
                                            <td align="left" class="style2">
                                                <asp:TextBox ID="txtwt" runat="server" Width="140px" Visible="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Reason :
                                            </td>
                                            <td align="left">
                                                <textarea cols="20" rows="3" runat="server" id="txtarreason" name="S1" visible="true"></textarea>
                                            </td>
                                            <td align="right">Supervisor Name :
                                            </td>
                                            <td align="left" class="style2">
                                                <asp:TextBox ID="txtname" runat="server" Width="140px" Visible="true" EnableViewState="False"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">Defect Details
                                    <textarea cols="20" rows="3" runat="server" id="txtar"></textarea>
                                </td>
                                <td colspan="2">Remark
                                    <textarea cols="20" rows="3" runat="server" id="txtRemark"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:CheckBoxList ID="Select1" Style="align: left; display: none;" runat="server"
                                                AutoPostBack="True" RepeatDirection="Horizontal" CellPadding="2" CellSpacing="2"
                                                CssClass="chkliststyle" Height="10%" RepeatColumns="4" Width="100%">
                                            </asp:CheckBoxList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <div align="center">
                                        <asp:DataGrid ID="grddeffectlist" Style="align: center; valign: middle;" runat="server"
                                            Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                                            BorderWidth="1px" CellPadding="1" Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black"
                                            Font-Size="11pt">
                                            <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                                            <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                                                Font-Size="10pt" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="sr" HeaderText="Sr No"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="subdeffect_id" HeaderText="subdeffect_id" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect_desc" HeaderText="Defect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect_decr" HeaderText="Sub Defect Type"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="deffect_id" HeaderText="defect_id" Visible="false"></asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="Delete" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.sr") %>'
                                                            CommandName="Delete" ImageUrl="../images/delete.gif" />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" rowspan="0" style="display: none">Mechanic
                                </td>
                                <td align="left" style="display: none">
                                    <asp:DropDownList ID="ddlmech" runat="server" Width="150px">
                                        <%--  <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Mech1"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Mech2"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Mech3"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="Mech4"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2" style="display: none">
                                    <table id="Table1" width="100%" border="1" align="right" cellpadding="5" cellspacing="5"
                                        style="text-decoration: none">
                                        <tr>
                                            <td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none; width: 700px;">Inspection Note
                                            </td>
                                            <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none;">
                                                <asp:TextBox ID="txtinspectionnote" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none;">Note
                                            </td>
                                            <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none;">
                                                <asp:TextBox ID="txtnote" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <label>
                                        <%--<asp:ImageButton ID="btnSave" runat="server" ImageUrl="../images/btn_h.gif" TabIndex="9">
                                        </asp:ImageButton>--%>
                                        <asp:Button ID="btnSave" runat="server" Text="Save" Height="32px" Width="63px" OnClientClick="breakdown_validations()" />
                                    </label>
                                    &nbsp;<%--<a href="../report/rptJOC.aspx">Save</a> --%>
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" Height="32px" Width="63px" />
                                    <asp:Button ID="btndocking" runat="server" Text="Docking" Height="32px" Width="63px"
                                        Enabled="False" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="orgbottam">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>



        $(document).ready(function () {
            SearchText();
            loadArrayDd();
        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);


            $("#ddlsubdefect").autocomplete
           ({

               source: function (request, response) {
                   $.ajax
                    ({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Job_Order_Card.aspx/GetAutoCompleteData",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": document.getElementById('ddldeffect').options[document.getElementById('ddldeffect').selectedIndex].value, "SearchText": document.getElementById('ddlsubdefect').value }),
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

            $("#txtBusNo").autocomplete
           ({
               source: [<%= strBusno  %>]
           });




            $(document).ready(function () {
                $("#ddldeffect").change(function () {
                    $("#ddlsubdefect").val("");
                });

            })
        }
        function loadArrayDd() {

        }

    </script>
</asp:Content>
