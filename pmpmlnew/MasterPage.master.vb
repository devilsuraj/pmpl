
Partial Class MasterPage
    Inherits System.Web.UI.MasterPage
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("UserId") Is Nothing Or Session("UserId") = "" Then
            Response.Redirect(ConfigurationManager.AppSettings("Host") & "login.aspx")
        End If
        If Session("Dept_type") Is Nothing Or Session("Dept_type") = "" Then
            Response.Redirect(ConfigurationManager.AppSettings("Host") & "login.aspx")
        End If
    End Sub
End Class

