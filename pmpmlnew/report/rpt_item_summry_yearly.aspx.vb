Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rpt_item_summry_yearly
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim qry As String
        Dim da As SqlClient.SqlDataAdapter
        Dim r1, r2, r3, r4 As Decimal
        Public stritemname As String = ""
        Dim TotalItem As Double = 0

        Protected Sub btnShowreport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowreport.Click
            divcry.Visible = False
            Table1.Visible = True
            Try
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                Dim todateyear As String
                Dim todateday As String
                Dim todatemonth As String
                Dim fromyear As String
                fromyear = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "yyyy")

                todateday = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd")
                todatemonth = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "MM")
                todateyear = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "yyyy")
                'todate = lblfrom.Text = BDPLite1.SelectedDate 'Format(Convert.ToDateTime(fromdate), "dd/MM/yy")               
                'BindGrid(grdstock, con, "[view_item_summary_yearly] '" & fromdate & "','" & todate & "','0','0'")
                BindGrid(grdstock, con, "[view_item_summery_Valuation_DateWise] '" & fromyear & "','" & todateday & "','" & todatemonth & "','" & todateyear & "','" & drpTypeOfItems.SelectedValue & "','0'")
                'end nilesh code'

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    btnexcel.Visible = True

                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnexcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnexcel.Click
            ExportDataGrid(grdstock)
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case CType(e.Item.Cells(8).Text, String)
                Case Is = 0
                    e.Item.Cells(9).BackColor = Drawing.Color.Red
                    e.Item.Cells(9).ForeColor = Drawing.Color.White
                    'Case Is = 10
                    '    e.Item.Cells(7).BackColor = Drawing.Color.Orange
                    'e.Item.BackColor = Drawing.Color.Red
            End Select
            Select Case CType(e.Item.Cells(8).Text, String)
                Case Is = 0
                    e.Item.Cells(8).BackColor = Drawing.Color.Red
                    e.Item.Cells(8).ForeColor = Drawing.Color.White
                    'Case Is = 10
                    '    e.Item.Cells(7).BackColor = Drawing.Color.Orange
                    'e.Item.BackColor = Drawing.Color.Red
            End Select
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    ''e.Item.Cells(0).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))

                    TotalItem = TotalItem + CDbl(e.Item.Cells(11).Text)
                    'TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
                Case ListItemType.Footer
                    e.Item.Cells(10).Text = "Total : "
                    e.Item.Cells(11).Text = TotalItem.ToString()   '.TryParse()

            End Select
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                Dim fromdate As String
                Dim todate As String
                Dim year As String '= ddlfinancecalendar.SelectedItem.Text
                fromdate = year.ToString().Substring(0, 4)
                todate = year.ToString().Substring(5, 4)
                'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                Dim dt As New DataTable
                dt = GetDatatTable("view_item_summary_yearly '" & fromdate & "' ,'" & todate & "','0','0'")
                Session("itemcontractdt") = dt
                If dt.Rows.Count <= 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    cry_Itemsumvalrpt.Visible = False
                    cry_Itemsumvalrpt.EnableDatabaseLogonPrompt = False
                    Table1.Visible = False
                    'divcrt.Visible = True
                Else
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("CrystalReport.rpt"))
                    cryRpt.SetDataSource(dt)
                    cryRpt.SetParameterValue("@cont", Session("depotval"))
                    cryRpt.SetParameterValue("@dt", Session("fromcontract"))
                    cryRpt.SetParameterValue("dtto", Session("tocontract"))
                    cry_Itemsumvalrpt.EnableDatabaseLogonPrompt = False
                    cry_Itemsumvalrpt.EnableParameterPrompt = False
                    cry_Itemsumvalrpt.EnableViewState = True
                    cry_Itemsumvalrpt.ReportSource = cryRpt
                    cry_Itemsumvalrpt.RefreshReport()
                    cry_Itemsumvalrpt.DataBind()
                    Table1.Visible = False
                    'divcrt.Visible = True
                End If
            Catch ex As Exception
            End Try
        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
        End Sub
    End Class
End Namespace
