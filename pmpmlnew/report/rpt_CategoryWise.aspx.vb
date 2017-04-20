Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rpt_CategoryWise

        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date()
            Else

            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = BDPLite1.SelectedDate
                BindGrid(grdstock, con, "[view_category_wise] '" & fromdate & "' ,'" & drpTypeOfItems.SelectedValue & "' ")
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace