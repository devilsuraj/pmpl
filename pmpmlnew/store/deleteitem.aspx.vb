Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class deleteitem
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                'Me.BDPLite1.SelectedDate = Now.Date
                btnSubmit.Attributes.Add("Onclick", "return Validate ()")
                trgrid.Visible = False
                trbtn.Visible = False

                Hid_Rec.Value = ""
            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click

            Try


                Dim i As Integer
                Dim Check As CheckBox
                Dim is_delete As Integer = 0
                For i = 0 To dgresult.Items.Count - 1
                    Check = dgresult.Items(i).Cells(6).FindControl("check")
                    If Check.Checked Then

                        Call fnExecuteNonQuery("deleteitemstore " & dgresult.Items(i).Cells(0).Text & "")
                        is_delete = 1
                    End If
                Next
                If is_delete = 1 Then
                    Response.Write("<script>alert('Item Deleted ')</script>")
                End If

                fillgrid()

            Catch ex As Exception

            End Try
        End Sub


        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            fillgrid()

        End Sub
        Private Sub fillgrid()
            Try
                If bdpDate.SelectedDate = "#12:00:00 AM#" Then
                    BindGrid(dgresult, con, "viewitemstore '','" & txtefno.Text & "'")
                Else
                    BindGrid(dgresult, con, "viewitemstore '" & bdpDate.SelectedDate & "','" & txtefno.Text & "'")
                End If

                If dgresult.Items.Count > 0 Then
                    trgrid.Visible = True
                    trbtn.Visible = True
                Else
                    trgrid.Visible = False
                    trbtn.Visible = False
                    Response.Write("<script>alert ('Record Not Found') </script>")
                End If

            Catch ex As Exception

            End Try

        End Sub
    End Class
End Namespace
