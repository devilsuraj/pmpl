Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Close_JobCard
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
            Try
                If Not IsPostBack Then
                    BindGrid(grdjobdetails, con, "close_job_bus '" + txtjocno.Value + "','" + txtBusNo.Value + "'")

                    'If ddldeffectplace.SelectedValue > 0 Then
                    'txtBusNo.Value = ""
                    'txtjocno.Value = ""
                    strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=0 and inspection_no<>0 order by joccode", "joccode")

                    strBusno = getAutoCompleteList("SELECT vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0  and inspection_no<>0  ORDER BY vech_master.vech_no", "vech_no")

                    'Else
                    '    txtBusNo.Value = ""
                    '    txtjocno.Value = ""
                    'End If
                    'strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")

                    'grdjobdetails.DataSource = ""
                    'grdjobdetails.DataBind()
                Else
                    'BindGrid(grdjobdetails, con, "close_job_bus '" + txtjocno.Value + "','" + txtBusNo.Value + "'")
                    'txtBusNo.Value = ""
                    'txtjocno.Value = ""
                End If
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            BindGrid(grdjobdetails, con, "close_job_bus '" + txtjocno.Value + "','" + txtBusNo.Value + "'")

            strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=1 order by joccode", "joccode")

            strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            strBusno = getAutoCompleteList("SELECT vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=1  ORDER BY vech_master.vech_no", "vech_no")
            txtBusNo.Value = ""
            txtjocno.Value = ""
        End Sub
        Protected Sub grdjobdetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjobdetails.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    'Dim grd As DataGrid
                    'grd = e.Item.FindControl("grddeffect")
                    Dim txt1 As TextBox
                    txt1 = e.Item.FindControl("txtnote")
                    txt1.Text = IIf(e.Item.Cells(10).Text = "&nbsp;", "", e.Item.Cells(10).Text)
                    'Dim adp As New SqlDataAdapter("JOC_closingjob_details '" + txtjocno.Value + "','" + e.Item.Cells(4).Text + "'," + e.Item.Cells(1).Text + "", con)
                    'Dim ds As New DataSet
                    'adp.Fill(ds)s
                    'grd.DataSource = ds.Tables(1)
                    'grd.DataBind()
                    'Dim txt1 As TextBox
                    'txt1 = e.Item.FindControl("txtmech")
                    'strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
                    'e.Item.Cells(10).Text = Format(Now.Date, "dd/MM/yyyy") & "-" & Now.Hour & Now.Minute & Now.Second
                    'Dim btn As Button
                    'btn=
            End Select
        End Sub
        Protected Sub grdjobdetails_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdjobdetails.ItemCommand
            Try
                If e.CommandName = "save" Then
                    'Response.Write("../report/rptJOC.aspx?id=2& jobid='" & e.Item.Cells(0).Text & "'")
                    Dim txt1 As TextBox
                    txt1 = e.Item.FindControl("txtnote")
                    If txt1.Text = "" Then
                        'If e.Item.Cells(8).Text = 0 Then
                        Call Show_Msg(Page, "Enter Note ", "Close_Assign_Job.aspx")
                        txt1.Focus()
                        'End If
                    Else

                        'If e.Item.Cells(8).Text <> 0 Then
                        Dim txt2 As TextBox
                        txt2 = e.Item.FindControl("txtbraketime")
                        If e.Item.Cells(12).Text = "2" Then
                            If txt2.Text = "" Then
                                Call Show_Msg(Page, "Enter Brakedown Close Time", "Close_Assign_Job.aspx")
                            Else
                                con.Open()
                                cmd = New SqlCommand("ins_JOC_closingjob " + e.Item.Cells(1).Text + ",'" + e.Item.Cells(4).Text + "','" + e.Item.Cells(5).Text + "','" + txt1.Text + "','" + e.Item.Cells(11).Text + "','" + txt2.Text + "'", con)
                                cmd.ExecuteNonQuery()
                                con.Close()
                                Call Show_Msg(Page, "Save Successfully", "Close_Assign_Job.aspx")

                            End If
                        ElseIf e.Item.Cells(12).Text = "0" Then
                            If e.Item.Cells(13).Text = "1" Then
                                Call Show_Msg(Page, "Enter Docking Inspection", "Close_Assign_Job.aspx")
                            Else
                                con.Open()
                                cmd = New SqlCommand("ins_JOC_closingjob " + e.Item.Cells(1).Text + ",'" + e.Item.Cells(4).Text + "','" + e.Item.Cells(5).Text + "','" + txt1.Text + "','" + e.Item.Cells(11).Text + "','" + txt2.Text + "'", con)
                                cmd.ExecuteNonQuery()
                                con.Close()
                                Call Show_Msg(Page, "Save Successfully", "Close_Assign_Job.aspx")
                            End If
                        ElseIf e.Item.Cells(12).Text = "1" Then
                            con.Open()
                            cmd = New SqlCommand("ins_JOC_closingjob " + e.Item.Cells(1).Text + ",'" + e.Item.Cells(4).Text + "','" + e.Item.Cells(5).Text + "','" + txt1.Text + "','" + e.Item.Cells(11).Text + "','" + txt2.Text + "'", con)
                            cmd.ExecuteNonQuery()
                            con.Close()
                            Call Show_Msg(Page, "Save Successfully", "Close_Assign_Job.aspx")
                        End If
                        BindGrid(grdjobdetails, con, "close_job_bus '" + txtjocno.Value + "','" + txtBusNo.Value + "'")
                        'End If
                    End If
                    'Response.Write("<script>window.location.href='../report/rpt_Closing_Job.aspx?id=2&jobno=" + e.Item.Cells(2).Text + "&deffectid=" + e.Item.Cells(5).Text + "'</script>")
                End If
            Catch ex As Exception

            End Try
        End Sub

        'Protected Sub ddldeffectplace_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddldeffectplace.SelectedIndexChanged
        '    txtBusNo.Value = ""
        '    txtjocno.Value = ""
        'End Sub
    End Class
End Namespace
