<%@ Page Language="VB" AutoEventWireup="false" CodeFile="KITDRB.aspx.vb" Inherits="KDMT.store_KITDRB" %>

<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title>Authenticate Receive Item</title>
    <link rel="stylesheet" type="text/css" href="menu/anylinkcssmenu.css" />

    <script type="text/javascript" src="menu/anylinkcssmenu.js"></script>

    <script type="text/javascript">
//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet" />

    <script language="javascript">


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
    ajaxFunction()
    url = url + '&t=' + new Date();      
    xmlHttp.open("GET",url );   
    xmlHttp.send(null);   
}



    function Details(ID){ 
             var type = 'KIT'         
            var url = "Ajaxstore.aspx?action=getAuthenticDetails&storeid=" + ID + "&parttype=" + type
            sendRequest(url);            
            return false;             
    }       
    function omchanged(ID){
       document.getElementById('hdnsp').value =  document.getElementById('txtdrbNo_' + ID).value       
        var url = "Ajaxstore.aspx?action=geomchanged&id=" + ID ;
        sendRequest(url);            
        return false;             
    }   
    
    function spchanged(ID){     
       document.getElementById('txtdrbNo_' + ID).value =  document.getElementById('hdnsp').value 
        return false;             
    }   
    
    function handleresponse() 
       {   
    
        var arrresp = new Array();     
        if(xmlHttp.readyState==4) {                    
        resp = xmlHttp.responseText;            
            if (resp.indexOf('omNo')!= -1){
                 arrresp = resp.split("^");                 
                 document.getElementById('txtdrbNo_' + arrresp[2].substring(0,1)).value =   + arrresp[1];
            }
            else if (resp.indexOf('Authenticated')!= -1){
            
                 if(confirm("Are You Want to Print")){
                 window.location.href='../report/rptDRBreport.aspx?SrNo=' +  document.getElementById('hdnMID').value ;
                 return true}
                 else{
                 alert('Saved Successfuly');
                 window.location.href='Authenticate_receive.aspx';
                 return false}  
            
                alert('Authenticate Succesfully'); 
                window.location.href = "Authenticate_receive.aspx";                
                return false;               
            }            
            else{
                arrresp = resp.split("^");                     
                document.getElementById('hdncnt').value = arrresp[1].substring(0,1);
                document.getElementById('hdnom').value = arrresp[2].substring(0,1);                                
                document.getElementById('dvAuthenticDetail').innerHTML = arrresp[0];                        
                return false;
            }
            }              
        }
    
    
    function chkradio(count,typeid)
    {
    var typeid1 = typeid.id
    spid = "radsp_" + count
    omid = "radom_" + count
  
    if (typeid1 != spid ) 
  {
       document.getElementById(omid).checked = true  ;
       document.getElementById(spid).checked = false 
  }
  else
    {
       document.getElementById(omid).checked = false  ;
       document.getElementById(omid).checked = true  ;
    }
    }

function radvaidate(radid)
{

var checkid = (radid.id)
var rowCount = document.getElementById("dgresult").rows.length;
var i=1;
var j=0;
    for (i=2;i<=rowCount;i++)
    {
    var id = 'dgresult__ctl' + i + '_authenticate'
    if (id != checkid )
    {
        document.getElementById(id).checked = false ;
     }
     else
      {
        document.getElementById(id).checked = true  ;
      }
    }
}

function validate ()
{
    var rowCount = document.getElementById("dgresult").rows.length;
    var i=1;
    var j=0;
    for (i=2;i<=rowCount;i++)
    {
        var id = 'dgresult__ctl' + i + '_authenticate'
        if (document.getElementById(id).checked == true )
        {
            j = 1            
        }
    }

    if (j== 0)
    {
    alert ('Please click The button if You want to Authenticate')
    return false 
    }   
    
    if(!confirm("Do you want to Authenticate"))    
    {    
    return(false);
    }
    else{   
   
        var MID = document.getElementById("hdnMID").value
        var ID = document.getElementById("hdnID").value
        var cnt = document.getElementById("hdncnt").value   
        var drbdate = document.getElementById("bdpdrbdate_TextBox").value
                                           
        var rdbsp = '';       
        var drbno = '';  
        for(i=0;i<cnt;i++){
            if(document.getElementById("radsp_" + i)){
                if(document.getElementById("radsp_" + i).checked == true){
                rdbsp +=  document.getElementById("radsp_" + i).value + '-';
                 drbno +=  document.getElementById("txtdrbNo_" + i).value + '|';
                }
            }
            if(document.getElementById("radom_" + i)){
         
                if(document.getElementById("radom_" + i).checked == true){ 
                rdbsp +=  document.getElementById("radom_" + i).value + '-';
                
                 drbno +=  document.getElementById("txtdrbNo_" + i).value + '|';
                
                }
            }
            else
            {
            drbno +=  document.getElementById("txtdrbNo_" + i).value + '|';
            }
        }       
        var url = "Ajaxstore.aspx?action=Authenticationforkit&storeid=" + ID + "&cnt=" + cnt + "&rdbsp=" + rdbsp + "&drbno=" + drbno + "&MID=" + MID + "&drbdate=" + drbdate;     
       // var url = "Ajaxstore.aspx?action=Authenticationforstn&storeid=" + ID + "&cnt=" + cnt + "&rdbsp=" + rdbsp + "&drbno=" + drbno + "&MID=" + MID + "&drbdate=" + drbdate;     
        sendRequest(url);            
        return false;             
    }
}


    </script>

</head>
<body class="body">
    <form id="Form1" runat="server">
    <div align="center">
        <input type="hidden" id="hdnsp" />
        <input type="hidden" id="hdncnt" />
        <input type="hidden" id="hdnom" />
       
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table width="100%">
                        <tr>
                            <td class="innerheading">
                                <span id="Span1">KIT DRB Register</span>
                            </td>
                        </tr>
                        <tr id="trgrid" runat="server">
                            <td>
                                <asp:DataGrid ID="dgresult" CellPadding="4" CellSpacing="0" BorderColor="#FFFFFF"
                                    HeaderStyle-CssClass="gridhead" border="0" bgcolor="#f4f4f4" Height="51" Style="border-collapse: collapse"
                                    runat="server" AutoGenerateColumns="False">
                                    <Columns>
                                    
                                        <asp:BoundColumn DataField="store_id" Visible="False"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <%#Container.ItemIndex + 1%>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="vendor_name" HeaderText="Vendor Name"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="rec_no" HeaderText="Rec No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="rec_date" HeaderText="Rec Date"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="challan No">
                                            <ItemTemplate>
                                                <asp:Label ID="challan_no" Text='<%# DataBinder.Eval(Container, "DataItem.challan_no") %>'
                                                    runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="challan_date" HeaderText="challan Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="po_no" HeaderText="Po No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="po_date" HeaderText="Po Date"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="bill_no" HeaderText="Bill No"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="bill_date" HeaderText="Bill Date"></asp:BoundColumn>
                                        <asp:TemplateColumn Visible="false" HeaderText="DRB NO">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtdrb" runat="server" Width="50px"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Authenticate">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="authenticate" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                    <HeaderStyle CssClass="gridhead"></HeaderStyle>
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                DRB Date :
                                <BDP:BDPLite ID="bdpdrbdate" TextBoxStyle-Width="80px" runat="server">
                                </BDP:BDPLite>
                            </td>
                        </tr>
                        <tr id="trchild" runat="server">
                            <td>
                                <div id="dvAuthenticDetail">
                                </div>
                            </td>
                        </tr>
                        <tr id="trbtn" runat="server" style="height: 100px">
                            <td style="height: 22px">
                                <div align="center">
                                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="../images/btn_h.gif"></asp:ImageButton><asp:ImageButton
                                        ID="btnclear" runat="server" ImageUrl="../images/cancel.gif" TabIndex="1"></asp:ImageButton></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="text3">
                                <asp:HiddenField ID="Hid_Rec" runat="server" />
                                <asp:HiddenField ID="from_km" runat="server" />
                                <asp:HiddenField ID="to_km" runat="server" />
                                <asp:HiddenField ID="hdnTotalKm" runat="server" />
                                <asp:HiddenField ID="BHid_Rec" runat="server" />
                                <asp:HiddenField ID="Dept_code" runat="server" />
                                <asp:HiddenField ID="fydrbyear" runat="server" />
                              
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
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
//-->

    </script>

</body>
</html>
