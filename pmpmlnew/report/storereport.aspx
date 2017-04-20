<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Storereport.aspx.vb" Inherits="KDMT.Storereport" %>

<%@ Register Src="~/Includes/controls/header.ascx" TagName="header" TagPrefix="uc" %>
<%@ Register Src="~/Includes/controls/leftmenu.ascx" TagName="leftmenu" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Store Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../styles/KDMT.css" type="text/css" rel="stylesheet"></link>
    <link rel="stylesheet" type="text/css" href="../store/menu/anylinkcssmenu.css" />
    <script type="text/javascript" src="../store/menu/anylinkcssmenu.js"></script>
    <script type="text/javascript">
        //anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
        anylinkcssmenu.init("anchorclass")
    </script>
    <script language="javascript" src="../Scripts/KDMT_Script.js"></script>
    <!--[if IE] -->
</head>
<body>
    <form id="Form1" runat="server">
    <div align="center">
        <uc:header ID="Header1" runat="server" />
        <div id="middal">
            <uc:leftmenu ID="Leftmenu1" runat="server" />
            <div class="contantbox">
                <div class="orgtop">
                </div>
                <div class="orgmiddal">
                    <table bgcolor="#f4f4f4" border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="top" class="gridhead" align="center" colspan="2">
                                <strong><span style="font-size: 16pt; color: white">Store Operation Reports</span></strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptissuereport.aspx"><span><font color="black">Item Issued Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptitem_moving_and_balance.aspx"><span><font color="black">Item FMS Moving
                                    Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptDepotWiseSummary.aspx"><span><font color="black">Depot Wise Item Issue Summary
                                    Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_act_nonact.aspx"><span><font color="black">Active Non Active Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptContractorwise.aspx"><span><font color="black">Depot Wise Issued Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_min_Stok.aspx"><span><font color="black">Minimum Stock Level Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rpt_item_to_depot.aspx"><span><font color="black">Single Item Issue To All
                                    Depot Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptViewItemSummary.aspx"><span><font color="black">All Items Summary Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptindentslipreport.aspx"><span><font color="black">Indent Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptDeadStockSummary.aspx"><span><font color="black">DeadStock Summary Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <a href="rptorignalstoresummary.aspx"><span><font color="black">Cardex Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <a href="rptitembalance.aspx"><span><font color="black">Items Balance Report</span></a>
                            </td>
                        </tr>
                        <%--<tr>
                            <td align="center" colspan="2">
                                <a href="rptitemvaluation.aspx"><span><font color="black">Items valuation Report</span></a>
                            </td>
                        </tr>--%>
                        <tr>
                            <td align="center" colspan="2">
                                <a href="rptitemummaryandvaluation.aspx"><span><font color="black">Items Summary and
                                    valuation Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <a href="rpt_item_summry_yearly.aspx"><span><font color="black"><b>Items Summary and
                                    valuation Date Wise Report</b></span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <a href="rptDRBreportYearly.aspx"><span><font color="black">DRB Report Yearly</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <a href="FastCardexReport.aspx"><span><font color="black">Fast-Cardex Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptreceivereport.aspx"><span><font color="black">Item Received Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_all_pendingpo.aspx"><span><font color="black">All Pending PO Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptcontractorwisereceive.aspx"><span><font color="black">Vendorwise Receipt
                                    Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_fsm_pendingpo.aspx"><span><font color="black">FMS Pending PO Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptreceiptcontrolreport.aspx"><span><font color="black">Receipt Control Report</span></a>
                            </td>
                            <td align="center">
                                <a href="Poitemwisereport.aspx"><font color="black">Item Wise PO Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptreceiptcontrolreport_YEAR.aspx"><span><font color="black">Receipt Control
                                    Report Yearly</span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_po_pending_items.aspx"><span><font color="black"><b>All Pending PO Items
                                    With 0 Balance</b> </span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptDRBreport.aspx"><span><font color="black">DRB Report</span></a>
                            </td>
                            <td align="center">
                                <a href="recooperation.aspx"><span><font color="black">Recooperation Report </span>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href=""><span><font color="black"></span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_po_details.aspx"><span><font color="black"><b>PO with Item Details Report</b>
                                </span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href=""><span><font color="black"></span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_CategoryWise.aspx"><span><font color="black"><b>Category Wise Report</b>
                                </span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href=""><span><font color="black"></span></a>
                            </td>
                            <td align="center">
                                <a href="purchase_request_report.aspx"><span><font color="black"><b>Purchase Request
                                    Report</b> </span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href=""><span><font color="black"></span></a>
                            </td>
                            <td align="center">
                                <a href="rpt_moving_bar_graph_report.aspx"><span><font color="black"><b>Item Moving
                                    Report (Bar Chart)</b> </span></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px" colspan="2" align="center">
                                <a href="ABC_Analysis_monthly.aspx"><span><font color="black"><b>ABC Valuation Report</b>
                                </span></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px" colspan="2" align="center">
                                <a href="rpt_minlavel_zero.aspx"><span><font color="black"><b>Item Balance and R/Y/G
                                    List Report </b></span></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px" colspan="2" align="center">
                                <a href="rpt_act_nonact_datewise.aspx"><span><font color="black"><b>Active Non Active
                                    Summary Report </b></span></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px" colspan="2" align="center">
                                <a href="R_Y_G_summery.aspx"><span><font color="black"><b>Inventory Valuation Report
                                </b></span></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px" colspan="2" align="center">
                                <a href="rpt_po_status.aspx"><span><font color="black"><b>PO Summary</b> </span>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptItemMasterReport.aspx"><span><font color="black">Item Details Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptABCSummreport.aspx"><span><font color="black">ABC Analysis Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rptmakewisereport.aspx"><span><font color="black">Make Wise Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptibc.aspx"><span><font color="black">IBC Report And Reprint</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="VendorList.aspx"><span><font color="black">Vendor Details Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptinvoice.aspx"><span><font color="black">Invoice Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="rpt_pending_indent.aspx"><span><font color="black">Pending Indent</span></a>
                            </td>
                            <td align="center">
                                <a href="rptprojection.aspx"><span><font color="black">Projection Report</span></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a href="StocjVarificationReport.aspx"><span><font color="black">Stock Verification
                                    Report</span></a>
                            </td>
                            <td align="center">
                                <a href="rptprojectforselecteditem.aspx"><span><font color="black">Selected Item Projection
                                    Report</span></a>
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
