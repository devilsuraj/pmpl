Namespace kdmt
    Partial Class rpt_pending_indent
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then

                BindGrid(grdstock, con, "view_pendingindent")

            End If
        End Sub
    End Class
End Namespace

