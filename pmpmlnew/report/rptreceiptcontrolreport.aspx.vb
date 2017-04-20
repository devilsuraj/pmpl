Imports System.Data.SqlClient
Imports System.Data
Namespace KDMT
    Partial Class rptreceiptcontrolreport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strvendor As String = ""
        Dim TotalItem As Double = 0

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim i As Integer = 1
                For i = 1 To 6
                    Dim fin_year As String = GetFinYear(i)
                    ddlrecyear.Items.Add(New ListItem(fin_year, i))
                Next
                'If Request.QueryString("potype") Is Nothing Then

                '    bdppodate.SelectedDate = Now.Date

                '    Table1.Visible = False

                'Else
                'Dim potype As String = Request.QueryString("potype")
                'Dim pono As Integer = Request.QueryString("PoNo")
                'Dim poyear As String = Request.QueryString("poyear")
                'Dim category As Integer = Request.QueryString("category")
                'Dim vendor As String = Request.QueryString("vendor")

                'drpType.SelectedValue = category
                'drbPoType.SelectedValue = potype
                'txtPONo.Text = pono
                'ddlfinancecalendar.SelectedItem.Text = poyear
                'txtvendor.Text = vendor.ToString()
                ''bdppodate.SelectedDate = PODATE
                'showdata(category, potype, pono, poyear, vendor)
            End If
            'End If

        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try

                Dim dt As New DataTable
                'Dim fromdate As String = BDPLite1.SelectedDate
                'Dim todate As String = BDPLite2.SelectedDate
                'Label3.Text = "( " + IIf(ddldepttype.SelectedValue = "SP", "Spare Parts", "Hardware") + " )"
                'Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                'Label2.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                dt = GetDatatTable("VIEW_Receipt_Control_report '" & ddlparttype.SelectedValue & "','" & txtrecno.Text & "','" & ddlrecyear.SelectedItem.Text & "'")
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False

                Else
                    For i = 0 To dt.Rows.Count - 1
                        lblSupName.Text = dt.Rows(i).Item("vendor_name")
                        lblBlNo.Text = dt.Rows(i).Item("Bill_No")
                        lblBlDT.Text = dt.Rows(i).Item("Bill_Date")
                        lblChNo.Text = dt.Rows(i).Item("Challan_No")
                        lblChDT.Text = dt.Rows(i).Item("Challan_Date")
                        'If ddldepttype.SelectedValue = "SP" Then
                        '    lblDRBNo.Text = ddldrbtype.SelectedValue + " - " + txtdrbno.Text
                        'Else
                        '    lblDRBNo.Text = txtdrbno.Text
                        'End If
                        lblOrdNo.Text = dt.Rows(i).Item("PO_type") + " " + dt.Rows(i).Item("PO_No")
                        lblOrdDT.Text = dt.Rows(i).Item("PO_Date")
                        lblRecNo.Text = dt.Rows(0).Item("Rec_No")
                        lblRecDate.Text = dt.Rows(0).Item("Rec_Date")
                        'lblPMPLNo.Text = dt.Rows(i).Item("vendor_name")
                        lblSerNo.Text = dt.Rows(i).Item("Store_Id")
                    Next
                    BindGrid(grdstock, con, "VIEW_receipt_Control_Detail '" & ddlparttype.SelectedValue & "','" & txtrecno.Text & "','" & ddlrecyear.SelectedItem.Text & "'")
                    'BindGrid(grdstock, con, "VIEW_cont_receive_report_Print '" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "'")
                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                End If

            Catch ex As Exception
            Finally
                ' strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
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

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            Dim hed As String = "Nilesh Report"
            ExportDataGrid(grdstock)
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
                Case ListItemType.Footer
                    e.Item.Cells(4).Text = "Total : " + TotalItem.ToString()
            End Select
        End Sub
    End Class
End Namespace
