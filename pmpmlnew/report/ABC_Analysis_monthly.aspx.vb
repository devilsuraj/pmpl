Namespace KDMT
    Partial Class report_ABC_Analysis_monthly
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim TotalCon As Double = 0
        Dim TotalItem As Double = 0
        Dim itemcount As Integer = 0

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Table1.Visible = False
            End If
        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                btnexcel.Visible = True
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "MM/dd/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "MM/dd/yy")
                BindGrid(grdstock, con, "ABC_valuation_monthly '" & fromdate & "','" & todate & "' , '" & drpType.SelectedValue & "' , 0 ")
                'BindGrid(grdstock, con, "VIEW_ABC_Summ " & drpType.SelectedValue & "")

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdstock_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdstock.ItemCommand
            Dim Total As Integer = 0
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Dim lnk As LinkButton = CType(e.Item.FindControl("lnkClass"), LinkButton)
            If Not IsNothing(lnk) Then
                lnk.Text = e.Item.Cells(0).Text
                lnk.Attributes.Add("href", "../report/rptABCmonthly.aspx?Cls=" & e.Item.Cells(0).Text & "&FDate=" & BDPLite1.SelectedDate & "&TDate=" & BDPLite2.SelectedDate & "&drbtext=" & drpType.SelectedItem.Text & "&drpType=" & drpType.SelectedValue)
            End If


            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    ''e.Item.Cells(0).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
                    itemcount = itemcount + Val(e.Item.Cells(2).Text)
                    TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
                    'TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
                    TotalCon = TotalCon + CDbl(e.Item.Cells(5).Text)

                Case ListItemType.Footer
                    'Use the footer to display the summary row.
                    e.Item.Cells(2).Text = itemcount
                    e.Item.Cells(4).Text = TotalItem
                    e.Item.Cells(5).Text = TotalCon
                    lblACRange.Text = TotalItem

                    lbltotalitems.Text = itemcount
            End Select
        End Sub

        Protected Sub btnexcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnexcel.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace

