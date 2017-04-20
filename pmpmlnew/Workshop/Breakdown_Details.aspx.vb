Namespace KDMT
    Partial Class Breakdown_Details
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtBrkdwnDate.SelectedDate = Now.Date
                'txtBusNo.Focus()
                'Fill_Combo("Place_ID", "Place_Name", "Place_Master", ddlBrkdwnPlace, Con)
                'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
            End If
        End Sub
    End Class
End Namespace
