Imports System.Data.SqlClient
Namespace kdmt
    Partial Class rpt_moving_bar_graph_report
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public dynamic_item_moving_script As New StringBuilder
        Dim builder As New StringBuilder


        Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then

            End If
        End Sub

        Protected Sub btnshow_Click(sender As Object, e As System.EventArgs) Handles btnshow.Click
            Try


                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                Dim lblfromdate As String = Format(Convert.ToDateTime("04/01/2013"), "dd/MMM/yyyy")
                Dim lbltodate As String = Format(Convert.ToDateTime(Now.Date), "dd/MMM/yyyy")
                Dim dt As DataTable
                dt = GetDatatTable("[view_item_summary_moving] '04/01/2013' ,'" & Now.Date & "'," + drbType.SelectedValue + ",'16'")
                If dt.Rows.Count > 0 Then
                    a_back_id.Visible = True
                    a_backto_report.Visible = False
                    Table2.Visible = False

                    Dim fast_percent As String = dt.Rows(0).Item("f_percent")
                    Dim medium_percent As String = dt.Rows(0).Item("m_percent")
                    Dim slow_percent As String = dt.Rows(0).Item("s_percent")

                    dynamic_item_moving_script.Append("   Highcharts.chart('container', {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        chart: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            type: 'column'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        title: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            text: 'Item Moving Report ( " + drbType.SelectedItem.Text + ") " + lblfromdate.ToString() + " To " + lbltodate.ToString() + "' ")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        subtitle: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            text: 'Click the columns to view the details of each moving type'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        xAxis: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            type: 'category'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        yAxis: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            title: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                text: 'Moving Type Percent'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            }")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        legend: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            enabled: false")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        plotOptions: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            series: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                borderWidth: 0,")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                dataLabels: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                    enabled: true,")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                    format: '{point.y:.1f}%'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                }")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            }")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        tooltip: {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            headerFormat: '<span style=""font-size:11px"">{series.name}</span><br>', ")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            pointFormat: '<span style=""color:{point.color}"">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        },")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("")
                    dynamic_item_moving_script.Append("        series: [{")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            name: 'Moving Type',")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            colorByPoint: true,")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            data: [{")
                    dynamic_item_moving_script.AppendLine()
                    'dynamic_item_moving_script.Append("                name:  '<a href="" + ConfigurationManager.AppSettings("Host") + "">Fast Moving </a>.',")
                    dynamic_item_moving_script.Append("                 name:  '<a href=""" + ConfigurationManager.AppSettings("Host") + "report/rptchartwiseitemmoving_bal_and_po_details.aspx?movingtype=8&drbType=" + drbType.SelectedValue + """>Fast Moving</a>.',")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                y: " + fast_percent.ToString() + ",")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                drilldown: 'Fast Moving'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            }, {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                 name:  '<a href=""" + ConfigurationManager.AppSettings("Host") + "report/rptchartwiseitemmoving_bal_and_po_details.aspx?movingtype=9&drbType=" + drbType.SelectedValue + """>Medium Moving</a>.',")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                y: " + medium_percent.ToString() + ",")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                drilldown: 'Medium Moving'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            }, {")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                 name:  '<a href=""" + ConfigurationManager.AppSettings("Host") + "report/rptchartwiseitemmoving_bal_and_po_details.aspx?movingtype=10&drbType=" + drbType.SelectedValue + """>Slow Moving</a>.',")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                y: " + slow_percent.ToString() + ",")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("                drilldown: 'Slow Moving'")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("       ")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("            }]")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("        }]")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("       ")
                    dynamic_item_moving_script.AppendLine()
                    dynamic_item_moving_script.Append("    });")
                    dynamic_item_moving_script.AppendLine()

                Else
                    Table2.Visible = True
                    a_back_id.Visible = False
                    a_backto_report.Visible = True
                End If
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace

