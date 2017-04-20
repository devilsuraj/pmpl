
Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT

    Partial Class report_rptViewItemSummary
        Inherits System.Web.UI.Page

        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim qry As String
        Dim da As SqlClient.SqlDataAdapter
        Dim r1, r2, r3, r4 As Decimal
        Public stritemname As String = ""
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then

            Else
                cryshow()
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Table1.Visible = False

            End If


        End Sub


        Protected Sub btnShowreport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowreport.Click
            divcry.Visible = False
            Table1.Visible = True
            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")

                BindGrid(grdstock, con, "view_item_summary '" & fromdate & "','" & todate & "','" & drpType.SelectedValue & "'")

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

        Public Sub cryshow()
            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Try

                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_summery.rpt"))
                cryRpt.SetDataSource(Session("sumdt"))
                cryRpt.SetParameterValue("category", Session("typritm"))
                If Session("fromsum") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("frm", Now.Date())
                Else
                    cryRpt.SetParameterValue("frm", Session("fromsum"))

                End If
                If Session("tosum") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("to", Now.Date())
                Else
                    cryRpt.SetParameterValue("to", Session("tosum"))

                End If
                crst_item_summery.ReportSource = cryRpt
                crst_item_summery.EnableDatabaseLogonPrompt = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub btncry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncry.Click
            divcry.Visible = True
            Table1.Visible = False
            Try
                Session("sumdt") = ""
                Session("typritm") = ""
                Session("fromsum") = ""
                Session("tosum") = ""
                
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

               

                Session("typritm") = drpType.SelectedItem.Text
                Dim dt As New DataTable
                dt = GetDatatTable("view_item_summary '" & fromdate & "','" & todate & "','" & drpType.SelectedValue & "'")
                Session("sumdt") = dt

                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_summery.rpt"))
                    cryRpt.SetDataSource(Session("sumdt"))
                    cryRpt.SetParameterValue("category", Session("typritm"))
                    If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("frm", Now.Date())
                        Session("fromsum") = "#12:00:00 AM#"
                    Else
                        cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy"))
                        Session("fromsum") = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy")
                    End If
                    If BDPLite2.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("to", Now.Date())
                        Session("tosum") = "#12:00:00 AM#"
                    Else
                        cryRpt.SetParameterValue("to", Format(Convert.ToDateTime(todate), "dd/MM/yy"))
                        Session("tosum") = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yy")
                    End If
                    crst_item_summery.ReportSource = cryRpt
                    crst_item_summery.EnableDatabaseLogonPrompt = False
                End If
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace

