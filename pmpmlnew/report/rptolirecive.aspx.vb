Namespace KDMT
    Partial Class report_rptolirecive
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim i As Integer = 1
                For i = 1 To 5
                    Dim fin_year As String = GetFinYear(i)
                    ddlrecyear.Items.Add(New ListItem(fin_year, i))
                Next
            End If

        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try

                Dim dt As New DataTable
               
                dt = GetDatatTable("VIEW_Receipt_Control_oil_report '" & txtrecno.Text & "','" & ddlrecyear.SelectedItem.Text & "'")
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False

                Else
                    For i = 0 To dt.Rows.Count - 1
                        lblSupName.Text = dt.Rows(i).Item("vendor_name")
                        'lblBlNo.Text = dt.Rows(i).Item("Bill_No")
                        'lblBlDT.Text = dt.Rows(i).Item("Bill_Date")
                        lblChNo.Text = dt.Rows(i).Item("Challan_No")
                        lblChDT.Text = dt.Rows(i).Item("Challan_Date")
                      
                        lblOrdNo.Text = dt.Rows(i).Item("PONo")
                        lblOrdDT.Text = dt.Rows(i).Item("PO_Date")
                        lblRecNo.Text = dt.Rows(0).Item("RecNo")
                        lblRecDate.Text = dt.Rows(i).Item("RecDate")
                        ' lblSerNo.Text = dt.Rows(i).Item("oilrecmstid")
                    Next
                    BindGrid(grdstock, con, "VIEW_receipt_Control_oil_Detail '" & txtrecno.Text & "','" & ddlrecyear.SelectedItem.Text & "'")

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                End If

            Catch ex As Exception
            Finally

            End Try
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
    End Class
End Namespace
