Imports System.Data.SqlClient
Namespace KDMT
    Partial Class sick_reason_editable
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click

            Dim dt As DataTable = GetDatatTable("sick_reason_detail  '" & txtjob.Text & "','" & txtjobno.Text & "'")
            txtDesc.Text = dt.Rows(0).Item(2)
            Dim dt1 As DataTable = GetDatatTable("select * from tblSickReasonMst")
            ddlReason.DataTextField = "reason"
            ddlReason.DataValueField = "reason_id"
            ddlReason.DataSource = dt1
            ddlReason.DataBind()
            ddlReason.Items.Insert(0, New ListItem("Select", "0"))
            ddlReason.SelectedValue = 0
            ddlReason.SelectedValue = dt.Rows(0).Item(7)

        End Sub

        Protected Sub btn_update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_update.Click

            cmd = New SqlCommand("update_sick_reason", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@reason", ddlReason.SelectedValue)

            cmd.Parameters.AddWithValue("@jobno", txtjobno.Text)
            cmd.Parameters.AddWithValue("@description", txtDesc.Text)
            cmd.Parameters.AddWithValue("@jcyear", txtjob.Text)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
            Response.Write("<script>alert('Sick Reason Updated Successfuly');window.location.href='sick_reason_editable.aspx'</script>")
        End Sub
        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            Session("MenuId") = 2
        End Sub

    End Class
End Namespace