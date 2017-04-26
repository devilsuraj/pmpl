<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
          <script src="<% =Session("host") %>/scripts/jquery-1.11.0.min.js"></script>
    <script src="http://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="http://www.amcharts.com/lib/3/serial.js"></script>
<script src="http://www.amcharts.com/lib/3/themes/light.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" Runat="Server">
      <!-- END HEADER -->
            <div class="container-fluid" style="margin-top:-50px">
                <div class="">
                    <!-- BEGIN BREADCRUMBS -->
                    <div class="breadcrumbs">
                        <h1 class="aption-subject bold uppercase font-dark"><%=Session("deponame") %></h1>
                        
                    </div>
                    <!-- END BREADCRUMBS -->
                    <!-- BEGIN PAGE BASE CONTENT -->

                    <div class="row widget-row">
                        <div class="col-md-3">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">Total Defects</h4>
                                <div class="widget-thumb-wrap">
                                   <i class=" widget-thumb-icon bg-green fa fa-cogs" aria-hidden="true"></i>
                                    <div class="widget-thumb-body">
                                       
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value='<%=Session("total_defect") %>'><%=Session("total_defect") %></span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                        <div class="col-md-3">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">Depot Defects</h4>
                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon bg-red fa fa-bus"></i>
                                    <div class="widget-thumb-body">
                                     
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value='<%=Session("depo_defect") %>'><%=Session("depo_defect") %></span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                        <div class="col-md-3">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">Road Defects</h4>
                                <div class="widget-thumb-wrap">
                                <i class=" widget-thumb-icon bg-purple fa fa-road" aria-hidden="true"></i>
                                    <div class="widget-thumb-body">
                           
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value='<%=Session("docking") %>'><%=Session("docking") %></span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                        <div class="col-md-3">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">Docking Defects</h4>
                                <div class="widget-thumb-wrap">
                                  <i class=" widget-thumb-icon bg-blue fa fa-industry" aria-hidden="true"></i>
                                    <div class="widget-thumb-body">
                                 
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value='<%=Session("road_defect") %>'><%=Session("road_defect") %></span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                    </div>

                    
                    <div class="row">
                        <div class="col-lg-12 col-xs-12 col-sm-12">
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <span class="caption-subject bold uppercase font-dark">Month wise Material Consumption</span>
                                       
                                    </div>
                                    
                                </div>
                                <div class="portlet-body">
                                    <div id="dashboard_amchart_1" style=" width: 100%;
                                         height: 500px;" ></div>
                                </div>
                            </div>
                        </div>
                   
                    </div>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    <!-- END PAGE BASE CONTENT -->
                </div>
                <!-- BEGIN FOOTER -->
            </div>
   
        <!-- END CONTAINER -->
        <!-- BEGIN QUICK SIDEBAR -->
      <script>
          /**
 * Plugin to auto-truncate the axis labels
 */
          AmCharts.addInitHandler(function (chart) {

              // Add handler for when the chart is inited
              chart.addListener("init", function (e) {

                  // Process each value axis
                  for (var i = 0; i < chart.valueAxes.length; i++) {
                      var axis = chart.valueAxes[i];
                      if (axis.title) {

                          // Get available height
                          var ph = chart.plotAreaHeight;

                          // Calculate title actual height
                          var th = axis.titleLabel.node.clientWidth;
                          if (th > ph) {

                              // Preserve original title
                              axis.originalTitle = axis.title;

                              // Start truncating the title
                              while (th > ph) {
                                  if (axis.title.match(/[\W]+/)) {
                                      // Truncate a word
                                      axis.title = axis.title.replace(/[\W]?[\w]*$/, "");
                                  } else {
                                      // Truncate a character
                                      axis.title = axis.title.replace(/[\w]{1}$/, "");
                                  }
                                  axis.titleLabel.node.firstElementChild.innerHTML = axis.title + "...";
                                  th = axis.titleLabel.node.clientWidth;
                              }

                              // Set up hover balloon
                              var title = document.createElementNS("http://www.w3.org/2000/svg", "title");
                              title.textContent = axis.originalTitle;
                              axis.titleLabel.node.appendChild(title);


                          }
                      }
                  }
              });
          }, ["serial"]);
          $.get("<% =Session("host") %>/store/ajaxstore.aspx?action=getchartvaluemwmc&poyear=2016", function (data) {
              var chartData = JSON.parse( data);
              console.log(chartData);
              var chart = AmCharts.makeChart("dashboard_amchart_1", {
                  type: "serial",
                  fontSize: 12,
                  fontFamily: "Open Sans",
                  dataProvider: chartData,
                  startDuration: 1,
                  color: "#6c7b88",
                  "categoryField": "date",
                  "categoryAxis": {
                      "gridPosition": "middle",
                      "gridAlpha": 0,
                      "labelFunction": function (valueText, serialDataItem, categoryAxis) {
                          if (valueText.length > 3)
                              return valueText.substring(0, 3) + '';
                          else
                              return valueText;
                      }
                  },
                  "valueAxis": [{
                      "gridColor": "#FFFFFF",
                      "gridAlpha": 0.2,
                      "dashLength": 0,
                      "labelFunction": function (valueText, serialDataItem, valueAxis) {
                          if (valueText.length > 3)
                              return valueText.substring(0, 3) + '';
                          else
                              return valueText;
                      }
                  }],
                  "graphs": [{
                      "balloonText": "[[category]] : <b>[[value]]</b>",
                      "fillAlphas": 0.8,
                      "lineAlpha": 0.2,
                      "type": "column",
                      "valueField": "distance",
                  }],
                  "export": {
                      "enabled": true
                  }
              });
          });
          

      
      </script>
      
</asp:Content>

