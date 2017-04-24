Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class ibc_closer
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strvendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            If Not IsPostBack Then
                Session("MenuId") = 10
                Try
                    Fill_Combo("bank_id", "bank_name", "bank_master", ddlbank, con, "", "select")
                    'BindGrid(dgresult, con, "view_ibc_detail")

                    ' BindGrid(dgresult, con, "view_ibc_detail_print '','','','0','0'")
                    tblcontain.Visible = False

                Catch ex As Exception

                End Try

            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try


                Dim i As Integer
                Dim Check As CheckBox
                Dim is_delete As Integer = 0
                For i = 0 To dgresult.Items.Count - 1
                    Check = dgresult.Items(i).Cells(17).FindControl("check")
                    If Check.Checked Then

                        Call fnExecuteNonQuery("update_ibc_detail " & dgresult.Items(i).Cells(1).Text & "")
                        is_delete = 1
                    End If
                Next
                'If is_delete = 1 Then
                '    Response.Write("<script>alert('IBC  Deleted ')</script>")
                'End If

                show()

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            show()
        End Sub
        Private Sub show()
            Try
                Dim fromdate As String = ""
                Dim todate As String = ""
                If dtibc.Text <> "#12:00:00 AM#" Then
                    ' lbldate.Text = "IBC Date : " + dtibc.Text.ToString("dd/MM/yy")
                    fromdate = dtibc.Text.ToString("MM/dd/yyyy")
                End If
                If dtibctodate.Text <> "#12:00:00 AM#" Then
                    'lbltodate.Text = "IBC ToDate : " + dtibctodate.Text.ToString("dd/MM/yy")
                    todate = dtibctodate.Text.ToString("MM/dd/yyyy")
                End If

                If txtvendor.Value = "" And ddlbank.SelectedValue = 0 And fromdate.ToString = "" And todate.ToString = "" Then
                    Response.Write("<script>alert ('Please enter search value');window.location.href='ibc_closer.aspx' </script>")
                Else

                    BindGrid(dgresult, con, "view_ibc_detail_print '" & txtvendor.Value & "','" & fromdate.ToString() & "','" & todate.ToString() & "','" & ddlbank.SelectedValue & "','0'")
                    tblcontain.Visible = True
                    ' End If
                    If dgresult.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        tblcontain.Visible = False
                    End If
                End If

            Catch ex As Exception

            Finally
                ''clean()
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub
        Private Sub clean()
            dtibc.Text = "#12:00:00 AM#"
            dtibctodate.Text = "#12:00:00 AM#"
            txtvendor.Value = ""

            ddlbank.SelectedValue = "0"


        End Sub
    End Class
End Namespace