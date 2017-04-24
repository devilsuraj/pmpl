<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="Inspectionrmaster.aspx.vb"
    Inherits="kdmt.Workshop_Inspectionrmaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>Inspection Card</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>--%>

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
        function Chkbusdetails() {
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

            xmlHttp.onreadystatechange = function() {

                if (xmlHttp.readyState == 4) {

                    resp = xmlHttp.responseText;

                    var ele = resp.split("!");

                    for (var i = 0; i < ele.length; i++) {
                        if (i == 0) {
                            document.getElementById("txtjocno").value = ele[i];
                        }
                        if (i == 1) {
                            document.getElementById("txtBusNo").value = ele[i];
                        }
                        if (i == 2) {
                            document.getElementById("txtmodel").value = ele[i];
                        }
                        if (i == 3) {
                            document.getElementById("txtchassis").value = ele[i];
                        }
                        if (i == 4) {
                            document.getElementById("txtkms").value = ele[i];
                        }
                        if (i == 5) {
                            document.getElementById("txtengin").value = ele[i];
                        }
                        if (i == 6) {
                            document.getElementById("dtjobDate").value = ele[i];
                        }
                        if (i == 7) {
                            document.getElementById("txtjotime").value = ele[i];
                        }
                        if (i == 8) {
                            document.getElementById("txtmech").value = ele[i];
                        }

                        if (i == 9) {
                            document.getElementById("txtdeffect").value = ele[i];
                        }
                        if (i == 10) {

                            document.getElementById("TextBox1").value = ele[i];
                        }
                        if (i == 11) {

                            document.getElementById("txtjob").value = ele[i];
                        }
                        if (i == 12) {

                            document.getElementById("txtjobno").value = ele[i];
                        }
                    }
                }
            }

            if ((document.getElementById("txtjobno").value != '') || (document.getElementById("txtBusNo").value != '')) {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkjobbusdetails&busno=" + document.getElementById("txtBusNo").value + "&newjob=" + document.getElementById("txtjob").value + "&newjobno=" + document.getElementById("txtjobno").value, true);
                xmlHttp.send(null);
            }
            //            else {
            //                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkjobbusdetails&busno=" + document.getElementById("txtBusNo").value, true);
            //                xmlHttp.send(null);
            //            }

        }

        function Chkjobdetails() {
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

            xmlHttp.onreadystatechange = function() {

                if (xmlHttp.readyState == 4) {

                    resp = xmlHttp.responseText;

                    var ele = resp.split("!");

                    for (var i = 0; i < ele.length; i++) {
                        if (i == 0) {
                            document.getElementById("txtjocno").value = ele[i];
                        }
                        if (i == 1) {
                            document.getElementById("txtBusNo").value = ele[i];
                        }
                        if (i == 2) {
                            document.getElementById("txtmodel").value = ele[i];
                        }
                        if (i == 3) {
                            document.getElementById("txtchassis").value = ele[i];
                        }
                        if (i == 4) {
                            document.getElementById("txtkms").value = ele[i];
                        }
                        if (i == 5) {
                            document.getElementById("txtengin").value = ele[i];
                        }
                        if (i == 6) {
                            document.getElementById("dtjobDate").value = ele[i];
                        }
                        if (i == 7) {
                            document.getElementById("txtjotime").value = ele[i];
                        }
                        if (i == 8) {
                            document.getElementById("txtmech").value = ele[i];
                        }

                        if (i == 9) {
                            document.getElementById("txtdeffect").value = ele[i];
                        }
                    }
                }
            }
            if (document.getElementById("txtjocno").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkjobdetails&jobno=" + document.getElementById("txtjocno").value, true);
                xmlHttp.send(null);
            }
        }

        function chkbusno() {

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
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp;

                    if (ele1 == "NO-SUCH-ITEM") {
                        //    alert("No Such Bus Present");
                        document.getElementById("txtBusNo").focus();
                    }
                }
            }
            if (document.getElementById("txtBusNo").value != '') {
                xmlHttp.open("GET", "Ajaxstore.aspx?Action=chkbusno&busno=" + document.getElementById("txtBusNo").value, true);
                xmlHttp.send(null);
            }

        }


        function itemsearch() {
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

            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {

                    resp = xmlHttp.responseText;

                    if (resp == 0) {
                        document.getElementById("select2").style.display = 'none';
                        return false;
                    }

                    var ele = resp.split("!");

                    while (document.getElementById("select2").options.length > 0)

                        document.getElementById("select2").options.remove(document.getElementById("select2").options.length - 1);
                    if (document.getElementById('ddlsubdefect').value != "") {

                        for (var i = 0; i < ele.length; i++) {
                            var temp = document.getElementById("select2")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("select2").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.text = ele[i];

                            if ((document.getElementById('ddlsubdefect').value).toLowerCase() == (ele[i].toLowerCase())) {
                                document.getElementById("<%= select2.clientID %>").style.display = 'none'
                                document.getElementById("<%= btnadd.clientID %>").style.display = 'block'

                                return false;
                            }
                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                //  return false;
                            }
                            else {
                                document.getElementById("<%= btnadd.clientID %>").style.display = 'none'
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById("select2")
                        temp.size = 0
                        //temp.style.display="none";
                        temp.style.display = '';
                    }
                }
            }
            //var lfno = document.getElementById('txtlfno').value;
            //var partno = document.getElementById('txtPartNo').value;

            // if (lfno == "" && partno == "")
            //{
            if (document.getElementById('ddlsubdefect').value.length >= 3) {
                url = "../store/AjaxStore.aspx?Action=subdefect&subdefectid=" + document.getElementById("ddldeffect").value + "&subdefectdetail=" + document.getElementById('ddlsubdefect').value;
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
            else {
                // document.getElementById("<%= select2.clientID %>").options.length = 0;
                document.getElementById("<%= select2.clientID %>").style.display = 'none'
            }

            //            url = "../store/AjaxStore.aspx?Action=subdefect&subdefectid=" + document.getElementById("ddldeffect").value + "&subdefectdetail=" + document.getElementById('ddlsubdefect').value;
            //            xmlHttp.open("GET", url, true);
            //            xmlHttp.send(null);
            //            //}
        }


        function fillitem() {
            var resultStr = "";
            objddl2 = document.getElementById('select2');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('ddlsubdefect');
                    objddl1.value = resultStr;
                    document.getElementById("select2").style.display = 'none';
                    document.getElementById('ddlsubdefect').focus();
                    return false;
                }
            }
        }
    


    </script>

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
        <h1>Job Order Card Master</h1>
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
                                        <td colspan="4" class="innerheading">
                                            <span id="Label3">Inspection Card Master</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 500px" >
                                            Bus No.
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBusNo" AutoPostBack="true" Width="140px" runat="server"></asp:TextBox>
                                          
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
                                        <td align="left" style="display: none">
                                            <asp:TextBox ID="txtdeffect" runat="server" Width="140px" ReadOnly="True" AutoPostBack="True"></asp:TextBox>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Job Date
                                        </td>
                                        <td align="left">
                                          <asp:TextBox ID="dtjobDate" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>
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
                                            Deffect Type
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddldeffect" runat="server"  Width="125px">
                                                <%-- <asp:ListItem Text="Select" Value="00"></asp:ListItem>
                                        <asp:ListItem Text="Minor Deffect" Value="01"></asp:ListItem>
                                        <asp:ListItem Text="Major Deffect" Value="02"></asp:ListItem>--%>
                                                <%--<asp:ListItem Text="On Road Deffect" Value="03"></asp:ListItem>
                                        <asp:ListItem Text="Docking Deffect" Value="04"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                        <td colspan="2" align="center">
                                            Subdefect
                                            <asp:TextBox ID="ddlsubdefect" onpropertychange="itemsearch();"  runat="server"
                                                Width="250px" EnableTheming="True"></asp:TextBox>
                                            <asp:ListBox ID="select2" Style="display: none; align: left" onclick="fillitem();"
                                                runat="server"></asp:ListBox>
                                            <asp:Button ID="btnadd" Style="display: none;" runat="server" Text="ADD" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Job Deffect
                                        </td>
                                        <td colspan="3" align="center">
                                            <asp:TextBox ID="TextBox1" runat="server" Width="489px" ReadOnly="True" Height="69px"
                                                TextMode="MultiLine"></asp:TextBox>
                                            <%--<asp:Button ID="btnshow" runat="server" Text="Show Deffect Details" 
                                      style="height: 26px" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            Jobs Deatils
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
                                        <td colspan="4" align="center">
                                            <div align="center">
                                                <asp:DataGrid ID="grddeffectlist" Style="align: center; valign: middle;" runat="server"
                                                    Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                                                        <asp:BoundColumn DataField="srno" HeaderText="Sr No"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="subdeffectid" HeaderText="subdeffect_id" Visible="false">
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="deffecttypeid" HeaderText="deffecttypeid" Visible="false">
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="deffect" HeaderText="Deffect Type"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="subdeffect" HeaderText="Sub Deffect Type"></asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Task Done">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txttaskdone" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                         <asp:TemplateColumn HeaderText="Mechanic">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtmech" Width="140px"  runat="server"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="Delete" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.srno") %>'
                                                                    CommandName="Delete" ImageUrl="../images/delete.gif" />
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                                    </Columns>
                                                </asp:DataGrid>
                                                <asp:DataGrid ID="grddetails" Style="align: center; valign: middle;" runat="server"
                                                    Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
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
                                                        <asp:BoundColumn DataField="item_name" HeaderText="Item Name" >
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="part_no" HeaderText="Part No" >
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="total_qty" HeaderText="Total Qty"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="wname" HeaderText="Worker Name"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="approvedby" HeaderText="Approved By"></asp:BoundColumn>
                                                        
                                                        
                                                        <%--<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete"></asp:ButtonColumn>--%>
                                                    </Columns>
                                                </asp:DataGrid>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <%--<td align="right" rowspan="0">
                                            Mechanic
                                        </td>--%>
                                        <%--<td align="left">
                                            <input type="text" id="txtmech" style="width: 200px" class="textfield" runat="server" />
                                            <%-- <asp:TextBox ID="txtmech" runat="server" Width="140px" ReadOnly="True"></asp:TextBox>--%>
                                            <%--<asp:DropDownList ID="ddlmech" runat="server" Width="150px">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Mech1"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Mech2"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Mech3"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="Mech4"></asp:ListItem>
                                    </asp:DropDownList>--%>
                                        </td>
                                        <td colspan="4">
                                            <table id="Table1" width="100%" border="1" align="right" cellpadding="5" cellspacing="5">
                                                <tr>
                                                    <td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                        border-left-style: none; width: 100px;">
                                                        Inspection Note
                                                    </td>
                                                    <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                        border-left-style: none;">
                                                        <asp:TextBox ID="txtinspectionnote" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <%--<td align="right" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                        border-left-style: none;">
                                                        Note
                                                    </td>--%>
                                                   <%-- <td align="left" style="border-bottom-style: none; border-right-style: none; border-top-style: none;
                                                        border-left-style: none;">
                                                        <asp:TextBox ID="txtnote" runat="server" Width="350px" Height="70px"></asp:TextBox>
                                                    </td>--%>
                                                </tr>
                                            </table>
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
    </form>

    <script>
    var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->
 $(document).ready(function() {
                SearchText();
                loadArrayDd();
        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);
           
            
            $("#ddlsubdefect").autocomplete
           ({

               source: function(request, response) {
                   $.ajax
                    ({
                    
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Job_Order_Card.aspx/GetAutoCompleteData",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": document.getElementById ('ddldeffect').options[document.getElementById ('ddldeffect').selectedIndex].value, "SearchText": document.getElementById('ddlsubdefect').value }),
                        //dataType: "json",
                        success: function(data) {
                            response(data.d);
                        },
                        error: function(result) {
                            alert("Error");
                        }
                    });

               }
           });
         
            $("#txtBusNo").autocomplete
           ({
            source: [<%= strBusno  %>]
            });
            
          
            
      
            
            $(document).ready(function(){
    $("#ddldeffect").change(function(){
       $("#ddlsubdefect").val("") ;
    });

})
       }
       function loadArrayDd() {
         
                }
    </script>
     <script type="text/javascript" language="javascript">

        //-->


        $(document).ready(function () {
            SearchText1();
            loadArrayDd();
        });
        function SearchText1() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);
            debugger;

           <% =strmechanic  %>

        }
       
       
    </script>

</asp:Content>