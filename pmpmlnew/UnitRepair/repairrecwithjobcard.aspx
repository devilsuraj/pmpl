

<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="repairrecwithjobcard.aspx.vb" Inherits="KDMT.repairrecwithjobcard" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Item Rec for Repair</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>
      <script src="../scripts/jquery-1.11.0.min.js"></script>
    <script src="../scripts/jquery-ui.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript" language="javascript">
    

    
    
     var Optype = 0
        var Fuel
        var ID = 0;
        var rowcnt = 1;
        var rowcntSave = 1;
        var dltcnt = 0
        
        
        
        

        function additemDetails() 
        {

           
            var ddlitem = document.getElementById('ddlitem');
            var txtserial = document.getElementById('txtserial');
            var txtbus = document.getElementById('txtbus');
            var txtqty = document.getElementById('txtqty');
             var txtremark = document.getElementById('txtremark');
            var tbody = document.getElementById('tbodyIndent');
 
            var row = tbody.insertRow(rowcnt);
            row.setAttribute('id', 'trPO_' + rowcntSave);

            var cells1 = row.insertCell(0);
            cells1.setAttribute('id', 'ddlitem_' + rowcntSave);

            var cells2 = row.insertCell(1);
            cells2.setAttribute('id', 'txtserial_' + rowcntSave);

            var cells3 = row.insertCell(2);
            cells3.setAttribute('id', 'txtbus_' + rowcntSave);
            
             var cells4 = row.insertCell(3);
            cells4.setAttribute('id', 'txtqty_' + rowcntSave);
            
             var cells5 = row.insertCell(4);
            cells5.setAttribute('id', 'txtremark_' + rowcntSave);
            
            var cells6 = row.insertCell(5);


        
            
            cells1.innerHTML = ddlitem.value;
            cells2.innerHTML = txtserial.value;
          
            cells3.innerHTML = txtbus.value;
            cells4.innerHTML = txtqty.value;
            cells5.innerHTML = txtremark.value;
           
            cells6.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcntSave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'

            rowcnt = rowcnt + 1;
            rowcntSave += 1;
                                   
            
            ddlitem.value = '';
            txtserial.value = '';
            txtbus.value = '';
            txtqty.value = '';
            txtremark.value = '';

            ddlitem.focus();
            document.getElementById('hdnrwcnt').value = rowcntSave;
            // alert(document.getElementById('hdnrwcnt').value)
        }


        function deleteRow(cnt) {

            var tr = document.getElementById(cnt);
            document.getElementById('tbodyIndent').removeChild(tr);
            var hdnrwcnt = document.getElementById('hdnrwcnt');
            //hdnrwcnt.value = hdnrwcnt.value -1;
            rowcnt = rowcnt - 1;
            dltcnt = dltcnt + 1

        }






////////////////   end  filteration   ///////////////////////////
//// check for numeric fields only
//      
function IsNumeric(strString)
{
    var ValidChars = "0123456789";
    var Char;
    for (i = 0; i < strString.length; i++) 
    { 
    Char = strString.charAt(i); 
    if (ValidChars.indexOf(Char) == -1) 
    {
    return true;
    }
    }
    
    return false;
}

function ticFunction2()

{

    
    
  if (document.getElementById ("ddlvendor").selectedIndex == 0 )
    {
    alert ('Select Contractor Name');
    document.getElementById ("ddlvendor").focus()
    return false;
    }

    if (document.getElementById ("txtSupervisor").value.length==0)
    {
    alert ('Please Enter Supervisor Name');
    document.getElementById ("txtSupervisor").focus()
    return false;
}
if (document.getElementById("ddlplace").selectedIndex == 0) {
    alert('Please Select place');
    document.getElementById("ddlplace").focus()
    return false;
}

//if (document.getElementById ("txtDeliver").value.length==0)
//    {
//    alert ('Please Enter Delivered by Name');
//    document.getElementById ("txtDeliver").focus()
//    return false;
//    }
//if (document.getElementById ("txtReceive").value.length==0)
//    {
//    alert ('Please Enter Receiver Name');
//    document.getElementById ("txtReceive").focus()
//    return false;
//    }
if (document.getElementById ("ddlitem").value == '')
    {
    alert("Please Enter Item ");
    document.getElementById ("ddlitem").focus();
    return false ;
    }
    if (document.getElementById ("txtserial").value == '')
    {
    alert("Please Enter Serial No ");
    document.getElementById ("txtserial").focus();
    return false ;
    }
     if (document.getElementById ("txtbus").value == '')
    {
    alert("Please Enter Bus No ");
    document.getElementById ("txtbus").focus();
    return false ;
    }
    
    
    
    if (document.getElementById ("txtqty").value == '')
    {
    alert("Please Enter Quantity ");
    document.getElementById ("txtqty").focus();
    return false ;
    }




}

