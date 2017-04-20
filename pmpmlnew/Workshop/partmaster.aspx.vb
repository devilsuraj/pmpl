Imports System.Data.SqlClient
Namespace kdmt
    Partial Class partmaster
        Inherits System.Web.UI.Page
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtCompDate.SelectedDate = Now.Date
                dtWSDate.SelectedDate = Now.Date
                'txtBusNo.Focus()
                Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", ddlPartType, Con)
                'ddlPartType.SelectedValue = "1"
                txtPartCompNo.Focus()


            End If
        End Sub

        'Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click

        '    'Try


        '    '    Dim i As Integer

        '    '    Dim delete As CheckBox

        '    '    For i = 0 To dgresult.Items.Count - 1

        '    '        delete = dgresult.Items(i).Cells(10).FindControl("delete")
        '    '        Dim reject As String = dgresult.Items(i).Cells(9).Text
        '    '        Dim is_reject As Integer
        '    '        If reject = "Yes" Then
        '    '            is_reject = 1
        '    '        Else
        '    '            is_reject = 0
        '    '        End If

        '    '        If delete.Checked Then

        '    '            Call fnExecuteNonQuery("delete_receive_item " & dgresult.Items(i).Cells(0).Text & ",'" & is_reject & "' ")
        '    '        End If



        '    '    Next
        '    '    fillgrid()
        '    'Catch ex As Exception

        '    'End Try
        'End Sub

        'Private Sub fillgrid()
        '    'Try
        '    '    'BindGrid(dgresult, con, "select store_master_detail.store_id,store_detail_id,store_master_detail.item_code,convert(varchar(10),challan_date,103)challan_date,convert(varchar(10),store_master.trans_date,103)trans_date,vendor_name,challan_no,item_name,total_qty,part_no,inward_no,po_no,case reject when 1 then 'Yes' else '' end as reject from   store_master  left outer join stock_vendor on store_master.vendor_id = stock_vendor.vendor_id join store_master_detail on store_master_detail.store_id = store_master.store_id left outer join item_detail on store_master_detail.item_code = item_detail.item_code where  challan_no ='" & txtchallan_no.Text & "'")
        '    '    BindGrid(dgresult, con, "store_detail_id,store_master_detail.item_code,convert(varchar(10),challan_date,103)challan_date,convert(varchar(10),store_master.trans_date,103)trans_date,vendor_name,challan_no,item_name,total_qty,part_no,rate from   store_master  left outer join stock_vendor on store_master.vendor_id = stock_vendor.vendor_id join store_master_detail on store_master_detail.store_id = store_master.store_id left outer join item_detail on store_master_detail.item_code = item_detail.item_code where  challan_no ='" & txtchallan_no.Text & "'")
        '    '    If dgresult.Items.Count > 0 Then
        '    '        trgrid.Visible = True
        '    '        trbtn.Visible = True
        '    '    Else
        '    '        trgrid.Visible = False
        '    '        trbtn.Visible = False
        '    '        Response.Write("<script>alert ('Record Not Found') </script>")
        '    '    End If
        '    'Catch ex As Exception

        '    'End Try
        '    BindGrid(dgresult, con, "select store_detail_id,convert(varchar(10),challan_date,103)challan_date,convert(varchar(10),store_master.trans_date,103)trans_date,vendor_name,challan_no,item_name,total_qty,part_no,rate from   store_master  left outer join stock_vendor on store_master.vendor_id = stock_vendor.vendor_id join store_master_detail on store_master_detail.store_id = store_master.store_id left outer join item_detail on store_master_detail.item_code = item_detail.item_code where  challan_no ='" & txtchallan_no.Text & "'")
        'End Sub

        Private Sub BindData()
            Try

                Dim query As String = "View_Part_Master '" & ddlPartType.SelectedValue & "'"
                Dim cmd As New SqlCommand(query)
                gvCustomers.DataSource = GetData2(cmd)
                gvCustomers.DataBind()
                If gvCustomers.Rows.Count > 0 Then
                    trgrid.Visible = True

                Else
                    trgrid.Visible = False

                    Response.Write("<script>alert ('Record Not Found') </script>")
                End If
            Catch ex As Exception

            End Try
        End Sub
        Private Function GetData2(ByVal cmd As SqlCommand) As DataTable
            Dim strConnString As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
            Using con As New SqlConnection(strConnString)
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    Using dt As New DataTable()
                        sda.Fill(dt)
                        Return dt
                    End Using
                End Using
            End Using
        End Function
       

        Protected Sub EditCustomer(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
            gvCustomers.EditIndex = e.NewEditIndex
            Me.BindData()
        End Sub

        Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
            gvCustomers.EditIndex = -1
            BindData()
        End Sub
        'Protected Sub deletecustomer(ByVal sender As Object, ByVal e As GridViewDeleteEventArgs)
        '    OnRowDeleting = "deletecustomer"
        '    'Dim Serial As String = gvCustomers.DataKeys(e.RowIndex).Value.ToString()

        '    'Dim strConnString As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
        '    'Dim con As New SqlConnection(strConnString)

        '    'con.Open()
        '    'Dim qur = "delete from test where Serial='" & Serial & "'"
        '    'Dim cmd As New SqlCommand(qur, con)
        '    ''com = New oledbCommand("DELETE FROM course WHERE courseID ='" & str & "'", cn)
        '    'cmd.CommandType = CommandType.Text
        '    'cmd.ExecuteNonQuery()
        '    'con.Close()
        '    'BindData()
        '    'Me.call_question_no()

        'End Sub
        Protected Sub UpdateCustomer(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)

            Dim part_id As String = gvCustomers.DataKeys(e.RowIndex).Value.ToString()

            Dim txtbusno As TextBox = gvCustomers.Rows(e.RowIndex).FindControl("txtbusno")

            Dim strConnString As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
            Using con As New SqlConnection(strConnString)
                Dim query As String = "update part_master set Busno=@Busno where Part_ID=@Part_ID"
                Using cmd As New SqlCommand(query)
                    cmd.Connection = con

                    cmd.Parameters.AddWithValue("@Busno", txtbusno.Text)
                    cmd.Parameters.AddWithValue("@Part_ID", part_id)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                    'Response.Redirect(Request.Url.AbsoluteUri)
                    ' BindData()
                    gvCustomers.EditIndex = -1
                    BindData()

                End Using
            End Using
        End Sub

        Protected Sub ddlPartType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPartType.SelectedIndexChanged
            BindData()
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try


                cmd = New SqlCommand("Ins_Part_Master", Con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@Part_ID", 0)
                cmd.Parameters.AddWithValue("@Part_Type", ddlPartType.SelectedValue)
                cmd.Parameters.AddWithValue("@Part_Company_No", txtPartCompNo.Text)
                cmd.Parameters.AddWithValue("@Part_Company ", txtPartComp.Text)
                cmd.Parameters.AddWithValue("@Part_WS_No", txtPartWSNo.Text)
                cmd.Parameters.AddWithValue("@Part_Size", txtPartSize.Text)
                cmd.Parameters.AddWithValue("@Part_Comp_Date", dtCompDate.SelectedDate)
                cmd.Parameters.AddWithValue("@Part_WS_Date", dtWSDate.SelectedDate)
                cmd.Parameters.AddWithValue("@User_ID", Session("Userid"))
                cmd.Parameters.AddWithValue("@type", 0)
                cmd.Parameters.AddWithValue("@TypeB", drptype.SelectedValue)
                cmd.Parameters.AddWithValue("@BusNo", txtbusno.Text)
                cmd.Parameters.AddWithValue("@status", 0)
                cmd.Parameters.AddWithValue("@PartRemark", txtbusno.Text)
                Con.Open()
                cmd.ExecuteNonQuery()
                Con.Close()

                BindData()
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace

