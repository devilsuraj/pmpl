Namespace KDMT
    Partial Class Authentication
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtCheckDate.SelectedDate = Now.Date
                dtWorkDate.SelectedDate = Now.Date
                'txtBusNo.Focus()
                'Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", ddlDefectType, Con)
                'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
            End If
        End Sub
    End Class
End Namespace
