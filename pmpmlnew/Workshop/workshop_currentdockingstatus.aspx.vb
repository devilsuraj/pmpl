Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_workshop_currentdockingstatus
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                Label2.Text = Format(Now.Date, "dd/MMM/yyyyy")
                'BindGrid(grdinsp, con, "view_currentkms")
                Dim ds As DataSet = GetDataset("view_duebuses '" & ddlkms.SelectedItem.Value & "'")
                grdinsp.DataSource = ds
                grdinsp.DataBind()

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            'Dim fromdate As String = Request.QueryString("fromdate")
            ' Dim todate As String = Request.QueryString("todate")
            ' Response.Redirect("excelissuereport.aspx?fromdate=" & BDPLite1.SelectedDate & "&Todate=" & BDPLite2.SelectedDate & "")
            ExportDataGrid(grdinsp)
        End Sub

       


    End Class
End Namespace
