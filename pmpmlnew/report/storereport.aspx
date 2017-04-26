<%@ Page Title="" Language="VB" EnableEventValidation="false" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="false" CodeFile="Storereport.aspx.vb" Inherits="kdmt.Storereport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Store Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>
    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>
    <!--[if IE] -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static"
    EnableViewState="true" runat="Server">
    <link href="../css/newmvc.css" rel="stylesheet" />
    <style>
        .form-horizontal ul li a
        {
            padding: 10px;
            display: block;
            background-color: #bd5f30;
            margin-bottom: 10px;
            color: #fff;
        }
        
        .form-horizontal ul li
        {
            display: block;
        }
        
        .form-horizontal ul li a:hover
        {
            background-color: #a44520;
            text-decoration: none;
            color: #2b180a;
        }
        .xxx
        {
            padding: 10px;
            display: block;
            background-color: #bd5f30;
            margin-bottom: 10px;
            color: #fff;
        }
        
        .xxx
        {
            display: block;
        }
        
        .xxx:hover
        {
            background-color: #a44520;
            text-decoration: none;
            color: #2b180a;
        }
    </style>
    <div class="breadcrumbs">
        <h1>
            Store Reports</h1>
    </div>
    <asp:ScriptManager ID="sc1" runat="server">
    </asp:ScriptManager>
    <div id="form-horizontal" style="overflow: auto">
        <div class="col-md-10 lft">
            <div class="row card ps">
                <div class="col-md-12">
                    <div class="col-md-4">
                        <h4 style="margin-left: 80px;">
                            PO Reports
                        </h4>
                        <ul>
                            <li style="display: block"><a class="xxx" href="rpt_po_status.aspx">PO Summary </a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rpt_all_pendingpo.aspx">All Pending
                                PO Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_po_details.aspx">PO with Item Details
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_fsm_pendingpo.aspx">FMS Pending
                                PO Report</a> </li>
                            <li style="display: block"><a class="xxx" href="Poitemwisereport.aspx">Item Wise PO
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_po_pending_items.aspx">All Pending
                                PO Items With 0 Balance</a> </li>
                            <li style="display: block"><a class="xxx" href="purchase_request_report.aspx">Purchase
                                Request Report</a> </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h4 style="margin-left: 80px;">
                            Receive /Issue Report
                        </h4>
                        <ul>
                            <li style="display: block"><a class="xxx" href="rptreceivereport.aspx">Item Received
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptcontractorwisereceive.aspx">Vendorwise
                                Receipt Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptreceiptcontrolreport.aspx">Receipt
                                Control Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptreceiptcontrolreport_YEAR.aspx">Receipt
                                Control Report Yearly</a> </li>
                            <li style="display: block"><a class="xxx" href="rptContractorwise.aspx">Depot Wise Issued
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptissuereport.aspx">Item Issued Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rptindentslipreport.aspx">Indent Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rpt_pending_indent.aspx">Pending Indent</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h4 style="margin-left: 80px;">
                            DRB/ Invoice/ IBC Report
                        </h4>
                        <ul>
                            <li style="display: block"><a class="xxx" href="rptDRBreport.aspx">DRB Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rptDRBreportYearly.aspx">DRB Report
                                Yearly</a> </li>
                            <li style="display: block"><a class="xxx" href="rptinvoice.aspx">Invoice Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rptibc.aspx">IBC Report And Reprint</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <br />
            <div class="row card ps">
                <div class="col-md-12">
                    <div class="col-md-4">
                        <h4 style="margin-left: 80px;">
                            Master Reports
                        </h4>
                        <ul>
                            <li style="display: block"><a class="xxx" href="rptItemMasterReport.aspx">Item Details
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptitembalance.aspx">Items Balance Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rptitemummaryandvaluation.aspx">Items
                                Summary and valuation Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_item_summry_yearly.aspx">Items Summary
                                and valuation Date Wise Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptitemummaryandvaluation.aspx">Items
                                Summary and valuation Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_minlavel_zero.aspx">Item Balance
                                and R/Y/G List Report </a></li>
                            <li style="display: block"><a class="xxx" href="rptViewItemSummary.aspx">All Items Summary
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_CategoryWise.aspx">Category Wise
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptmakewisereport.aspx">Make Wise Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="rptDeadStockSummary.aspx">DeadStock
                                Summary Report</a> </li>
                            <li style="display: block"><a class="xxx" href="StocjVarificationReport.aspx">Stock
                                Verification Report</a> </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h4 style="margin-left: 80px;">
                            Analytical Reports
                        </h4>
                        <ul>
                            <li style="display: block"><a class="xxx" href="recooperation.aspx">Recooperation Report
                            </a></li>
                            <li style="display: block"><a class="xxx" href="rptDepotWiseSummary.aspx">Depot Wise
                                Item Issue Summary Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_act_nonact.aspx">Active Non Active
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_item_summry_yearly.aspx">Items Summary
                                and valuation Date Wise Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_min_Stok.aspx">Minimum Stock Level
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptitem_moving_and_balance.aspx">Item
                                Moving and Balance Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_moving_bar_graph_report.aspx">Item
                                Moving Report (Bar Chart)</a> </li>
                            <li style="display: block"><a class="xxx" href="ABC_Analysis_monthly.aspx">ABC Valuation
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_act_nonact_datewise.aspx">Active
                                Non Active Summary Report </a></li>
                            <li style="display: block"><a class="xxx" href="R_Y_G_summery.aspx">Inventory Valuation
                                Report </a></li>
                            <li style="display: block"><a class="xxx" href="rptABCSummreport.aspx">ABC Analysis
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptprojection.aspx">Projection Report</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h4 style="margin-left: 80px;">
                            Item Related Reports
                        </h4>
                        <ul>
                            <li style="display: block"><a class="xxx" href="rptorignalstoresummary.aspx">Cardex
                                Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rptprojectforselecteditem.aspx">Selected
                                Item Projection Report</a> </li>
                            <li style="display: block"><a class="xxx" href="rpt_item_to_depot.aspx">Single Item
                                Issue To All Depot Report</a> </li>
                            <li style="display: block"><a class="xxx" href="FastCardexReport.aspx">Fast-Cardex Report</a>
                            </li>
                            <li style="display: block"><a class="xxx" href="VendorList.aspx">Vendor Details Report</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
