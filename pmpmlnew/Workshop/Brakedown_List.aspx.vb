Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Brakedown_List
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Dim jobno As String = ""
        Dim sr As Integer = 0
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                BindGrid(grdjoclist, con, "view_brakedown_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "','" & txtbusno.Text & "','" & ddlbustype.SelectedValue & "','" & ddlshift.SelectedValue & "'")
                'grdjoclist.DataSource = ""
                'grdjoclist.DataBind()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = Format(Convert.ToDateTime(dtformDate.SelectedDate), "MM/dd/yyyy")
                Dim todate As String = Format(Convert.ToDateTime(dttoDate.SelectedDate), "MM/dd/yyyy")
                BindGrid(grdjoclist, con, "view_brakedown_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "','" & txtbusno.Text & "','" & ddlbustype.SelectedValue & "','" & ddlshift.SelectedValue & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                Response.Redirect("../report/Workshop_rptbrakedown.aspx?fromdate=" & dtformDate.SelectedDate & "&Todate=" & dttoDate.SelectedDate & "&Busno=" & txtbusno.Text & "&type=" & ddlbustype.SelectedValue & "&shift=" & ddlshift.SelectedValue & " ")
                ' Response.Write("<script>window.location.href='../Workshop/Job_Assign.aspx?id=1&jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdjoclist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjoclist.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
                If e.Item.Cells(1).Text = jobno Then
                    e.Item.Cells(2).Text = ""
                    e.Item.Cells(3).Text = ""
                    e.Item.Cells(0).Text = ""
                    e.Item.Cells(4).Text = ""
                    e.Item.Cells(5).Text = ""
                    e.Item.Cells(6).Text = ""
                    e.Item.Cells(8).Text = ""
                    e.Item.Cells(10).Text = ""
                    e.Item.Cells(11).Text = ""
                Else
                    jobno = e.Item.Cells(1).Text

                    If e.Item.Cells(0).Text <> "Job No" Then
                        sr = sr + 1
                        e.Item.Cells(0).Text = sr
                    End If
                End If

               


            End If
            If (dtformDate.SelectedDate <> dttoDate.SelectedDate) Then
                e.Item.Cells(13).Visible = "False"

            End If

        End Sub

        Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
            ExportDataGrid(grdjoclist)
        End Sub

    End Class
End Namespace