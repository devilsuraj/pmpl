Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Bus_seek
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                BindGrid(grdjoclist, con, "view_seek_bus  '',''")
            End If
        End Sub
        Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = Format(Convert.ToDateTime(dtformDate.SelectedDate), "MM/dd/yyyy")
                Dim todate As String = Format(Convert.ToDateTime(dttoDate.SelectedDate), "MM/dd/yyyy")
                BindGrid(grdjoclist, con, "view_seek_bus  '" & fromdate & "','" & todate & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        Protected Sub grdjoclist_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdjoclist.ItemCommand
            Try
                If e.CommandName = "Save" Then
                    'Response.Write("../report/rptJOC.aspx?id=2& jobid='" & e.Item.Cells(0).Text & "'")
                    'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=2&jobno=" + e.Item.Cells(1).Text + "&deffectid=" + e.Item.Cells(5).Text + "'</script>")
                    Dim txt As TextBox
                    txt = e.Item.FindControl("txtnote")
                    If txt.Text = "" Then
                        'grdjoclist.Items(i).Cells(5).Enabled = False
                    Else
                        Dim id As String
                        If BDPLiteseek.SelectedDate = "12:00:00 AM" Or ddlshift.SelectedValue = 0 Then
                            Call Show_Msg(Page, "Do not Save Because Select Seek Date and Shift. ", "")
                        Else
                            id = ExecuteQuery("select isnull(jobid,'') from tbl_Bus_SeekDetails where jobid=" & e.Item.Cells(7).Text & "")
                            If id = "" Then
                                'cmd = New SqlCommand("update JobOrderCard_Master set seekflag=1 where JOC_id=" & e.Item.Cells(7).Text & "")
                                'con.Open()
                                'cmd.ExecuteNonQuery()
                                'con.Close()
                                fnExecuteNonQuery("update JobOrderCard_Master set seekflag=1 where JOC_id=" & e.Item.Cells(7).Text & "")

                                cmd = New SqlCommand("insert into tbl_Bus_SeekDetails values(" & e.Item.Cells(7).Text & ",'" & txt.Text & "','" & Now.Date & "'," & Session("UserId") & ",'" & BDPLiteseek.SelectedDate & "','" & ddlshift.SelectedItem.Text & "')", con)
                                con.Open()
                                cmd.ExecuteNonQuery()
                                'con.Close()
                                con.Close()
                            Else
                                fnExecuteNonQuery("update JobOrderCard_Master set seekflag=1 where JOC_id=" & e.Item.Cells(7).Text & "")
                            End If
                        End If
                    End If
                End If
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                'Response.Redirect("../report/rptSeekBusDetails.aspx")
                Response.Redirect("../report/rptSeekBusDetails.aspx?seekdate=" & BDPLiteseek.SelectedDate & "")
                ' Response.Write("<script>window.location.href='../Workshop/Job_Assign.aspx?id=1&jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub grdjoclist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjoclist.ItemDataBound
            Try
                'For i = 0 To grdjoclist.Items.Count - 1
                '    If grdjoclist.Items(0).ItemType = ListItemType.AlternatingItem Or grdjoclist.Items(0).ItemType = ListItemType.Item Then
                '        Dim txt As TextBox
                '        txt = e.Item.FindControl("txtnote")
                '        If txt.Text = "" Then
                '            grdjoclist.Items(i).Cells(5).Enabled = False
                '        Else
                '            grdjoclist.Items(i).Cells(5).Enabled = True
                '        End If
                '    End If
                'Next
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace