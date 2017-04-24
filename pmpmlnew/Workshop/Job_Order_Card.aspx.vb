
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class Job_Order_Card
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim cmd1 As SqlClient.SqlCommand
        Dim ds1 As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Public strSupervisor As String = ""
        Protected Sub page_init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            txtwt.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
            txtdt.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
            Dim sr As String
            sr = Request.QueryString("msg")
            Response.Write(sr)

        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 2
            If Not IsPostBack Then
                txtBusNo.Focus()
                'lblsup.Text = Session("UserName")
                'dtjobDate.Text = Format(Now.Date, "dd-MMM-yyyy")
                txtjotime.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
                ' btnSave.Attributes.Add("onclick", "return chkdate()")

                grddeffectlist.DataSource = ""
                grddeffectlist.DataBind()

                dtjobDate.Text = Now.Date()
                strBusno = getAutoCompleteList("select vech_no from vech_Master where is_delete<>'1' order by vech_no", "vech_no")
                strSupervisor = getAutoCompleteList("select distinct supervisorname from dbo.JobOrderCard_Master", "supervisorname")
                edit_combo(ddlsupervisor, "Mech_id", "Name", "tbl_Mechanic_master", "sub_id=124")
                edit_combo(ddlmech, "Mech_id", "Name", "tbl_Mechanic_master", " Sub_id<>0")
                edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")
                'maxid()
                rd1.Checked = True
                lblsupervisor.Text = Session("engineer")
            Else
                txtBusNo.Focus()
                If rd2.Checked = True Then
                    txtvis()
                Else
                    txtinvis()
                End If
            End If
            'Select1.Items.Clear()
        End Sub
        Sub maxid()
            Try
                Dim id1, id2 As String
                id1 = GetMaxId("JOC_id", con, "JobOrderCard_Master")
                Dim ln As Integer
                ln = id1.Length
                'If ln = 1 Then
                '    txtjocno.Text = "0" & Session("LocID") & "-" & ddldeffect.SelectedValue & "-" & "00000" & id1
                '    id2 = "00000" & id1
                'ElseIf ln = 2 Then
                '    txtjocno.Text = "0" & Session("LocID") & "-" & ddldeffect.SelectedValue & "-" & "0000" & id1
                '    id2 = "0000" & id1
                'Else
                Dim dt1 As String
                dt1 = Format(Now.Date, "ddMyy")
                dt1 = IIf(dt1.Length = 5, Format(Now.Date, "ddmMyy"), Format(Now.Date, "ddMyy"))
                If ln = 1 Then
                    txtjocno.Value = "00000" & id1 & "0" & Session("LocID") & txtBusNo.Value & dt1
                    '"-" & ddldeffect.SelectedValue & "-"
                    id2 = "00000" & id1
                ElseIf ln = 2 Then
                    txtjocno.Value = "0000" & id1 & "0" & Session("LocID") & txtBusNo.Value & dt1
                    id2 = "0000" & id1
                ElseIf ln = 3 Then
                    txtjocno.Value = "000" & id1 & "0" & Session("LocID") & txtBusNo.Value & dt1
                    id2 = "000" & id1
                ElseIf ln >= 4 Then
                    txtjocno.Value = "00" & id1 & "0" & Session("LocID") & txtBusNo.Value & dt1
                    id2 = "00" & id1
                ElseIf ln >= 5 Then
                    txtjocno.Value = "0" & id1 & "0" & Session("LocID") & txtBusNo.Value & dt1
                    id2 = "0" & id1
                ElseIf ln >= 6 Then
                    txtjocno.Value = id1 & "0" & Session("LocID") & txtBusNo.Value & dt1
                    id2 = id1
                End If
                Session("Jid") = id1
                Session("id2") = id2
                con.Close()
                'txtjocno.Text = "dfgdf"
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub ddldeffect_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddldeffect.SelectedIndexChanged
            Try
                'maxid()

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                'Dim da As New SqlClient.SqlDataAdapter("select deffect_decr from tbl_deffect_Master where subid=1", con)
                Dim cmd2 As New SqlClient.SqlCommand("select deffect_id,deffect_decr from tbl_deffect_Master where subid=" & ddldeffect.SelectedValue & " and subid>0", con)
                dr = cmd2.ExecuteReader
                'and deffectype='Minor'

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

                strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")
            Catch ex As Exception
            End Try
        End Sub
        'Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click

        'End Sub
        Dim dt As New DataTable
        Dim dt1 As New DataTable
        Protected Sub Select1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Select1.SelectedIndexChanged
            ''txtBusNo.Text = Select1.Items
            'BindGrid(grddeffectlist, con, "select deffect_id,deffect_decr from tbl_deffect_Master where subid=" & ddldeffect.SelectedValue & "")

            'Dim i As Integer = 0
            dt.Columns.Add("sr")
            dt.Columns.Add("subdeffect_id")
            dt.Columns.Add("deffect_desc")
            dt.Columns.Add("deffect_decr")
            dt.Columns.Add("deffect_id")

            dt1.Columns.Add("sr")
            dt1.Columns.Add("subdeffect_id")
            dt1.Columns.Add("deffect_desc")
            dt1.Columns.Add("deffect_decr")
            dt1.Columns.Add("deffect_id")
            Dim dr As DataRow
            dr = dt.NewRow
            Dim dr1 As DataRow
            dr1 = dt1.NewRow
            Dim deffectid, subdeffectid As Integer
            Dim a As Integer = Select1.Items.Count '- 1
            Dim i As Integer = 0
            Dim b As Integer = 1
            Dim str As String = String.Empty
            Dim j As Integer = 0
            Dim b1 As Integer = 1
            For i = 0 To a - 1
                If Select1.Items(i).Selected = True Then
                    Select1.Items(i).Enabled = False  'added on 15/01 for disable checkbox
                    Select1.Items(i).Selected = False  'added on 15/01  for unchecked checkbox
                    If grddeffectlist.Items.Count > 0 Then
                        'b = grddeffectlist.Items.Count
                        'dt.Rows.Add(
                        'If Session("ab") = 1 Then
                        dt1.Rows.Clear()
                        b1 = 1
                        For j = 0 To grddeffectlist.Items.Count - 1
                            dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(2).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text)
                            b1 = b1 + 1
                        Next
                        'Session("ab") = 2
                        'End If
                        b = b1
                        deffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + ddldeffect.SelectedItem.Text + "'")
                        subdeffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + Select1.Items(i).Text + "'")
                        dt1.Rows.Add(b, subdeffectid, ddldeffect.SelectedItem.Text, Select1.Items(i).Text, deffectid)
                        b = b + 1
                    Else
                        deffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + ddldeffect.SelectedItem.Text + "'")
                        subdeffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + Select1.Items(i).Text + "'")
                        dt.Rows.Add(b, subdeffectid, ddldeffect.SelectedItem.Text, Select1.Items(i).Text, deffectid)
                        b = b + 1
                    End If
                End If
            Next

            If grddeffectlist.Items.Count = 0 Then
                grddeffectlist.DataSource = dt
                grddeffectlist.DataBind()
            Else
                grddeffectlist.DataSource = dt1
                grddeffectlist.DataBind()
            End If

        End Sub

        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            Try
                maxid()
                txtBusNo.Value = ""
                txtmodel.Text = ""
                txtchassis.Text = ""
                txtkms.Text = ""
                txtengin.Text = ""
                '                dtjobDate.Text = Now.Date
                ' dtjobDate.Text = Now.Date
                txtjotime.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
                grddeffectlist.DataSource = ""
                grddeffectlist.DataBind()
                ddlmech.SelectedValue = 0
                txtinspectionnote.Text = ""
                txtnote.Text = ""
                ddldeffect.SelectedValue = 0
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            'Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

            Dim count As Integer = ExecuteQuery("select count (*)  from dbo.JobOrderCard_Master  where busno = '" & txtBusNo.Value & "'  and locid <>  1")

            If txtBusNo.Value = "" Then
                Call Show_Msg(Page, "Enter Bus No....", "Job_Order_Card.aspx")
            ElseIf count <> 0 Then
                Call Show_Msg(Page, "Job Card Is already created....", "Job_Order_Card.aspx")
                Exit Sub



            ElseIf (dtjobDate.Text <> Now.Date()) And (dtjobDate.Text <> DateAdd(DateInterval.Day, -1, Now.Date)) Then
                Response.Write("<script>alert('Please Select Proper Date');</script>")

                Exit Sub


            Else

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
                maxid() 'added 15/01
                Try
                    Dim ad As Integer = 0
                    Dim rd As Integer = 0
                    If txtBusNo.Value = "" Then
                        Call Show_Msg(Page, "Enter Bus No....", "Job_Order_Card.aspx")
                    Else
                        Dim id1 As Integer = 0
                        If rd3.Checked = True Then
                            id1 = 1
                        Else
                            If grddeffectlist.Items.Count = 0 Then
                                id1 = 2
                            Else
                                id1 = 1
                            End If
                        End If
                        If id1 = 2 Then
                            Call Show_Msg(Page, "Do Not Save because Select Deffect Type", "Job_Order_Card.aspx")
                        Else
                            If ddlsupervisor.SelectedItem.Text = "" Or ddlshift.SelectedItem.Text = "Select" Then
                                Call Show_Msg(Page, "Do Not Save because Enter Supervisor Name and Shift", "Job_Order_Card.aspx")
                            Else
                                If rd3.Checked = True Then
                                    If grddeffectlist.Items.Count = 0 Then
                                        rd = 0
                                        cmd = New SqlCommand
                                        ds = New DataSet
                                        DA = New SqlDataAdapter
                                        cmd.Connection = con
                                        cmd.CommandType = CommandType.StoredProcedure

                                        cmd.CommandText = "ins_JOC_master"
                                        cmd.Parameters.AddWithValue("@JOC_No", Session("id2"))
                                        cmd.Parameters.AddWithValue("@loc_no", Session("LocID"))
                                        cmd.Parameters.AddWithValue("@Deffecttypeid", "00")
                                        cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                                        cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                                        cmd.Parameters.AddWithValue("@model", txtmodel.Text)
                                        cmd.Parameters.AddWithValue("@chassis", txtchassis.Text)
                                        cmd.Parameters.AddWithValue("@kms", txtkms.Text)
                                        cmd.Parameters.AddWithValue("@engine", txtengin.Text)
                                        cmd.Parameters.AddWithValue("@jobdate", dtjobDate.Text)
                                        cmd.Parameters.AddWithValue("@jobtime", txtjotime.Text)
                                        cmd.Parameters.AddWithValue("@Mechanicname", IIf(ddlmech.SelectedItem.Text = "Select", "", ddlmech.SelectedItem.Text))
                                        cmd.Parameters.AddWithValue("@inspnote", txtinspectionnote.Text)
                                        cmd.Parameters.AddWithValue("@note", txtnote.Text)
                                        cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                                        cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                                        cmd.Parameters.AddWithValue("@deffectplace", rd)
                                        cmd.Parameters.AddWithValue("@decking", 1)
                                        cmd.Parameters.AddWithValue("@drvcode", txtdrvcode.Text)
                                        cmd.Parameters.AddWithValue("@drvname", txtdrvcode.Text)

                                        cmd.Parameters.AddWithValue("@dutyno", "")
                                        cmd.Parameters.AddWithValue("@place", "")
                                        cmd.Parameters.AddWithValue("@worktime", "")
                                        cmd.Parameters.AddWithValue("@deftime", "")
                                        cmd.Parameters.AddWithValue("@reason", "")
                                        cmd.Parameters.AddWithValue("@supervisor", "")
                                        cmd.Parameters.AddWithValue("@Supervisorname", ddlsupervisor.SelectedItem.Text)
                                        cmd.Parameters.AddWithValue("@shift", ddlshift.SelectedItem.Text)
                                        cmd.Parameters.AddWithValue("@newjob", txtjob.Value)
                                        cmd.Parameters.AddWithValue("@newjobno", txtjobno.Value)
                                        cmd.Parameters.AddWithValue("@engineer", Session("engineer"))
                                        cmd.Parameters.AddWithValue("@Remark ", txtRemark.Value)
                                        con.Open()
                                        cmd.ExecuteNonQuery()

                                        con.Close()

                                        cmd1 = New SqlCommand
                                        ds1 = New DataSet
                                        cmd1.Connection = con
                                        cmd1.CommandType = CommandType.StoredProcedure




                                        'btndocking.Enabled = True
                                        'maxid()
                                        'txtBusNo.Value = ""
                                        'txtmodel.Text = ""
                                        'txtchassis.Text = ""
                                        'txtkms.Text = ""
                                        'txtengin.Text = ""
                                        ''                dtjobDate.Text = Now.Date
                                        'dtjobDate.Text = Now.Date
                                        'txtjotime.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
                                        'grddeffectlist.DataSource = ""
                                        'grddeffectlist.DataBind()
                                        'ddlmech.SelectedValue = 0
                                        'txtinspectionnote.Text = ""
                                        'txtnote.Text = ""
                                        'ddldeffect.SelectedValue = 0

                                        ' Call Show_Msg(Page, "Save Successfully", "")
                                        Response.Write("<script>alert('Saved Successfuly');window.location.href='Job_Order_Card.aspx'</script>")
                                    Else
                                        Call Show_Msg(Page, "Not Add Deffect in Docking Job Card....", "")
                                    End If
                                    'btnSave.Enabled = False
                                    'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=1'</script>")

                                    'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=1&jobid=" + Session("id2") + "&deffectid=" + ddldeffect.SelectedValue + "'</script>")
                                    'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=1&jobid=" + txtjocno.Value + "&deffectid=" + ddldeffect.SelectedValue + "'</script>")
                                ElseIf rd1.Checked = True Then
                                    If ddldeffect.SelectedValue = "00" Then
                                        Call Show_Msg(Page, "Select Deffect type Properly", "Job_Order_Card.aspx")
                                        ddldeffect.Focus()
                                    Else

                                        If rd1.Checked = True Then
                                            ad = 1
                                            rd = 1
                                            'ElseIf rd2.Checked = True Then
                                            '    ad = 1
                                            '    rd = 2
                                        End If
                                        If ad = 1 Then
                                            cmd = New SqlCommand
                                            ds = New DataSet
                                            DA = New SqlDataAdapter
                                            cmd.Connection = con
                                            cmd.CommandType = CommandType.StoredProcedure

                                            cmd.CommandText = "ins_JOC_master"
                                            cmd.Parameters.AddWithValue("@JOC_No", Session("id2"))
                                            cmd.Parameters.AddWithValue("@loc_no", Session("LocID"))
                                            cmd.Parameters.AddWithValue("@Deffecttypeid", "00")
                                            cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                                            cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                                            cmd.Parameters.AddWithValue("@model", txtmodel.Text)
                                            cmd.Parameters.AddWithValue("@chassis", txtchassis.Text)
                                            cmd.Parameters.AddWithValue("@kms", txtkms.Text)
                                            cmd.Parameters.AddWithValue("@engine", txtengin.Text)
                                            cmd.Parameters.AddWithValue("@jobdate", dtjobDate.Text)
                                            cmd.Parameters.AddWithValue("@jobtime", txtjotime.Text)
                                            cmd.Parameters.AddWithValue("@Mechanicname", IIf(ddlmech.SelectedItem.Text = "Select", "", ddlmech.SelectedItem.Text))
                                            cmd.Parameters.AddWithValue("@inspnote", txtinspectionnote.Text)
                                            cmd.Parameters.AddWithValue("@note", txtnote.Text)
                                            cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                                            cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                                            cmd.Parameters.AddWithValue("@deffectplace", rd)
                                            cmd.Parameters.AddWithValue("@decking", 0)
                                            cmd.Parameters.AddWithValue("@drvcode", txtdrvcode.Text)
                                            cmd.Parameters.AddWithValue("@drvname", txtdrvcode.Text)

                                            cmd.Parameters.AddWithValue("@dutyno", "")
                                            cmd.Parameters.AddWithValue("@place", "")
                                            cmd.Parameters.AddWithValue("@worktime", "")
                                            cmd.Parameters.AddWithValue("@deftime", "")
                                            cmd.Parameters.AddWithValue("@reason", "")
                                            cmd.Parameters.AddWithValue("@supervisor", "")
                                            cmd.Parameters.AddWithValue("@Supervisorname", ddlsupervisor.SelectedItem.Text)
                                            cmd.Parameters.AddWithValue("@shift", ddlshift.SelectedItem.Text)
                                            cmd.Parameters.AddWithValue("@newjob", txtjob.Value)
                                            cmd.Parameters.AddWithValue("@newjobno", txtjobno.Value)
                                            cmd.Parameters.AddWithValue("@engineer", Session("engineer"))
                                            cmd.Parameters.AddWithValue("@Remark ", txtRemark.Value)
                                            con.Open()
                                            'Dim first As Integer = 0              'added 15/01
                                            'first =
                                            cmd.ExecuteNonQuery()         'added 15/01

                                            con.Close()
                                            'If first > 0 Then                       'added 15/01
                                            Dim i As Integer = 0
                                            For i = 0 To grddeffectlist.Items.Count - 1
                                                cmd = New SqlCommand("ins_JOC_Details", con)
                                                cmd.CommandType = CommandType.StoredProcedure
                                                cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                                                cmd.Parameters.AddWithValue("@deffecttypeid", grddeffectlist.Items(i).Cells(4).Text)
                                                cmd.Parameters.AddWithValue("@subdeffectid", grddeffectlist.Items(i).Cells(1).Text)
                                                cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                                                cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                                                con.Open()
                                                cmd.ExecuteNonQuery()
                                                con.Close()
                                            Next
                                            Response.Write("<script>alert('Saved Successfuly');window.location.href='Job_Order_Card.aspx'</script>")
                                            'Call Show_Msg(Page, "Save Successfully", "Job_Order_Card.aspx")
                                            'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=1&jobid=" + txtjocno.Value + "&deffectid=" + ddldeffect.SelectedValue + "'</script>")
                                            'Else
                                            '    Call Show_Msg(Page, "Bus Number Already Exists", "Job_Order_Card.aspx")
                                            '    Response.Redirect("Job_Order_Card.aspx")

                                            'End If

                                        End If
                                    End If
                                ElseIf rd2.Checked = True Then
                                    If ddldeffect.SelectedValue = "00" Then
                                        Call Show_Msg(Page, "Select Deffect type Properly", "Job_Order_Card.aspx")
                                        ddldeffect.Focus()
                                    Else

                                        'If rd1.Checked = True Then
                                        '    ad = 1
                                        '    rd = 1
                                        'Else
                                        If rd2.Checked = True Then
                                            ad = 1
                                            rd = 2
                                        End If
                                        If ad = 1 Then
                                            cmd = New SqlCommand
                                            ds = New DataSet
                                            DA = New SqlDataAdapter
                                            cmd.Connection = con
                                            cmd.CommandType = CommandType.StoredProcedure

                                            cmd.CommandText = "ins_JOC_master"
                                            cmd.Parameters.AddWithValue("@JOC_No", Session("id2"))
                                            cmd.Parameters.AddWithValue("@loc_no", Session("LocID"))
                                            cmd.Parameters.AddWithValue("@Deffecttypeid", "00")
                                            cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                                            cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                                            cmd.Parameters.AddWithValue("@model", txtmodel.Text)
                                            cmd.Parameters.AddWithValue("@chassis", txtchassis.Text)
                                            cmd.Parameters.AddWithValue("@kms", txtkms.Text)
                                            cmd.Parameters.AddWithValue("@engine", txtengin.Text)
                                            cmd.Parameters.AddWithValue("@jobdate", dtjobDate.Text)
                                            cmd.Parameters.AddWithValue("@jobtime", txtjotime.Text)
                                            cmd.Parameters.AddWithValue("@Mechanicname", IIf(ddlmech.SelectedItem.Text = "Select", "", ddlmech.SelectedItem.Text))
                                            cmd.Parameters.AddWithValue("@inspnote", txtinspectionnote.Text)
                                            cmd.Parameters.AddWithValue("@note", txtnote.Text)
                                            cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                                            cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                                            cmd.Parameters.AddWithValue("@deffectplace", rd)
                                            cmd.Parameters.AddWithValue("@decking", 0)
                                            cmd.Parameters.AddWithValue("@drvcode", txtdrvcode.Text)
                                            cmd.Parameters.AddWithValue("@drvname", txtdrvcode.Text)

                                            cmd.Parameters.AddWithValue("@dutyno", txtrt.Text)
                                            cmd.Parameters.AddWithValue("@place", txtplc.Text)
                                            cmd.Parameters.AddWithValue("@worktime", txtwt.Text)
                                            cmd.Parameters.AddWithValue("@deftime", txtdt.Text)
                                            cmd.Parameters.AddWithValue("@reason", txtarreason.Value)
                                            cmd.Parameters.AddWithValue("@supervisor", txtname.Text)
                                            cmd.Parameters.AddWithValue("@Supervisorname", ddlsupervisor.SelectedItem.Text)
                                            cmd.Parameters.AddWithValue("@shift", ddlshift.SelectedItem.Text)
                                            cmd.Parameters.AddWithValue("@newjob", txtjob.Value)
                                            cmd.Parameters.AddWithValue("@newjobno", txtjobno.Value)
                                            cmd.Parameters.AddWithValue("@engineer", Session("engineer"))

                                            con.Open()
                                            'Dim first As Integer = 0              'added 15/01
                                            'first =
                                            cmd.ExecuteNonQuery()         'added 15/01

                                            con.Close()
                                            'If first > 0 Then                       'added 15/01
                                            Dim i As Integer = 0
                                            For i = 0 To grddeffectlist.Items.Count - 1
                                                cmd = New SqlCommand("ins_JOC_Details", con)
                                                cmd.CommandType = CommandType.StoredProcedure
                                                cmd.Parameters.AddWithValue("@joccode", txtjocno.Value)
                                                cmd.Parameters.AddWithValue("@deffecttypeid", grddeffectlist.Items(i).Cells(4).Text)
                                                cmd.Parameters.AddWithValue("@subdeffectid", grddeffectlist.Items(i).Cells(1).Text)
                                                cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                                                cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                                                con.Open()
                                                cmd.ExecuteNonQuery()
                                                con.Close()
                                            Next
                                            Response.Write("<script>alert('Saved Successfuly');window.location.href='Job_Order_Card.aspx'</script>")
                                            ' Call Show_Msg(Page, "Save Successfully", "Job_Order_Card.aspx")

                                            'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=1&jobid=" + txtjocno.Value + "&deffectid=" + ddldeffect.SelectedValue + "'</script>")
                                            'Else
                                            '    Call Show_Msg(Page, "Bus Number Already Exists", "Job_Order_Card.aspx")
                                            '    Response.Redirect("Job_Order_Card.aspx")

                                            'End If

                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If
        End Sub

        Protected Sub btndocking_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btndocking.Click
            If grddeffectlist.Items.Count = 0 Then
            Else
                Response.Write("<script>window.location.href='../Workshop/Docking_inspection.aspx?jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
            End If
        End Sub

        Protected Sub rd3_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rd3.CheckedChanged
            Try
                If rd3.Checked = True Then
                    ddldeffect.Enabled = False
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub rd2_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rd2.CheckedChanged
            Try
                If rd2.Checked = True Then
                    ddldeffect.Enabled = True
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub rd1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rd1.CheckedChanged
            Try
                If rd1.Checked = True Then
                    ddldeffect.Enabled = True
                End If
            Catch ex As Exception

            End Try
        End Sub
        Public Sub txtvis()
            onroad.Visible = True
            'txtrt.Visible = True
            'txtplc.Visible = True
            'txtdt.Visible = True
            'txtwt.Visible = True
            'txtarreason.Visible = True
            'txtname.Visible = True
            'btnSave.Visible = False

        End Sub
        Public Sub txtinvis()
            onroad.Visible = False
            'txtrt.Visible = False
            'txtplc.Visible = False
            'txtdt.Visible = False
            'txtwt.Visible = False
            'txtarreason.Visible = False
            'txtname.Visible = False
            'btnSave.Visible = True

        End Sub

        Protected Sub btnadd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnadd.Click
            Try
                Dim strdefects As String = ""
                'select deffect_id,deffect_decr from tbl_deffect_Master where subid=" & ddldeffect.SelectedValue & ""
                strdefects = ExecuteQuery("select *  from tbl_deffect_Master   where deffect_decr = '" & ddlsubdefect.Text & "' and subid = " & ddldeffect.SelectedValue & "")
                If strdefects <> "" Then


                    dt.Columns.Add("sr")
                    dt.Columns.Add("subdeffect_id")
                    dt.Columns.Add("deffect_desc")
                    dt.Columns.Add("deffect_decr")
                    dt.Columns.Add("deffect_id")

                    dt1.Columns.Add("sr")
                    dt1.Columns.Add("subdeffect_id")
                    dt1.Columns.Add("deffect_desc")
                    dt1.Columns.Add("deffect_decr")
                    dt1.Columns.Add("deffect_id")
                    Dim dr As DataRow
                    dr = dt.NewRow
                    Dim dr1 As DataRow
                    dr1 = dt1.NewRow
                    Dim deffectid, subdeffectid As Integer
                    Dim a As Integer = Select1.Items.Count '- 1
                    Dim i As Integer = 0
                    Dim b As Integer = 1
                    Dim str As String = String.Empty
                    Dim j As Integer = 0
                    Dim b1 As Integer = 1
                    Dim presenent As String = ""


                    If grddeffectlist.Items.Count > 0 Then
                        dt1.Rows.Clear()
                        b1 = 1

                        For j = 0 To grddeffectlist.Items.Count - 1
                            dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(2).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text)
                            b1 = b1 + 1
                        Next

                        For k = 0 To grddeffectlist.Items.Count - 1
                            If grddeffectlist.Items(k).Cells(3).Text <> ddlsubdefect.Text Then

                            Else
                                presenent = "yes"
                            End If

                        Next

                        If presenent = "" Then

                            'Session("ab") = 2
                            'End If
                            b = b1
                            deffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + ddldeffect.SelectedItem.Text + "'")
                            subdeffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + ddlsubdefect.Text + "'")
                            dt1.Rows.Add(b, subdeffectid, ddldeffect.SelectedItem.Text, ddlsubdefect.Text, deffectid)
                            b = b + 1
                        End If
                    Else
                        deffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + ddldeffect.SelectedItem.Text + "'")
                        subdeffectid = ExecuteQuery("select deffect_id from tbl_deffect_Master where deffect_decr='" + ddlsubdefect.Text + "'")
                        dt.Rows.Add(b, subdeffectid, ddldeffect.SelectedItem.Text, ddlsubdefect.Text, deffectid)
                        b = b + 1
                    End If



                    If grddeffectlist.Items.Count = 0 Then
                        grddeffectlist.DataSource = dt
                        grddeffectlist.DataBind()
                    Else
                        grddeffectlist.DataSource = dt1
                        grddeffectlist.DataBind()
                    End If
                    ddlsubdefect.Text = ""
                    ddlsubdefect.Focus()
                    lblmsg.Text = ""
                Else
                    lblmsg.Text = "Plese select proper combination of defects"
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grddeffectlist_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grddeffectlist.ItemCommand
            Try
                If e.CommandName = "Delete" Then
                    Dim srno As Integer = e.Item.Cells(0).Text
                    dt.Columns.Add("sr")
                    dt.Columns.Add("subdeffect_id")
                    dt.Columns.Add("deffect_desc")
                    dt.Columns.Add("deffect_decr")
                    dt.Columns.Add("deffect_id")

                    dt1.Columns.Add("sr")
                    dt1.Columns.Add("subdeffect_id")
                    dt1.Columns.Add("deffect_desc")
                    dt1.Columns.Add("deffect_decr")
                    dt1.Columns.Add("deffect_id")
                    Dim dr As DataRow
                    dr = dt.NewRow
                    Dim dr1 As DataRow
                    dr1 = dt1.NewRow
                    Dim deffectid, subdeffectid As Integer
                    Dim a As Integer = Select1.Items.Count '- 1
                    Dim i As Integer = 0
                    Dim b As Integer = 1
                    Dim str As String = String.Empty
                    Dim j As Integer = 0
                    Dim b1 As Integer = 1
                    Dim presenent As String = ""


                    If grddeffectlist.Items.Count > 0 Then
                        dt1.Rows.Clear()
                        b1 = 1

                        For j = 0 To grddeffectlist.Items.Count - 1
                            If grddeffectlist.Items(j).Cells(0).Text <> srno Then
                                dt1.Rows.Add(b1, grddeffectlist.Items(j).Cells(1).Text, grddeffectlist.Items(j).Cells(2).Text, grddeffectlist.Items(j).Cells(3).Text, grddeffectlist.Items(j).Cells(4).Text)
                                b1 = b1 + 1
                            End If

                        Next

                    End If



                    If grddeffectlist.Items.Count = 0 Then
                        grddeffectlist.DataSource = dt
                        grddeffectlist.DataBind()
                    Else
                        grddeffectlist.DataSource = dt1
                        grddeffectlist.DataBind()
                    End If
                    ddlsubdefect.Text = ""
                End If

            Catch ex As Exception

            End Try
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
    End Class
End Namespace
