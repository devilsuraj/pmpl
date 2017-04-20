
Partial Class includes_controls_header
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserId") Is Nothing Or Session("UserId") = "" Then
            Response.Redirect(ConfigurationManager.AppSettings("Host") & "login.aspx")
        End If
    End Sub
End Class
