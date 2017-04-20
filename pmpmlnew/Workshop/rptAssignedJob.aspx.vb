Imports System.Data
Imports System.Data.SqlClient

Namespace KDMT

    Partial Class Workshop_rptAssignedJob
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strmech As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtfromDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                
                strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim ds As DataSet = GetDataset("view_mechanic '" + dtfromDate.SelectedDate + "','" + dttoDate.SelectedDate + "','" + txtMechanicName.Value + "'")
                grdMechlist.DataSource = ds
                grdMechlist.DataBind()
            Catch ex As Exception

            End Try

        End Sub
    End Class
End Namespace
