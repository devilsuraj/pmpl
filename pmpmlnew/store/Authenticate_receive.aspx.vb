Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Authenticate_receive
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public currenedate

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                Session("MenuId") = 10
                btnSubmit.Attributes.Add("Onclick", "return validate ()")
                If Not IsPostBack Then
                    fillgrid()
                    bdpdrbdate.SelectedDate = Now.Date()
                    fydrbyear.Value = GetFinYear(1)
                End If

            Catch ex As Exception

            End Try
        End Sub
        'Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        '    Try

        '        Dim i As Integer
        '        Dim drb_no As TextBox
        '        Dim bdpreceive_date As BasicFrame.WebControls.BDPLite
        '        Dim authenticate As CheckBox

        '        For i = 0 To dgresult.Items.Count - 1

        '            drb_no = dgresult.Items(i).Cells(9).FindControl("txtdrb")
        '            bdpreceive_date = CType(dgresult.Items(i).Cells(10).FindControl("bdpreceive_date"), BasicFrame.WebControls.BDPLite)
        '            authenticate = dgresult.Items(i).Cells(11).FindControl("authenticate")

        '            If authenticate.Checked Then

        '                cmd = New SqlCommand("Upd_Authentication", con)
        '                cmd.CommandType = CommandType.StoredProcedure

        '                cmd.Parameters.AddWithValue("@store_id", dgresult.Items(i).Cells(0).Text)
        '                cmd.Parameters.AddWithValue("@drb_no", drb_no.Text)
        '                cmd.Parameters.AddWithValue("@trans_date", bdpreceive_date.SelectedDate)
        '                cmd.Parameters.AddWithValue("@userid", Session("UserId"))
        '                con.Open()
        '                cmd.ExecuteNonQuery()
        '                Response.Write("<script>alert('Successfuly Received')</script>")
        '                con.Close()
        '            End If
        '        Next

        '    Catch ex As Exception

        '    Finally

        '    End Try
        'End Sub
        'Private Sub fillgrid()
        '    Try
        '        BindGrid(dgresult, con, "view_receive_authenticate")
        '    Catch ex As Exception

        '    End Try

        'End Sub
        Private Sub fillgrid()
            Try
                Dim Part_Type As String = ""

                If Session("Dept_code") = 1 Then
                    Part_Type = "sp"
                    hdnparttype.Value = "SP"
                ElseIf Session("Dept_code") = 2 Then
                    Part_Type = "hw"
                    hdnparttype.Value = "HW"
                End If

                BindGrid(dgresult, con, "view_receive_authenticate " & Part_Type)
            Catch ex As Exception

            End Try

        End Sub
        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then
                'Dim bdplite As BasicFrame.WebControls.BDPLite
                'bdplite = CType(e.Item.FindControl("bdpreceive_date"), BasicFrame.WebControls.BDPLite)
                'bdplite.SelectedDate = Now.Date()

                Dim radauthenticate As RadioButton
                radauthenticate = e.Item.FindControl("authenticate")
                radauthenticate.Attributes.Add("onclick", "radvaidate(this);Details('" & e.Item.Cells(0).Text & "')")

            End If
        End Sub
        Protected Sub dgresult_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgresult.ItemCommand
            Try

                If e.CommandName = "select" Then
                    Hid_Rec.Value = e.CommandArgument.ToString()
                    ' BindGrid(DataGrid1, con, " view_receive_detail_storeid '" & Hid_Rec.Value & "'")
                    'ViewState("Save") = 2

                End If
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click

        End Sub
        Public Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = bdpdrbdate.SelectedDate
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function
    End Class
End Namespace
