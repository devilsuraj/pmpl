Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rpt_po_status
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim TotalItem As Double = 0
        Dim sql19 As String

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            crydv.Visible = False
            Table1.Visible = True
            Try


                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then

                If BDPLite1.SelectedDate = Now.Date Then
                    Response.Write("<script>alert('Please Select Proper Date');</script>")
                    '                    Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                Else

                    BindGrid(grdstock, con, "[view_po_rctc] '" & fromdate & "' ,'" & todate & "' ")

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        crydv.Visible = False
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnCry0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry0.Click
            ExportDataGrid(grdstock)
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            'Select Case e.Item.ItemType
            '    Case ListItemType.AlternatingItem, ListItemType.Item
            '        e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
            'End Select
            'Select Case e.Item.ItemType
            '    Case ListItemType.AlternatingItem, ListItemType.Item
            '        ''e.Item.Cells(0).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))

            '        TotalItem = TotalItem + CDbl(e.Item.Cells(7).Text)
            '        'TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
            '    Case ListItemType.Footer
            '        e.Item.Cells(7).Text = "Total : " + TotalItem.ToString()   '.TryParse()

            'End Select
        End Sub
    End Class
End Namespace

