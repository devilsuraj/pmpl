Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT


    Partial Class StocjVarificationReport
        Inherits System.Web.UI.Page



        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim qry As String
        Dim da As SqlClient.SqlDataAdapter
        Dim r1, r2, r3, r4 As Decimal
        Public stritemname As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim i As Integer = 1
                For i = 1 To 6
                    Dim fin_year As String = GetFinYear(i)
                    ddlfinancecalendar.Items.Add(New ListItem(fin_year, i))


                Next
            End If
        End Sub
        Private Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = DateTime.Now.Date
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function

        Protected Sub btnShowreport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowreport.Click
            divcry.Visible = False
            Table1.Visible = True
            Try

                Dim fromdate As String
                Dim todate As String
                Dim year As String = ddlfinancecalendar.SelectedItem.Text
                fromdate = year.ToString().Substring(0, 4)
                todate = year.ToString().Substring(5, 4)

                lblfrom.Text = ddlfinancecalendar.SelectedItem.Text 'Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                ' lbltodate.Text = todate 'Format(Convert.ToDateTime(todate), "dd/MM/yy")

                ''  (grdstock, con, "view_item_summary '" & fromdate & "','" & todate & "','" & drpType.SelectedValue & "'")
                BindGrid(grdstock, con, "[view_item_Valuation] '" & fromdate & "','" & todate & "','" & drpTypeOfItems.SelectedValue & "','0'")

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

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                Dim fromdate As String
                Dim todate As String
                Dim year As String = ddlfinancecalendar.SelectedItem.Text
                fromdate = year.ToString().Substring(0, 4)
                todate = year.ToString().Substring(5, 4)
                'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                Dim dt As New DataTable
                dt = GetDatatTable("view_item_Valuation '" & fromdate & "' ,'" & todate & "','" & drpTypeOfItems.SelectedValue & "','0'")
                Session("itemcontractdt") = dt
                If dt.Rows.Count <= 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    cry_Itemsumvalrpt.Visible = False
                    cry_Itemsumvalrpt.EnableDatabaseLogonPrompt = False
                    Table1.Visible = False

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

                End If

            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnexcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnexcel.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace