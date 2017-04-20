Namespace KDMT
    Partial Class rpt_Depotwiseitemissuedetails
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String

        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Table1.Visible = True
        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try
                Dim dt As New DataTable
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                Dim str As String = drbType.SelectedItem.ToString()
                BindGrid(grdstock, con, "VIEW_depotwist_itemcost '" & fromdate & "','" & todate & "','" & str & "'")
                lblfromdate.Text = fromdate
                lbltodate.Text = todate
                'BindGrid(grdstock, con, "VIEW_cont_receive_report_Print '" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception
            Finally
                ' strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace
