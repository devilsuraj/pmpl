Imports System.Data.SqlClient
Namespace kdmt
    Partial Class Workshop_Edit_Inspection
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Public strjobno As String = ""
        Public strmech As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                strBusno = getAutoCompleteList("SELECT distinct vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0 ORDER BY vech_master.vech_no", "vech_no")

                edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")

            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim jobs As String = ""
                Dim sql1 As String = ""
                Dim dr2 As SqlDataReader
                If txtBusNo.Value = "" Then
                    txtBusNo.Focus()
                    Call Show_Msg(Page, "Enter Bus No", "Edit_Inspection.aspx")
                Else
                    sql1 = "view_inspect_master '" & txtBusNo.Value & "' "
                    Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                    con.Open()
                    dr2 = cmd2.ExecuteReader
                    If (dr2.Read) Then
                        'strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(5) & "!" & dr2(6) & "!" & dr2(7) & "!" & dr2(8) & "!" & dr2(9) & "!" & jobs
                        txtjocno.Value = dr2(2)
                        txtmodel.Text = dr2(4)
                        txtchassis.Text = dr2(5)
                        txtkms.Text = dr2(6)
                        txtengin.Text = dr2(7)
                        dtjobDate.Text = dr2(8)
                        txtjotime.Text = dr2(9)
                        txtmech.Value = dr2(10)
                        txtinspectionnote.Text = dr2(11)
                        txtnote.Text = dr2(12)
                    End If
                    con.Close()

                    sql1 = "view_jobsubdetails '" & txtBusNo.Value & "' "
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
                    con.Close()
                    txtjobdeffect.Text = jobs

                    BindGrid(grddeffectlist, con, "view_inspect_details '" & txtBusNo.Value & "'")

                End If
                strBusno = getAutoCompleteList("SELECT distinct vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0 ORDER BY vech_master.vech_no", "vech_no")

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub ddldeffect_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddldeffect.SelectedIndexChanged

            'BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtjocno.Value + "'")
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                'Dim da As New SqlClient.SqlDataAdapter("select deffect_decr from tbl_deffect_Master where subid=1", con)
                Dim cmd2 As New SqlClient.SqlCommand("select deffect_id,deffect_decr from tbl_deffect_Master where subid=" & ddldeffect.SelectedValue & " and subid<>0", con)
                dr = cmd2.ExecuteReader

                Dim dt As New DataTable
                dt.Load(dr)
                Select1.DataSource = dt
                Select1.DataTextField = "deffect_decr"
                Select1.DataValueField = "deffect_id"
                Select1.DataBind()
                Session("ab") = 1
                'While dr.Read
                '    'Select1.Items.Add(dr(0).ToString)
                '    Select1.DataTextField = "deffect_decr"
                '    Select1.DataValueField = "deffect_id"
                '    'Select1.Items.Insert(dr(0).ToString, dr(1).ToString)
                '    'Select1.Items.Add(Select1.Items.Insert())
                'End While
                'Select1.DataSource = ds.Tables.Add.Columns(0)
                'Select1.DataBind()
                strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")

            Catch ex As Exception

            End Try
        End Sub
        Dim dt As New DataTable
        Dim dt1 As New DataTable
        Protected Sub Select1_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles Select1.DataBinding
            Try
                Dim j As Integer = 0
                Dim a As Integer = Select1.Items.Count '- 1
                Dim i As Integer = 0
                Dim b As Integer = 1
                Dim str As String = String.Empty
                'Dim j As Integer = 0
                Dim b1 As Integer = 1
                For i = 0 To a - 1
                    For j = 0 To grddeffectlist.Items.Count - 1
                        'If Select1.Items(i).Text = "" Then

                        'End If
                    Next
                Next
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub Select1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Select1.SelectedIndexChanged
            dt.Columns.Add("srno")
            dt.Columns.Add("subdeffectid")
            dt.Columns.Add("deffect")
            dt.Columns.Add("subdeffect")
            dt.Columns.Add("deffectid")

            dt1.Columns.Add("srno")
            dt1.Columns.Add("subdeffectid")
            dt1.Columns.Add("deffect_decr")
            dt1.Columns.Add("subdeffect")
            dt1.Columns.Add("deffectid")
            Dim dr As DataRow
            dr = dt.NewRow
            Dim dr1 As DataRow
            dr1 = dt1.NewRow
            Dim a As Integer = Select1.Items.Count '- 1
            Dim i As Integer = 0

            Dim b As Integer = 1
            Dim str As String = String.Empty
            Dim j As Integer = 0
            Dim b1 As Integer = 1
            For i = 0 To a - 1
                If Select1.Items(i).Selected = True Then
                    'For j = 0 To grddeffectlist.Items.Count - 1
                    '    If grddeffectlist.Items(j).DataItem = Select1.SelectedItem.Text Then
                    '        Response.Write("<script language=javascript>alert('value already entered')</script>")

                    '    End If
                    'Next
                    Select1.Items(i).Enabled = False  'added on 15/01 for disable checkbox
                    Select1.Items(i).Selected = True  'added on 15/01  for unchecked checkbox

                    If grddeffectlist.Items.Count > 0 Then

                        'dt1.Rows.Clear()  'comented on 15/01
                        b1 = 1
                        For j = 0 To grddeffectlist.Items.Count - 1
                            dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text, grddeffectlist.Items(j).Cells(2).Text)
                            b1 = b1 + 1
                        Next

                        'If Select1.Items(i).Enabled = True Then
                        b = b1
                        dt1.Rows.Add(b, Select1.Items(i).Value, ddldeffect.SelectedItem.Text, Select1.Items(i).Text, ddldeffect.SelectedValue)
                        b = b + 1
                        'End If
                    Else
                        dt.Rows.Add(b, Select1.Items(i).Value, ddldeffect.SelectedItem.Text, Select1.Items(i).Text, ddldeffect.SelectedValue)
                        b = b + 1
                    End If
                Else
                End If
            Next
            i = 0

            strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            If grddeffectlist.Items.Count = 0 Then
                grddeffectlist.DataSource = dt
                grddeffectlist.DataBind()
            Else
                grddeffectlist.DataSource = dt1
                grddeffectlist.DataBind()
            End If
        End Sub
        Protected Sub grddeffectlist_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grddeffectlist.DeleteCommand
            Try

                Dim get_key As String
                Dim tbl_name As String
                get_key = e.Item.ItemIndex
                tbl_name = e.Item.ID

                fnExecuteNonQuery("deletejobinspdetails " & e.Item.Cells(1).Text & ",'" & txtjocno.Value & "'")

                BindGrid(grddeffectlist, con, "view_inspect_details '" & txtBusNo.Value & "'")

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            Try
                cmd = New SqlCommand
                ds = New DataSet
                DA = New SqlDataAdapter
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                Dim mechid As Integer

                If grddeffectlist.Items.Count > 0 Then
                    mechid = ExecuteQuery("select Mech_id from tbl_Mechanic_master where Name='" + txtmech.Value + "' and Sub_id<>0")

                    cmd.CommandText = "update_JOC_inspec_mst"
                    cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                    cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                    cmd.Parameters.AddWithValue("@mechid", mechid)
                    cmd.Parameters.AddWithValue("@inspnote", txtinspectionnote.Text)
                    cmd.Parameters.AddWithValue("@note", txtnote.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                    con.Open()
                    cmd.ExecuteNonQuery()

                    con.Close()
                    For i = 0 To grddeffectlist.Items.Count - 1
                        cmd = New SqlCommand("update_JOC_inspec_Details", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                        cmd.Parameters.AddWithValue("@deffectid", grddeffectlist.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@subdeffectid", grddeffectlist.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                        cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    Next

                    txtBusNo.Value = ""
                    txtjocno.Value = ""
                    txtmodel.Text = ""
                    txtchassis.Text = ""
                    txtkms.Text = ""
                    txtengin.Text = ""
                    dtjobDate.Text = ""
                    txtjotime.Text = ""
                    txtmech.Value = ""
                    txtinspectionnote.Text = ""
                    txtnote.Text = ""
                    txtjobdeffect.Text = ""
                    grddeffectlist.DataSource = ""
                    grddeffectlist.DataBind()
                    strBusno = getAutoCompleteList("SELECT distinct vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0 ORDER BY vech_master.vech_no", "vech_no")

                    edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")

                    Select1.DataSource = ""
                    Select1.DataBind()
                    Call Show_Msg(Page, "Update Successfully", "Edit_Inspection.aspx")
                    'Response.Write("<script>window.location.href='../Workshop/Job_Assign.aspx?id=1&jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
                End If
                'cleare()
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace
