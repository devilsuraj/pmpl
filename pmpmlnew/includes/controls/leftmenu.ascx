<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftmenu.ascx.vb" Inherits="includes_controls_leftmenu" %>
<div class="leftlinkbox">
    <div class="leftlinktopimg">
    </div>
    <div class="leftlinkbg">
        <ul class="MenuBarVertical MenuBarActive" id="MenuBar1">
            <% If Session("Dept_code") = 4 Then%>
            <li><a href="../fuel/diesel_indent.aspx" class="">Diesel Indent</a></li>
            <li><a href="../fuel/tanker_master.aspx" class="">Tanker</a></li>
            <li><a href="../fuel/Oiltransfer.aspx" class="">Oil Transfer</a></li>
            <li><a href="../fuel/oilpo.aspx">Oil PO Order</a></li>
            <li><a href="../fuel/oilreceipt.aspx">Oil Recipt</a></li>
            <li><a href="../../fuel/oilissue.aspx">Oil Issue</a></li>
            <li><a href="../report/fuelreport.aspx">Fuel Report</a></li>
            <% Else%>
            <% If Session("RoleId") = 1 Then%>
            <li><a href="../store/storeitemmaster.aspx" class="">Master</a></li>
            <% End If%>
            <li><a href="../store/po_master.aspx" class="">PO Master</a></li>
            <li><a href="../store/frmibc.aspx" class="">IBC</a></li>
            <li><a href="../store/ibc_closer.aspx" class="">IBC Close</a></li>
            <li><a href="../store/storemasternew.aspx" class="">Receipt Control Register</a></li>
             <li><a href="../store/ClamAfterRecived.aspx" class="">Claim After Recived</a></li>
           
            <li><a href="../store/Authenticate_receive.aspx" class="">DRB Received</a></li>
            
            <li><a href="../store/uploadexcel.aspx" class="">Upload Excel</a></li>
            <li><a href="../store/newissue.aspx" class="">New Issue</a></li>
            <li><a href="../store/storeissue.aspx" class="">Stock Issue</a></li>
            <li><a href="../store/invoice_detail.aspx" class="">Invoice</a></li>
            <li><a href="../store/delete_inv.aspx" class="">Invoice Delete</a></li>
            <li><a href="../store/claimmaster.aspx"class="">Claim Master</a></li>
            <li><a href="../store/claimreceive.aspx">Claim Recive</a></li>
            <li><a href="../report/rptItemrate.aspx">Item Rate Report</a></li>
            <li><a href="../report/rpt_ClaimRejection.aspx">Claim and Rejection Report </a></li>
            <li><a href="../report/AllClaimReport.aspx">All Claim Report </a></li>
       
            <li><a href="javascript:void(0);" class="MenuBarItemSubmenu">Item</a>
                <ul class="">
                   <li><a href="../store/Updateitem.aspx">Update Item</a></li>
                     <%--<li><a href="../store/deletereceiveitem.aspx">Delete Receive Item</a></li>
                    <li><a href="../store/rejectitem.aspx">Reject Receive Item</a></li>
                    <li><a href="../store/deleteitem.aspx">Delete Issue Item</a></li>
                    <li><a href="../store/updatestock.aspx">Update Item Stock</a></li>
                    <li><a href="../store/UpdateTransDate.aspx">Update Transaction Date</a></li>
                    <li><a href="../store/updatepo.aspx">Update PO</a></li>
                    <li><a href="../../code/store/updatePoAll.aspx"  >Update PO Details</a></li>--%>
                    <% If Session("RoleId") = 1 Then%>
                    <li><a href="../store/usermaster.aspx">User Master</a></li>
                    <% Else%>
                    <li><a href="javascript:void(0);">User Master</a></li>
                    <% End If%>
                      <li><a href="../store/Itemupdatemaster.aspx">Update Item Category </a></li>
                    <li><a href="../store/Update_ItemMaster.aspx">Update File Wise Item </a></li>
                      <% If Session("RoleId") = 4 Then%>                  
                    <li><a href="../store/updateVendor.aspx" >Update Stock Vendors </a></li>
                    <li><a href="../store/updatePoAll.aspx"  >Update PO Details </a></li>
                      <li><a href="../store/storemasterold.aspx" >Add Vendor Details </a></li>
                    <li><a href="../store/storeitemmaster.aspx"  >Add Item Details </a></li>
                    <li><a href="../store/Update_ItemMaster.aspx">Update File Wise Item </a></li>
                    <% End If%>
                </ul>
            </li>
            <li><a href="../report/storereport.aspx" class="">Store Report</a></li>
            
            <% If Session("Dept_code") = 2 Then%>
            <li><a href="../store/GlassReceipt.aspx">Glass PO</a></li>
            <li><a href="../store/GlassReceive.aspx">Glass Recive</a></li>
            <li><a href="../store/Stndrb.aspx">STN DRB</a></li>
            <li><a href="../store/KITDRB.aspx">KIT DRB</a></li>
            <li><a href="../report/rptGlassPO.aspx">Glass PO Report</a></li>
            <li><a href="../store/Updateitem.aspx">Update Item</a></li>
            <li><a href="../store/Rejectionentry.aspx">Rejection Form</a></li>
              <li><a href="../report/rpt_depowisecost.aspx">Depot Wise Cost</a></li>              
                 <li><a href="../report/rpt_Depotwiseitemissuedetails.aspx">Depot Wise Item Cost Details</a></li>                
                  <li><a href="../report/storereport.aspx" class="">Store Report</a></li>
            <% End If%>
             
            <% End If%>
        </ul>
    </div>
</div>
