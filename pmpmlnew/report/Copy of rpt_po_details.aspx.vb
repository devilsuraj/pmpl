Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rpt_po_details
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strVendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                If Not IsPostBack Then
                    strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                    Dim PODATE As String = Request.QueryString("podate")
                    Dim Vendor_name As String = Request.QueryString("Vendor_name")
                    Dim category As String = Request.QueryString("category")
                    Dim po_TYPE As String = Request.QueryString("po_TYPE")
                    Dim po_no As String = Request.QueryString("po_no")

                    lblcategory.Text = "Category  : " + category.ToString
                    lbldate.Text = "Date  : " + Format(Convert.ToDateTime(PODATE), "dd/MM/yy")
                    lblVendor.Text = "Vendor  : " + Vendor_name.ToString
                    If po_TYPE.ToString = "T" Then
                        lblpotype.Text = "PO No  : " + "T&C" + "  " + po_no.ToString
                    Else
                        lblpotype.Text = "PO No  : " + po_TYPE.ToString + "  " + po_no.ToString
                    End If

                    ' lblpono.Text = "PO No  : " + po_no.ToString

                    BindGrid(grdstock, con, "[view_SINGLE_pending_po] '" & PODATE & "','" & Vendor_name & "','" & category & "','" & po_TYPE & "','" & po_no & "'")
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


        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
            End Select
        End Sub


        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                If txtPONo.Text = "" Then
                    Response.Write("<script>alert ('Plese Select and Enter Proper Information') </script>")
                    Table1.Visible = False
                Else
                    lblcategory.Text = "Category  : " + drpType.SelectedItem.Text
                    lbldate.Text = "Date  : " + bdppodate.SelectedDate.ToString("dd/MM/yy")
                    lblVendor.Text = "Vendor  : " + txtvendor.Value
                    lblpotype.Text = "PO NO  : " + drbPoType.SelectedItem.Text + "  " + txtPONo.Text
                    'lblpono.Text = "PO No  : " + txtPONo.Text
                    If drbPoType.SelectedItem.Text = "T&C" Then

                        BindGrid(grdstock, con, "[view_SINGLE_pending_po] '" & bdppodate.SelectedDate & "','" & txtvendor.Value & "','" & drpType.SelectedItem.Text & "','T','" & txtPONo.Text & "'")
                    Else
                        BindGrid(grdstock, con, "[view_SINGLE_pending_po] '" & bdppodate.SelectedDate & "','" & txtvendor.Value & "','" & drpType.SelectedItem.Text & "','" & drbPoType.SelectedItem.Text & "','" & txtPONo.Text & "'")
                    End If

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
            'Response.Redirect("excelvehiclewise.aspx?fromdate=" & BDPLite1.SelectedDate & " &todate= " & BDPLite2.SelectedDate & " &veh_no= " & txtbusno.Text & " ")
        End Sub
    End Class
End Namespace
