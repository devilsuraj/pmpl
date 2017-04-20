Imports System.Data.SqlClient
Namespace kdmt
    Partial Class Indentrequestwithoutjobcard
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dt As New DataTable
        Dim dt1 As New DataTable
        Dim jobno As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not IsPostBack Then
                Try
                    btnadd.Attributes.Add("Onclick", "ValidateSave();")
                    btnaddandsave.Attributes.Add("Onclick", "ValidateSave();")

                    dtIndentDate.SelectedDate = Now.Date
                    lblindent.Text = ExecuteQuery("getinentno '" & dtIndentDate.SelectedDate & "' ")

                    dtIndentDate.Focus()
                Catch ex As Exception

                End Try

                'Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", ddlDefectType, Con)
                'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
            End If
        End Sub
        Protected Sub btnadd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnadd.Click
            addrecords()
        End Sub

        Protected Sub grddetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddetails.ItemDataBound
            If e.Item.Cells(3).Text = jobno.ToString Then
                e.Item.Cells(3).Text = ""
                e.Item.Cells(4).Text = ""

            Else
                jobno = e.Item.Cells(3).Text

            End If
        End Sub
        Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
            save()
        End Sub

        Protected Sub btnaddandsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnaddandsave.Click
            addrecords()
            save()
        End Sub
        Private Sub addrecords()
            Try
                dt.Columns.Add("sr")
                dt.Columns.Add("busno")
                dt.Columns.Add("partno")
                dt.Columns.Add("itemname")
                dt.Columns.Add("avbqty")
                dt.Columns.Add("reqqty")


                dt1.Columns.Add("sr")
                dt1.Columns.Add("busno")
                dt1.Columns.Add("partno")
                dt1.Columns.Add("itemname")
                dt1.Columns.Add("avbqty")
                dt1.Columns.Add("reqqty")
                Dim dr As DataRow
                dr = dt.NewRow
                Dim dr1 As DataRow
                dr1 = dt1.NewRow
                Dim i As Integer = 0
                Dim b As Integer = 1
                Dim str As String = String.Empty
                Dim j As Integer = 0
                Dim b1 As Integer = 1
                Dim presenent As String = ""


                If grddetails.Items.Count > 0 Then
                    dt1.Rows.Clear()
                    b1 = 1

                    For j = 0 To grddetails.Items.Count - 1
                        dt1.Rows.Add(b1, grddetails.Items(j).Cells(1).Text, grddetails.Items(j).Cells(2).Text, grddetails.Items(j).Cells(3).Text, grddetails.Items(j).Cells(4).Text, grddetails.Items(j).Cells(5).Text)
                        b1 = b1 + 1
                    Next

                    Dim myarray As Array = Split(Hid_Rec.Value, "|")
                    Dim k As Integer

                    b = b1
                    For i = 0 To myarray.Length - 2
                        Dim mainarray As Array = Split(myarray(i), "^")
                        dt1.Rows.Add(b, mainarray(0), mainarray(1), mainarray(2), mainarray(3), mainarray(4))
                        b = b + 1
                    Next
                Else
                    Dim myarray As Array = Split(Hid_Rec.Value, "|")
                    Dim k As Integer

                    b = b1
                    For i = 0 To myarray.Length - 2
                        Dim mainarray As Array = Split(myarray(i), "^")
                        dt1.Rows.Add(b, mainarray(0), mainarray(1), mainarray(2), mainarray(3), mainarray(4))
                        b = b + 1
                    Next

                End If


                grddetails.DataSource = dt1
                grddetails.DataBind()
                If dt1.Rows.Count > 0 Then
                    trsave.Visible = True

                Else
                    trsave.Visible = False
                End If

                Hid_Rec.Value = ""
            Catch ex As Exception

            End Try
        End Sub
        Private Sub save()
            Try

                lblindent.Text = ExecuteQuery("getinentno '" & dtIndentDate.SelectedDate & "' ")

                cmd = New SqlCommand
                ds = New DataSet
                DA = New SqlDataAdapter
                cmd.Connection = Con
                cmd.CommandType = CommandType.StoredProcedure
                Dim i As Integer

                cmd = New SqlCommand("ins_indent_request_master", Con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@Indent_No", lblindent.Text)
                cmd.Parameters.AddWithValue("@Indent_Date", dtIndentDate.SelectedDate)
                cmd.Parameters.AddWithValue("@Indent_Approve_By", txtapprovedby.Text)
                cmd.Parameters.AddWithValue("@Indent_Remark", txtremark.Text)
                cmd.Parameters.AddWithValue("@is_job", 0)

                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)


                Con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                Con.Close()

                For j = 0 To grddetails.Items.Count - 1

                    Dim jobno As Array = Split(grddetails.Items(j).Cells(1).Text, "/")
                    Dim code As String = ExecuteQuery("select item_code from item_detail where part_no = '" & grddetails.Items(j).Cells(2).Text.Replace("&nbsp;", "") & "'  and  item_name  = '" & grddetails.Items(j).Cells(3).Text & "'")

                    cmd = New SqlCommand("ins_Indent_Request_Details", Con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@Indent_Master_ID", maxid)
                    cmd.Parameters.AddWithValue("@jobcard", 0)
                    cmd.Parameters.AddWithValue("@jobcardno", 0)
                    cmd.Parameters.AddWithValue("@Indent_Item_code", code)
                    cmd.Parameters.AddWithValue("@Indent_Bus_No", grddetails.Items(j).Cells(1).Text)
                    cmd.Parameters.AddWithValue("@Indent_avb_Qty", grddetails.Items(j).Cells(4).Text)
                    cmd.Parameters.AddWithValue("@Indent_Req_Qty", grddetails.Items(j).Cells(5).Text)


                    Con.Open()
                    cmd.ExecuteNonQuery()
                    Con.Close()
                    cmd.Parameters.Clear()

                    If (Decimal.Parse(grddetails.Items(j).Cells(5).Text) = 0) Then

                        cmd = New SqlCommand("ins_pending_indent", Con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@indent_master_id", maxid)
                        cmd.Parameters.AddWithValue("@ind_itemcode", code)
                        cmd.Parameters.AddWithValue("@avbqty", grddetails.Items(j).Cells(4).Text)
                        cmd.Parameters.AddWithValue("@req_qty", grddetails.Items(j).Cells(5).Text)
                        cmd.Parameters.AddWithValue("@isclose", 0)
                        cmd.Parameters.AddWithValue("@closereason", "")
                        Con.Open()
                        cmd.ExecuteNonQuery()
                        Con.Close()
                    End If
                Next

                Response.Write("<script>alert('Saved Successfuly');window.location.href='Indentrequestwithoutjobcard.aspx'</script>")

            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace