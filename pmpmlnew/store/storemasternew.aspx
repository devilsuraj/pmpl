<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="storemasternew.aspx.vb"
    Inherits="kdmt.storemaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" src="../Scripts/LogSheetReceipt.js"></script>

    <script src="popcalendar.js"></script>

    <link href="popcalendar.css" rel="stylesheet" type="text/css" />

    <script language="javascript">
    
        var Optype = 0

        var rowcnt = 0;

        function fillActualQty()
        {
            if(document.getElementById ("txtChallnQty").value.length>0)
            {
                if(IsNumeric(document.getElementById ("txtChallnQty").value))
                {
                    document.getElementById ("txtqty").value=document.getElementById ("txtChallnQty").value;
                }
                else
                {
                    alert("Enter Proper Value");
                    document.getElementById("txtChallnQty").focus();
                    document.getElementById("txtChallnQty").value=0;
                }
            }
            else
            {
                alert("Enter Some Value");
                document.getElementById("txtChallnQty").focus();
                        
            }
        }
        function fillItemName()
        {
            objddl2 =document.getElementById('Select1');
            if(document.getElementById("ddlitem").value!="" && objddl2.options.length>0)
            {
                document.getElementById("ddlitem").value=objddl2.options[0].text;
                document.getElementById("txtRate").focus();
            }

        }
      
        function chkItemName()
        {
            var xmlHttp;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();   
            }
            catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    try
                    { 
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e)
                    {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange=function()
            {
                if(xmlHttp.readyState==4)
                {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp;

                    if(ele1=="NO-SUCH-ITEM")
                    {
                        alert("No Such Item Present");
                        document.Form1.ddlitem.focus();
                    }
                }
            }
            var cat=document.Form1.ddlitem.value;
            xmlHttp.open("GET","Ajaxstore.aspx?Action=chkitemname&itemid="+document.Form1.ddlitem.value,true);
            xmlHttp.send(null);
        }


        function chkvendorname()
        {

            var xmlHttp;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();   
            }
            catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    try
                    { 
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e)
                    {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange=function()
            {
                if(xmlHttp.readyState==4)
                {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp;

                    if(ele1=="NO-SUCH-ITEM")
                    {
                        alert("No Such Vendor Present");
                        document.getElementById ("txtvendor").focus();   
                    }
                    else {
    
                        getpono();
                    }
                }
            }
            if (document.getElementById ("txtvendor").value != '')
            {
                xmlHttp.open("GET","Ajaxstore.aspx?Action=chkvendorname&vendorname="+document.getElementById ("txtvendor").value,true);
                xmlHttp.send(null);
            }
        }

        function validate ()
        {

            // if (document.getElementById ("radparttype_0").checked == false && document.getElementById ("radparttype_1").checked == false ) 
            //  {
            //  alert ('Please Select Part Type');
            //  return false;
            //  }
            if (document.getElementById ("txtvendor").value == "" )
            {
                alert ('Enter Vendor Name');
                document.getElementById ("txtvendor").focus()
                return false;
            }
            if (document.getElementById('txtPOtype').value == "")
            {
                document.getElementById('txtPOtype').focus();
                alert ('Please Enter Po First');
                return false;
            }   
  
            //   if (IsNumeric (document.getElementById('txtPoNo').value)== false  )
            //  {
            //  document.getElementById('txtPoNo').focus();
            //  alert ('Please Enter Number Only');
            //  return false;
            //  }   
            if (document.getElementById ("txtchalan").value.length==0)
            {
                alert ('Please Enter Challan no');
                document.getElementById ("txtchalan").focus()
                return false;
            }
            if( document.getElementById('txtRecNo').value == ''){
                alert('Please Enter Rec No.');
                document.getElementById('txtRecNo').focus();
                return false;
            }     

            return ValidateSave();
             
        }

        function isValidDate(dateString)
        { 
            // First check for the pattern
            if(!/^\d{2}\/\d{2}\/\d{4}$/.test(dateString))
                return false;
            alert('a');
            // Parse the date parts to integers
            var parts = dateString.split("-");
            var day = parseInt(parts[1], 10);
            var month = parseInt(parts[0], 10);
            var year = parseInt(parts[2], 10);

            // Check the ranges of month and year
            if(year < 1000 || year > 3000 || month == 0 || month > 12)
                return false;

            var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

            // Adjust for leap years
            if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
                monthLength[1] = 29;

            // Check the range of the day
            return day > 0 && day <= monthLength[month - 1];
        };


        ///////////   for removing blaak spaces 
        String.prototype.trim = function()
        {

            return this.replace(/^\s+|\s+$/g,"");
        }


        function  check()
        {

            var str = document.getElementById('ddlitem').value;
            if (str.trim() !='')
            {
                getitemname();
            }
            return false;
        }
        
        function  check1()
        {
            var str = document.getElementById('ddlitem').value;
            if (str.trim() !='')
            {
                Fromcombo2();
            }
            return false;
        }
        
        
             

          
        ///////////////////  for filteration ///////////////////////////////////////

        function getitemname()
        {

            var xmlHttp;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();   
            }
            catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    try
                    { 
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e)
                    {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange=function()
            {
                if(xmlHttp.readyState==4)
                {

                    resp = xmlHttp.responseText;

                    if (resp == 0)
                    {
                        document.getElementById("Select1").style.display='none';
                        return false;
                    }

                    var ele = resp.split("!");

                    while(document.getElementById("Select1").options.length > 0)

                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length-1);
                    if(document.Form1.ddlitem.value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtPartNo').value != "")
                    {

                        for (var i = 0; i < ele.length; i++)
                        {

                            var temp=document.getElementById("Select1")
                            temp.style.display='';
                            temp.size=ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("Select1").options.add(newOpt);

                            newOpt.value = ele[i];
                            newOpt.text  = ele[i];
                            if (document.Form1.ddlitem.value==ele[i])
                            {
                                // temp.style.display="none";				               
                                // return false;
                            }
                            if (ele[i]=="0")
                            {
                                //temp.style.display="none";				               
                                //  return false;
                            }			
                         
                        }

                    }
                    else
                    {
                        var temp=document.getElementById("Select1")
                        temp.size=0
                        //temp.style.display="none";
                        temp.style.display='';
                    }
                }
            }
            var lfno = document.getElementById('txtlfno').value;
            var partno = document.getElementById('txtPartNo').value;

            url = "../store/AjaxStore.aspx?Action=itemname1&itemid=''&item=" + document.getElementById ('ddlitem').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();   
            //window.location .href=url 
            // alert (url);
            xmlHttp.open("GET",url ,true);
            xmlHttp.send(null);
        }

        function Select(obj)
        { 
            var resultStr = "";     
            for(var i = 0; i < obj.options.length; i++ )
            {  
                if( obj.options[i].selected ) 
                {    
                    resultStr+= (obj.options[i].text);   
                    obj.value=resultStr;    
                    obj.style.display="none";  
                    document.getElementById('txtPOtype').value = resultStr;
                    document.getElementById('txtPOtype').focus();
                    return false;
                    //alert(resultStr)
                } 
            } 
        }

        //////////////   end  filteration   ///////////////////////////
      
   
      
        // check for numeric fields only
      
        function IsNumeric(strString)
        {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) 
            { 
                Char = strString.charAt(i); 
                if (ValidChars.indexOf(Char) == -1) 
                {
                    return false;
                }
            }
            return true;
        }

        function ticFunction2()
        {
            if(document.getElementById ("txtqty").value.length>0)
            {
                if(IsNumeric(document.getElementById ("txtqty").value))
                {
                    LogSheet_receive();
                }
                else
                {
                    alert("Enter Proper Value");
                    document.getElementById("txtqty").focus();
                    document.getElementById("txtqty").value=0;
                }
            }
        }			
			
        function ticFunction1()
        {
            BLogSheet();
        }
			
        function Fromcombo2()
        {
            var xmlHttp;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();   
            }
            catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    try
                    { 
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e)
                    {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange=function()
            {
                if(xmlHttp.readyState==4)
                {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');
                    document.getElementById('txtbqty').value =ele1[0];
                    document.getElementById('txtRate').value =ele1[1];
                    document.getElementById('txtPartNo').value=ele1[2];
                    document.getElementById('txtlfno').value=ele1[3];
                }
            }
            var itemname= document.getElementById('ddlitem').value  ;
            var lfno = document.getElementById('txtlfno').value;
            var partno = document.getElementById('txtPartNo').value;
            xmlHttp.open("GET","AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno ,true);
            //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
            xmlHttp.send(null);
        }
			
        function Fromcombo()
        {
            var xmlHttp;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();   
            }
            catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    try
                    { 
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e)
                    {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange=function()
            {
                if(xmlHttp.readyState==4)
                {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split("!");
                    while(document.getElementById("ddlitem").options.length > 0)
                        document.getElementById("ddlitem").options.remove(document.getElementById("ddlitem").options.length-1);
                    document.getElementById("ddlitem").value=="";
                    var temp=document.getElementById("ddlitem")
                    //if(document.Form1.txtroute.value !="")
                    // {
                    for (var i = 0; i < ele1.length-1; i++)
                    {
                        var temp=document.getElementById("ddlitem")
                        newOpt = document.createElement("OPTION");
                        document.getElementById("ddlitem").options.add(newOpt);
                        newOpt.value = ele1[i];
                        newOpt.innerText  = ele1[i];
                    }
                }
            }
            var cat='' //document.Form1.ddlcat.value;
            //alert(cat);
            xmlHttp.open("GET","Ajaxstore.aspx?Action=itemname&itemid=''",true);
            xmlHttp.send(null);
        }
			
        function emptytext()
        {
            if (document .getElementById ('txtPartNo').value !='' && document .getElementById ('ddlitem').value !='' )
            {
                document .getElementById ('txtPartNo').value='';
                document .getElementById ('ddlitem').value='';
            }
        }

        function emptytextpart ()
        {
            if (document .getElementById ('txtlfno').value !='' && document .getElementById ('ddlitem').value !='' )
            {
                document .getElementById ('txtlfno').value='';
                document .getElementById ('ddlitem').value='';
            }
        }

        function display()
        {
            var x=document.getElementById('Select1');
            x.style.display="none";  
        }


        function getpo(){    
             
            var txtvendor = document.getElementById('txtvendor')
            var txtPoNo = document.getElementById('txtPOtype')        
            if (txtPoNo.value == ''  ){            
                return false;
            } 
            else{                            
                var PO = txtPoNo.value.split(" | ")
            
                var url = '../tmtAjax/Common_ajax.aspx?action=getpoDetails&potype=' + PO[0] + '&pono=' + PO[1] + '&poyear=' + PO[2] + "&vendor=" + txtvendor.value;
                sendRequest(url);                                
                return false;
            }
        }
    
        function getpodate(obj){
                
            var txtvendor = document.getElementById('txtvendor')
            var txtPoNo = document.getElementById('txtPOtype')               
            var bdpPoDate = document.getElementById('bdpPoDate')
            if (txtPoNo.value == ''  ){            
                alert('Please Enter PO Number.')
                return false;
            }    
                //        else if (isValidDate(bdpPoDate.value) == false){
                //            alert('Please Check Date');
                //            var dt = new Date();
                //            var month = dt.getMonth() + 1;
                //            //var currentDate = dt.getDate()+ "-" + month + "-" +dt.getFullYear();
                //            //bdpPoDate.value =  currentDate;
                //            setTimeout(function(){bdpPoDate.focus()}, 10);
                //            //bdpPoDate.focus();
                //            return false;
                //        } 
            else{
                var dateTime = '04/01/2012';            
                var myDate = new Date(dateTime);                           
                var arrDareTime = new Array();                                    
                var ComingDate = bdpPoDate.value.replace(/-/g,'/');            
                arrDareTime = ComingDate.split("/");                
                var ComingDate = arrDareTime[1] + "/" + arrDareTime[0] + "/" + arrDareTime[2];                                           
                var ComDate = new Date(ComingDate);                            
                if (ComDate < myDate ){
                    if(confirm('Do You Want To Enter Old PO')){
                        window.location.href = "storemasterold.aspx?vendor=" + txtvendor.value + "&PoNo=" + txtPoNo.value ;
                    }                            
                }    
                var PO = txtPoNo.value.split(" ")            
                var url = '../tmtAjax/Common_ajax.aspx?action=getpoDetailsdt&potype=' + PO[0] + '&pono=' + PO[1] + '&dtpo=' + obj.value + "&vendor=" + txtvendor.value;
                sendRequest(url);                                
                return false;
            }
        }
    
        function getpono(){  

            var txtvendor = document.getElementById('txtvendor'); 
               
            //alert (setTimeout(function(){txtvendor.value}, 10));
       
            if (txtvendor.value == ''){
                txtvendor.focus();
                alert ('Please Enter Vendor Name');
                return false;
            } 
            else{                
                var url = '../tmtAjax/Common_ajax.aspx?action=getpoNo&vendor=' + txtvendor.value;               
                sendRequest(url);                                
                return false;
            }
        }

        function ajaxFunction() {

            try	{
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();   
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try { 
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }

            xmlHttp.onreadystatechange=handleresponse
        }

        ajaxFunction();

        function sendRequest(url) {
            //debugger
            ajaxFunction();
            url = url + '&t=' + new Date();
            xmlHttp.open("GET",url);
            xmlHttp.send(null);
        }
        function Clean(){
            window.location.href = "storemasternew.aspx";
        }


        function handleresponse() { 
            var arrApp = new Array();
            if(xmlHttp.readyState==4) {            
                resp = xmlHttp.responseText;
                                
                if (resp.indexOf('PassIndent')!= -1) {             
                    arrApp =  resp.split("|");           
                    resp = arrApp[0];                             
                    document.getElementById('hdnrwcnt').value = arrApp[1];                 
                    if (arrApp.length > 2){             
                        document.getElementById('txtvendor').value = arrApp[2];     
                        document.getElementById('bdpPoDate').value = arrApp[3];   
                      
                        document.getElementById('hdnPoDate').value = arrApp[5];   
                        if(arrApp[4] != ''){
                            //                    if(arrApp[4] == 'sp'){
                            //                        document.getElementById ("radparttype_0").checked = true  ; 
                            //                    }
                            //                    else
                            //                    {
                            //                        document.getElementById ("radparttype_1").checked = true  ; 
                            //                    }                    
                        }                               
                    }
                    else{
                        // var now = new Date();                                       
                        // document.getElementById('bdpPoDate').value = now.toString('dd-MMM-yyyy');
                        // document.getElementById('txtvendor').value = '';     
                    }          
                          
                    document.getElementById('dvRIndent').innerHTML = resp.substring(10);                                    
                    return false;
                }
                else if(resp.indexOf('PoNo') != -1){                               
                    var ele = resp.split("!");
            
                    while(document.getElementById("ListBox1").options.length > 0)
                        document.getElementById("ListBox1").options.remove(document.getElementById("ListBox1").options.length-1);            
            
                    for (var i = 1; i < ele.length; i++){
                        var temp=document.getElementById("ListBox1")
                        temp.style.display='';
                        temp.size=ele.length;
                        newOpt = document.createElement("option");
                        document.getElementById("ListBox1").options.add(newOpt);
                        newOpt.value = ele[i];
                        newOpt.text  = ele[i];
                    }                        
                }
                else if(resp.indexOf('OptFail') != -1) {  
                    alert('Error Occur While Operation.');            
                    return false;
                }
                else if(resp.indexOf('Failpo') != -1) {  
                    alert('This Is Not a Valid PO');   
                    document.getElementById('txtPOtype').focus();         
                    return false;
                }
                else if(resp.indexOf('Add') != -1) {      
                    alert('Data Added Successfully.');                    
                    Clean();
                    return false;
                }
                else if(resp.indexOf('Edit') != -1) {    
                    alert('Data Updated Successfully.');                              
                    Clean();
                    return false;
                }
                else if(resp.indexOf('Duplicate') != -1) {    
                    alert('Defect No. is already exist.');                              
                    Clean();
                    return false;
                }
                else if(resp.indexOf('Delete') != -1) {              
                    alert('Data Deleted Successfully.');                              
                    return false;
                }           
            }
        }

        function receive(id){
            //debugger 
            var AvailableQty = document.getElementById('tdAvailableQty_' + id);
            var RequiredQty = document.getElementById('tdRequiredQty_' + id);
            var Receivedqty = document.getElementById('tdreceivedQty_' + id);
            var ReceiveQty = document.getElementById('txtreceiveQty_' + id);
            var balqty = document.getElementById('tdbalQty_' + id);

            if(parseInt(ReceiveQty.value) > (parseInt(RequiredQty.innerHTML) -parseInt(Receivedqty.innerHTML))    ){
                alert("Received Qty should be less then or equal to Pending Qty"); 
                ReceivedQty.focus();
                return false;
            }
            if (ReceiveQty.value != '' ){            
        
                balqty.innerHTML = (parseInt(RequiredQty.innerHTML) -parseInt(Receivedqty.innerHTML)) - parseInt(ReceiveQty.value);
            }
            else{ReceiveQty.value = 0;}
        }

        function deleteRow(cnt,IndId) {    
            var tr = document.getElementById(cnt);
            document.getElementById('tbodyRIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;    
        }

        function ValidateSave() {
          
         //   alert(parseFloat(balQty.innerHTML));
          //  alert(receiveQty);

            var detvalues = '';
            var i = 0;    
           // alert("called");
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            var hdnPOtype = document.getElementById('hdnPOtype');
            var hdnPoNo = document.getElementById('hdnPoNo');
            var hdndetail = document.getElementById('hdndetail');        
            var radparttype = '';
            //        if (document.getElementById ("radparttype_0").checked == false )
            //        {
            //         radparttype = 'HW'
            //         
            //        
            //        }
            //        else
            //        {
            //           radparttype = 'SP'
            //        }        
        
            var txtpotype = document.getElementById('txtPOtype').value;
            var PO = txtpotype.split(" | ");
            hdnPOtype.value = PO[0];
            hdnPoNo.value = PO[1];
          //  alert(hdnrwcnt.value);
            //        var txtvendor = document.getElementById('txtvendor').value;        
            //        var dtpoDate = document.getElementById('bdpPoDate').value;                 
            ////        var txtinwardno = document.getElementById('txtInwardNo').value;                        
            //        var dtsecuritydate = document.getElementById('BDPLite1_TextBox').value;                                
            //        var txtchalan = document.getElementById('txtchalan').value;                                        
            //        var dtchalandate= document.getElementById('BDPLite2_TextBox').value;  
            //        var txtbill = document.getElementById('txtbill').value;  
            //        var dtbilldate= document.getElementById('bdpbilldate_TextBox').value;  
            //        var txtrecno = document.getElementById('txtRecNo').value;  
            //        var dtrecdate= document.getElementById('bdpRecDate_TextBox').value;  
            //        var txtgate = document.getElementById('txtgate').value;  
                          
        
            for (i = 0; i < hdnrwcnt.value ; i++) {
             //   alert("called validate save");
                var balQty = document.getElementById('tdbalQty_' + i);
                var receiveQty = document.getElementById('txtreceiveQty_' + i);
             //   alert("called " + receiveQty);
            //    alert("balance value : "+parseFloat(+balQty.innerHTML));
               // alert(receiveQty);
                if (receiveQty != null) {
               
                    if (receiveQty.value == ''){
                        alert('Received Qty. should not be empty')
                        receiveQty.focus();  
                        return false;
                    }
                    if (receiveQty.value > parseFloat(balQty.innerHTML)) {
                        alert('Received Qty. should should be less than or equal to Balance Qty')
                        //receiveQty.focus();
                        return false;
                    }
                }
              
            }
        
        
            if( document.getElementById('txtvendor').value == ''){
                alert('Please select vendor');
                document.getElementById('txtvendor').focus();
                return false;
            }         
              
            for (i=0;i<hdnrwcnt.value ;i++)
            {  
                //debugger   
                if (document.getElementById('tdRackNo_' + i)!= null){
                    var ID = document.getElementById('tdID_' + i).innerHTML;
                    var part1 = document.getElementById('tdpart1_' + i).innerHTML;
                    var lfno = document.getElementById('tdRackNo_' + i).innerHTML;
                    var PartNo = document.getElementById('tdPartNo_' + i).innerHTML;
                    var ItemName = document.getElementById('tdItemName_' + i).innerHTML;
                    var AvaiQty = document.getElementById('tdAvailableQty_' + i).innerHTML;               
                    var receivedQty = document.getElementById('tdreceivedQty_' + i).innerHTML;
                    var receiveQty= document.getElementById('txtreceiveQty_' + i).value;
                    var balQty = document.getElementById('tdbalQty_' + i).innerHTML; 
                    var rate = document.getElementById('txtRate_' + i).value;
                    var chkclaim = document.getElementById('chkclaim_' + i);
                
                    if (chkclaim.checked == true )
                    {
                        claim = 1
                    }
                    else
                    {
                        claim = 0
                    }
                
                
           
                                    
                    var Requiredqty = document.getElementById('tdRequiredQty_' + i).innerHTML;

                    //var reqqty = document.getElementById('tdRequiredQty_0').innerHTML;
                          
                
                    hdndetail.value = hdndetail.value + ID + '^' + part1  +'^' + lfno  + '^' + PartNo + '^' + ItemName + '^' + AvaiQty + '^' + Requiredqty + '^' + receivedQty + '^' + receiveQty + '^' + balQty + '^' + rate + '^' + claim  + '|';
                
                }
            }             
            
            //if (document.getElementById('hdnID').value!=''){ID = document.getElementById('hdnID').value}
                                                                                                                                                                                                                                             
            //        if (Optype==0){    
            //                   
            //             var url = "../tmtAjax/Common_ajax.aspx?action=ReceiveDetails&hdnrwcnt=" + hdnrwcnt + "&radparttype=" + radparttype + "&txtpotype=" + txtpotype + "&txtpono=" + txtpono + "&txtvendor=" + txtvendor + "&dtpoDate="+ dtpoDate + "&txtinwardno=" + txtinwardno + "&dtsecuritydate=" + dtsecuritydate  + "&txtchalan=" + txtchalan  + "&dtchalandate=" + dtchalandate  + "&txtbill=" + txtbill  + "&dtbilldate=" + dtbilldate  + "&txtgate=" + txtgate  + "&receivedetails=" + detvalues  + "&Optype=" + Optype + "&txtrecno=" + txtrecno + "&dtrecdate=" + dtrecdate ;                                                             
            //                 
            //        }
            //        else{
            //             //var url = "../tmtAjax/Common_ajax.aspx?action=indentDetails&Id=" + ID +  "&txtindentdate=" + txtindentdate + "&txtapprovedby=" + txtapprovedby + "&txtremark=" + txtremark  + "&Optype=" + Optype;                         
            //             Optype = 0;
            //        }
            //        sendRequest(url);
        }
    
    
        function changecolor (chkid,rowid)
        {
            id = 'trIndent_' + rowid;
            if (document .getElementById (chkid).checked == true )
            {
   
                document .getElementById(id).style.backgroundColor="#FFFF33";
            }
            else
            {

                document .getElementById(id).style.backgroundColor="";
            }
        }
    
    
    </script>
         <script src="../scripts/jquery-1.11.0.min.js"></script>
            <script src="../scripts/jquery-ui.js"></script>

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
        <h1>Receipt Control Register (     <asp:Label ID="lblType" runat="server" Text="" ForeColor="REd"></asp:Label>
                                                        <asp:RadioButtonList ID="radparttype" Visible="false" Enabled="false" AutoPostBack="true"
                                                            RepeatDirection="Horizontal" runat="server">
                                                            <asp:ListItem Text="SP" Value="sp"> </asp:ListItem>
                                                            <asp:ListItem Text="HW" Value="hw"> </asp:ListItem>
                                                        </asp:RadioButtonList><asp:Label ID="lblmessage" Visible="false" ForeColor="red" Text="Click here for adding vendor" runat="server"></asp:Label>)</h1>
     
                                                    <asp:CheckBox ID="check" AutoPostBack="true" Visible="false" runat="server" />
                                         
         </div>

    <asp:HiddenField ID="Hid_Rec" runat="server" />
    <div align="center">
        
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnPOtype" runat="server" type="hidden" name="hdnPOtype" />
        <input id="hdnPoNo" runat="server" type="hidden" name="hdnPoNo" />
        <input id="hdndetail" runat="server" type="hidden" name="hdndetail" />
        <input id="hdnPoDate" runat="server" type="hidden" name="hdnPoDate" />

        <div id="middal">
           
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%" cellpadding="0" cellspacing="0" runat="server" align="center">
                        <tbody>
                           

                            <tr>
                                <td>
                                    <div style="text-align: center">
                                        <table>
                                          
                                        </table>
                                        <table id="trvendor" runat="server" visible="false">
                                            <tr>
                                                <td align="right">Add Vendor Name
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtvendorname" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Add1
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtadd1" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Add2
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtadd2" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Capital
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtcapital" runat="server" Width="350px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:ImageButton ID="save_vendor" runat="server" ImageUrl="../images/btn_h.gif" align="absmiddle"
                                                        border="0" Width="87" Height="38" AlternateText="Save" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tblmain" runat="server">
                                            <tbody>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                     
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="Label2" runat="server" Text="  Vendor Name"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <input type="text" id="txtvendor" onblur="chkvendorname();" style="width: 220px"
                                                            class="textfield" runat="server" />
                                                    </td>
                                                    <td align="right">PO Type
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPOtype" runat="server" onblur="getpo();" class="textfield"></asp:TextBox>
                                                        <asp:ListBox ID="ListBox1" onclick="Select(this);" Style="display: none; text-align: center"
                                                            runat="server"></asp:ListBox>
                                                        <%--<select id="ddlPOtype" runat="server" style="width: 60px">
                                                            <option value="RC">RC</option>
                                                            <option value="SP">SP</option>
                                                            <option value="PA">PA</option>
                                                            <option value="T&C">T&C</option>
                                                            <option value="PB">PB</option>
                                                            <option value="PMT">PMT</option>
                                                        </select>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">PO. Date
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="bdpPoDate" ReadOnly="true" runat="server" Size="10" Width="120"></asp:TextBox>
                                                        <%--  <img id="Cal_Start" visible ="false" onclick="return popUpCalendar(this, bdpPoDate)" src="../images/cal.gif"
                                                            valign="Middle" />--%>
                                                        <%--<BDP:BDPLite ID="bdpPoDate" runat="server" TextBoxStyle-CssClass="textfield">
                                                        </BDP:BDPLite>--%>
                                                    </td>
                                                    <td align="right" visible="false">Gate Pass No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtgate" Visible="false" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" visible="false">Inward No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtInwardNo" Visible="false" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="height: 25px" visible="false">Security Date
                                                    </td>
                                                    <td align="left" style="height: 25px">
                                                    
                                                         <asp:TextBox ID="BDPLite1" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                                    PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                                </asp:ScriptManager>
                                                    </td>
                                                    <td visible="false" align="right">D.R.B No
                                                    </td>
                                                    <td visible="false" align="left">
                                                        <asp:TextBox ID="txtdrb" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">Challan No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtchalan" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">Challan Date
                                                    </td>
                                                    <td align="left">
                                                     
                                                         
                                                         <asp:TextBox ID="BDPLite2" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="BDPLite2"
                                                    PopupButtonID="BDPLite2" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">Bill No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtbill" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">Bill Date
                                                    </td>
                                                    <td align="left">
                                                       
                                                            <asp:TextBox ID="bdpbilldate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="bdpbilldate"
                                                    PopupButtonID="bdpbilldate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">Rec No
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtRecNo" ForeColor="red" ReadOnly="true" runat="server" class="textfield"></asp:TextBox>
                                                    </td>
                                                    <td align="right">Rec Date
                                                    </td>
                                                    <td align="left">
                                                   
                                                                <asp:TextBox ID="bdpRecDate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="bdpRecDate"
                                                    PopupButtonID="bdpRecDate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 7px" colspan="9">&nbsp;
                                                        <table id="Grd_Item" cellpadding="4" cellspacing="0" bordercolor="#FFFFFF" border="0"
                                                            bgcolor="#f4f4f4" height="51px" style="border-collapse: collapse" runat="server">
                                                            <tr>
                                                                <td colspan="5">
                                                                    <div id="dvRIndent">
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr visible="false" class="gridtxt">
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtlfno" TabIndex="9" onblur="emptytext();getitemname();"
                                                                        runat="server" Width="100px" Height="22px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtPartNo" TabIndex="10" onblur="emptytextpart();getitemname();"
                                                                        runat="server" Width="100px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="ddlitem" TabIndex="11" onpropertychange="getitemname()"
                                                                        onblur="return check1();" runat="server" Width="175px"></asp:TextBox><asp:ListBox
                                                                            ID="Select1" Style="display: none; align: left" onclick="Select();" runat="server"></asp:ListBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtbqty" TabIndex="12" Onfocus="display ()" ReadOnly="true"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>

                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtunit" TabIndex="12" Onfocus="display ()" ReadOnly="true"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>

                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtRate" TabIndex="13" onblur="if (!IsNumeric(this.value)){alert('Enter proper value');this.value=0;return false}"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtChallnQty" TabIndex="14" onblur="return fillActualQty();"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="width: 100px; height: 28px;">
                                                                    <asp:TextBox class="textfield" ID="txtqty" TabIndex="15" onblur="ticFunction2()"
                                                                        runat="server" Width="56px"></asp:TextBox>
                                                                </td>
                                                                <td style="height: 28px"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="7" style="height: 50px">
                                                        <%--<input name="btnSubmit" type="button" id="btnSubmit" imageurl="../images/btn_h.gif"
                                                            value="Save" onclick="return validate();ValidateSave();" />--%>
                                                        <asp:ImageButton ID="btnSubmit" TabIndex="16" runat="server" ImageUrl="../images/btn_h.gif"
                                                            align="absmiddle" border="0" Width="87" Height="38" AlternateText="Save" />
                                                        <a href="storemasternew.aspx">Reset</a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="orgbottam">
                </div>
            </div>
        </div>
    </div>
  

    <script type="text/javascript">
        $(document).ready(function () {

            $("#txtvendor").autocomplete(

                {
                    source: [<% =strVendor  %>]
                }
            );
        });
	
/*

var txtSecDate = document.getElementById('BDPLite1_TextBox');
    txtSecDate.readOnly = true;   
var txtChlnDate = document.getElementById('BDPLite2_TextBox');
    txtChlnDate.readOnly = true;
var txtBillDate = document.getElementById('bdpbilldate_TextBox');
    txtBillDate.readOnly = true;
var txtRecDate = document.getElementById('bdpRecDate_TextBox');
    txtRecDate.readOnly = true;     
*/
    </script>

</asp:Content>
