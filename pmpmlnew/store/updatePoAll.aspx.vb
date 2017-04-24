Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT

    Partial Class updatePoAll
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Session("MenuId") = 10
                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                ' btnSubmit.Attributes.Add("Onclick", "return validate ()")
                'trgrid.Visible = False
                trbtn.Visible = False
                'Me.BDPLite1.SelectedDate = Now.Date

            End If
        End Sub

        Private Sub BindData()
            Try

                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")

                gvCustomers.DataSource = GetDataset("[view_SINGLE_pending_po] '" & bdppodate.SelectedDate & "','" & txtvendor.Value & "','" & drpType.SelectedValue & "','" & drbPoType.SelectedValue & "','" & txtPONo.Text & "'")
                gvCustomers.DataBind()

                If gvCustomers.Rows.Count > 0 Then
                    trgrid.Visible = True
                    trbtn.Visible = True
                Else
                    trgrid.Visible = False
                    trbtn.Visible = False
                    Response.Write("<script>alert ('Record Not Found') </script>")
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            Try

                BindData()
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub EditCustomer(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvCustomers.RowEditing
            gvCustomers.EditIndex = e.NewEditIndex
            Me.BindData()
        End Sub

        Protected Sub UpdateCustomer(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvCustomers.RowUpdating
            Dim po_detail_id As String = gvCustomers.DataKeys(e.RowIndex).Value.ToString()

            Dim item_code As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("item_code")
            Dim item_qty As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("item_qty")
            Dim item_rate As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("item_rate")
            Dim item_amt As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("TextBox4")
            Dim po_flag As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("po_flag")
            Dim base_rate As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("base_rate")
            Dim pen_qty As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("TextBox3")



            Dim strConnString As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
            Using con As New SqlConnection(strConnString)
                If pen_qty.Text = 0 Then

                    fnExecuteNonQuery("update po_details set item_code = " & item_code.Text & "  , item_qty = " & item_qty.Text & " , item_rate = " & item_rate.Text & " ,item_amt = " & item_amt.Text & "  , pen_qty = " & pen_qty.Text & " , po_flag = " & po_flag.Text & "  where po_detail_id =" & po_detail_id & "  ")

                    fnExecuteNonQuery("update po_details set  po_flag = 1   where po_detail_id =" & po_detail_id & " ")
                    Response.Redirect(Request.Url.AbsoluteUri)
                    gvCustomers.EditIndex = -1
                    BindData()
                Else


                    Dim query As String = "update po_details set  item_code = @item_code  , item_qty = @item_qty , item_rate = @item_rate ,item_amt = @item_amt , pen_qty = @pen_qty,po_flag = @po_flag  where po_detail_id =@po_detail_id  "
                    Using cmd As New SqlCommand(query)
                        cmd.Connection = con
                        cmd.Parameters.AddWithValue("@item_code", item_code.Text)
                        cmd.Parameters.AddWithValue("@item_qty", item_qty.Text)
                        cmd.Parameters.AddWithValue("@item_rate", item_rate.Text)
                        cmd.Parameters.AddWithValue("@item_amt", item_amt.Text)
                        cmd.Parameters.AddWithValue("@pen_qty", pen_qty.Text)

                        cmd.Parameters.AddWithValue("@po_flag", po_flag.Text)
                        cmd.Parameters.AddWithValue("@base_rate", base_rate.Text)
                        cmd.Parameters.AddWithValue("@po_detail_id", po_detail_id)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                        Response.Redirect(Request.Url.AbsoluteUri)
                        gvCustomers.EditIndex = -1
                        BindData()
                    End Using
                End If
            End Using

        End Sub


        Protected Sub CancelEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvCustomers.RowCancelingEdit
            gvCustomers.EditIndex = -1
            BindData()
        End Sub
    End Class
End Namespace

