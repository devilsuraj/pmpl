Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Daily_Deffect
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date

                'BindGrid(grdjoclist, con, "view_brakedown_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "'")

                'grdjoclist.DataSource = ""
                'grdjoclist.DataBind()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = Format(Convert.ToDateTime(dtformDate.SelectedDate), "MM/dd/yyyy")
                Dim todate As String = Format(Convert.ToDateTime(dttoDate.SelectedDate), "MM/dd/yyyy")
                'BindGrid(grdjoclist, con, "view_brakedown_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
    End Class
End Namespace