function chkRepairItemSR()
{
//    document.getElementById("Select1").style.display='none';
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

    alert("Please enter Proper Item");
    document.getElementById("ddlitem").focus();
    return false;

    }

    }
    }
 
if (document.getElementById("ddlitem").value != '')
{
    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkrepaiitemsrno&itemName="+document.getElementById("ddlitem").value,true);
    xmlHttp.send(null);
    }
    
}

function chkSerialNo()
{
//    document.getElementById("Select1").style.display='none';
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

    if(ele1=="NO-SUCH-Serial No")
    {

    alert("Please enter valid Serail No");
    document.getElementById("txtserial").focus();
    return false;

    }

    }
    }
 
if (document.getElementById("txtserial").value != '')
{

    xmlHttp.open("GET","Ajaxstore.aspx?Action=chkSerialNo&serailNo="+document.getElementById("txtserial").value,true);
    xmlHttp.send(null);
    }
    
}





function chkbus()
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
    //debugger
    resp = xmlHttp.responseText;
    var ele1 = resp
    if (ele1 == "empty")
    {
    alert("Please Enter Proper Bus No ");
    setTimeout(function () {   document.getElementById ("txtbus").focus() }, 10);

  return false;
  }

    }
    }

if (document.getElementById("txtbus").value != '')
{
    xmlHttp.open("GET","../store/Ajaxstore.aspx?Action=chkbus&busno=" + document.getElementById("txtbus").value ,true);
    xmlHttp.send(null);
    }
//    else
//    {
//    alert("Please Enter  Bus No ");
//  document.getElementById ("txtbus").focus();
//  return false;
//  }
}


  


 
        </script>
<link href="../css/newmvc.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Item Receive for repair</h1>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
   <div class="form-horizontal">
       
        <div id="middal">
           
            <div class="contantbox">
                <div class="mpagetop">
                </div>
                <div class="mpage">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                               
                                <asp:Label ID="Label1" runat="server" Text="" Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        
                                        <%--<td align="right">
                                            Date:
                                        </td>--%>
                                        <td align="right">
                                            Department Name:
                                        </td>
                                        <td align="left">
                                            <%----%>
                                            <asp:DropDownList ID="ddlvendor" runat="server" Width="180px">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                           Date: 
                                        </td>
                                        <td align="left">
                                           <%-- <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                                 
                                              <asp:TextBox ID="BDPLite1" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="BDPLite1"
                                        PopupButtonID="BDPLite1" Format="dd-MMM-yyyy">
                                    </asp:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="style1">
                                            Supervisor Name: 
                                        </td>
                                        <td align="left" class="style1">
                                           <asp:TextBox ID="txtSupervisor" runat="server"></asp:TextBox>  
                                        </td>
                                        <td align="right" class="style1">
                                    Shift
                                </td>
                                <td align="left" class="style1">
                                    <%--<asp:TextBox ID="txtshift" runat="server" Width="140px" TabIndex="13"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlshift"  runat="server">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="I" Text="I"></asp:ListItem>
                                        <asp:ListItem Value="II" Text="II"></asp:ListItem>
                                        <asp:ListItem Value="III" Text="III"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Delivered By:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDeliver" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            Received By:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtReceive" runat="server" Width="168px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Job Card No:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtJob" runat="server" ReadOnly="true" Width="40px"></asp:TextBox>
                                            <asp:TextBox ID="txtJobNo" runat="server" ReadOnly="true" Width="40px"></asp:TextBox>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="right">
                                           Place:
                                        </td>
                                        <td align="left">
                                           <asp:DropDownList ID="ddlplace"  runat="server">
                                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Turbhe"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Asudgaon"></asp:ListItem>
                                       
                                    </asp:DropDownList>  
                                        </td>
                                        <td align="right">
                                           Challan No:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtchallanno" runat="server" Width="168px" MaxLength="5"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="tblIndent" width="90%" border="1" cellpadding="2" cellspacing="2">
                                    <tbody runat="server" id="tbodyIndent">
                                        <tr class="gridhead">
                                            <td>
                                                Item Name
                                            </td>
                                            <td>
                                                Serial No
                                            </td>
                                            <td>
                                                Bus No
                                            </td>
                                            <td>
                                                Qty
                                            </td>
                                            <td>
                                                Remark
                                            </td>
                                        </tr>
                                        <tr class="gridtxt" valign="top">
                                            <td>
                                                <asp:TextBox ID="ddlitem" onblur="chkRepairItemSR();" runat="server" Width="300px"></asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtserial" runat="server" Width="100px"></asp:TextBox>
                                                <%--<asp:CheckBox ID="ch1" runat="server" Text="Contract Work" Visible="False" />--%>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtbus" runat="server" onblur="chkbus();" Width="70px"></asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtqty" runat="server" ReadOnly="true"  Text="1" Width="40px"></asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 28px;">
                                                <asp:TextBox ID="txtremark" TextMode="MultiLine" runat="server" Width="100px">
                                                </asp:TextBox>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <asp:HiddenField ID="Hid_Rec" runat="server" />
                        <tr>
                            <td style="height: 22px">
                                <div align="center">
                                    <p>
                                        &nbsp;<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"
                                            TabIndex="9"></asp:ImageButton>
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
    </form>
    <%--    <script type="text/javascript">

