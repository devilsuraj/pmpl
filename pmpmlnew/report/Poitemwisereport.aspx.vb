Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports System.Data.SqlClient
Imports System.Data
Imports CrystalDecisions.CrystalReports.Engine

Namespace KDMT
    Partial Class Poitemwisereport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strvendor As String = ""
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then
            Else
                cryshow()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                dvcry.Visible = False
                Table1.Visible = True
                'BindGrid(grdstock, con, "VIEW_cont_receive_report '" & ddldepttype.SelectedValue & "','" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "'")
                BindGrid(grdpoitem, con, "Item_Wise_PO_Report'" & txtlfno.Text & "','" & txtpartno.Text & "'")
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btncry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncry.Click
            dvcry.Visible = True
            Table1.Visible = False
            Session("lf") = ""
            Try
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_po_itemwise.rpt"))
                Dim dt As DataTable
                dt = GetDatatTable("Item_Wise_PO_Report'" & txtlfno.Text & "','" & txtpartno.Text & "'")
                cryRpt.SetDataSource(dt)

                cryRpt.SetParameterValue("part", txtlfno.Text)

                Session("lf") = txtlfno.Text

                crst_item_po.ReportSource = cryRpt
                crst_item_po.EnableDatabaseLogonPrompt = False

                dvcry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub
        Protected Sub txtpartno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtpartno.TextChanged

        End Sub
        Public Sub cryshow()
            Try
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_po_itemwise.rpt"))
                Dim dt As DataTable
                dt = GetDatatTable("Item_Wise_PO_Report'" & txtlfno.Text & "','" & txtpartno.Text & "'")
                cryRpt.SetDataSource(dt)
                cryRpt.SetParameterValue("part", Session("lf"))
                crst_item_po.ReportSource = cryRpt
                crst_item_po.EnableDatabaseLogonPrompt = False

                dvcry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdpoitem)
        End Sub
    End Class
End Namespace

