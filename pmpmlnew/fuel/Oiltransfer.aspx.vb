Namespace KDMT
    Partial Class Oiltransfer
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            ' btnadd.Attributes.Add("Onclick", "return validate()")
            If Not IsPostBack Then
                edit_combo(ddloiltype, "Oil_id", "Oil_Name", "[Oil_type_master]", "0=0")
                bdpchalandate.SelectedDate = Now.Date()
            End If
        End Sub
    End Class
End Namespace
