Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rejectitem
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public currenedate

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                btnSubmit.Attributes.Add("Onclick", "return validate ()")

                'If txtchallan_no.Text <> "" Then
                '    fillgrid()
                'End If
                trgrid.Visible = False
                trbtn.Visible = False

            Catch ex As Exception

            End Try
        End Sub


        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try


                Dim i As Integer

                Dim reject As CheckBox
                Dim txtqty As TextBox
                Dim rejectdate As BasicFrame.WebControls.BDPLite
                Dim gatepassno As TextBox

                For i = 0 To dgresult.Items.Count - 1

                    reject = dgresult.Items(i).Cells(11).FindControl("reject")
                    txtqty = dgresult.Items(i).Cells(5).FindControl("txtqty")

                    rejectdate = CType(dgresult.Items(i).Cells(6).FindControl("bdpreject"), BasicFrame.WebControls.BDPLite)

                    gatepassno = dgresult.Items(i).Cells(7).FindControl("txtgate")
                    If reject.Checked Then

                        Dim actqty As Decimal = dgresult.Items(i).Cells(12).Text
                        If txtqty.Text > actqty Then

                            Response.Write("<script>alert('Quantity Should be less than Or Equal to previous Quantity')</script>")
                            fillgrid()
                        Else


                            Dim avb_qty As Decimal
                            avb_qty = ExecuteQuery("select total_stock  from dbo.stock_master  where item_code = '" & dgresult.Items(i).Cells(1).Text & "'")

                            cmd = New SqlCommand("Ins_storereject", con)
                            cmd.CommandType = CommandType.StoredProcedure

                            cmd.Parameters.AddWithValue("@trans_date ", rejectdate.SelectedDate)
                            cmd.Parameters.AddWithValue("@userid ", Session("UserId"))
                            cmd.Parameters.AddWithValue("@loc_id ", Session("LocID"))
                            cmd.Parameters.AddWithValue("@getpassno ", gatepassno.Text)


                            cmd.Parameters.AddWithValue("@prestore_id ", dgresult.Items(i).Cells(0).Text)
                            cmd.Parameters.AddWithValue("@available_qty ", avb_qty)
                            cmd.Parameters.AddWithValue("@item_code", dgresult.Items(i).Cells(1).Text)
                            cmd.Parameters.AddWithValue("@quantity", txtqty.Text)


                            con.Open()
                            cmd.ExecuteNonQuery()
                            Response.Write("<script>alert('Successfuly Rejected')</script>")
                            con.Close()
                        End If
                    End If
                Next

              

            Catch ex As Exception

            Finally

            End Try
        End Sub
        Private Sub fillgrid()
            Try
                BindGrid(dgresult, con, "select store_master_detail.store_id,store_detail_id,store_master_detail.item_code,convert(varchar(10),challan_date,103)challan_date,convert(varchar(10),store_master.trans_date,103)trans_date,vendor_name,challan_no,item_name,total_qty,part_no,inward_no,po_no from   store_master  left outer join stock_vendor on store_master.vendor_id = stock_vendor.vendor_id join store_master_detail on store_master_detail.store_id = store_master.store_id left outer join item_detail on store_master_detail.item_code = item_detail.item_code where reject <> 1 and  challan_no ='" & txtchallan_no.Text & "'  and store_master_detail.item_code not in (select store_master_detail.item_code  from store_master join store_master_detail on store_master_detail.store_id = store_master.store_id  where reject = 1 and challan_no = '" & txtchallan_no.Text & "')")
                trgrid.Visible = True
                trbtn.Visible = True
            Catch ex As Exception

            End Try

        End Sub

        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then


                Dim bdplite As BasicFrame.WebControls.BDPLite
                bdplite = CType(e.Item.FindControl("bdpreject"), BasicFrame.WebControls.BDPLite)
                bdplite.SelectedDate = Now.Date()

                ' bdplite.Attributes.Add("Onblur", "getdate('" & bdplite.ClientID & "');")
            End If
        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            Try

                fillgrid()


            Catch ex As Exception

            End Try
        End Sub

  
    End Class
End Namespace
