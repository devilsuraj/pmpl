Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class closejobcard
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
            'btnsubmit.Attributes.Add("Onclick", "return chkBrakedown()")
            Try

                If Not IsPostBack Then
                    BDPLite1.SelectedDate = Format(Now.Date, "dd/MMM/yyyy")
                    txtjotime.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
                    txtbdclosedtime.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
                    txtjob.Text = ExecuteQuery("(SELECT RIGHT('0' + RTRIM(year(getdate())), 2)+ RIGHT('0' + RTRIM(month(getdate())), 2))")
                    'btnSubmit.Attributes.Add("onclick", "return chkBrakedown()")
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim docking As String = "closed"
                docking = ExecuteQuery("select deffectplace  from dbo.JobOrderCard_Master where locid = 0 and busno = '" + txtBusNo.Value + "' ")
                Dim jobid As String = ExecuteQuery("select JOC_id  from dbo.JobOrderCard_Master where locid = 0 and busno = '" + txtBusNo.Value + "' ")
                If docking = "0" Then
                    lblmsg.Text = "Docking"
                    tbldata.Visible = True
                    tdclosedtime.Visible = False
                    tdbd.Visible = False
                    tdclosed.Visible = True
                    tdsave.Visible = True
                    tddeffect.Visible = False
                    trdocking.Visible = True
                    BindGrid(grdinsp, con, "view_docking_details '" + jobid + "'")

                    If (docking = "0" And grdinsp.Items.Count > 0) Then
                        tbldata.Visible = True
                    Else
                        tbldata.Visible = False
                        Response.Write("<script>alert ('Please do Inpection') </script>")
                    End If

                ElseIf docking = "1" Then
                    lblmsg.Text = "Defect"
                    trdocking.Visible = False
                    tbldata.Visible = True
                    tdclosedtime.Visible = True
                    tdbd.Visible = True
                    tdclosed.Visible = True
                    tdsave.Visible = True
                    tddeffect.Visible = True
                    BindGrid(grddeffectlist, con, "view_defects '" + txtBusNo.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'")

                    If (docking = "1" And grddeffectlist.Items.Count > 0) Then
                        tbldata.Visible = True
                    Else
                        tbldata.Visible = False
                        Response.Write("<script>alert ('Please do Inpection') </script>")
                    End If


                ElseIf docking = "2" Then
                    lblmsg.Text = "Brakedown"
                    trdocking.Visible = False
                    tbldata.Visible = True
                    tdclosedtime.Visible = True
                    tdbd.Visible = True
                    tdclosed.Visible = True
                    tdsave.Visible = True
                    txtbdclosedtime.Focus()
                    tddeffect.Visible = True
                    BindGrid(grddeffectlist, con, "view_defects '" + txtBusNo.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'")

                    If (docking = "2" And grddeffectlist.Items.Count > 0) Then
                        tbldata.Visible = True
                    Else
                        tbldata.Visible = False
                        Response.Write("<script>alert ('Please do Inpection') </script>")
                    End If


                Else
                    lblmsg.Text = "Job Card closed"
                End If

            Catch ex As Exception

            End Try

        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
            Try

                Dim docking As String
                docking = ExecuteQuery("select docking  from dbo.JobOrderCard_Master where locid = 0 and busno = '" + txtBusNo.Value + "' ")
                If docking = "1" Then

                    cmd = New SqlCommand
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.CommandText = "[updateclosingjob]"
                    cmd.Parameters.AddWithValue("@jobid", ExecuteQuery("select JOC_id  from dbo.JobOrderCard_Master where locid = 0 and busno = '" + txtBusNo.Value + "' "))
                    cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                    cmd.Parameters.AddWithValue("@jobclosedate", BDPLite1.SelectedDate)
                    cmd.Parameters.AddWithValue("@closejob_remark", txtremark.Text)
                    cmd.Parameters.AddWithValue("@jobclosetime", BDPLite1.SelectedDate + " " + txtjotime.Text)
                    cmd.Parameters.AddWithValue("@brakedownclosetime", txtbdclosedtime.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                    Response.Write("<script>alert ('Saved Successfully') </script>")
                Else


                    Dim i As Integer
                    For i = 0 To grddeffectlist.Items.Count - 1
                        cmd = New SqlCommand
                        cmd.Connection = con
                        cmd.CommandType = CommandType.StoredProcedure
                        Dim txttask As TextBox
                        txttask = (grddeffectlist.Items(i).FindControl("txttaskdone"))

                        cmd.CommandText = "[updatetaskdone]"
                        cmd.Parameters.AddWithValue("@insp_job_dtl_id", grddeffectlist.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@taskdone", txttask.Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()


                    Next

                    Response.Write("<script>alert ('Saved Successfully') </script>")

                    cmd = New SqlCommand
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.CommandText = "[updateclosingjob]"
                    cmd.Parameters.AddWithValue("@jobid", grddeffectlist.Items(0).Cells(1).Text)
                    cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                    cmd.Parameters.AddWithValue("@jobclosedate", BDPLite1.SelectedDate)
                    cmd.Parameters.AddWithValue("@closejob_remark", txtremark.Text)
                    cmd.Parameters.AddWithValue("@jobclosetime", BDPLite1.SelectedDate + " " + txtjotime.Text)
                    cmd.Parameters.AddWithValue("@brakedownclosetime", txtbdclosedtime.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    con.Open()

                    cmd.ExecuteNonQuery()
                    con.Close()
                End If

                Response.Redirect("closejobcard.aspx")

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            Response.Redirect("closejobcard.aspx")
        End Sub
    End Class
End Namespace

