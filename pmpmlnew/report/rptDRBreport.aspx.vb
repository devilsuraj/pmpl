Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rptcontractorwisereceive
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Dim TotalItem As Double = 0
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim i As Integer
                For i = 1 To 6
                    Dim fin_year As String = GetFinYear(i)
                    ddlrecyear.Items.Add(New ListItem(fin_year, i))
                Next
                Dim SrNo As String = Request.QueryString("SrNo")
                Dim str_storeid() As String
                If SrNo Is Nothing Then
                    Table1.Visible = False
                Else
                    str_storeid = SrNo.Split("-")
                    'str_storeid = SrNo.ToString.Substring(0, SrNo.ToString.Length - 1)
                    Show(str_storeid(0))

                End If

                If ddldepttype.SelectedValue = "SP" Then
                    ddldrbtype.Items.Clear()
                    ddldrbtype.Items.Add(New ListItem("SP", "SP"))
                    ddldrbtype.Items.Add(New ListItem("OM", "OM"))
                Else
                    ddldrbtype.Items.Clear()
                    ddldrbtype.Items.Add(New ListItem("HW", "HW"))
                    ddldrbtype.Items.Add(New ListItem("STN", "STN"))
                    ddldrbtype.Items.Add(New ListItem("KIT", "KIT"))
                End If

                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                ' strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")

            End If

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
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
            End Select
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    ''e.Item.Cells(0).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))

                    TotalItem = TotalItem + CDbl(e.Item.Cells(6).Text)
                    'TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
                Case ListItemType.Footer
                    e.Item.Cells(6).Text = "Total : " + TotalItem.ToString()   '.TryParse()

            End Select
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim dt As New DataTable
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                Label3.Text = "( " + IIf(ddldepttype.SelectedValue = "SP", "Spare Parts", "Hardware") + " )"
                Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                Label2.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                dt = GetDatatTable("VIEW_DRB_report '" & ddldepttype.SelectedValue & "','" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "', '" & ddlrecyear.SelectedItem.Text & "'")
                For i = 0 To dt.Rows.Count - 1
                    lblSupName.Text = dt.Rows(i).Item("vendor_name")
                    lblBlNo.Text = dt.Rows(i).Item("Bill_No")

                    lblBlDT.Text = dt.Rows(i).Item("Bill_Date")
                    lblChNo.Text = dt.Rows(i).Item("Challan_No")
                    lblChDT.Text = dt.Rows(i).Item("Challan_Date")
                    If ddldepttype.SelectedValue = "SP" Then
                        If ddldrbtype.SelectedValue = "SP" Then
                            lblDRBNo.Text = "Tata/" + ddldrbtype.SelectedValue + " - " + txtdrbno.Text
                        Else
                            lblDRBNo.Text = "Leyland/" + ddldrbtype.SelectedValue + " - " + txtdrbno.Text

                        End If

                    Else
                        lblDRBNo.Text = ddldrbtype.SelectedValue + " - " + txtdrbno.Text
                    End If

                    lbldrbdate.Text = "DRB Date :" + dt.Rows(0).Item("drb_date")
                    lblOrdNo.Text = dt.Rows(i).Item("PO_type") + " " + dt.Rows(i).Item("PO_No")
                    lblOrdDT.Text = dt.Rows(i).Item("PO_Date")
                    lblRecNo.Text = dt.Rows(0).Item("Rec_No")
                    lblRecDate.Text = dt.Rows(0).Item("Rec_Date")
                    'lblPMPLNo.Text = dt.Rows(i).Item("vendor_name")
                    ' lblSerNo.Text = dt.Rows(i).Item("Store_Id")
                Next
                BindGrid(grdstock, con, "VIEW_cont_receive_report '" & ddldepttype.SelectedValue & "','" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "', '" & ddlrecyear.SelectedItem.Text & "'")
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

        Private Sub Show(ByVal SrNo As String)
            Try
                Dim dt As New DataTable
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                Dim ds As DataSet = GetDataset("VIEW_cont_receive_report_Print '" & SrNo & "'")
                grdstock.DataSource = ds.Tables(0)
                grdstock.DataBind()

                Label2.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                dt = GetDatatTable("VIEW_DRB_report_Print '" & SrNo & "'")

                lblSupName.Text = dt.Rows(0).Item("vendor_name")
                lblBlNo.Text = dt.Rows(0).Item("Bill_No")
                lblBlDT.Text = dt.Rows(0).Item("Bill_Date")
                lblChNo.Text = dt.Rows(0).Item("Challan_No")
                lblChDT.Text = dt.Rows(0).Item("Challan_Date")
                Dim drbtype As String = ds.Tables(1).Rows(0).Item("sub_part_type").ToString()
                Dim drbno As String = ds.Tables(1).Rows(0).Item("sub_invert_no").ToString()
                If ds.Tables(1).Rows(0).Item("sub_part_type") = "sp" Then

                    If drbtype = "sp" Then
                        lblDRBNo.Text = "Tata/" + drbtype.ToString() + " - " + drbno.ToString()
                    Else
                        lblDRBNo.Text = "Leyland/" + drbtype.ToString() + " - " + drbno.ToString()

                    End If

                    '' lblDRBNo.Text = drbtype.ToString() + " - " + drbno.ToString()
                Else
                    lblDRBNo.Text = drbtype.ToString() + " - " + drbno.ToString()
                    'Dim drbtype As String = ds.Tables(1).Rows(0).Item("sub_part_type").ToString()
                End If

                lbldrbdate.Text = "DRB Date :" + dt.Rows(0).Item("drb_date")
                Label3.Text = "( " + IIf(ds.Tables(1).Rows(0).Item("part_type") = "sp", "Spare Parts", "Hardware") + " )"
                lblOrdNo.Text = dt.Rows(0).Item("PO_type") + " " + dt.Rows(0).Item("PO_No")
                lblOrdDT.Text = dt.Rows(0).Item("PO_Date")
                lblRecNo.Text = dt.Rows(0).Item("Rec_No")
                lblRecDate.Text = dt.Rows(0).Item("Rec_Date")
                'lblSerNo.Text = dt.Rows(0).Item("Store_Id")

                ' BindGrid(grdstock, con, "VIEW_cont_receive_report_Print '" & SrNo & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If
                '  Response.Write("<script>window.print();</script>")
                'Response.Write("<script>window.print(); window.location.href='../store/storemasterold.aspx'</script>")
            Catch ex As Exception
            Finally
                'strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        End Sub

        Protected Sub ddldepttype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddldepttype.SelectedIndexChanged
            If ddldepttype.SelectedValue = "SP" Then
                ddldrbtype.Items.Clear()
                ddldrbtype.Items.Add(New ListItem("SP", "SP"))
                ddldrbtype.Items.Add(New ListItem("OM", "OM"))
            Else
                ddldrbtype.Items.Clear()

                ddldrbtype.Items.Add(New ListItem("HW", "HW"))
                ddldrbtype.Items.Add(New ListItem("STN", "STN"))
                ddldrbtype.Items.Add(New ListItem("KIT", "KIT"))
            End If
        End Sub
    End Class
End Namespace

