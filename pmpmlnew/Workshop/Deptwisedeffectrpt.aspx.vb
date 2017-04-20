Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Deptwisedeffectrpt
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = Format(Convert.ToDateTime(dtformDate.SelectedDate), "MM/dd/yyyy")
                Dim todate As String = Format(Convert.ToDateTime(dttoDate.SelectedDate), "MM/dd/yyyy")
                BindGrid(grdjoclist, con, "view_deptwise_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "','" & ddldeffect.SelectedItem.Text & "','" & ddlstatus.SelectedValue & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")
                BindGrid(grdjoclist, con, "view_deptwise_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "','" & ddldeffect.SelectedItem.Text & "','" & ddlstatus.SelectedValue & "'")
                'grdjoclist.DataSource = ""
                'grdjoclist.DataBind()
            End If
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                Response.Redirect("../report/Workshop_Deptwisedeffect.aspx?fromdate=" & dtformDate.SelectedDate & "&Todate=" & dttoDate.SelectedDate & "&dept=" & ddldeffect.SelectedItem.Text & "&status=" & ddlstatus.SelectedValue & "")
                ' Response.Write("<script>window.location.href='../Workshop/Job_Assign.aspx?id=1&jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
            ExportDataGrid(grdjoclist)
        End Sub

    End Class
End Namespace
