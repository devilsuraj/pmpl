Namespace KDMT
    Partial Class Part_Repair_Details
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim dr As SqlClient.SqlDataReader
                Dim Sql As String = "SELECT DISTINCT Part_Type_ID, Part_Type FROM Part_Type_Master ORDER BY Part_Type"
                dtRepairDate.SelectedDate = Now.Date
                'txtBusNo.Focus()
                Dim Com As New SqlClient.SqlCommand(Sql, Con)
                ddlPartType.DataTextField = "Part_Type"
                ddlPartType.DataValueField = "Part_Type_ID"
                Con.Open()
                dr = Com.ExecuteReader
                ddlPartType.DataSource = dr
                ddlPartType.DataBind()
                ddlPartType.Items.Insert(0, "Select") : ddlPartType.Items(0).Value = 0
                Com.Dispose()
                Com = Nothing
                dr.Close()
                dr = Nothing
                Con.Close()
                Fill_Combo("Repair_ID", "Repair_Type", "Repair_Type_Master", ddlRepairType, Con)
            End If
        End Sub
    End Class
End Namespace
