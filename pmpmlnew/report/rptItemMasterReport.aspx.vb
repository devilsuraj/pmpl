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
            Table1.Visible = True
            divcry.Visible = False
            
            Try

                BindGrid(grditemdetail, con, "VIEW_Item_List'" & ddldepttype.SelectedValue & "','9' ")
            Catch ex As Exception

            End Try

        End Sub

        Protected Sub btncrystal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncrystal.Click
            Session("itemaster") = ""
            Session("valmaster") = ""

            Try
                Dim dt As New DataTable
                dt = GetDatatTable("VIEW_Item_List '" & ddldepttype.SelectedValue & "'")
                Session("itemaster") = dt
                Session("valmaster") = ddldepttype.SelectedItem.Text
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_master.rpt"))
                cryRpt.SetDataSource(dt)
                cryRpt.SetParameterValue("itemmaster", Session("valmaster"))
                crst_item_master.ReportSource = cryRpt
                crst_item_master.EnableDatabaseLogonPrompt = False
                divcry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                Response.Write(ex.Message)

            End Try
        End Sub
        Public Sub cryshow()
            Try

                Dim dt As New DataTable
                dt = Session("itemaster")
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_master.rpt"))
                cryRpt.SetDataSource(dt)
                cryRpt.SetParameterValue("itemmaster", Session("valmaster"))
                crst_item_master.ReportSource = cryRpt
                crst_item_master.EnableDatabaseLogonPrompt = False

                divcry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                'Response.Write(ex.Message)

            End Try

        End Sub

        Protected Sub btnCry0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry0.Click
            ExportDataGrid(grditemdetail)
        End Sub
    End Class
End Namespace