var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});


</script>--%>

    <script type="text/javascript">
    
//    $(document).ready(function() {
//                SearchText();
//                loadArrayDd();
//        });
//        function SearchText() {
//            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
//            //alert(document.getElementById('ddlsubdefect0').value);
//            //var details = JSON.stringify(dts);
//           
//            
//            $("#ddlvendor").autocomplete
//           ({

//               source: function(request, response) {
//                   $.ajax
//                    ({
//                    
//                        type: "POST",
//                        contentType: "application/json; charset=utf-8",
//                        url: "repairrecwithjobcard.aspx/GetAutoCompleteData",
//                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
//                        //data: details,
//                        data: JSON.stringify({ "partType": "2", "SearchText": document.getElementById('ddlitem').value }),
//                        //dataType: "json",
//                        success: function(data) {
//                            response(data.d);
//                        },
//                        error: function(result) {
//                            alert("Error");
//                        }
//                    });

//               }
//           });
//    
//    }
//    
////      $(document).ready(function() {
////         $("#ddlitem").autocomplete
////           ({
////            source: [<%= stritem  %>]
////            });
////      });
////      

 $(document).ready(function() {
                SearchText();
                //loadArrayDd();
        });
        function SearchText() {
            //var dts = '{ "SubId": "2", "SearchText": ' + '"' + document.getElementById('ddlsubdefect0').value + '"' + '}';
            //alert(document.getElementById('ddlsubdefect0').value);
            //var details = JSON.stringify(dts);
           
            
            $("#ddlitem").autocomplete
           ({

               source: function(request, response) {
                   $.ajax
                    ({
                    
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "repairrecwithjobcard.aspx/GetAutoCompleteData",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "contid": document.getElementById ('ddlvendor').options[document.getElementById ('ddlvendor').selectedIndex].value, "SearchText": document.getElementById('ddlitem').value }),
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

            
      
            
            $(document).ready(function(){
    $("#ddlvendor").change(function(){
       $("#ddlitem").val("") ;
    });

})
       }
       
       
       
         $("#txtserial").autocomplete
           ({

               source: function(request, response) {
                   $.ajax
                    ({
                    
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "repairrecwithjobcard.aspx/GetAutoCompleteSerialNo",
                        //data: JSON.stringify({ "SubId": "2", "SearchText": document.getElementById('ddlsubdefect0').value }),
                        //data: details,
                        data: JSON.stringify({ "contid": document.getElementById ('ddlvendor').options[document.getElementById ('ddlvendor').selectedIndex].value, "SearchText": document.getElementById('txtserial').value }),
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

            
      
            
            $(document).ready(function(){
    $("#ddlvendor").change(function(){
       $("#txtserial").val("") ;
    });

})
       
       
       
      
      
    </script>

</asp:Content>
