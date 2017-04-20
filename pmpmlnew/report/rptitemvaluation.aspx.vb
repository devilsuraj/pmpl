Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.ReportSource 
Imports System.Web
Imports System.IO
Namespace KDMT
    Partial Class rptitemvaluation
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand

        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then
            Else
                cryshow()
            End If
        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date
                Table1.Visible = False

            End If
        End Sub
        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)


        End Sub
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
            End Select
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                BindGrid(grdstock, con, "view_available_itemstock '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "'")
                If grdstock.Items.Count = 0 Then
                    'Session("df") = grdstock.DataSource
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    divcry.Visible = False
                End If
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btncrt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncrt.Click
            Session("itemvaluationdt") = ""
            Session("item_val") = ""
            Try
                Dim fromdate As String = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yyyy")
                Dim fromdate1 As String = BDPLite1.SelectedDate

                Session("item_val") = drpTypeOfItems.selectedItem.Text
                Dim dt As New DataTable
                dt = GetDatatTable("view_available_itemstock '" & fromdate1 & "','" & drpTypeOfItems.SelectedValue & "'")
                If dt.Rows.Count = 0 Then
                    'Session("df") = grdstock.DataSource
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    divcry.Visible = False
                Else

                    Session("itemvaluationdt") = dt
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_val.rpt"))
                    cryRpt.SetDataSource(dt)
                    cryRpt.SetParameterValue("type", Session("item_val"))
                    view_itemval.ReportSource = cryRpt
                    view_itemval.EnableDatabaseLogonPrompt = False
                    divcry.Visible = True
                    Table1.Visible = False
                End If
               
            Catch ex As Exception
            End Try
        End Sub

        Public Sub cryshow()
            Try
                Dim dt1 As New DataTable
                dt1 = Session("itemvaluationdt")
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_val.rpt"))
                cryRpt.SetDataSource(dt1)
                view_itemval.ReportSource = cryRpt
                cryRpt.SetParameterValue("type", Session("item_val"))
                divcry.Visible = True
                Table1.Visible = False
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
