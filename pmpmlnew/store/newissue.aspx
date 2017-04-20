<%@ Page Language="VB" AutoEventWireup="false" CodeFile="newissue.aspx.vb" Inherits="kdmt.newissue" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Item Issue</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>

    <script language="javascript" src="../Scripts/LogSheetIssue.js">
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script language="javascript">
        var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 2;

        var ex = /^[0-9]+\.?[0-9]*$/;

        function checkqty(id, lblavbqty, reqqty,lblbal) {

            claimqty = document.getElementById(lblavbqty).innerHTML
            if (document.getElementById(id).value != '') {
                if (ex.test(document.getElementById(id).value) == false) {
                    alert('please Enter numbers Only.');
                    document.getElementById(id).focus()
                    //                    setTimeout(function() { document.getElementById(id).focus() }, 10);
                    return false;
                }

                if (parseFloat(document.getElementById(id).value) > parseFloat(claimqty)) {
                    alert('Should be less than Available Qty')
                    document.getElementById(id).focus()
                    //                    setTimeout(function() { document.getElementById(id).focus() }, 10);
                    return false;
                }
                if (parseFloat(document.getElementById(id).value) > parseFloat(reqqty)) {
                    alert('Should be less than Request Qty')
                    document.getElementById(id).focus()
                    //                    setTimeout(function() { document.getElementById(id).focus() }, 10);
                    return false;
                }
                document.getElementById(lblbal).innerHTML = parseFloat(claimqty) - parseFloat(document.getElementById(id).value)
                return true;

            }
        }








        function validate() {
//            if (document.getElementById("txtref").value.length == 0) {
//                alert('Please Enter Request No');
//                document.getElementById("txtref").focus()
//                return false;
//            }
            if (document.getElementById("ddlindent").selectedIndex == 0) {
                alert('Select Indent No');
                document.getElementById("ddlindent").focus()
                return false;
            }

            if (document.getElementById("txtapproved").value.length == 0) {
                alert('Please Enter Approvedby Name');
                document.getElementById("txtapproved").focus()
                return false;
            }
            var grdvat = document.getElementById('<%= dgresult.clientID %>');
            var i = 0;
            var j = 0
            var value = 0;
            var vcount = grdvat.rows.length;
            var qtyexist = 0;
            var itemexist = 0;
 
            for (i; i < vcount - 1; i++) {
                var rowel = grdvat.rows[i];
                //grddetail__ctl2_ + ''
                j = i + 2
                 
                var lblitem = 'dgresult__ctl' + j + '_lblitem'
                var txtqtyid = 'dgresult__ctl' + j + '_txtissueqty'
                var txtqty = document.getElementById(txtqtyid);
                if (txtqty.value == '') { txtqty.value = 0 }
                if (txtqty.value != 0) {
                    qtyexist = 1;
                }
                if (document.getElementById(lblitem).innerHTML == 'No') {
                    alert('please Correct all the item');
                    document.getElementById('dgresult__ctl' + j + '_txtlfno').focus();
                    return false;
                }
                if (qtyexist == 0) {
                    alert('please enter issue qty');
                    document.getElementById('dgresult__ctl2_txtissueqty').focus();
                    return false;
                }


            }


            return true;
        }




        ///////////   for removing blaak spaces 
        String.prototype.trim = function() {

            return this.replace(/^\s+|\s+$/g, "");
        }


        function check() {
            var str = document.getElementById('ddlitem').value;
            if (str.trim() != '') {
                ajaxFunction();
            }
            return false;
        }

        function check1() {
            var str = document.getElementById('ddlitem').value;
            if (str.trim() != '') {
                Fromcombo2();
            }
            return false;
        }





        function ajaxFunction(txtlfno, txtitemname, txtpartno, selectlist, lblitem, id) {

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

                    if (resp == 0) {
                        document.getElementById(selectlist).style.display = 'none';

                        document.getElementById(lblitem).innerHTML = 'No'
                        document.getElementById(lblitem).style.color = "#ff0000";

                        return false;
                    }
                    if (ele.length == 0) {
                        document.getElementById(lblitem).innerHTML = 'YES'
                        document.getElementById(lblitem).style.color = "#000000";
                    }


                    //			                          

                    while (document.getElementById(selectlist).options.length > 0)
                        document.getElementById(selectlist).options.remove(document.getElementById(selectlist).options.length - 1);
                    if (document.getElementById(txtitemname).value != "" || document.getElementById(txtlfno).value != "" || document.getElementById(txtpartno).value != "") {

                        for (var i = 0; i < ele.length; i++) {

                            var temp = document.getElementById(selectlist)
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById(selectlist).options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.innerText = ele[i];
                            if (document.getElementById(txtitemname).value == ele[i]) {
                                //                                temp.style.display = "none";
                                //                                return false;
                            }
                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                // return false;
                            }

                        }

                    }
                    else {
                        var temp = document.getElementById(selectlist)
                        temp.size = 0
                        temp.style.display = "none";

                    }
                }
            }


            var lfno = document.getElementById(txtlfno).value;
            var partno = document.getElementById(txtpartno).value;
            if (id == 1) {
                if (document.getElementById(txtlfno).value.length >= 3) {
                    document.getElementById(txtpartno).value = ''
                    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=&item=&lfno=" + lfno + '&partno=&t=' + new Date();
                    xmlHttp.open("GET", url, true);
                    xmlHttp.send(null);
                }
            }
            if (id == 2) {
                if (document.getElementById(txtlfno).value.length > 0) {
                    document.getElementById(txtlfno).value = ''
                    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=&item=&lfno=&partno=" + partno + "&t=" + new Date();
                    xmlHttp.open("GET", url, true);
                    xmlHttp.send(null);
                }
            }
            if (id == 3) {
                if (document.getElementById(txtitemname).value.length >= 3) {
                    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById(txtitemname).value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                    xmlHttp.open("GET", url, true);
                    xmlHttp.send(null);
                }
            }


            //            if (lfno == "" && partno == "") {
            //                if (document.getElementById(txtitemname).value.length >= 3) {
            //                    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById(txtitemname).value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
            //                    xmlHttp.open("GET", url, true);
            //                    xmlHttp.send(null);
            //                }
            //                else {
            //                    document.getElementById(selectlist).style.display = 'none'
            //                }
            //            }
            //            else {
            //                url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById(txtitemname).value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
            //                xmlHttp.open("GET", url, true);
            //                xmlHttp.send(null);
            //            }
        }



        function select(itemname, selectlist) {
            var resultStr = "";
            objddl2 = document.getElementById(selectlist);
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById(itemname);
                    objddl1.value = resultStr;
                    document.getElementById(selectlist).style.display = 'none';
                    document.getElementById(itemname).focus();
                    return false;
                }
            }
        }

        function hidelist(selectlist) {
            document.getElementById(selectlist).style.display = 'none';
            return true;
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


        function Fromcombo2(txtlfno, txtitemname, txtpartno, selectlist, lblavb, lblitem) {

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
                    if (resp != 'empty') {

                        var ele1 = resp.split('|');
                        document.getElementById(lblitem).innerHTML = 'Yes'
                        document.getElementById(lblitem).style.color = "#000";
                        document.getElementById(lblavb).innerHTML = ele1[0];
                        document.getElementById(txtpartno).value = ele1[2];
                        document.getElementById(txtlfno).value = ele1[3];
                    }
                    else {

                        document.getElementById(lblitem).innerHTML = 'No'
                        document.getElementById(lblitem).style.color = "#ff0000";
                    }



                }
            }
            var itemname = document.getElementById(txtitemname).value;
            var lfno = document.getElementById(txtlfno).value;
            var partno = document.getElementById(txtpartno).value;
            xmlHttp.open("GET", "AjaxStore.aspx?Action=itemqtynew&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno, true);
            xmlHttp.send(null);
        }

        function emptytext(txtpartno, txtitemname) {
            if (document.getElementById(txtpartno).value != '' && document.getElementById(txtitemname).value != '') {
                //                document.getElementById(txtpartno).value = '';
                //document.getElementById(txtitemname).value = '';
            }
        }

        function emptytextpart(txtlfno, txtitemname) {
            if (document.getElementById(txtlfno).value != '' && document.getElementById(txtitemname).value != '') {
                //                document.getElementById(txtlfno).value = '';
                //document.getElementById(txtitemname).value = '';
            }
        }

        function check1(txtlfno, txtitemname, txtpartno, selectlist, lblavb, lblitem) {
            var str = document.getElementById(txtitemname).value;
            if (str.trim() != '') {
                Fromcombo2(txtlfno, txtitemname, txtpartno, selectlist, lblavb, lblitem);
            }
            return false;
        }    


        

 
    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">Item Issue (
                                    <asp:Label ID="lbldepttype" Text="" ForeColor="red" runat="server"></asp:Label>
                                    )</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <%--<td align="right">
                                            Depot Name:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlvendor" TabIndex="1" runat="server" Width="216px" Height="25"
                                                Font-Size="Medium">
                                            </asp:DropDownList>
                                        </td>--%>
                                        <td align="right">
                                            Indent No :
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlindent" AutoPostBack="true"  runat="server" 
                                                style="height: 22px">
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="txtref" AutoPostBack="true" runat="server" Height="20" Font-Size="Medium"></asp:TextBox>--%>
                                        </td>
                                        <td align="right">
                                            Date : -
                                        </td>
                                        <td align="left">
                                            <BDP:BDPLite ID="BDPLite1" runat="server" Height="20" Font-Size="Medium">
                                            </BDP:BDPLite>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Worker Name :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtwname" runat="server" Width="168px" Height="20" Font-Size="Medium"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Approved By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtapproved" runat="server" Width="168px" Height="20" Font-Size="Medium"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Gate Pass No :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtgate" runat="server" Height="20" Font-Size="Medium"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Remark :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="168px" Height="20"
                                                Font-Size="Medium"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DataGrid ID="dgresult" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                    runat="server" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr No">
                                            <ItemTemplate>
                                                <%#Container.ItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="indent_dtl_id" Visible="False"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="LFNo">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtlfno" MaxLength ="4" Width="50px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.lfno") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Part No">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtpartno" MaxLength ="50" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.part_no") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Nomenclature">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtitemname"  MaxLength ="50"  runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.item_name") %>'></asp:TextBox>
                                                <asp:ListBox ID="Select1" Style="display: none; align: left" runat="server"></asp:ListBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="reqqty" HeaderText="Required Qty"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Avb Qty">
                                            <ItemTemplate>
                                                <asp:Label ID="lblavb" Text='<%# DataBinder.Eval(Container, "DataItem.avbqty") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="issue Qty">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtissueqty" MaxLength ="5" Width="40px" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Bal Qty">
                                            <ItemTemplate>
                                                <asp:Label ID="lblbal" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Item Exist">
                                            <ItemTemplate>
                                                <asp:Label ID="lblitem" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="ind_locid" Visible="False"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="itemcode" Visible="False"></asp:BoundColumn>
                                    </Columns>
                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                </asp:DataGrid>
                                <%--    <table id="Grd_Item" width="100%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbodyIndent">
                                        <tr>
                                        </tr>
                                        <tr class="gridhead">
                                            <td>
                                                SR No.
                                            </td>
                                            <td>
                                                LF No
                                            </td>
                                            <td>
                                                Part No.
                                            </td>
                                            <td>
                                                Item Name
                                            </td>
                                            <td>
                                                Available<br />
                                                Qty.
                                            </td>
                                            <td>
                                                Issue
                                                <br />
                                                Qty.
                                            </td>
                                            <td>
                                                Bal
                                                <br />
                                                Qty.
                                            </td>
                                            <td>
                                                Bus No
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr class="gridtxt">
                                            <td>
                                                <input type="text" style="display: none" id="lblsrno" style="width: 20px" readonly="readonly"
                                                    size="10" />
                                            </td>
                                            <td align="left" style="width: 100px; height: 28px;">
                                                <asp:TextBox class="textfield" ID="txtlfno" TabIndex="9" onblur="emptytext();ajaxFunction();"
                                                    runat="server" Width="100px" Height="20" Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td align="left" style="width: 100px; height: 28px;">
                                                <asp:TextBox class="textfield" ID="txtPartNo" onblur="emptytextpart();ajaxFunction();"
                                                    runat="server" Width="100px" Height="20" Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="ddlitem" onpropertychange="ajaxFunction();" TabIndex="10" onblur="return check1();"
                                                    runat="server"></asp:TextBox>
                                                <asp:ListBox ID="Select1" Style="display: none; align: left" onclick="Select();"
                                                    runat="server"></asp:ListBox>
                                            </td>
                                            <td align="left" style="width: 43px; height: 28px;">
                                                <asp:TextBox ID="txtbqty" onfocus="chkItemName()" TabIndex="11" runat="server" Width="56px"
                                                    ReadOnly="True" Height="20" Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtqty" onblur="ticFunction2()" TabIndex="12" runat="server" Width="56px"
                                                    Height="20" Font-Size="Medium"> </asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtbalqty" ReadOnly="true" runat="server" Width="56px" Height="20"
                                                    Font-Size="Medium"> </asp:TextBox>
                                            </td>
                                            <td style="height: 28px; width: 55px;">
                                                <asp:TextBox ID="txtRefNo" TabIndex="13" onblur="addissueitem ()" runat="server"
                                                    Width="56px" Height="20" Font-Size="Medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>--%>
                            </td>
                        </tr>
                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                        <tr>
                            <td style="height: 22px">
                                <div align="center">
                                    &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" TabIndex="14" ImageUrl="../images/btn_h.gif">
                                    </asp:ImageButton><asp:ImageButton ID="btnclear" TabIndex="15" runat="server" ImageUrl="../images/cancel.gif">
                                    </asp:ImageButton></div>
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

    <script type="text/javascript">
<!--
        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", { imgRight: "SpryAssets/SpryMenuBarRightHover.gif" });
//-->

    </script>

</body>
</html>
