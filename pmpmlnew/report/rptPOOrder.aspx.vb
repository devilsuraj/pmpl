Imports System.Data
Imports System.Data.SqlClient

Namespace KDMT

    Partial Class rptPOOrder
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Page.IsPostBack = False Then

                Table1.Visible = False

            End If
        End Sub
        'Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        '    Try




        '        BindGrid(grdstock, con, "VIEW_ITEMISSUE '" & fromdate & "','" & todate & "'")

        '        If grdstock.Items.Count = 0 Then
        '            Response.Write("<script>alert ('Record Not Found') </script>")
        '            Table1.Visible = False
        '        Else
        '            Table1.Visible = True
        '        End If

        '    Catch ex As Exception

        '    End Try
        'End Sub

        Protected Sub Showorder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try

                'Dim fromdate As String = BDPLite1.SelectedDate
                'Dim todate As String = BDPLite2.SelectedDate

                'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                '                BindGrid(grdstock, con, "VIEW_ABC_Summ '" & fromdate & "','" & todate & "'")
                ' BindGrid(grdstock, con, "VIEW_ABC_Summ")

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception

            End Try

        End Sub

    End Class
End Namespace

