Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class store_updateVendor
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strVendor As String = ""

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            Try

                BindData()
            Catch ex As Exception

            End Try
        End Sub
        Private Sub BindData()
            Try

                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")

                gvCustomers.DataSource = GetDataset("[view_vendors] '" & txtvendor.Value & "' ")
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

        Protected Sub EditCustomer(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvCustomers.RowEditing
            gvCustomers.EditIndex = e.NewEditIndex
            Me.BindData()
        End Sub

        Protected Sub CancelEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvCustomers.RowCancelingEdit
            gvCustomers.EditIndex = -1
            BindData()
        End Sub

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

        Protected Sub UpdateCustomer(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvCustomers.RowUpdating
            Dim vendor As String = gvCustomers.DataKeys(e.RowIndex).Value.ToString()

            Dim vendor_name As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("vendor_name")
            Dim add1 As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("add1")
            Dim add2 As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("add2")
            Dim capital As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("capital")
            Dim contact_no As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("contact_no")
            Dim contact_name As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("contact_name")
            Dim vendor_id As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("vendor_id")


            Dim strConnString As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
            Using con As New SqlConnection(strConnString)
                


                Dim query As String = "update stock_vendor set vendor_name = @vendor_name , add1 = @add1 , add2 = @add2 ,capital = @capital ,contact_name = @contact_name, contact_no = @contact_no  where vendor_id = @vendor_id  "
                Using cmd As New SqlCommand(query)
                    cmd.Connection = con

                    cmd.Parameters.AddWithValue("@vendor_name", vendor_name.Text)
                    cmd.Parameters.AddWithValue("@add1", add1.Text)
                    cmd.Parameters.AddWithValue("@add2", add2.Text)
                    cmd.Parameters.AddWithValue("@capital", capital.Text)
                    cmd.Parameters.AddWithValue("@contact_no", contact_no.Text)
                    cmd.Parameters.AddWithValue("@contact_name", contact_name.Text)
                    cmd.Parameters.AddWithValue("@vendor_id", vendor)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                    Response.Redirect(Request.Url.AbsoluteUri)
                    'BindData()
                    gvCustomers.EditIndex = -1
                    BindData()
                End Using


            End Using
        End Sub
    End Class
End Namespace
