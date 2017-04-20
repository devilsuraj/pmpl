Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class puncturetyres
        Inherits System.Web.UI.Page

        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                btnSubmit.Attributes.Add("Onclick", "return validate ()")
                gridbind()
            End If
        End Sub
        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then


                Dim bdplite As BasicFrame.WebControls.BDPLite
                bdplite = CType(e.Item.FindControl("bdpdonedate"), BasicFrame.WebControls.BDPLite)
                bdplite.SelectedDate = Now.Date()

                ' bdplite.Attributes.Add("Onblur", "getdate('" & bdplite.ClientID & "');")
            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                For i = 0 To dgresult.Items.Count - 1



                    Dim bdpdonedate As BasicFrame.WebControls.BDPLite
                    bdpdonedate = CType(dgresult.Items(i).Cells(6).FindControl("bdpdonedate"), BasicFrame.WebControls.BDPLite)
                    Dim txtremark As TextBox = CType(dgresult.Items(i).Cells(7).FindControl("txtremark"), TextBox)
                    Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(8).FindControl("chkselect"), CheckBox)





                    If chkselect.Checked = True Then
                        Dim isreturn As Integer = 1
                        'If myarray(i) <> "" Then
                        '    Dim mainarray As Array = Split(myarray(i), "^")
                        cmd = New SqlCommand("ins_puncture", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@tyrewsno", dgresult.Items(i).Cells(4).Text)
                        cmd.Parameters.AddWithValue("@tyrecompanyno", dgresult.Items(i).Cells(3).Text)
                        cmd.Parameters.AddWithValue("@size", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@remark", txtremark.Text)
                        cmd.Parameters.AddWithValue("@done_date", bdpdonedate.SelectedDate)
                        cmd.Parameters.AddWithValue("@historyid", dgresult.Items(i).Cells(1).Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()

                    End If

                Next
                Response.Write("<script>alert('Saved Successfuly')</script>")
            Catch ex As Exception

            End Try
            gridbind()
        End Sub

        Private Sub gridbind()
            BindGrid(dgresult, con, "view_puncture_tyres")
            If dgresult.Items.Count = 0 Then
                tblmain.Visible = False
                lblmsg.Text = "No Puncture Tyre Found"
            Else
                tblmain.Visible = True
                lblmsg.Text = ""
            End If

        End Sub
    End Class
End Namespace

