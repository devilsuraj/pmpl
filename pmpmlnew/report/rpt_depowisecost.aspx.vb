Namespace KDMT
    Partial Class rpt_depowisecost
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Dim TotalItem As Double = 0
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
            Table1.Visible = True
        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try
                Dim dt As New DataTable
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
               
                BindGrid(grdstock, con, "VIEW_depotwist_cost '" & fromdate & "','" & todate & "'")
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

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
         
        End Sub
    End Class
End Namespace

