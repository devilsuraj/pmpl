Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rpt_po_by_date
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strVendor As String = ""
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                If txtvendor.Value = "" & txtPONofrom.Text = "" & txtPONoto.Text = "" & bdppodatefrom.SelectedDate = "" & bdppodateto.SelectedDate = "" & drbPoType.SelectedValue = "RC" & drpType.SelectedValue = "All" Then

                    Response.Write("<script>alert ('Plese Select and Enter Proper Information') </script>")
                    Table1.Visible = False
                Else
                    lblcategory.Text = "Category  : " + drpType.SelectedItem.Text
                    lbldate.Text = "Date  : " + bdppodatefrom.SelectedDate.ToString("dd/MM/yy")
                    lblVendor.Text = "Vendor  : " + txtvendor.Value
                    lblpotype.Text = "PO NO  : " + drbPoType.SelectedItem.Text + "  " + txtPONofrom.Text
                    'lblpono.Text = "PO No  : " + txtPONo.Text
                    'If drbPoType.SelectedItem.Text = "T&C" Then

                    BindGrid(grdstock, con, "[view_all_po_order] '" & txtvendor.Value & "', '" & drbPoType.SelectedValue & "' ,,'" & drpType.SelectedValue & "' '" & txtPONofrom.Text & "' , '" & txtPONoto.Text & "','" & bdppodatefrom.SelectedDate & "','" & bdppodateto.SelectedDate & "' ")
                    ' & bdppodate.SelectedDate & "','" & txtvendor.Value & "','" & drpType.SelectedItem.Text & "','T','" & txtPONo.Text & "'")
                    '   Else
                    ' BindGrid(grdstock, con, "[view_SINGLE_pending_po] '" & bdppodate.SelectedDate & "','" & txtvendor.Value & "','" & drpType.SelectedItem.Text & "','" & drbPoType.SelectedItem.Text & "','" & txtPONo.Text & "'")
                    '      End If

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace
