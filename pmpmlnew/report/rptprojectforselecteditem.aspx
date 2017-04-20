<%@ Page Language="VB" AutoEventWireup="false" EnableEventValidation="false" CodeFile="rptprojectforselecteditem.aspx.vb"
    Inherits="kdmt.rptprojectforselecteditem" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<html>
<head>
    <title>Selected Item Projection Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>

    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>

    <script language="javascript">


        ///////////   for removing blaak spaces 
        String.prototype.trim = function() {

            return this.replace(/^\s+|\s+$/g, "");
        }

        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;
        var rowcntsave = 1;



        function addDetails() {

            if (document.getElementById('hdnsrno').value == '') {
                document.getElementById('hdnsrno').value = 0;
            }
            var srno = 0;
            var itemcode = document.getElementById('hdnitemcode');
            var lblsrno = document.getElementById('lblsrno');
            var txtlfNo = document.getElementById('txtlfno');
            var txtCodeNo = document.getElementById('txtCodeNo');
            var txtNomenclature = document.getElementById('txtNomenclature');

            var tbody = document.getElementById('tbodyIndent');

            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntsave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'tdsrno_' + rowcntsave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'tdlfno_' + rowcntsave);
            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'tdCodeNo_' + rowcntsave);
            var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'tdNomenclature_' + rowcntsave);
            var cells5 = row.insertCell(4);


            var cells6 = row.insertCell(5);

            cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
            document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

            cells2.innerHTML = txtlfNo.value;
            cells3.innerHTML = txtCodeNo.value;
            cells4.innerHTML = txtNomenclature.value;

            debugger
            cells5.innerHTML = '<input id="hdnitemcode_' + rowcntsave + '" type="hidden" value="' + itemcode.value + '" name="hdnitemcode_' + rowcntsave + '" /> <a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntsave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            rowcntsave = rowcntsave + 1;
            lblsrno.value = '';
            txtlfNo.value = '';
            txtCodeNo.value = '';
            txtNomenclature.value = '';
            itemcode.value = "0";
            txtlfNo.focus();
            document.getElementById('hdnrwcnt').value = rowcntsave;
            // alert(document.getElementById('hdnrwcnt').value)
        }




        function Amount() {

            //            var itemcode = document.getElementById('hdnitemcode');
            //            if (itemcode.value == "0") {
            //                Fromcombo2();
            //            }
            var txtNomenclature = document.getElementById('txtNomenclature');
            var Rate = document.getElementById('txtRate');
            var Amt = document.getElementById('txtAmount');
            if (txtNomenclature.value == '') {
                alert('Enter the Item');
                setTimeout(function() { txtNomenclature.focus() }, 10);
                return false;
            }
            return addDetails();
            return true;
        }

        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;

            document.getElementById('hdnsrno').value = 0;
            for (i = 1; i < hdnrwcnt.value; i++) {
                if (document.getElementById('tdNomenclature_' + i) != null) {
                    document.getElementById('tdsrno_' + i).innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1
                    document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1

                }


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
                        document.getElementById("Select1").style.display = 'none';
                        return false;
                    }

                    var ele = resp.split("!");

                    while (document.getElementById("Select1").options.length > 0)

                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.getElementById('txtNomenclature').value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtCodeNo').value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById("Select1")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("Select1").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.text = ele[i];
                            if ((document.getElementById('txtNomenclature').value == ele[i]) && (document.getElementById('txtNomenclature').value != '')) {
                                document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                                return false;
                            }


                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                //  return false;
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById("Select1")
                        temp.size = 0
                        //temp.style.display="none";
                        temp.style.display = '';
                    }
                }
            }
            var lfno = document.getElementById('txtlfno').value;
            var partno = document.getElementById('txtCodeNo').value;

            if (lfno == "" && partno == "") {
                if (document.getElementById('txtNomenclature').value.length >= 3) {
                    url = "../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById('txtNomenclature').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                    xmlHttp.open("GET", url, true);
                    xmlHttp.send(null);
                }
                else {
                    // document.getElementById("<%= Select1.clientID %>").options.length = 0;
                    document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                }
            }
            else {
                url = "../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById('txtNomenclature').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
        }
        function check1() {

            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() != '') {
                Fromcombo2();
            }


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
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');

                    // document.getElementById('txtbqty').value =ele1[0];
                    //document.getElementById('txtRate').value =ele1[1];
                    document.getElementById('txtCodeNo').value = ele1[2];
                    document.getElementById('txtlfno').value = ele1[3];
                    document.getElementById('hdnitemcode').value = ele1[4];
                }
            }
            var itemname = document.getElementById('txtNomenclature').value;
            var lfno = document.getElementById('txtlfno').value;
            var partno = document.getElementById('txtCodeNo').value;
            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno, true);
            //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
            xmlHttp.send(null);
        }

        function emptytext() {

            if (document.getElementById('txtlfno').value != '' && document.getElementById('txtNomenclature').value != '') {
                document.getElementById('txtlfno').value = '';
                document.getElementById('txtNomenclature').value = '';
            }
        }

        function emptytextpart() {
            if (document.getElementById('txtCodeNo').value != '' && document.getElementById('txtNomenclature').value != '') {
                document.getElementById('txtCodeNo').value = '';
                document.getElementById('txtNomenclature').value = '';
            }
        }

        function Select() {

            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtNomenclature');
                    objddl1.value = resultStr.trim();
                    document.getElementById('Select1').style.display = "none";
                    Fromcombo2();
                    // document.getElementById('txtNomenclature').focus();
                    return false;
                    //alert(resultStr)
                }
            }

        }


        function save() {
            var detvalues = '';
            var i = 0;
            var hdnrwcnt = document.getElementById('hdnrwcnt').value;
            var hdnitemcodelist = document.getElementById("hdnitemcodelist");


            for (i = 1; i < hdnrwcnt; i++) {
                if (document.getElementById('tdNomenclature_' + i) != null) {



                    var lfno = document.getElementById('tdlfno_' + i).innerHTML;
                    var partno = document.getElementById('tdCodeNo_' + i).innerHTML;
                    var name = document.getElementById('tdNomenclature_' + i).innerHTML;
                    var itemcode = document.getElementById('hdnitemcode_' + i).value;


                    detvalues = detvalues + lfno + '^' + partno + '^' + name + '^' + itemcode + '^' + '|';
                    hdnitemcodelist.value = hdnitemcodelist.value + itemcode + ','
                }

            }

            var str = hdnitemcodelist.value;
            if (str.charAt(str.length - 1) == ",") {
                hdnitemcodelist.value = (str.slice(0, -1));
            }
            document.getElementById("hdndetail").value = detvalues
            return true;
        }

    </script>

    <!--[if IE] -->
    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
</head>
<body class="body">
    <form id="Form1" runat="server">
    <a href="storereport.aspx" class="ctrl">Back</a>
    <input id="hdnID" runat="server" type="hidden" name="hdnID" />
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
    <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
    <input id="hdnitemcode" runat="server" value="0" type="hidden" name="hdnitemcode" />
    <input id="hdnitemcodelist" runat="server" type="hidden" name="hdnitemcodelist" />
    <table id="Table2" align="center" style='font-family: Times New Roman; font-size: 12px;
        width: 750px;' cellspacing="0" cellpadding="0" border="1" runat="server">
        <tr>
            <td colspan="4" align="center">
                <strong><span style='font-family: Times New Roman; font-size: 16px; width: auto;'>PUNE
                    MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED </span></strong>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
                <strong><span style='font-family: Times New Roman; font-size: 16px; width: auto;'>Selected
                    Item Projection Report </span></strong>
            </td>
        </tr>
        <tr>
            <td>
                Date :
                <asp:Label ID="lbldate" Text="" runat="server"></asp:Label>
            </td>
        </tr>
        <tr id="trhtml" runat="server" class="ctrl">
            <td id="tdindent" colspan="6">
                <div style="border: solid 2px #000">
                    <table id="tblIndent" width="100%" border="1" cellpadding="2" cellspacing="2">
                        <tbody runat="server" id="tbodyIndent">
                            <tr class='gridhead'>
                                <td>
                                    SR No.
                                </td>
                                <td>
                                    LF No.
                                </td>
                                <td>
                                    Part No.
                                </td>
                                <td>
                                    Nomenclature
                                </td>
                            </tr>
                            <tr class='gridtxt'>
                                <td>
                                    <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                </td>
                                <td>
                                    <input type="text" id="txtlfno" style="width: 40px" size="10" onblur="emptytext();itemsearch()" />
                                </td>
                                <td>
                                    <input type="text" id="txtCodeNo" onblur="emptytextpart();itemsearch();" />
                                </td>
                                <td>
                                    <input type="text" id="txtNomenclature" onpropertychange="itemsearch()" onblur="check1();" />
                                    <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                        runat="server"></asp:ListBox>
                                </td>
                                <td>
                                    <input type="button" id="Button1" value="ADD" onclick="return Amount();" name="btnadd" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnshow" runat="server" Text="Print" Style="height: 26px" />
                                    <asp:Button ID="btncry" runat="server" Text="Crystal Report " />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div id="divcry" runat="server">
        <CR:CrystalReportViewer ID="crst_item_move" runat="server" AutoDataBind="true" />
    </div>
    <table id="table1" align="center" cellspacing="0" cellpadding="0" border="1" style="width: 750px"
        runat="server">
        <tr id="trlabel" runat="server" visible="false" style='font-family: Times New Roman;
            font-size: 14px; width: auto;'>
            <td align="left" style="height: 19px">
                Total :
                <asp:Label ID="lbltotal" runat="server" Font-Bold="True"></asp:Label>
                Class A :
                <asp:Label ID="lbla" runat="server" Font-Bold="True"></asp:Label>
                Class B :
                <asp:Label ID="lblb" runat="server" Font-Bold="True"></asp:Label>
                Class C :
                <asp:Label ID="lblc" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 50px">
                <div align="center">
                    <asp:DataGrid ID="grdstock" Style="align: center; valign: middle;" runat="server"
                        Width="750px" AutoGenerateColumns="False" BackColor="White" BorderColor="Black"
                        BorderStyle="None" BorderWidth="1px" CellPadding="1" ShowFooter="True" Font-Bold="False"
                        Font-Italic="False" Font-Names="Times New Roman" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" ForeColor="Black">
                        <FooterStyle BackColor="White" ForeColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Mode="NumericPages" />
                        <ItemStyle ForeColor="#000066" />
                        <HeaderStyle Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False"
                            Font-Size="14px" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <Columns>
                            <asp:TemplateColumn HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="cat" HeaderText="Category(A,B,C)" HeaderStyle-HorizontalAlign="center"
                                ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="movetype" HeaderText="Move Type" HeaderStyle-HorizontalAlign="center"
                                ItemStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Item_name" HeaderText="Nomenclature" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lf_no" HeaderText="LFNo " ItemStyle-HorizontalAlign="left"
                                ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Bin_No" HeaderText="Bin No" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="part_no" HeaderText="PartNo" ItemStyle-HorizontalAlign="left"
                                HeaderStyle-HorizontalAlign="left"></asp:BoundColumn>
                            <asp:BoundColumn DataField="Actual_min" HeaderText="Min Level" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="current_stock" HeaderText="Current Balance" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                            <asp:BoundColumn DataField="expect_15stock" HeaderText="Balance After 15" ItemStyle-HorizontalAlign="right"
                                HeaderStyle-HorizontalAlign="Center"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
