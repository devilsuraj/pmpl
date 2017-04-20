Namespace KDMT
    Partial Class Indent_Request_Details
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim dt As DataTable
                dtIssueDate.SelectedDate = Now.Date
                Dim dr As SqlClient.SqlDataReader
                Dim Sql As String = "SELECT DISTINCT IRM.Indent_ID, IRM.Indent_No FROM Indent_Request_Master IRM INNER JOIN Indent_Request_Details IRD ON IRM.Indent_ID = IRD.Indent_Master_ID WHERE IRD.Indent_Flag = 0 AND IRM.Authentic = 1 AND IRM.Is_Delete = 0 ORDER BY IRM.Indent_No"
                Dim Com As New SqlClient.SqlCommand(Sql, Con)
                ddlIndNo.DataTextField = "Indent_No"
                ddlIndNo.DataValueField = "Indent_ID"
                Con.Open()
                dr = Com.ExecuteReader
                ddlIndNo.DataSource = dr
                ddlIndNo.DataBind()
                ddlIndNo.Items.Insert(0, "Select") : ddlIndNo.Items(0).Value = 0
                Com.Dispose()
                Com = Nothing
                dr.Close()
                dr = Nothing
                Con.Close()

                ddlIndNo.Focus()
                Fill_Combo("Cont_ID", "Cont_Name", "contractor_master", ddlvendor, Con, , "Select")
                dt = GetDatatTable("View_Indent_Details " & ddlIndNo.SelectedValue)
                hdnrwcnt.Value = dt.Rows.Count
            End If
        End Sub
       
    End Class
End Namespace
