Namespace KDMT
    Partial Class Vehicle_Master
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtDepoDate.SelectedDate = Now.Date
                dtFitRenewalDate.SelectedDate = Now.Date
                dtPutDate.SelectedDate = Now.Date
                dtRTODate.SelectedDate = Now.Date
                txtBusNo.Focus()
                Fill_Combo("Company_ID", "Company_Name", "Company_Master", ddlBusCompany, Con)
                Fill_Combo("Model_ID", "Model_Name", "Model_Master", ddlModelNo, Con)
                Fill_Combo("Status_ID", "Status", "Status_Master", ddlCurStatus, Con)
            End If
        End Sub
    End Class
End Namespace
