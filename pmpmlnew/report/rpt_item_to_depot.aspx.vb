Namespace kdmt
    Partial Class rpt_item_to_depot
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Dim TotalItem As Double = 0

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                ''Call Fill_Combo("cont_id", "cont_name", "contractor_master", DropDownList1, con, "", "Select")
                Table1.Visible = False
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try

                Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & ddlitem.Text & "','" & txtlfno.Text & "','" & txtPartNo.Text & "'")
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                ' Dim CONT As Integer = DropDownList1.SelectedValue
                Dim item As String = ""
                Dim rack_no As String = ""
                Dim subrack_no As String = ""
                Dim part_no As String = ""
                Dim category As String = ""

                Dim dr As SqlClient.SqlDataReader
                Dim strSql As String = "select item_detail.Item_Name,rack_no,subrack_no,part_no,item_master.Item_Name   from item_detail  inner join item_master on item_master.item_id  = item_detail.item_id  where item_code = '" & itemcode & "'"
                con.Open()

                Dim cmd As New SqlClient.SqlCommand(strSql, con)
                dr = cmd.ExecuteReader
                'dr.Read()
                If dr.Read Then
                    item = dr(0)
                    rack_no = dr(1)
                    subrack_no = dr(2)
                    part_no = dr(3)
                    category = dr(4)
                End If

                cmd.Dispose()
                dr.Close()

                lblname.Text = "Nomenclature  : " + item + ""
                lbllf.Text = "Lf No : " + rack_no + """"
                lblbin.Text = "Bin No : " + subrack_no + ""
                lblpart.Text = "Part No : " + part_no + ""
                lblcat.Text = "Category : " + category + ""
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then
                If (ddlitem.Text = "" And txtlfno.Text = "" And txtPartNo.Text = "") Then
                    Response.Write("<script>alert ('Please Select Item')</script>")
                Else
                    BindGrid(grdstock, con, "view_contractorwise_summarry '" & fromdate & "' ,'" & todate & "','0','" & itemcode & "'")
                End If

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If
                'End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    ''e.Item.Cells(0).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))

                    TotalItem = TotalItem + CDbl(e.Item.Cells(2).Text)
                    'TotalItem = TotalItem + CDbl(e.Item.Cells(4).Text)
                Case ListItemType.Footer
                    e.Item.Cells(2).Text = "Total : " + TotalItem.ToString()   '.TryParse()

            End Select
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class

End Namespace
