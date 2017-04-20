Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rptTyreHistory
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strparttypedetails As String = ""
        Public strcompanyno As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtfromdate.SelectedDate = Now.Date
                dttodate.SelectedDate = Now.Date
                strparttypedetails = getAutoCompleteList("SELECT Part_Master.Part_WS_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_WS_No")
                strcompanyno = getAutoCompleteList("SELECT Part_Master.Part_company_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_company_No")
                BindGrid(grdTyre, con, "view_tyre_history '" & dtfromdate.SelectedDate & "','" & dttodate.SelectedDate & "','" & txtBusNo.Text & "','" & ddltype.SelectedValue & "','" & txtPartNo.Text & "','" & txtCompanyNo.Text & "','" & ddlReason.SelectedValue & "'")
                'grdjoclist.DataSource = ""
                'grdjoclist.DataBind()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = dtfromdate.SelectedDate
                Dim todate As String = dttodate.SelectedDate
                lblfromdate.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yyyy")
                BindGrid(grdTyre, con, "view_tyre_history '" & dtfromdate.SelectedDate & "','" & dttodate.SelectedDate & "','" & txtBusNo.Text & "','" & ddltype.SelectedValue & "','" & txtPartNo.Text & "','" & txtCompanyNo.Text & "','" & ddlReason.SelectedValue & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
            ExportDataGrid(grdTyre)
        End Sub
        
    End Class
End Namespace
