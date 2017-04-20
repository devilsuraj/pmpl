Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Web.Services


Partial Class update_tyre_status
    Inherits System.Web.UI.Page
    Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
    Dim cmd As SqlClient.SqlCommand
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Try
            cmd = New SqlCommand("update_tyre_status", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@company_no", txtcompanyno.Text)
            cmd.Parameters.AddWithValue("@status", ddlPartStatus.SelectedValue)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()

            Response.Write("<script>alert('Tyre Status Updated Successfuly');window.location.href='update_tyre_status.aspx'</script>")

        Catch ex As Exception
        End Try
    End Sub

    Protected Sub txtcompanyno_TextChanged(sender As Object, e As EventArgs) Handles txtcompanyno.TextChanged
        Try


            'Dim cmd As SqlCommand
            'Dim sql As String = "Select Part_ID, Part_Company_no, Part_Size, Part_WS_No, status, Busno from part_master where Part_Company_no = '" + txtcompanyno.Text + "'"
            'Dim dr As SqlDataReader

            'cmd = New SqlCommand(sql, con)
            'con.Open()
            'dr = cmd.ExecuteReader()

            'If dr.Read Then
            '    txtPartNo.Text = dr.GetValue(3)
            '    ddlPartStatus.SelectedValue = dr.GetValue(4)
            '    ddlPartType.SelectedItem.Text = dr.GetValue(2)
            '    txtBusNo.Text = dr.GetValue(5)
            'End If
            Dim dr As SqlDataReader
            cmd = New SqlCommand("get_tyre_status", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Company_no", txtcompanyno.Text)
            con.Open()
            dr = cmd.ExecuteReader()
            If dr.Read Then
                ddlPartType.SelectedItem.Text = dr.GetValue(2)
                txtPartNo.Text = dr.GetValue(3)
                ddlPartStatus.SelectedValue = dr.GetValue(4)
                txtBusNo.Text = dr.GetValue(5)
            End If
        Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
 <WebMethod()> _
    Public Shared Function SearchCustomers(ByVal prefixText As String, ByVal count As Integer) As List(Of String)

        Dim cmd As SqlCommand = New SqlCommand
        cmd.CommandText = "Select  distinct Part_Company_no from part_master where Part_Company_no like @SearchText + '%'"
        cmd.Parameters.AddWithValue("@SearchText", prefixText)
        cmd.Connection = con
        con.Open()
        Dim customers As List(Of String) = New List(Of String)
        Dim sdr As SqlDataReader = cmd.ExecuteReader
        While sdr.Read
            customers.Add(sdr("Part_Company_no").ToString)
        End While
        con.Close()
        Return customers
    End Function
End Class

