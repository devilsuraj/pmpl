Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic

Namespace KDMT
    Partial Class Workshop_Inspectionrmaster
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Public strjobno As String = ""
        Public strmech As String = ""
        Public strmechanic As New StringBuilder
        Dim txtMech As TextBox
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


            If Not IsPostBack Then
                txtjobno.Focus()
                BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtjocno.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'")
                txtjob.Text = ExecuteQuery("(SELECT RIGHT('0' + RTRIM(year(getdate())), 2)+ RIGHT('0' + RTRIM(month(getdate())), 2))")
                'BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtjocno.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'")

                grddeffectlist.DataSource = ""
                grddeffectlist.DataBind()

                'strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=0 and inspection_no=0 order by joccode", "joccode")
                edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")
                strBusno = getAutoCompleteList("SELECT distinct vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0  and inspection_no=0 and docking=0  ORDER BY vech_master.vech_no", "vech_no")

                'edit_combo(ddlmech, "Mech_id", "Name", "tbl_Mechanic_master", " Sub_id<>0")
            End If
            strmech = getAutoCompleteList("select * from tbl_Mechanic_master where sub_id not in(123,0,1,129,127,124,160) order by Name", "Name")
        End Sub
        Sub cleare()
            txtjocno.Value = ""
            txtBusNo.Text = ""
            txtmodel.Text = ""
            txtchassis.Text = ""
            txtkms.Text = ""
            txtengin.Text = ""
            txtjotime.Text = ""
            dtjobDate.Text = ""
            grddeffectlist.DataSource = ""
            grddeffectlist.DataBind()
            'txtmech.Value = ""
            txtinspectionnote.Text = ""
            'txtnote.Text = ""


        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            Try
                cmd = New SqlCommand
                ds = New DataSet
                DA = New SqlDataAdapter
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                Dim mechid As Integer

                If grddeffectlist.Items.Count <> 0 Then


                    cmd.CommandText = "ins_JOC_inspec_mst"
                    cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                    cmd.Parameters.AddWithValue("@busno", txtBusNo.Text)
                    'cmd.Parameters.AddWithValue("@mechid", mechid)
                    cmd.Parameters.AddWithValue("@inspnote", txtinspectionnote.Text)
                    'cmd.Parameters.AddWithValue("@note", txtnote.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                    con.Open()
                    cmd.ExecuteNonQuery()

                    con.Close()
                    For i = 0 To grddeffectlist.Items.Count - 1

                        txtMech = (grddeffectlist.Items(i).FindControl("txtmech"))
                        mechid = ExecuteQuery("select Mech_id from tbl_Mechanic_master where Name='" + txtMech.Text + "' and Sub_id<>0")
                        Dim txttask As TextBox
                        txttask = (grddeffectlist.Items(i).FindControl("txttaskdone"))
                        cmd = New SqlCommand("ins_JOC_inspec_Details", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                        cmd.Parameters.AddWithValue("@deffectid", grddeffectlist.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@subdeffectid", grddeffectlist.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                        cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                        cmd.Parameters.AddWithValue("@taskdone", txttask.Text)
                        cmd.Parameters.AddWithValue("@mechid", mechid)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    Next

                    cmd = New SqlCommand("[ins_Assign_open_and_close]", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@jobno", txtjocno.Value)
                    cmd.Parameters.AddWithValue("@busno", txtBusNo.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                    Response.Write("<script>alert('Saved Successfuly');window.location.href='Inspectionrmaster.aspx'</script>")
                    'Response.Redirect("Workshop_Inspectionrmaster.aspx")
                    'Response.Write("<script>window.location.href='../Workshop/Job_Assign.aspx?id=1&jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
                End If
                'cleare()
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            cleare()
        End Sub
        'Protected Sub ddldeffect_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddldeffect.SelectedIndexChanged

        '    'BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtjocno.Value + "'")
        '    Try

        '        ddlsubdefect.Text = ""
        '        If con.State = ConnectionState.Closed Then
        '            con.Open()
        '        End If
        '        'Dim da As New SqlClient.SqlDataAdapter("select deffect_decr from tbl_deffect_Master where subid=1", con)
        '        Dim cmd2 As New SqlClient.SqlCommand("select deffect_id,deffect_decr from tbl_deffect_Master where subid=" & ddldeffect.SelectedValue & " and subid<>0", con)
        '        dr = cmd2.ExecuteReader

        '        Dim dt As New DataTable
        '        dt.Load(dr)
        '        Select1.DataSource = dt
        '        Select1.DataTextField = "deffect_decr"
        '        Select1.DataValueField = "deffect_id"
        '        Select1.DataBind()
        '        Session("ab") = 1
        '        'While dr.Read
        '        '    'Select1.Items.Add(dr(0).ToString)
        '        '    Select1.DataTextField = "deffect_decr"
        '        '    Select1.DataValueField = "deffect_id"
        '        '    'Select1.Items.Insert(dr(0).ToString, dr(1).ToString)
        '        '    'Select1.Items.Add(Select1.Items.Insert())
        '        'End While
        '        'Select1.DataSource = ds.Tables.Add.Columns(0)
        '        'Select1.DataBind()
        '        strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")

        '    Catch ex As Exception

        '    End Try
        'End Sub
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

            'dt.Columns.Add("srno")
            'dt.Columns.Add("subdeffectid")
            'dt.Columns.Add("deffect")
            'dt.Columns.Add("subdeffect")
            'dt.Columns.Add("deffecttypeid")

            'dt1.Columns.Add("srno")
            'dt1.Columns.Add("subdeffectid")
            'dt1.Columns.Add("deffect")
            'dt1.Columns.Add("subdeffect")
            'dt1.Columns.Add("deffecttypeid")
            'Dim dr As DataRow
            'dr = dt.NewRow
            'Dim dr1 As DataRow
            'dr1 = dt1.NewRow
            'Dim a As Integer = Select1.Items.Count '- 1
            'Dim i As Integer = 0

            'Dim b As Integer = 1
            'Dim str As String = String.Empty
            'Dim j As Integer = 0
            'Dim b1 As Integer = 1
            'For i = 0 To a - 1
            '    If Select1.Items(i).Selected = True Then
            '        'For j = 0 To grddeffectlist.Items.Count - 1
            '        '    If grddeffectlist.Items(j).DataItem = Select1.SelectedItem.Text Then
            '        '        Response.Write("<script language=javascript>alert('value already entered')</script>")

            '        '    End If
            '        'Next
            '        Select1.Items(i).Enabled = False  'added on 15/01 for disable checkbox
            '        Select1.Items(i).Selected = False  'added on 15/01  for unchecked checkbox

            '        If grddeffectlist.Items.Count > 0 Then

            '            'dt1.Rows.Clear()  'comented on 15/01
            '            b1 = 1
            '            For j = 0 To grddeffectlist.Items.Count - 1
            '                dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text, grddeffectlist.Items(j).Cells(2).Text)
            '                b1 = b1 + 1
            '            Next

            '            'If Select1.Items(i).Enabled = True Then
            '            b = b1
            '            dt1.Rows.Add(b, Select1.Items(i).Value, ddldeffect.SelectedItem.Text, Select1.Items(i).Text, ddldeffect.SelectedValue)
            '            b = b + 1
            '            'End If
            '        Else
            '            dt.Rows.Add(b, Select1.Items(i).Value, ddldeffect.SelectedItem.Text, Select1.Items(i).Text, ddldeffect.SelectedValue)
            '            b = b + 1
            '        End If
            '    Else
            '    End If
            'Next
            'i = 0

            'strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            'If grddeffectlist.Items.Count = 0 Then
            '    grddeffectlist.DataSource = dt
            '    grddeffectlist.DataBind()
            'Else
            '    grddeffectlist.DataSource = dt1
            '    grddeffectlist.DataBind()
            'End If
        End Sub
        'Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click

        '    'BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtjocno.Value + "'")
        '    strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
        'End Sub

        Protected Sub grddeffectlist_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grddeffectlist.ItemCommand
            Try
                If e.CommandName = "Delete" Then
                    Dim srno As Integer = e.Item.Cells(0).Text
                    Try
                        dt.Columns.Add("srno")
                        dt.Columns.Add("subdeffectid")
                        dt.Columns.Add("deffect")
                        dt.Columns.Add("subdeffect")
                        dt.Columns.Add("deffecttypeid")

                        dt1.Columns.Add("srno")
                        dt1.Columns.Add("subdeffectid")
                        dt1.Columns.Add("deffect")
                        dt1.Columns.Add("subdeffect")
                        dt1.Columns.Add("deffecttypeid")
                        Dim dr As DataRow
                        dr = dt.NewRow
                        Dim dr1 As DataRow
                        dr1 = dt1.NewRow
                        Dim i As Integer = 0
                        Dim k As Integer = 0
                        Dim b As Integer = 1
                        Dim str As String = String.Empty
                        Dim j As Integer = 0
                        Dim b1 As Integer = 1
                        Dim presenent As String = ""

                        'dt1.Rows.Clear()  'comented on 15/01
                        b1 = 1
                        For j = 0 To grddeffectlist.Items.Count - 1
                            If grddeffectlist.Items(j).Cells(0).Text <> srno Then
                                dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text, grddeffectlist.Items(j).Cells(2).Text)
                                b1 = b1 + 1
                            End If
                            
                        Next
                        'If Select1.Items(i).Enabled = True Then
                        i = 0

                        strmech = getAutoCompleteList("select * from tbl_Mechanic_master where sub_id not in(123,0,1,129,127,124,160) order by Name", "Name")
                        If grddeffectlist.Items.Count = 0 Then
                            grddeffectlist.DataSource = dt
                            grddeffectlist.DataBind()
                        Else
                            grddeffectlist.DataSource = dt1
                            grddeffectlist.DataBind()
                        End If

                        ddlsubdefect.Text = ""
                    Catch ex As Exception

                    End Try
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnadd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnadd.Click
            Try
                strmech = getAutoCompleteList("select * from tbl_Mechanic_master where sub_id not in(123,0,1,129,127,124,160) order by Name", "Name")

                dt.Columns.Add("srno")
                dt.Columns.Add("subdeffectid")
                dt.Columns.Add("deffect")
                dt.Columns.Add("subdeffect")
                dt.Columns.Add("deffecttypeid")

                dt1.Columns.Add("srno")
                dt1.Columns.Add("subdeffectid")
                dt1.Columns.Add("deffect")
                dt1.Columns.Add("subdeffect")
                dt1.Columns.Add("deffecttypeid")
                Dim dr As DataRow
                dr = dt.NewRow
                Dim dr1 As DataRow
                dr1 = dt1.NewRow
                Dim i As Integer = 0
                Dim k As Integer = 0
                Dim b As Integer = 1
                Dim str As String = String.Empty
                Dim j As Integer = 0
                Dim b1 As Integer = 1
                Dim presenent As String = ""




                If grddeffectlist.Items.Count > 0 Then
                    'dt1.Rows.Clear()  'comented on 15/01
                    b1 = 1
                    For j = 0 To grddeffectlist.Items.Count - 1
                        dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text, grddeffectlist.Items(j).Cells(2).Text)
                        b1 = b1 + 1
                    Next
                    'If Select1.Items(i).Enabled = True Then
                    For k = 0 To grddeffectlist.Items.Count - 1
                        If grddeffectlist.Items(k).Cells(4).Text <> ddlsubdefect.Text Then

                        Else
                            presenent = "yes"
                        End If

                    Next

                    If presenent = "" Then
                        b = b1
                        dt1.Rows.Add(b, ExecuteQuery("select  deffect_id from tbl_deffect_Master where deffect_decr ='" + ddlsubdefect.Text + "' "), ddldeffect.SelectedItem.Text, ddlsubdefect.Text, ddldeffect.SelectedValue)
                        b = b + 1
                    End If
                Else
                    dt.Rows.Add(b, ExecuteQuery("select  deffect_id from tbl_deffect_Master where deffect_decr ='" + ddlsubdefect.Text + "' "), ddldeffect.SelectedItem.Text, ddlsubdefect.Text, ddldeffect.SelectedValue)
                    b = b + 1
                End If

                i = 0

                strmech = getAutoCompleteList("select * from tbl_Mechanic_master where sub_id not in(123,0,1,129,127,124,160) order by Name", "Name")
                If grddeffectlist.Items.Count = 0 Then
                    grddeffectlist.DataSource = dt
                    grddeffectlist.DataBind()
                Else
                    grddeffectlist.DataSource = dt1
                    grddeffectlist.DataBind()
                End If

                ddlsubdefect.Text = ""
                ddlsubdefect.Focus()
            Catch ex As Exception

            End Try
        End Sub

        

        Protected Sub txtBusNo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBusNo.TextChanged
            Try

                filldata()
                BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtBusNo.Text + "','" + txtjob.Text + "','" + txtjobno.Text + "'")
                BindGrid(grddetails, con, "view_ItemIssueOnJobcard '" + txtBusNo.Text + "','" + txtjobno.Text + "','" + txtjob.Text + "',''")
                'BindGrid(grddetails, con, "SHOW_ITEM_DETAIL '" + txtBusNo.Text + "','" & dtjobDate.Text & "','" + txtjob.Text + "'")
                ddldeffect.Focus()

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub txtjobno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtjobno.TextChanged
            Try
                filldata()
                BindGrid(grddeffectlist, con, "view_jobsubdetails '" + txtBusNo.Text + "','" + txtjob.Text + "','" + txtjobno.Text + "'")
                BindGrid(grddetails, con, "view_ItemIssueOnJobcard '" + txtBusNo.Text + "','" + txtjob.Text + "','" + txtjobno.Text + "',''")
                ddldeffect.Focus()
                txtBusNo.AutoPostBack = False
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
                'txtmech.Value = dr(8)
                txtdeffect.Text = dr(9)
                TextBox1.Text = jobs.ToString
                txtjob.Text = dr(11)
                txtjobno.Text = dr(12)



            End If
           

            dr.Close()
            con.Close()
        End Sub
        <WebMethod()> _
