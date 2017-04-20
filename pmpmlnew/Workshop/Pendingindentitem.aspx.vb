Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Pendingindentitem
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                'btnSubmit.Attributes.Add("Onclick", "return validate ()")
                gridbind()
            End If
        End Sub
        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then


                'Dim bdplite As BasicFrame.WebControls.BDPLite
                'bdplite = CType(e.Item.FindControl("bdpdonedate"), BasicFrame.WebControls.BDPLite)
                'bdplite.SelectedDate = Now.Date()

                ' bdplite.Attributes.Add("Onblur", "getdate('" & bdplite.ClientID & "');")
            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                For i = 0 To dgresult.Items.Count - 1



                    'Dim bdpdonedate As BasicFrame.WebControls.BDPLite
                    'bdpdonedate = CType(dgresult.Items(i).Cells(6).FindControl("bdpdonedate"), BasicFrame.WebControls.BDPLite)
                    'Dim txtremark As TextBox = CType(dgresult.Items(i).Cells(7).FindControl("txtremark"), TextBox)
                    Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(7).FindControl("chkselect"), CheckBox)





                    If chkselect.Checked = True Then
                        Dim isreturn As Integer = 1
                        'If myarray(i) <> "" Then
                        '    Dim mainarray As Array = Split(myarray(i), "^")
                        cmd = New SqlCommand("ins_pending_indentrequest", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@item_code", dgresult.Items(i).Cells(3).Text)
                        con.Open()
                        cmd.ExecuteNonQuery()

                        Response.Write("<script>alert('Saved Successfuly')</script>")
                        con.Close()
                        gridbind()
                    End If

                Next
            Catch ex As Exception

            End Try
        End Sub

        Private Sub gridbind()
            BindGrid(dgresult, con, "view_pending_indent")
            If dgresult.Items.Count = 0 Then
                tblmain.Visible = False
                lblmsg.Text = "No Pending Items"
            Else
                tblmain.Visible = True
                lblmsg.Text = ""
            End If

        End Sub
    End Class
End Namespace
