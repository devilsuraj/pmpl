Imports System.Data.SqlClient
Namespace Kdmt

    Partial Class before_expire_issue_reason
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 2
            Try
                If Not IsPostBack Then
                    FILLGRID()

                End If
            Catch ex As Exception

            End Try
        End Sub
        Private Sub FILLGRID()
            Try

                BindGrid(grddetails, con, "view_spare_issued_before_expiry")

                If grddetails.Items.Count > 0 Then
                    grddetails.Visible = True
                    trsave.Visible = True

                Else
                    grddetails.Visible = False
                    trsave.Visible = False
                End If

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btnclear_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnclear.Click
            Response.Redirect("before_expire_issue_reason.aspx")
        End Sub

        Protected Sub btnSubmit_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                For i = 0 To grddetails.Items.Count - 1
                    Dim txtreason As TextBox = CType(grddetails.Items(i).Cells(8).FindControl("txtreason"), TextBox)
                    If txtreason.Text <> "" Then

                        cmd = New SqlCommand("update_spare_issued_before_expiry", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@reason_for_change", txtreason.Text)
                        cmd.Parameters.AddWithValue("@buswise_spare_life_id ", grddetails.Items(i).Cells(9).Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    End If
                Next

                FILLGRID()
            Catch ex As Exception

            End Try
        End Sub
    End Class

End Namespace