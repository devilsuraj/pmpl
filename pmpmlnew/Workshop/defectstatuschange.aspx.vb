Imports System.Data
Imports System.Data.SqlClient
Namespace kdmt
    Partial Class defectstatuschange
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then

            End If
        End Sub
        Protected Sub txtBusNo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBusNo.TextChanged
            Try
                ddlnewdefect.Items.Clear()
                filldata()
                ddlnewdefect.Focus()

                If lblolddefect.Text = "Brakedown" Then
                    ddlnewdefect.Items.Insert(0, New ListItem("Defect", "1"))
                    ddlnewdefect.Items.Insert(1, New ListItem("Docking", "0"))
                ElseIf lblolddefect.Text = "Defect" Then

                    ddlnewdefect.Items.Insert(0, New ListItem("Docking", "0"))
                Else
                    ddlnewdefect.Items.Clear()
                End If


            Catch ex As Exception

            End Try
        End Sub
        Private Sub filldata()
            Dim sql1 As String
            ' sql1 = "view_itemdetail '%" & value & "%' "
            Dim jobs As String = ""
            sql1 = "view_jobsubdetails '" & txtBusNo.Text & "','" & txtjob.Text & "','" & txtjobno.Text & "' "
            Dim da As New SqlClient.SqlDataAdapter(sql1, con)
            Dim ds As New DataSet
            da.SelectCommand.CommandTimeout = 0
            da.Fill(ds)

            'Dim cmd3 As New SqlClient.SqlCommand(sql1, con)
            'con.Open()
            'Dim ds As New DataSet
            Dim i As Integer = 0
            'ds = cmd3.ExecuteScalar
            For i = 0 To ds.Tables(0).Rows.Count - 1
                If jobs = "" Then
                    jobs = ds.Tables(0).Rows(i).Item(6).ToString
                Else
                    jobs = jobs + " , " + ds.Tables(0).Rows(i).Item(6).ToString
                End If
            Next
            'If (dr2.Read) Then
            'End If
            'dr2.Close()
            con.Close()

            sql1 = "view_jobdetails '','" & txtBusNo.Text & "','" & txtjob.Text & "','" & txtjobno.Text & "' "
            Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
            con.Open()
            dr = cmd2.ExecuteReader
            If (dr.Read) Then
                txtjocno.Value = dr(0)
                txtBusNo.Text = dr(1)
                txtmodel.Text = dr(2)
                txtchassis.Text = dr(3)
                txtkms.Text = dr(4)
                txtengin.Text = dr(5)
                dtjobDate.Text = dr(6)
                txtjotime.Text = dr(7)
                TextBox1.Text = jobs.ToString
                txtjob.Text = dr(11)
                txtjobno.Text = dr(12)
                lblolddefect.Text = dr(13)
                If lblolddefect.Text = "Brakedown" Then
                    txtbdclosedtime.ReadOnly = False
                ElseIf lblolddefect.Text = "Defect" Then
                    txtbdclosedtime.ReadOnly = True
                Else
                    Response.Write("<script>alert('Your Defect Type Is Docking');window.location.href='defectstatuschange.aspx'</script>")
                End If

            End If

            dr.Close()
            con.Close()
        End Sub

        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            Response.Redirect("defectstatuschange.aspx")
        End Sub

        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

            Dim intdefect As Integer
            If lblolddefect.Text = "Defect" Then
                intdefect = 1
            ElseIf lblolddefect.Text = "Brakedown" Then
                intdefect = 2
            Else
                Response.Write("<script>alert('Please Enter valid data');window.location.href='defectstatuschange.aspx'</script>")
            End If
            cmd = New SqlCommand
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure

            cmd = New SqlCommand("[ins_defectstatus]", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@newjob", txtjob.Text)
            cmd.Parameters.AddWithValue("@newjobno", txtjobno.Text)
            cmd.Parameters.AddWithValue("@olddefecttype", intdefect)
            cmd.Parameters.AddWithValue("@newdefecttype", ddlnewdefect.SelectedValue)
            cmd.Parameters.AddWithValue("@trans_date", Now.Date())
            cmd.Parameters.AddWithValue("@userid", Session("userid"))
            cmd.Parameters.AddWithValue("@brakedownclosetime", txtbdclosedtime.Text)


            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()

            Response.Write("<script>alert('Saved Successfuly');window.location.href='defectstatuschange.aspx'</script>")

        End Sub

        Protected Sub txtjobno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtjobno.TextChanged
            Try
                ddlnewdefect.Items.Clear()
                filldata()
                ddlnewdefect.Focus()

                If lblolddefect.Text = "Brakedown" Then
                    ddlnewdefect.Items.Insert(0, New ListItem("Defect", "1"))
                    ddlnewdefect.Items.Insert(1, New ListItem("Docking", "0"))
                ElseIf lblolddefect.Text = "Docking" Then

                    ddlnewdefect.Items.Insert(0, New ListItem("Docking", "0"))
                End If


            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace