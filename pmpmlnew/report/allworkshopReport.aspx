<%@ Page Title="" Language="VB" enableEventValidation="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" 
    CodeFile="allworkshopReport.aspx.vb"
    Inherits="kdmt.allworkshopReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Basic Page Needs
  ================================================== -->
    <meta charset="utf-8">
    <title>Workshop Reports</title>
    <!-- Mobile Specific Metas
	================================================== -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- CSS
	================================================== -->
    <link rel="stylesheet" href="../css/style.css">
    <!-- Custom Fonts -->
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <!-- Optional theme -->
    <link rel="stylesheet" href="../css/bootstrap-theme.min.css" />
    <!-- Latest compiled and minified JavaScript -->
    <script src="../css/bootstrap.min.js"></script>
    <script src="../css/html5shiv.min.js"></script>
    <script src="../css/respond.min.js"></script>
   <link href="../css/newmvc.css" rel="stylesheet" />
    <style>
       .form-horizontal  li a {
        padding:10px;
        display:block;
          background-color:#bd5f30;
          margin-bottom:10px;
          color:#fff;
        }
        .form-horizontal li  {
        display:block;
      
        }
            .form-horizontal li a:hover {
              background-color:#a44520;
              text-decoration:none;
              color:#2b180a
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>All Workshop Reports</h1>
    </div>
    <div class="form-horizontal" style="overflow:auto">
   
        <div class="row">
            <div class="col-md-12">
         
                <div class="col-md-10 lft">
                    <div class="row card ps">
                        <div class="col-md-12">
                            <div class="col-md-4">
                                <h4 style="margin-left: 80px;">
                                    Job Card
                                </h4>
                                <ul>
                                    <li><a href="../Workshop/JOC_Register.aspx">Job Order Card Report </a></li>
                                    <li><a href="../Workshop/rptAssignedJob.aspx">Assigned Job Report </a></li>
                                    <li><a href="../report/buswork.aspx">Work Done on Bus</a> </li>
                                    <li><a href="../report/rptjobopenclosereport.aspx">Job Open Close Report </a></li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h4 style="margin-left: 80px;">
                                    Workshop
                                </h4>
                                <ul>
                                    <li><a href="../Workshop/workshopreport.aspx">Workshop Detail Report </a></li>
                                    <li><a href="../report/rptWorkshopSummary.aspx">Workshop Summary Report </a></li>
                                    <li><a href="../report/rptjobopenclosereport.aspx">Daily Bus Position Report</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h4 style="margin-left: 80px;">
                                    Break Down
                                </h4>
                                <ul>
                                    <li><a href="../Workshop/Brakedown_List.aspx">Brakedown Report </a></li>
                                    <li><a href="../Workshop/Deptwisedeffectrpt.aspx">Section wise Deffect Report </a>
                                    </li>
                                    <li><a href="../Workshop/Repetationdeffect.aspx">Repetition Work Report</a> </li>
                                    <li><a href="../report/rptrepeatbrakedown.aspx">Daily Repeat Brakedown Report</a>
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
                                    Docking</h4>
                                <ul>
                                    <li><a href="../Workshop/workshop_currentdockingstatus.aspx">Docking Due Buses Report
                                    </a></li>
                                    <li><a href="../Workshop/Workshop_inspReport.aspx">Half Docking Report </a></li>
                                    <li><a href="../Workshop/Workshop_inspReport1.aspx">Full Docking Report Report</a>
                                    </li>
                                    <li><a href="../report/rptDockingInspHistory.aspx">Docking & Inspection History Report</a>
                                    </li>
                                    <li><a href="../report/Extra_Insp_report.aspx">Extra Inspection Report</a> </li>
                                    <li><a href="../report/rptmonthlybuswiseoilanddoking.aspx">Buswise oil and Docking Report</a>
                                    </li>
                                    <li><a href="../report/skipinspection.aspx">Inspection Skip History Report</a> </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h4 style="margin-left: 80px;">
                                    Tyre
                                </h4>
                                <ul>
                                    <li><a href="../workshop/rptTyreHistory.aspx">Daily Tyre Report </a></li>
                                    <li><a href="../report/rptScrapdetails.aspx">Scrap Tyre Report </a></li>
                                    <li><a href="../report/rptremoldhistory.aspx">Remold Tyre Report </a></li>
                                    <li><a href="../report/rptremoldRec.aspx">Remold Tyre Receive Report</a> </li>
                                    <li><a href="../report/rpttyremileagereport.aspx">Tyre Mileage Report </a></li>
                                    <li><a href="../report/rptTyreRemoldHistory.aspx">Tyre Remold History Report</a>
                                    </li>
                                    <li><a href="../report/rptkm.aspx">Kilometers Report</a> </li>
                                    <li><a href="../report/tyrefulldetail.aspx">Tyre Detail and History Report</a> </li>
                                    <li><a href="../report/tyrecompletedetail.aspx">Tyre Complete Detail Report</a>
                                    </li>
                                    <li><a href="../report/Tyre_Mileage_required_report.aspx">Before Remold KM</a> </li>
                                    <li><a href="../report/Afterremold_mileage.aspx">After Remold KM </a></li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h4 style="margin-left: 80px;">
                                    Other</h4>
                                <ul>
                                    <li><a href="../Report/Sickbus_fuelwise.aspx">Sick Bus Fuel wise Report </a></li>
                                    <li><a href="../Report/workshop_bus_issue.aspx">Buswise Item Issue Report</a></li>
                                    <li><a href="../Report/rptfuel_month_cng.aspx?id=1">Daily CNG Report</a> </li>
                                    <li><a href="../Report/rptindent.aspx">Indent Report</a> </li>
                                    <li><a href="../Report/workshop_indentfittingreport.aspx">Indent Fitting Item Report</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