Public Shared Function GetAutoCompleteData(ByVal SubId As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()



            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master where subid='" + SubId + "'  and subid <> 0 and deffect_decr like '%" & SearchText & "%' ", con)
                    'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("deffect_decr").ToString())
                    End While
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function

     


        Protected Sub grddeffectlist_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddeffectlist.ItemDataBound
            Dim txtMechanic1 As TextBox
            For i = 0 To grddeffectlist.Items.Count - 1
                txtMechanic1 = grddeffectlist.Items(i).Cells(6).FindControl("txtmech")
          
                strmechanic.Append("$(#" + txtMechanic1.ClientID + ").autocomplete")
            strmechanic.Append("({")
            strmechanic.Append("source: function (request, response) {")
            strmechanic.Append("$.ajax")
            strmechanic.Append("({")
            strmechanic.Append("type: 'POST',")
            strmechanic.Append("contentType: 'application/json; charset=utf-8',")
            strmechanic.Append("url: 'Inspectionrmaster.aspx/GetAutoCompleteData2',")
                strmechanic.Append("data: JSON.stringify({ 'SubId': '2', 'SearchText1': " + txtMechanic1.ClientID + " }),")
            strmechanic.Append("success: function (data) {")
            strmechanic.Append("response(data.d);")
            strmechanic.Append("},")
            strmechanic.Append("error: function (result) {")
            strmechanic.Append("alert('Error');")
            strmechanic.Append("}")
            strmechanic.Append("});")
            strmechanic.Append("}")
            strmechanic.Append("});")

            Next

        End Sub
        <WebMethod()> _
        Public Shared Function GetAutoCompleteData2(ByVal SubId As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()

            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                Using cmd As New SqlCommand("select name from tbl_Mechanic_master where   sub_id not in(123,0,1,129,127,124,160) and name like '%" & SearchText & "%' ", con)
                    'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("strmechanic").ToString())
                    End While
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function

       
    End Class
End Namespace
