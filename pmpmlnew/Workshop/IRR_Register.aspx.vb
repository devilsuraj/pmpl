Namespace KDMT
    Partial Class IRR_Register
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            txtBusNo.Focus()
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                grdirrlist.DataSource = ""
                grdirrlist.DataBind()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = dtformDate.SelectedDate
                Dim todate As String = dttoDate.SelectedDate
                'added 19/01to retrieve mar joc_id if  last jobcard for given bus is closed  --------------------------------------
                Dim str As String = "select JobOrderCard_Master.joccode, Indent_Repair_Replacement_Items.Item_name, Indent_Repair_Replacement_Items.part_NO  from JobOrderCard_Master LEFT OUTER JOIN Indent_Repair_Replacement_Items ON JobOrderCard_Master.JOC_id = Indent_Repair_Replacement_Items.JOC_ID where JobOrderCard_Master.joc_id=(select isnull(max(joc_id),0)  from jobordercard_master where busno=" & txtBusNo.Text & ")"

                'Dim dr As New SqlClient.SqlDataReader
                con.Open()
                Dim cmd2 As New SqlClient.SqlCommand(str, con)
                dr = cmd2.ExecuteReader
                If (dr.Read) Then
                    txtjobno.Text = dr.GetValue(0)
                    txtitemreplace.Text = dr.GetValue(1)
                    txtpartno.Text = dr.GetValue(2)
                End If
                con.Close()
                ' ------------------------------------------------------
                BindGrid(grdirrlist, con, "view_IRR_reg '" & fromdate & "','" & todate & "','" & txtsupervisor.Text & "','" & txtBusNo.Text & "','" & txtjobno.Text & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        'Protected Sub grdirrlist_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdirrlist.ItemCommand
        '    Try
        '        If e.CommandName = "select" Then
        '            'Response.Write("../report/rptJOC.aspx?id=2& jobid='" & e.Item.Cells(0).Text & "'")
        '            Response.Write("<script>window.location.href='../Workshop/IRR_Repair_Fit.aspx?id=1&irrid=" & e.Item.Cells(0).Text & "&jocid=" & e.Item.Cells(4).Text & "'</script>")
        '        End If
        '    Catch ex As Exception
        '    End Try
        'End Sub
        Protected Sub grdirrlist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdirrlist.ItemDataBound
            Try
                Dim i As Integer
                Dim j As Integer
                j = 1
                Dim btn As New Button
                Dim link1, link2 As New HyperLink
                For i = 0 To grdirrlist.Items.Count - 1
                    If grdirrlist.Items(0).ItemType = ListItemType.AlternatingItem Or grdirrlist.Items(0).ItemType = ListItemType.Item Then
                        'btn = grdirrlist.Items(i).Cells(0).FindControl("btnshow1")
                        link2 = grdirrlist.Items(i).Cells(0).FindControl("hpshow")
                        link1 = grdirrlist.Items(i).Cells(0).FindControl("hpfit")
                        If grdirrlist.Items(i).Cells(10).Text = 1 Then
                            'btn.Enabled = True
                            'btn.OnClientClick = "../Workshop/IRR_Repair_Fit.aspx?id=2&irrid=" & grdirrlist.Items(i).Cells(0).Text & "&jocid=" & grdirrlist.Items(i).Cells(4).Text & ""
                            link2.NavigateUrl = "../Workshop/IRR_Repair_Fit.aspx?id=2&irrid=" & grdirrlist.Items(i).Cells(0).Text & "&jocid=" & grdirrlist.Items(i).Cells(4).Text & ""
                            link1.Enabled = False
                        Else
                            link1.NavigateUrl = "../Workshop/IRR_Repair_Fit.aspx?id=1&irrid=" & grdirrlist.Items(i).Cells(0).Text & "&jocid=" & grdirrlist.Items(i).Cells(4).Text & ""
                            'btn.Enabled = False
                            link2.Enabled = False
                        End If
                    End If
                Next
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub grdirrlist_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdirrlist.SelectedIndexChanged

        End Sub
    End Class
End Namespace