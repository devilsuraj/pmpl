
Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rptDeadStockSummary
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim qry As String
        Dim da As SqlClient.SqlDataAdapter
        Dim r1, r2, r3, r4 As Decimal
        Public stritemname As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Table1.Visible = False

            End If




        End Sub
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then

            Else
                cryshow()
            End If
        End Sub
        Protected Sub btnShowreport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowreport.Click
            Table1.Visible = True
            divcry.Visible = False
            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")

                BindGrid(grdstock, con, "view_Deadstock_summary '" & fromdate & "','" & todate & "','" & drpType.SelectedValue & "'")

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btnConvertToExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConvertToExcel.Click
            ExportDataGrid(grdstock)
        End Sub

        Protected Sub btnCry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry.Click
            Session("ddsmdt") = ""
            Session("ddval") = ""
            Session("frm") = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy")
            Session("to") = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yy")
            Table1.Visible = False
            divcry.Visible = True
            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                Session("ddval") = drpType.SelectedItem.Text
                Dim DT As DataTable
                DT = GetDatatTable("view_Deadstock_summary '" & fromdate & "','" & todate & "','" & drpType.SelectedValue & "'")

                Session("ddsmdt") = DT
                If DT.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_deadsummery.rpt"))
                    cryRpt.SetDataSource(Session("ddsmdt"))
                    cryRpt.SetParameterValue("category", Session("ddval"))
                    If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("frm", "")
                    Else
                        cryRpt.SetParameterValue("frm", Session("frm"))
                    End If
                    If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("to", "")
                    Else
                        cryRpt.SetParameterValue("to", Session("to"))
                    End If

                    crst_item_deadstock.ReportSource = cryRpt
                    crst_item_deadstock.EnableDatabaseLogonPrompt = False
                End If
            Catch ex As Exception

            End Try
        End Sub
        Public Sub cryshow()
            Try

                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_deadsummery.rpt"))
                cryRpt.SetDataSource(Session("ddsmdt"))
                cryRpt.SetParameterValue("category", Session("ddval"))
                If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("frm", "")
                Else
                    cryRpt.SetParameterValue("frm", Session("frm"))
                End If
                If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("to", "")
                Else
                    cryRpt.SetParameterValue("to", Session("to"))
                End If
                crst_item_deadstock.ReportSource = cryRpt
                crst_item_deadstock.EnableDatabaseLogonPrompt = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub
    End Class
End Namespace

