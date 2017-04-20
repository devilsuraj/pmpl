Namespace KDMT
    Partial Class Scrap_Details
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Public strparttypedetails As String = ""
        Public strcompanyno As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtScrapDate.SelectedDate = Now.Date
                strparttypedetails = getAutoCompleteList("SELECT Part_Master.Part_WS_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_WS_No")
                strcompanyno = getAutoCompleteList("SELECT Part_Master.Part_company_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_company_No")
                'txtBusNo.Focus()
                'Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", ddlScrapType, Con)
                'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
            End If
        End Sub
    End Class
End Namespace
