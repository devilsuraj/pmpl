
<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="invoice_detail.aspx.vb" Inherits="KDMT.invoice_detail" %>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Invoice</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />

    <script language="javascript">

        function chkvendorname() {

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
                        alert("No Such Vendor Present");
                        document.getElementById("txtvendor").focus();
                    }
                }
            }
            if (document.getElementById("txtvendor").value != '') {
                xmlHttp.open("GET", "../store/Ajaxstore.aspx?Action=chkvendorname&vendorname=" + document.getElementById("txtvendor").value, true);
                xmlHttp.send(null);
            }
        }


        function optCreation(value) {
            var select = document.getElementById('ddlRepairType');
            select.options.length = 0;
            var arrOption = new Array();
            arrValue = value.split("|");
            for (i = 0; i < arrValue.length - 1; i++) {
                arrOption = arrValue[i].split("~");
                select.options[i] = new Option(arrOption[1], arrOption[0].substring(6));
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

        function IsNumericdecimal(strString) {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if ((i = 2) && Char != '.') {
                    return false;
                }

                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }

        function Calculate(invqty, penqty, rate, amt) {

            //var txtinvqty = document.getElementById(invqty);
            var txtpenqty = penqty;
            var txtrate = rate.value;
            //var txtamt = document.getElementById(amt);

            if (invqty.value == '') {
                alert('Invoice Qty Should not be blank');
                invqty.focus();
                return false;
            }
            if (IsNumeric(invqty.value) == false) {
                alert('please Enter numbers Only.');
                invqty.focus();
                return false;
            }
            else {
                if (invqty.value <= parseFloat(txtpenqty)) {
                    var amt1 = parseFloat(invqty.value) * parseFloat(txtrate)
                    amt.innerHTML = amt1.toFixed(2);
                }
                else {
                    alert('Inv Qty Should be less than or equal to qty to be invoiced');
                    invqty.focus();
                    return false;
                }
            }

        }

        var subtotal = 0.0;
        var subtotalwithouttax = 0.0;
        function Calculatedisc(invqty, penqty, rate, amt, disc, hdndis, hdntotaldisc, vat, hdntax, amtwithtax, hdnamtwithtax, hdnwithtax, hdnwithouttax) {

            //var txtinvqty = document.getElementById(rate);
            var txtpenqty = penqty;
            var txtrate = rate.value;

            if (rate.value == '') {
                alert('Rate Should not be blank');
                rate.focus();
                return false;
            }
            if (IsNumeric(rate.value) == false) {
                alert('please Enter numbers Only.');
                rate.focus();
                return false;
            }
            if (invqty.value == '') {
                alert('Invoice Qty Should not be blank');
                invqty.focus();
                return false;
            }
            if (invqty.value <= parseFloat(txtpenqty)) {
                var amt1 = parseFloat(invqty.value) * parseFloat(txtrate)
                amt.innerHTML = amt1.toFixed(2);
            }
            else {
                alert('Inv Qty Should be less than or equal to qty to be invoiced');
                invqty.focus();
                return false;
            }

            //var txtamt = document.getElementById(amt);
            if (disc.value == '') {
                alert('Discount Qty Should not be blank');
                disc.focus();
                return false;
            }

            if (IsNumeric(disc.value) == false) {
                alert('please Enter numbers Only.');
                disc.focus();
                return false;
            }
            //           var expDec =  /^[0-9]{1,2}\.[0-9]{1,2}$/;
            //           
            //           if (expDec.test(disc.value)  == false  ){
            //            alert('please Enter Proper Value.');
            //            disc.focus();
            //            return false;
            //        }
            else {
                if (disc.value <= 100) {

                    var amt1 = (parseFloat(disc.value) * parseFloat(txtrate)) / 100
                    hdndis.value = amt1.toFixed(2);
                    //          alert (hdndis.value);
                    hdntotaldisc.value = (parseFloat(txtrate) - amt1)
                    //            alert (hdntotaldisc.value);
                    amt.innerHTML = (hdntotaldisc.value * parseFloat(invqty.value)).toFixed(2);
                    //hdnwithouttax.value=(hdntotaldisc.value * parseFloat(invqty.value)).toFixed(2);
                    // alert (hdnwithouttax.value);
                    if (hdnwithouttax.value == '') {
                        hdnwithouttax.value = parseFloat(amt.innerHTML);
                        subtotalwithouttax += parseFloat(hdnwithouttax.value);
                    }
                    else {
                        subtotalwithouttax = (subtotalwithouttax - hdnwithouttax.value) + parseFloat(amt.innerHTML);
                        hdnwithouttax.value = parseFloat(amt.innerHTML).toFixed(2);
                    }
                    document.getElementById('lblsubtotalwithouttax').innerHTML = parseFloat(subtotalwithouttax).toFixed(2);
                    document.getElementById('hdnsubtotalwithouttax').value = parseFloat(subtotalwithouttax).toFixed(2);
                    vatgrid();

                }

                else {
                    amt.innerHTML = '';
                    document.getElementById('hdnsubtotalwithouttax').value = 0;
                    document.getElementById('lblsubtotalwithouttax').innerHTML = "";
                    alert('Discount Should be less than 100%');
                    disc.focus();
                    return false;
                }
                var vattax = vat.options[vat.selectedIndex].text;
                if (vattax != 'select') {

                    hdntax.value = (parseFloat(vattax) * parseFloat(hdntotaldisc.value)) / 100
                    amtwithtax.innerHTML = ((parseFloat(hdntax.value) + parseFloat(hdntotaldisc.value)) * (parseFloat(invqty.value))).toFixed(2);
                    hdnwithtax.value = ((parseFloat(hdntax.value) + parseFloat(hdntotaldisc.value)) * (parseFloat(invqty.value))).toFixed(2);
                    //alert (hdnwithtax.value);

                    if (hdnamtwithtax.value == '') {
                        hdnamtwithtax.value = parseFloat(amtwithtax.innerHTML);
                        subtotal += parseFloat(hdnamtwithtax.value);
                    }
                    else {
                        subtotal = (subtotal - hdnamtwithtax.value) + parseFloat(amtwithtax.innerHTML);
                        hdnamtwithtax.value = parseFloat(amtwithtax.innerHTML).toFixed(2);
                    }
                    document.getElementById('lblsubtotal').innerHTML = parseFloat(subtotal).toFixed(2);
                    document.getElementById('hdnsubtotal').value = parseFloat(subtotal).toFixed(2);
                    vatgrid();

                }
                else {
                    amtwithtax.innerHTML = '';
                    document.getElementById('hdnsubtotal').value = 0;
                    document.getElementById('lblsubtotal').innerHTML = "";
                }
            }

        }
        function valid_vatgrid(per, amt) {

            if (per.value == '') {
                alert('Percentage Should not be blank');
                per.focus();
                return false;
            }

            if (IsNumeric(per.value) == false) {
                alert('please Enter numbers Only.');
                per.focus();
                return false;
            }
            if (amt.value == '') {
                alert('Amount Qty Should not be blank');
                amt.focus();
                return false;
            }

            if (IsNumeric(amt.value) == false) {
                alert('please Enter numbers Only.');
                amt.focus();
                return false;
            }
        }

        function checkreadonly(per, amt, taxnameid, type) {

            var name = document.getElementById(taxnameid).value;
            if (name == 'FREIGHT/PMT' || name == 'OTHER CHARGES' || name == 'HANDLING CHARGES' || name == 'TRANSPORTATION') {
                if (type == 1) {
                    if (document.getElementById(per).readOnly == true) {
                        document.getElementById('lblmsg').innerHTML = 'Please Untick the boxe if you want to edit the Percentage'
                        document.getElementById(amt).focus();
                    }
                    else {
                        document.getElementById('lblmsg').innerHTML = ''
                    }
                }
                else {
                    if (document.getElementById(amt).readOnly == true) {
                        document.getElementById('lblmsg').innerHTML = 'Please tick the boxe if you want to edit the Amount'
                        document.getElementById(per).focus();
                    }
                    else {
                        document.getElementById('lblmsg').innerHTML = ''
                    }
                }
            }
        }
        function vatgrid1(per, amt, chh7) {

            if (document.getElementById(chh7).checked == true) {
                document.getElementById(amt).readOnly = false;
                document.getElementById(per).value = '0.00';
                document.getElementById(per).readOnly = true;
            }
            else {
                document.getElementById(amt).readOnly = true;
                document.getElementById(amt).value = '0.00';
                document.getElementById(per).readOnly = false;
            }
        }



        function vatgrid() {

            var grdvat = document.getElementById('<%= GridView4.clientID  %>');
            var vcount = grdvat.rows.length;
            var i = 0;
            var dis = 0;
            var subtot = 0;
            var drp = 0;
            var excise = 0;
            var scess = 0;
            var hcess = 0;
            var drx = 0;
            var vat = 0;
            var drxv = 0;
            var cashd = 0;
            var drxvc = 0;
            var nmmc = 0;
            var oth = 0;
            var drxvcn = 0;
            var grandtot = 0;
            var freight = 0;
            var hand = 0;
            var trans = 0;
            var cd = 0;
            var exise = document.getElementById('radexise_0').checked;
            var nonexise = document.getElementById('radexise_1').checked;


            if (exise == true) {
                subtot = document.getElementById("lblsubtotalwithouttax").innerHTML;
                if (subtot == "") {
                    subtot = 0;
                }
            }
            else {
                subtot = document.getElementById("lblsubtotal").innerHTML;
                if (subtot == "") {
                    subtot = 0;
                }
            }

            k = 0;
            var rowvar = 0;
            //var toamt=document.getElementById("lbgrandtotal").innerHTML;
            for (i; i < vcount; i++) {
                var rowel = grdvat.rows[i];
                //                 var vatname = rowel.cells[0].childNodes[0].value;
                //                 var pr = rowel.cells[1].childNodes[0].value;
                //                 var lumsum = rowel.cells[2].childNodes[0].value;
                //                 
                rowvar = i + 2
                var vatname = document.getElementById('GridView4__ctl' + rowvar + '_txtname').value;
                var pr = document.getElementById('GridView4__ctl' + rowvar + '_txtper').value;
                var lumsum = document.getElementById('GridView4__ctl' + rowvar + '_txtamt').value;
                var objlumsum = document.getElementById('GridView4__ctl' + rowvar + '_txtamt');

                var chkper = document.getElementById('GridView4__ctl' + rowvar + '_chper');


                if (pr == '') {
                    alert('Percentage Should not be blank');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtper').focus();
                    i = vcount;
                    return false;
                }

                if (IsNumeric(pr) == false) {
                    alert('please Enter numbers Only.');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtper').focus();
                    i = vcount;
                    return false;
                }
                var expDec = /^[0-9]{1,2}\.[0-9]{1,2}$/;

                if (expDec.test(pr) == false) {
                    alert('please Enter Proper Value.');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtper').focus();
                    i = vcount;
                    return false;
                }


                if (lumsum == '') {
                    alert('Amount Qty Should not be blank');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtamt').focus();
                    i = vcount;
                    return false;
                }

                if (IsNumeric(lumsum) == false) {
                    alert('please Enter numbers Only.');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtamt').focus();
                    i = vcount;
                    return false;
                }



                k = i + 2
                var id = 'GridView4__ctl' + k + '_hdnamt'
                var hdnamt = document.getElementById(id);

                if (vatname == 'EXCISE') {
                    excise = (parseFloat(subtot) * parseFloat(pr)) / 100;
                    objlumsum.value = excise.toFixed(2);
                    hdnamt.value = excise.toFixed(2);
                }
                if (vatname == 'S CESS') {
                    scess = (parseFloat(excise) * parseFloat(pr)) / 100;
                    objlumsum.value = scess.toFixed(2);
                    hdnamt.value = scess.toFixed(2);
                }
                if (vatname == 'H CESS') {
                    hcess = (parseFloat(excise) * parseFloat(pr)) / 100;
                    objlumsum.value = hcess.toFixed(2);
                    hdnamt.value = hcess.toFixed(2);
                }
                if (vatname == 'VAT/CST') {
                    drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess));
                    vat = (parseFloat(drxvc) * parseFloat(pr)) / 100;
                    objlumsum.value = vat.toFixed(2);
                    hdnamt.value = vat.toFixed(2);
                }
                if (vatname == 'FREIGHT/PMT') {
                    if (chkper.checked == true) {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess));
                        freight = lumsum;
                        objlumsum.value = freight;
                        hdnamt.value = freight;
                    }
                    else {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess));
                        freight = (parseFloat(subtot) * parseFloat(pr)) / 100;
                        objlumsum.value = freight.toFixed(2);
                        hdnamt.value = freight.toFixed(2);
                    }
                }
                if (vatname == 'HANDLING CHARGES') {
                    if (chkper.checked == true) {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight));
                        hand = lumsum;
                        objlumsum.value = hand;
                        hdnamt.value = hand;
                    }
                    else {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight));
                        hand = (parseFloat(subtot) * parseFloat(pr)) / 100;
                        objlumsum.value = hand.toFixed(2);
                        hdnamt.value = hand.toFixed(2);
                    }
                }
                if (vatname == 'TRANSPORTATION') {
                    if (chkper.checked == true) {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand));
                        trans = lumsum;
                        objlumsum.value = trans
                        hdnamt.value = trans
                    }
                    else {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand));
                        trans = (parseFloat(subtot) * parseFloat(pr)) / 100;
                        objlumsum.value = trans.toFixed(2);
                        hdnamt.value = trans.toFixed(2);
                    }
                }
                if (vatname == 'OTHER CHARGES') {
                    if (chkper.checked == true) {
                        drxvcn = parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand) + parseFloat(trans);
                        //alert(drxvcn);
                        oth = lumsum;
                        objlumsum.value = oth
                        hdnamt.value = oth
                    }
                    else {

                        drxvcn = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand)) + parseFloat(trans);
                        oth = (parseFloat(subtot) * parseFloat(pr)) / 100;
                        objlumsum.value = oth.toFixed(2);
                        hdnamt.value = oth.toFixed(2);
                    }
                }
                if (vatname == 'CASH DISCOUNT') {
                    drxvcn = (parseFloat(subtot) + parseFloat(vat) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand)) + parseFloat(trans) + parseFloat(oth);
                    cd = (parseFloat(drxvcn) * parseFloat(pr)) / 100;
                    objlumsum.value = cd.toFixed(2);
                    hdnamt.value = cd.toFixed(2);
                }
            }

            var totalcol2 = 0;

            for (i = 0; i < grdvat.rows.length; i++) {
                col1 = grdvat.rows[i].cells[2];

                for (j = 0; j < col1.childNodes.length; j++) {
                    if (col1.childNodes[j].type == "text") {
                        if (!isNaN(col1.childNodes[j].value) && col1.childNodes[j].value != "") {
                            totalcol2 += parseInt(col1.childNodes[j].value);
                            //alert(totalcol1);
                        }
                    }
                }
            }

            var grandtot1 = 0;
            grandtot1 = parseFloat(drxvcn) - parseFloat(cd);
            grandtot1 = grandtot1.toFixed(0);
            document.getElementById("lblgrandtotal").innerHTML = grandtot1;
            document.getElementById("hdngrandtotal").value = grandtot1;
        }

        /////fright calculation is based on base rate + top 3 tax
        function vatgridfor() {

            var grdvat = document.getElementById('<%= GridView4.clientID  %>');
            var vcount = grdvat.rows.length;
            var i = 0;
            var dis = 0;
            var subtot = 0;
            var drp = 0;
            var excise = 0;
            var scess = 0;
            var hcess = 0;
            var drx = 0;
            var vat = 0;
            var drxv = 0;
            var cashd = 0;
            var drxvc = 0;
            var nmmc = 0;
            var oth = 0;
            var drxvcn = 0;
            var grandtot = 0;
            var freight = 0;
            var hand = 0;
            var trans = 0;
            subtot = document.getElementById("lblsubtotal").innerHTML;
            if (subtot == "") {
                subtot = 0;
            }
            k = 0;
            var rowvar = 0;
            //var toamt=document.getElementById("lbgrandtotal").innerHTML;
            for (i; i < vcount; i++) {
                var rowel = grdvat.rows[i];
                var vatname = rowel.cells[0].childNodes[0].value;
                var pr = rowel.cells[1].childNodes[0].value;
                var lumsum = rowel.cells[2].childNodes[0].value;
                var chkper = rowel.cells[3].childNodes[0];
                rowvar = i + 2

                if (pr == '') {
                    alert('Percentage Should not be blank');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtper').focus();
                    i = vcount;
                    return false;
                }

                if (IsNumeric(pr) == false) {
                    alert('please Enter numbers Only.');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtper').focus();
                    i = vcount;
                    return false;
                }
                if (lumsum == '') {
                    alert('Amount Qty Should not be blank');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtamt').focus();
                    i = vcount;
                    return false;
                }

                if (IsNumeric(lumsum) == false) {
                    alert('please Enter numbers Only.');
                    document.getElementById('GridView4__ctl' + rowvar + '_txtamt').focus();
                    i = vcount;
                    return false;
                }



                k = i + 2
                var id = 'GridView4__ctl' + k + '_hdnamt'
                var hdnamt = document.getElementById(id);

                if (vatname == 'EXCISE') {
                    excise = (parseFloat(subtot) * parseFloat(pr)) / 100;
                    rowel.cells[2].childNodes[0].value = excise.toFixed(2);
                    hdnamt.value = excise.toFixed(2);
                }
                if (vatname == 'S CESS') {
                    scess = (parseFloat(excise) * parseFloat(pr)) / 100;
                    rowel.cells[2].childNodes[0].value = scess.toFixed(2);
                    hdnamt.value = scess.toFixed(2);
                }
                if (vatname == 'H CESS') {
                    hcess = (parseFloat(excise) * parseFloat(pr)) / 100;
                    rowel.cells[2].childNodes[0].value = hcess.toFixed(2);
                    hdnamt.value = hcess.toFixed(2);
                }
                if (vatname == 'FREIGHT/PMT') {
                    if (chkper.checked == true) {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess));
                        freight = lumsum;
                        rowel.cells[2].childNodes[0].value = freight;
                        hdnamt.value = freight;
                    }
                    else {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess));
                        freight = (parseFloat(drxvc) * parseFloat(pr)) / 100;
                        rowel.cells[2].childNodes[0].value = freight.toFixed(2);
                        hdnamt.value = freight.toFixed(2);
                    }
                }
                if (vatname == 'HANDLING CHARGES') {
                    if (chkper.checked == true) {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight));
                        hand = lumsum;
                        rowel.cells[2].childNodes[0].value = hand;
                        hdnamt.value = hand;
                    }
                    else {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight));
                        hand = (parseFloat(drxvc) * parseFloat(pr)) / 100;
                        rowel.cells[2].childNodes[0].value = hand.toFixed(2);
                        hdnamt.value = hand.toFixed(2);
                    }
                }
                if (vatname == 'TRANSPORTATION') {
                    if (chkper.checked == true) {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand));
                        trans = lumsum;
                        rowel.cells[2].childNodes[0].value = trans
                        hdnamt.value = trans
                    }
                    else {
                        drxvc = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand));
                        trans = (parseFloat(drxvc) * parseFloat(pr)) / 100;
                        rowel.cells[2].childNodes[0].value = trans.toFixed(2);
                        hdnamt.value = trans.toFixed(2);
                    }
                }
                if (vatname == 'OTHER CHARGES') {
                    if (chkper.checked == true) {
                        drxvcn = parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand) + parseFloat(trans);
                        //alert(drxvcn);
                        oth = lumsum;
                        rowel.cells[2].childNodes[0].value = oth
                        hdnamt.value = oth
                    }
                    else {

                        drxvcn = (parseFloat(subtot) + parseFloat(excise) + parseFloat(scess) + parseFloat(hcess) + parseFloat(freight) + parseFloat(hand)) + parseFloat(trans);
                        oth = (parseFloat(drxvc) * parseFloat(pr)) / 100;
                        rowel.cells[2].childNodes[0].value = oth.toFixed(2);
                        hdnamt.value = oth.toFixed(2);
                    }
                }
            }

            var totalcol2 = 0;

            for (i = 0; i < grdvat.rows.length; i++) {
                col1 = grdvat.rows[i].cells[2];

                for (j = 0; j < col1.childNodes.length; j++) {
                    if (col1.childNodes[j].type == "text") {
                        if (!isNaN(col1.childNodes[j].value) && col1.childNodes[j].value != "") {
                            totalcol2 += parseInt(col1.childNodes[j].value);
                            //alert(totalcol1);
                        }
                    }
                }
            }

            var grandtot1 = 0;
            grandtot1 = parseFloat(drxvcn) + parseFloat(oth);
            grandtot1 = grandtot1.toFixed(0);
            document.getElementById("lblgrandtotal").innerHTML = grandtot1;
            document.getElementById("hdngrandtotal").value = grandtot1;
        }



        function validation() {
//debugger
            if (document.getElementById("txtinvno").value == '') {
                alert("Please Enter Invoice No");
                document.getElementById("txtinvno").focus();
                return false;
            }
            var grdvat = document.getElementById('<%= grddetail.clientID %>');
            var i = 0;
            var j = 0
            var vcount = grdvat.rows.length;
            if (document.getElementById('radexise_1').checked == true) {
                for (i; i < vcount - 1; i++) {
                    var rowel = grdvat.rows[i];
                    //grddetail__ctl2_ + ''
                    j = i + 2
                    var id = 'grddetail__ctl' + j + '_ddltaxamt'
                    var vat = document.getElementById(id);

                    var vattax = vat.options[vat.selectedIndex].text;
                    if (vattax == 'select') {
                        alert('Select Tax Amt ');
                        vat.focus();
                        return false;
                    }
                    //var vatname = rowel.cells[10].childNodes[0].value;
                }
            }
        }


        function fillall() {


            var grdvat = document.getElementById('<%= grddetail.clientID %>');
            var i = 0;
            var j = 0
            var vcount = grdvat.rows.length;
            var tax = 0;
            var disc = 0;

            for (i; i < vcount - 1; i++) {

                //grddetail__ctl2_ + ''
                j = i + 2

                var rowel = grdvat.rows[j - 1];
                var invqty = document.getElementById('grddetail__ctl' + j + '_txtinv');
                var penqty = document.getElementById('grddetail__ctl' + j + '_hdnpenqty').value;
                var rate = document.getElementById('grddetail__ctl' + j + '_txtitemrate');
                var txtamtwitouttax = document.getElementById('grddetail__ctl' + j + '_txtamtwitouttax')
                var iddisc = document.getElementById('grddetail__ctl' + j + '_txtdis')
                var hdndisc = document.getElementById('grddetail__ctl' + j + '_hdndisc')
                var hdntotaldisc = document.getElementById('grddetail__ctl' + j + '_hdntotaldisc')
                var idvat = 'grddetail__ctl' + j + '_ddltaxamt'
                var vat = document.getElementById(idvat);

                var hdntax = document.getElementById('grddetail__ctl' + j + '_hdntax')
                var txtwittax = document.getElementById('grddetail__ctl' + j + '_txtwittax')
                var hdntaxamt = document.getElementById('grddetail__ctl' + j + '_hdntaxamt')
                var hdnwittax = document.getElementById('grddetail__ctl' + j + '_hdnwittax')
                var hdnamtwitouttax = document.getElementById('grddetail__ctl' + j + '_hdnamtwitouttax')


                if (j == 2) {
                    var vattax = vat.options[vat.selectedIndex].text;
                    if (vattax == 'select' && document.getElementById('radexise_1').checked == true) {
                        alert('Select Tax Amt ');
                        vat.focus();
                        return false;
                    }
                    else {
                        tax = vat.value;
                        disc = iddisc.value;
                        Calculatedisc(invqty, penqty, rate, txtamtwitouttax, iddisc, hdndisc, hdntotaldisc, vat, hdntax, txtwittax, hdntaxamt, hdnwittax, hdnamtwitouttax)

                    }
                }
                else {

                    iddisc.value = disc;
                    vat.value = tax;

                    Calculatedisc(invqty, penqty, rate, txtamtwitouttax, iddisc, hdndisc, hdntotaldisc, vat, hdntax, txtwittax, hdntaxamt, hdnwittax, hdnamtwitouttax)
                }
                //var vatname = rowel.cells[10].childNodes[0].value;
            }
        }


        function checkchallan() {
            if (document.getElementById("txtvendor").value == '') {
                alert("Enter and select vendor name");
                document.getElementById("txtvendor").focus();
                return false;

            }
        }

        function ajaxFunction() {

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

            xmlHttp.onreadystatechange = handleresponse
        }

        ajaxFunction();

        function sendRequest(url) {
            //debugger
            ajaxFunction();
            url = url + '&t=' + new Date();
            xmlHttp.open("GET", url);
            xmlHttp.send(null);
        }

        function Clean() {
            window.location.href = "invoice_detail.aspx";
        }


        function handleresponse() {

            var arrApp = new Array();
            if (xmlHttp.readyState == 4) {
                resp = xmlHttp.responseText;

                if (resp.indexOf('Duplicate') != -1) {
                    alert('This Invoice No alredy entered');
                    setTimeout(function() { document.getElementById('txtinvno').focus() }, 10);

                    return false;
                }

            }
        }



        function checkinvoice() {

            var txtinvoice = document.getElementById('txtinvno');
            var hdnvendorid = document.getElementById('hdnvendorid').value;

            //alert (setTimeout(function(){txtvendor.value}, 10));

            if (txtinvoice.value == '') {
                txtinvoice.focus();
                alert('Please Enter Invoice No');
                return false;
            }
            else {
                var url = '../tmtAjax/Common_ajax.aspx?action=chkinvoice&invoice=' + txtinvoice.value + '&hdnvendorid=' + hdnvendorid;
                sendRequest(url);
                return false;
            }
        }


        function removestorecheck(thisid, storeid) {
            //debugger  
            //    if (document.getElementById(thisid).checked == true)
            //    {
            document.getElementById(storeid).checked = false;
            //    }
        }

        function removestore_detailcheck(thisid, counter) {

            var idcount = thisid.replace('chk_', '');
            var i = idcount;

            if (document.getElementById(thisid).checked == true) {
                for (i; i <= counter; i++) {
                    document.getElementById('chkstore_detail_id_' + i).checked = true;

                }
            }
            else {
                for (i; i <= counter; i++) {
                    document.getElementById('chkstore_detail_id_' + i).checked = false;
                }
            }

        }

        function noBack() { window.history.forward(); }


        function enabletax() {


            var grdvat = document.getElementById('<%= grddetail.clientID %>');
            var i = 0;
            var j = 0
            var vcount = grdvat.rows.length;
            var tax = 0;
            var disc = 0;
            var exise = document.getElementById('radexise_0').checked;
            var nonexise = document.getElementById('radexise_1').checked;


            if ((exise == true)) {

                document.getElementById('radtaxtype').style.display = "block";
                document.getElementById('GridView4__ctl2_txtper').readOnly = false;
                document.getElementById('GridView4__ctl2_txtamt').readonly = false;
                document.getElementById('GridView4__ctl3_txtper').readOnly = false;
                document.getElementById('GridView4__ctl3_txtamt').readonly = false;
                document.getElementById('GridView4__ctl4_txtper').readOnly = false;
                document.getElementById('GridView4__ctl4_txtamt').readonly = false;
                document.getElementById('GridView4__ctl2_txtper').value = '12.00';
                document.getElementById('GridView4__ctl2_txtamt').value = '0.00';
                document.getElementById('GridView4__ctl3_txtper').value = '2.00';
                document.getElementById('GridView4__ctl3_txtamt').value = '0.00';
                document.getElementById('GridView4__ctl4_txtper').value = '1.00';
                document.getElementById('GridView4__ctl4_txtamt').value = '0.00';


                document.getElementById('GridView4__ctl5_txtper').readOnly = false;
                document.getElementById('GridView4__ctl5_txtamt').readonly = false;
                document.getElementById('grddetail__ctl' + '2' + '_ddltaxamt').value = 0
                // fillall()

                var hdnsubtotal = document.getElementById('hdnsubtotal');
                hdnsubtotal.value = 0;
                for (i; i < vcount - 1; i++) {

                    //grddetail__ctl2_ + ''
                    j = i + 2

                    var rowel = grdvat.rows[j - 1];
                    var idvat = 'grddetail__ctl' + j + '_ddltaxamt'
                    var vat = document.getElementById(idvat).disabled = true;
                    document.getElementById('grddetail__ctl' + j + '_ddltaxamt').value = 0
                    document.getElementById('grddetail__ctl' + j + '_txtwittax').innerHTML = ""
                    if (document.getElementById('grddetail__ctl' + j + '_hdnamtwitouttax').value != '') {
                        subtotalwithouttax.value = parseFloat(subtotalwithouttax.value) + parseFloat(document.getElementById('grddetail__ctl' + j + '_hdnamtwitouttax').value)
                    }

                }


                document.getElementById('lblsubtotalwithouttax').innerHTML = parseFloat(subtotalwithouttax).toFixed(2);
                document.getElementById('hdnsubtotalwithouttax').value = parseFloat(subtotalwithouttax).toFixed(2);
                document.getElementById('lblsubtotal').innerHTML = "";
                document.getElementById('hdnsubtotal').value = 0;

                vatgrid();

            }
            else {
                document.getElementById('radtaxtype').style.display = "none";
                document.getElementById('GridView4__ctl2_txtper').readOnly = true;
                document.getElementById('GridView4__ctl2_txtamt').readonly = true;
                document.getElementById('GridView4__ctl3_txtper').readOnly = true;
                document.getElementById('GridView4__ctl3_txtamt').readonly = true;
                document.getElementById('GridView4__ctl4_txtper').readOnly = true;
                document.getElementById('GridView4__ctl4_txtamt').readonly = true;

                document.getElementById('GridView4__ctl2_txtper').value = '0.00';
                document.getElementById('GridView4__ctl2_txtamt').value = '0.00';
                document.getElementById('GridView4__ctl3_txtper').value = '0.00';
                document.getElementById('GridView4__ctl3_txtamt').value = '0.00';
                document.getElementById('GridView4__ctl4_txtper').value = '0.00';
                document.getElementById('GridView4__ctl4_txtamt').value = '0.00';

                document.getElementById('GridView4__ctl5_txtper').readOnly = true;
                document.getElementById('GridView4__ctl5_txtamt').readonly = true;

                document.getElementById('GridView4__ctl5_txtper').value = '0.00';
                document.getElementById('GridView4__ctl5_txtamt').value = '0.00';

                document.getElementById('grddetail__ctl' + '2' + '_ddltaxamt').value = 0
                // fillall()
                for (i; i < vcount - 1; i++) {

                    //grddetail__ctl2_ + ''
                    j = i + 2

                    var rowel = grdvat.rows[j - 1];
                    var idvat = 'grddetail__ctl' + j + '_ddltaxamt'
                    var vat = document.getElementById(idvat);
                    var vat = document.getElementById(idvat).disabled = false;
                    document.getElementById('grddetail__ctl' + j + '_ddltaxamt').value = 0


                }
            }


        }

    </script>

    <style type="text/css">
        .style1
        {
            width: 266px;
        }
        .style2
        {
            width: 553px;
        }
    </style>

        <link href="../css/newmvc.css" rel="stylesheet" />
</asp:content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
      <div class="breadcrumbs">
        <h1>Invoice </h1>
    </div>
    <asp:HiddenField ID="hdnrowcount" runat="server" />
    <div align="center">
       
        <div id="middal">
         
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                      
                        <tr>
                            <td align="left" colspan="2">
                                Vendor Name:
                                <input id="txtvendor" type="text" style="width: 260px" onblur="chkvendorname()" class="textfield"
                                    runat="server" />
                            </td>
                            <td align="right">
                                Challan No
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtchalan" runat="server" class="textfield"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="btn_show" runat="server" Text="Show" />
                            </td>
                        </tr>
                        <tr id="trgrid" visible="false" runat="server">
                            <td colspan="4" align="center">
                                <asp:Literal ID="htmlchallan" runat="server"></asp:Literal>
                                <span>
                                    <asp:Button ID="Btn_showdetail" runat="server" Text="Show Challan" /></span>
                            </td>
                        </tr>
                    </table>
                    <table id="tblchlitem" runat="server" visible="false">
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label1" runat="server" Text="  Vendor Name"></asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtvendorname" runat="server" ReadOnly="True" Enabled="False" Width="383px"></asp:TextBox>
                                <asp:HiddenField ID="hdnvendorid" runat="server"></asp:HiddenField>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label7" runat="server" Text="  Invoice No"></asp:Label>
                            </td>
                            <td align="left" class="style1">
                                <asp:TextBox ID="txtinvno" onblur="checkinvoice()" runat="server" Width="187px" MaxLength="20"></asp:TextBox>
                            </td>
                            <td class="style2">
                                <asp:Label ID="Label8" runat="server" Text="  Invoice Date"></asp:Label>
                            </td>
                            <td align="left">
                            
                                        <asp:TextBox ID="BDPLite1" Width="100px" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                                PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                            </asp:CalendarExtender>
                                            <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                            </asp:ScriptManager>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left">
                                <asp:RadioButtonList ID="radexise" RepeatDirection="Horizontal" onclick="enabletax()"
                                    runat="server">
                                    <asp:ListItem Text="Exise" Selected="True" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Non Exise" Value="1"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td colspan="2" align="right">
                                <input type="button" onclick="fillall()" value="Apply To All" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left">
                                <asp:RadioButtonList ID="radtaxtype" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Text="VAT" Selected="True" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="CST" Value="1"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="tr1" runat="server">
                            <td colspan="4">
                                <asp:GridView ID="grddetail" ItemStyle-CssClass="gridtxt" HeaderStyle-CssClass="gridhead"
                                    runat="server" AutoGenerateColumns="False" Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <%# CType(Container, GridViewRow).RowIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="store_id" Visible="false"></asp:BoundField>
                                        <asp:BoundField DataField="store_detail_id" Visible="false"></asp:BoundField>
                                        <asp:BoundField DataField="item_code" Visible="false"></asp:BoundField>
                                        <asp:BoundField DataField="po_id" Visible="false"></asp:BoundField>
                                        <asp:BoundField DataField="Part_no" HeaderText="PartNo" ItemStyle-Width="0px"></asp:BoundField>
                                        <asp:BoundField DataField="rack_no" HeaderText="Lf No" ItemStyle-Width="0px"></asp:BoundField>
                                        <asp:BoundField DataField="item_name" HeaderText="Description" ItemStyle-Wrap="false"
                                            ItemStyle-Width="150px"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Rate" ItemStyle-Width="160px">
                                            <ItemTemplate>
                                                <div style="text-align: right">
                                                    <asp:TextBox ID="txtitemrate" Width="90px" MaxLength="10" runat="server" Text='<%# Eval("item_rate") %>'></asp:TextBox>
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle Width="160px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="total_qty" ItemStyle-HorizontalAlign="Right" HeaderText="Rec Qty"
                                            ItemStyle-Width="0px"></asp:BoundField>
                                        <asp:BoundField DataField="pen_qty" ItemStyle-HorizontalAlign="Right" HeaderText="Qty tobe invoiced"
                                            ItemStyle-Width="0px"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Inv Qty" ItemStyle-Width="160px">
                                            <ItemTemplate>
                                                <div style="text-align: right">
                                                    <asp:TextBox ID="txtinv" Width="40px" MaxLength="5" runat="server" Text='<%# Eval("pen_qty") %>'></asp:TextBox>
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle Width="160px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dis" ItemStyle-Width="50px">
                                            <ItemTemplate>
                                                <div style="text-align: right">
                                                    <asp:TextBox ID="txtdis" Width="40px" MaxLength="5" Text="0" runat="server"></asp:TextBox>
                                                </div>
                                                <asp:HiddenField ID="hdndisc" runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="hdntotaldisc" runat="server"></asp:HiddenField>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax" ItemStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddltaxamt" runat="server">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdntax" runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="hdntaxamt" runat="server"></asp:HiddenField>
                                            </ItemTemplate>
                                            <ItemStyle Width="160px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amt Withot Tax" ItemStyle-Width="160px">
                                            <ItemTemplate>
                                                <div style="text-align: right">
                                                    <asp:Label ID="txtamtwitouttax" runat="server"></asp:Label>
                                                </div>
                                                <asp:HiddenField ID="hdnamtwitouttax" runat="server"></asp:HiddenField>
                                            </ItemTemplate>
                                            <ItemStyle Width="160px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amt with tax" ItemStyle-Width="160px">
                                            <ItemTemplate>
                                                <div style="text-align: right">
                                                    <asp:Label ID="txtwittax" runat="server"></asp:Label>
                                                </div>
                                                <asp:HiddenField ID="hdnwittax" runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="store_id" Value='<%# Eval("store_id") %>' runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="store_detail_id" Value='<%# Eval("store_detail_id") %>' runat="server">
                                                </asp:HiddenField>
                                                <asp:HiddenField ID="item_code" Value='<%# Eval("item_code") %>' runat="server">
                                                </asp:HiddenField>
                                                <asp:HiddenField ID="po_id" Value='<%# Eval("po_id") %>' runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="hdnpenqty" Value='<%# Eval("pen_qty") %>' runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="hdnrate" Value='<%# Eval("item_rate") %>' runat="server"></asp:HiddenField>
                                            </ItemTemplate>
                                            <ItemStyle Width="160px"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:Literal ID="htmlitemdetail" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                            <td align="right" colspan="1" class="style2">
                            </td>
                            <td align="right" colspan="1" style="border: 1">
                                <span>
                                    <asp:Label ID="lblsubtotalwithouttax" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
                                    <asp:HiddenField ID="hdnsubtotalwithouttax" runat="server" />
                                </span><span>|||
                                    <asp:Label ID="lblsubtotal" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
                                    <asp:HiddenField ID="hdnsubtotal" runat="server" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="5">
                                <asp:Label ID="lblmsg" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="4">
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" Width="400px"
                                    ShowHeader="False">
                                    <Columns>
                                        <asp:BoundField DataField="taxid" HeaderText="taxid" ItemStyle-Width="0px" Visible="false">
                                            <ItemStyle Width="0px"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="per" ItemStyle-Width="160px" InsertVisible="False">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtname" runat="server" Text='<%# Eval("taxname") %>' ReadOnly="True"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Width="160px"></ItemStyle>
                                        </asp:TemplateField>
                                        <%-- <asp:BoundField DataField="taxname" HeaderText="Name" ItemStyle-Width="300px">
                                                                                <ItemStyle Width="300px"></ItemStyle>
                                                                            </asp:BoundField>--%>
                                        <asp:TemplateField HeaderText="per" ItemStyle-Width="460px">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtper" runat="server" MaxLength="5" Width="50px" Text='<%# Eval("vatper") %>'></asp:TextBox>
                                                <asp:Label ID="lblper" runat="server" Text="%"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="860px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" ItemStyle-Width="130px" InsertVisible="False">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtamt" runat="server" Width="130px" ReadOnly="True" Text="0"></asp:TextBox>
                                                <asp:HiddenField ID="hdnamt" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="130px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chper" runat="server" value="1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="4">
                                <asp:Label ID="lblgrandtotal" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
                                <asp:HiddenField ID="hdngrandtotal" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                    AlternateText="Save" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div align="center" id="divchallan" runat="server">
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>
  

    <script type="text/javascript">

$("#txtvendor").autocomplete(
		
		{
		source:[<% =strVendor  %>]
		}
	);


    </script>

</asp:content>
