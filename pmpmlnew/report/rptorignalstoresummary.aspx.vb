Namespace KDMT
    Partial Class rptorignalstoresummary
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim qry As String
        Dim da As SqlClient.SqlDataAdapter
        Dim r1, r2, r3, r4 As Decimal
        Public stritemname As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                stritemname = getAutoCompleteList("select item_name  from item_detail order by item_name", "item_name")
                BDPLite1.SelectedDate = Now.Date
                BDPLite2.SelectedDate = Now.Date
                Table1.Visible = False

            End If
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Dim j As Integer
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    r3 = Val(Label2.Text)
                    ''If e.Item.Cells(4).Text <> "&nbsp;" Then
                    e.Item.Cells(4).Text = e.Item.Cells(4).Text
                    e.Item.Cells(12).Text = e.Item.Cells(12).Text
                    e.Item.Cells(13).Text = e.Item.Cells(13).Text
                    r4 = r4 + e.Item.Cells(13).Text
                    r1 = r1 + e.Item.Cells(4).Text
                    r2 = r2 + e.Item.Cells(12).Text
                Case ListItemType.Footer

                    j = 2
                    e.Item.Cells(12).Attributes.Add("align", "center")
                    e.Item.Cells(12).Text = r2
                    e.Item.Cells(4).Text = r1

            End Select
            e.Item.Cells(13).Text = r3 + r1 - r2
            e.Item.Cells(5).Text = r3 + r1

            Dim i As Integer

            i = 0
            i = i + 1
            If r3 = 0 And r1 = 0 And r2 = 0 Then
                If i = 1 Then
                    e.Item.Cells(13).Text = "Balance"
                    'j = i + 1
                End If
                If j = 2 Then
                    e.Item.Cells(13).Text = Label2.Text
                End If

                e.Item.Cells(5).Text = "Total"
            End If
            If e.Item.Cells(12).Text = "0" Then
                e.Item.Cells(8).Text = ""
            End If
            If e.Item.Cells(4).Text = "0" Then
                e.Item.Cells(1).Text = ""
            End If
            'End If


        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Dim item As String = ddlitem.Text
            con.Open()
            cmd = New SqlClient.SqlCommand
            ds = New DataSet
            cmd.Connection = con
            ' qry = "select  isnull(sum (cast(total_qty as numeric)),0) as quant   from store_master_detail inner join store_master on store_master.store_id = store_master_detail.store_id left outer join item_detail on item_detail.item_code = store_master_detail.item_code where store_master.trans_date < '" & fromdate & "'  and item_detail.item_name = '" & item & "'"
            da = New SqlClient.SqlDataAdapter("view_available_quant '" & fromdate & "','" & item & "','" & txtlfno.Text & "','" & txtPartNo.Text & "'", con)
            da.Fill(ds, "tblEmp")
            Me.Label2.Text = ds.Tables("tblEmp").Rows(0).Item("quantity").ToString
            con.Close()
            Label5.Text = item
            lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
            lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
            'lblfrom.Text = Format(Convert.ToDateTime(fromdate))
            'lbltodate.Text = Format(Convert.ToDateTime(todate))
            BindGrid(grdstock, con, "view_store_orignal '" & fromdate & "','" & todate & "','" & item & "','" & txtlfno.Text & "','" & txtPartNo.Text & "'")
            Table1.Visible = True
            'BindGrid(grdstock, con, "VIEW_ITEMISSUE '" & fromdate & "','" & todate & "'")
        End Sub
        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace
