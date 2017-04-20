Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Imports System.Data
Namespace KDMT
    Partial Class rptcontractorwisereceive
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
            divcry.Visible = False
            Table1.Visible = True
            Try
                'BindGrid(grdstock, con, "VIEW_cont_receive_report '" & ddldepttype.SelectedValue & "','" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "'")
                'Get_ItemwisePO_Details(grdpoitem, con, "Item_Wise_PO_Report'" & txtlfno.Text & "'")
                BindGrid(grdvendor, con, "VIEW_Vendor_report")
            Catch ex As Exception
            End Try
        End Sub

        Protected Sub btnCry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry.Click
            Session("vndrdt") = ""
            Try
                Dim dt As New DataTable
                dt = GetDatatTable("[VIEW_Vendor_report] ")
                Session("vndrdt") = dt
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("Item_vendor_list.rpt"))
                cryRpt.SetDataSource(dt)
                crst_item_vendor.ReportSource = cryRpt
                crst_item_vendor.EnableDatabaseLogonPrompt = False
                divCry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        Public Sub cryshow()
            Try
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("Item_vendor_list.rpt"))
                cryRpt.SetDataSource(Session("vndrdt"))
                crst_item_vendor.ReportSource = cryRpt
                crst_item_vendor.EnableDatabaseLogonPrompt = False
                divCry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdvendor)
        End Sub
    End Class
End Namespace
