<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="sub_store_rec_new.aspx.vb"
    Inherits="kdmt.sub_store_rec_new" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" src="../Scripts/LogSheetReceipt.js">
    </script>

    <script language="javascript">


        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;

        function addrecitem() {



            if (document.getElementById("txtqty").value.length > 0) {
                if (IsNumeric(document.getElementById("txtqty").value)) {
                    addrecDetails();
                }
                else {
                    alert("Enter Proper Value");
                    setTimeout(function () { document.getElementById('txtqty').focus() }, 10);
                    return false;
                }
            }
        }






        var clockID = 0;

        function UpdateClock() {
            if (clockID) {
                clearTimeout(clockID);
                clockID = 0;
            }

            var tDate = new Date();

            //lbltime.innerHTML = "" + tDate.getHours() + ":" + tDate.getMinutes() + ":" + tDate.getSeconds();

            clockID = setTimeout("UpdateClock()", 1000);
        }
        function StartClock() {
            clockID = setTimeout("UpdateClock()", 500);
        }

        function KillClock() {
            if (clockID) {
                clearTimeout(clockID);
                clockID = 0;
            }
        }

        function fillActualQty() {
            if (document.getElementById("txtChallnQty").value.length > 0) {
                if (IsNumeric(document.getElementById("txtChallnQty").value)) {
                    document.getElementById("txtqty").value = document.getElementById("txtChallnQty").value;
                }
                else {
                    alert("Enter Proper Value");
                    document.getElementById("txtChallnQty").focus();
                }
            }
        }
        function fillItemName() {
            objddl2 = document.getElementById('Select1');
            if (document.getElementById("ddlitem").value != "" && objddl2.options.length > 0) {
                document.getElementById("ddlitem").value = objddl2.options[0].text;
                document.getElementById("txtRate").focus();
            }

        }
        function chkItemName() {
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
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp;

                    if (ele1 == "NO-SUCH-ITEM") {

                        alert("No Such Item Present");
                        document.Form1.ddlitem.focus();

                    }

                }
            }
            var cat = document.Form1.ddlitem.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=chkitemname&itemid=" + document.Form1.ddlitem.value, true);
            xmlHttp.send(null);
        }
        function validate() {
            if (Right(10201, 2) == false) { return false; };
            var chkcnt = 0;
            if (IsValidDate(document.getElementById("txtrecdate").value) == false) {
                alert('Incorrect Rec Date Format');
                document.getElementById("txtrecdate").focus()
                return false;
            }

            else if (document.getElementById("txtWrkName").value == '') {
                alert('Please Enter Worker Name');
                document.getElementById("txtWrkName").focus()
                return false;
            }
            else if (document.getElementById("Txtmtv").value == '') {
                alert('Please Enter MTV NO');
                document.getElementById("Txtmtv").focus()
                return false;
            }

            var grdvat = document.getElementById('grddetails');
            var i = 0;
            var j = 0
            var value = 0;
            var vcount = grdvat.rows.length;

            for (i; i < vcount - 1; i++) {
                var rowel = grdvat.rows[i];
                //grddetail__ctl2_ + ''
                j = i + 2
                var id = 'grddetails__ctl' + j + '_txtissueqty'
                var issueqty = document.getElementById(id);
                if (issueqty.value == '') { issueqty.value = 0 }
                if (parseFloat(issueqty.value) > 0) {
                    value = 1
                }
            }

            if (value == '0') {
                alert('Please Enter Receive Qty ');
                document.getElementById('grddetails__ctl2_txtissueqty').focus();
                return false;
            }

            return true;
        }

        ///////////////////  for filteration ///////////////////////////////////////

        function ajaxFunction() {
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

                    if (resp == 0) {
                        //alert("No Such item")
                        return false;
                    }

                    var ele = resp.split("!");
                    //  temporary comment 
                    while (document.getElementById("Select1").options.length > 0)

                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.Form1.ddlitem.value != "") {


                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("Select1")
                            temp.style.display = "block";
                            temp.size = ele.length;
                            //alert("asdasd")
                            newOpt = document.createElement("OPTION");
                            document.getElementById("Select1").options.add(newOpt);

                            //str=ele[i];
                            //alert (ele[i] + "ravi")
                            newOpt.value = ele[i];
                            newOpt.innerText = ele[i];
                            if (document.Form1.ddlitem.value == ele[i]) {
                                //alert("ravi")
                                temp.style.display = "none";
                                return false;
                            }
                            if (ele[i] == "0") {
                                //alert("raviwewerwer")
                                temp.style.display = "none";
                                return false;
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById("Select1")
                        temp.size = 0
                        temp.style.display = "none";

                    }
                }
            }
            xmlHttp.open("GET", "AjaxStore.aspx?Action=itemname1&itemid=" + document.Form1.ddlcat.value + "&item=" + document.Form1.ddlitem.value, true);

            xmlHttp.send(null);

        }



        function Select() {

            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('ddlitem');
                    objddl1.value = resultStr;
                    var x = document.getElementById('Select1');
                    x.style.display = "none";
                    document.getElementById("ddlitem").focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }

        //////////////   end  filteration   ///////////////////////////



        // check for numeric fields only

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








        function ticFunction2() {
            if (document.getElementById("txtqty").value.length > 0) {

                if (IsNumeric(document.getElementById("txtqty").value)) {
                    LogSheet_receive();
                }
                else {

                    alert("Enter Proper Value");
                    document.getElementById("txtqty").focus();
                }
            }
        }


        function ticFunction1() {
            BLogSheet();
        }



        function Fromcombo2() {

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
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');
                    //alert(resp)

                    Form1.txtbqty.value = ele1[0];
                    Form1.txtRate.value = ele1[1];



                }
            }
            var cat = document.Form1.ddlitem.value;
            var itemname = document.Form1.ddlitem.value;

            xmlHttp.open("GET", "Ajaxstore.aspx?Action=itemqty&itemid=" + itemname, true);
            xmlHttp.send(null);
        }





        function Fromcombo() {
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
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split("!");
                    while (document.getElementById("ddlitem").options.length > 0)
                        document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length - 1);
                    document.getElementById("ddlitem").value == "";
                    var temp = document.getElementById("ddlitem")
                    //if(document.Form1.txtroute.value !="")
                    // {
                    for (var i = 0; i < ele1.length - 1; i++) {
                        var temp = document.getElementById("ddlitem")
                        newOpt = document.createElement("OPTION");
                        document.getElementById("ddlitem").options.add(newOpt);
                        newOpt.value = ele1[i];
                        newOpt.innerText = ele1[i];
                        //								//if (document.Form1.txtroute.value==ele1[i])
                        //								//{
                        //								//    temp.style.display="none";				               
                        //				               //     return false;
                        //								}
                        //                               	if (ele1[i]=="0")
                        //								{
                        //								    temp.style.display="none";				               
                        //				                    return false;
                        //								}			                         
                    }

                    //}

                    //else
                    //{
                    //var temp=document.getElementById("ddlfrom")
                    //temp.size=0;
                    //temp.style.display="none";
                    //}
                }
            }
            var cat = document.Form1.ddlcat.value;
            //alert(cat);
            xmlHttp.open("GET", "Ajaxstore.aspx?Action=itemname&itemid=" + document.Form1.ddlcat.value, true);
            xmlHttp.send(null);
        }


    </script>
    <style type="text/css">
        .style1 {
            width: 64px;
        }

        .style2 {
            height: 70px;
            width: 64px;
        }
    </style>
    <style>
        table {
            border-collapse: collapse !important;
        }

            table td, table th {
                background-color: #fff !important;
                text-align: left;
                padding: 10px;
                margin-top: 3px;
                font-family: "Open Sans",sans-serif;
                font-weight: 400;
                font-size: 14px;
            }


                table td input[type=number], input[type=text], input[type=date], input[type=time], input[type=password], input[type=email], select, textarea {
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

                table td textarea {
                    margin: 0;
                    font: inherit;
                    color: inherit;
                    overflow: auto;
                    height: auto;
                }

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


                table td lable {
                    font-weight: 400;
                    display: inline-block;
                    max-width: 100%;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" runat="Server">
    <div class="breadcrumbs">
        <h1>Sub Depot Receive</h1>
    </div>
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />

    <div id="middal">
        <div class="contantbox">
            <div class="orgmiddal">
                <table width="80%">
                    <%--            <usercontrol:Store ID="ucStore" runat="server" />--%>

                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td align="right">Indent No :
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlRef" runat="server" Width="216px">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left">
                                        <asp:ImageButton ID="btnShow" runat="server" ImageUrl="~/images/show.gif"></asp:ImageButton>
                                        <%--<asp:DropDownList ID="ddlremark" runat="server" Width="216px">
                                            </asp:DropDownList>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Receive No
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtrecno" runat="server"></asp:TextBox>
                                    </td>
                                    <td align="right">&nbsp;Receive Date
                                    </td>
                                    <td align="left" style="width: 200px">
                                        <asp:TextBox ID="txtrecdate" Width="120px" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtrecdate"
                                            PopupButtonID="imgPopBtnrec" Format="dd-MMM-yyyy">
                                        </asp:CalendarExtender>
                                        <asp:ImageButton ID="imgPopBtnrec" ImageAlign="AbsBottom" ImageUrl="~/images/imgCalendar.png"
                                            runat="server" />
                                        <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                        </asp:ScriptManager>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="height: 25px">Security Date
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:TextBox ID="txtsecuritydate" Width="120px" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtsecuritydate"
                                            PopupButtonID="imgPopBtnsec" Format="dd-MMM-yyyy">
                                        </asp:CalendarExtender>
                                        <asp:ImageButton ID="imgPopBtnsec" ImageAlign="AbsBottom" ImageUrl="~/images/imgCalendar.png"
                                            runat="server" />
                                    </td>
                                    <td align="right">Worker Name
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtWrkName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Gate Pass No :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtgate" runat="server" class="textfield"></asp:TextBox>
                                    </td>
                                    <td align="right">Inward No
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtinwardno" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 7px" colspan="2">
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
                                        <%--   <asp:BoundColumn DataField="Indent_Bus_No" HeaderText="Bus No"></asp:BoundColumn>--%>
                                        <asp:BoundColumn DataField="Subrack_no" ItemStyle-HorizontalAlign="Left" HeaderText="Bin No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="part_no" ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false"
                                            HeaderText="Part No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="item_name" ItemStyle-HorizontalAlign="Left" HeaderText="Item Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="avbqty" HeaderText="Avb Qty"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Inddet_reqqty" HeaderText="Req Qty"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Rec Qty">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtissueqty" Width="50px" Text="0" MaxLength="6" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="Inddet_itemcode" Visible="false"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Inddet_id" Visible="false"></asp:BoundColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                    <tr align="center">
                        <td class="style2">
                            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/save.gif"></asp:ImageButton>
                            &nbsp;
                            <asp:ImageButton ID="btnclear" runat="server" ImageUrl="../images/cancel.gif"></asp:ImageButton>
                        </td>
                    </tr>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </table>
                <asp:HiddenField ID="Hid_Rec" runat="server" />
            </div>
        </div>
    </div>
    </form>
    <script>

        //-->


        $(document).ready(function () {
            SearchText();

        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);


            $("#ddlitem").autocomplete
           ({

               source: function (request, response) {
                   $.ajax
                    ({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "storemaster.aspx/GetAutoCompleteData",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "SubId": document.getElementById('ddlcat').options[document.getElementById('ddlcat').selectedIndex].value, "SearchText": document.getElementById('ddlitem').value }),
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
