Namespace KDMT


    Partial Class rptibc
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strvendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                If Not IsPostBack Then
                    dtibc.SelectedDate = Now.Date()
                    dtibctodate.SelectedDate = Now.Date()
                    Fill_Combo("bank_id", "bank_name", "bank_master", ddlbank, con, "", "select")

                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = ""
                Dim todate As String = ""

                If txtvendor.Value <> "" Then
                    lblvendor.Text = "Vendor Name :  " + "" + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                End If

                If ddlbank.SelectedValue <> 0 Then
                    lblbankname.Text = "Bank : " + ddlbank.SelectedItem.Text
                End If

                If dtibc.SelectedDate <> "#12:00:00 AM#" Then
                    lbldate.Text = "IBC Date : " + dtibc.SelectedDate.ToString("dd/MM/yy")
                    fromdate = dtibc.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If dtibctodate.SelectedDate <> "#12:00:00 AM#" Then
                    lbltodate.Text = "IBC ToDate : " + dtibctodate.SelectedDate.ToString("dd/MM/yy")
                    todate = dtibctodate.SelectedDate.ToString("MM/dd/yyyy")
                End If

                '' lblibcstatus.Text = "IBC Status : " + ddlibc.SelectedItem.Text
                'If dtibc.SelectedDate = "#12:00:00 AM#" Then
                '    BindGrid(grdstock, con, "view_ibc_detail_print '" & txtvendor.Value & "','','" & ddlibc.SelectedValue & "'")


                'Else
                BindGrid(grdstock, con, "view_ibc_detail_print '" & txtvendor.Value & "','" & fromdate.ToString() & "','" & todate.ToString() & "','" & ddlbank.SelectedValue & "','" & ddlibc.SelectedValue & "'")
                ' End If



                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else

                    Table1.Visible = True
                End If
            Catch ex As Exception

            Finally
                clean()
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub

        Private Sub clean()
            dtibc.SelectedDate = "#12:00:00 AM#"
            dtibctodate.SelectedDate = "#12:00:00 AM#"
            txtvendor.Value = ""
            ddlibc.SelectedValue = "9"
            ddlbank.SelectedValue = "0"


        End Sub


    End Class
End Namespace
