Imports System.Data.SqlClient
Namespace KDMT
    Partial Class store_UpdateTransDate
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))

        Dim cmd As New SqlClient.SqlCommand
      
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            con.Open()
            cmd.Connection = con

            Dim trans_date As String = BDPLite1.SelectedDate
            Dim sql As String = "update store_master set trans_date='" & trans_date & "' where challan_no='" & txtChallanNo.Text.Trim & "'"
            cmd.CommandText = sql
            cmd.ExecuteNonQuery()
            con.Close()
            Response.Write("<script>alert('Successfuly Updated')</script>")

        End Sub

        Protected Sub btnclear_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnclear.Click
            txtChallanNo.Text = ""
            BDPLite1.Clear()
        End Sub
    End Class
End Namespace

