Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rpt_all_pendingpo
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
                    'BDPLite1.SelectedDate = Now.Date()
                    'BDPLite2.SelectedDate = Now.Date()
                    Dim i As Integer = 1
                    For i = 1 To 6
                        Dim fin_year As String = GetFinYear(i)
                        ddlfinancecalendar.Items.Add(New ListItem(fin_year, i))
                    Next

                End If
            Catch ex As Exception

            End Try
        End Sub
        Private Sub binddata()
            Try


                BindGrid(grdstock, con, "[view_all_pending_po] '" & txtvendor.Text & "','" & drpType.SelectedValue & "','" & drbPoType.SelectedValue & "','" & ddlfinancecalendar.SelectedItem.Text & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))



            End Select
        End Sub
        Private Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = DateTime.Now.Date
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function

        Protected Sub btn_showpo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_showpo.Click
            binddata()
            strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace