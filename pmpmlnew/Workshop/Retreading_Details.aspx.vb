Namespace KDMT
    Partial Class Retreading_Details
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtDate.SelectedDate = Now.Date
                'txtBusNo.Focus()
                Fill_Combo("Ven_Code", "Ven_Name", "Ven_Master", ddlVendorName, Con)
                Fill_Combo("Part_Type_Id", "Part_Type", "Part_type_Master", ddlPartType, Con)
            End If
        End Sub
    End Class
End Namespace
