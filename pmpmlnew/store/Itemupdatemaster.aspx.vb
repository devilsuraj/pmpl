Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Itemupdatemaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strVendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10
            If Page.IsPostBack = False Then
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
                'If Cache("Cache_ViewItemList") Is Nothing Then

                '    Cache.Insert("Cache_ViewItemList", GetDataset("[VIEW_Item_List] '" & drpType.SelectedValue & "','" & drbMoveCategory.SelectedValue & "'"))
                'End If
                'Dim ds_itemlist As DataSet
                'ds_itemlist = CType(Cache("Cache_ViewItemList"), DataSet)

                gvCustomers.DataSource = GetDataset("[VIEW_Item_List] '" & drpType.SelectedValue & "','" & drbMoveCategory.SelectedValue & "'") ' GetDataset("[VIEW_Item_List] '" & drpType.SelectedValue & "','" & drbMoveCategory.SelectedValue & "'")
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

        Protected Sub EditCustomer(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
            gvCustomers.EditIndex = e.NewEditIndex
            Me.BindData()
        End Sub

        Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
            gvCustomers.EditIndex = -1
            BindData()
        End Sub

        Protected Sub UpdateCustomer(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)

            Dim po_detail_id As String = gvCustomers.DataKeys(e.RowIndex).Value.ToString()
            Dim Item_Name As Label = gvCustomers.Rows(e.RowIndex).FindControl("lblname")

            Dim Item_code As Label = gvCustomers.Rows(e.RowIndex).FindControl("lblitemcode")

            Dim drbMovingCate As DropDownList = gvCustomers.Rows(e.RowIndex).FindControl("drbMoveCate")
            Dim Storename As DropDownList = gvCustomers.Rows(e.RowIndex).FindControl("drbstoreName")

            Dim txtststus As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("txtstatus")
            Dim strConnString As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
            Using con As New SqlConnection(strConnString)

                If Storename.SelectedValue <> 0 Then
                    fnExecuteNonQuery("UPDATE item_detail set item_id = " & Storename.SelectedValue & " WHERE item_code = " & Item_code.Text & " ")
                End If

                If drbMovingCate.SelectedValue <> 0 Then
                    fnExecuteNonQuery("UPDATE item_detail set Stock_Flag = " & drbMovingCate.SelectedValue & " WHERE item_code = " & Item_code.Text & " ")
                End If

                If txtststus.Text <> "" Then
                    fnExecuteNonQuery("UPDATE item_detail set status = '" & txtststus.Text & "' WHERE item_code = " & Item_code.Text & " ")
                End If


                'If Category.SelectedValue = 2 Then
                '    fnExecuteNonQuery("UPDATE item_detail set Is_Delete = " & Category.SelectedValue & " WHERE item_code = " & Item_code.Text & " ")
                'End If

                BindData()


            End Using
        End Sub



        Protected Sub gvCustomers_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvCustomers.PageIndexChanging
            gvCustomers.PageIndex = e.NewPageIndex
            BindData()


        End Sub
    End Class
End Namespace