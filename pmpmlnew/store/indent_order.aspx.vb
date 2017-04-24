Imports System.Data.SqlClient

Namespace KDMT
    Partial Class indent_order
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strVendor As String = ""
        Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
            strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            If Page.IsPostBack = False Then
                Try
                    Session("MenuId") = 10
                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    If Session("LocID").ToString <> "" Then
                        ddlrefno.Focus()

                        Dim cmd As SqlCommand
                        Dim sql As String = "select distinct(refno),indent_request.refno from indent_request  inner join indent_request_detail on indent_request_detail.requestvendor_id = indent_request.requestvendor_id where status <> 1 order by indent_request.refno"
                        Dim dr As SqlDataReader

                        cmd = New SqlCommand(sql, Con)
                        Con.Open()
                        dr = cmd.ExecuteReader()
                        ddlrefno.DataTextField = "refno"
                        ddlrefno.DataValueField = "refno"
                        ddlrefno.DataSource = dr
                        ddlrefno.DataBind()
                        Con.Close()
                        'dropdownlist.Items.Insert(0, "select");

                        ddlrefno.Items.Insert(0, New ListItem("Select", "0"))
                        show()
                    Else
                        Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                    End If
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If
        End Sub
        Protected Sub ddlrefno_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlrefno.SelectedIndexChanged
            ' BindGrid(dgresult, Con, "view_indent_request " & ddlrefno.SelectedValue & "")

            Dim dtindent As DataTable = GetDatatTable("view_indent_request " & ddlrefno.SelectedValue & "")
            Dim tr As HtmlTableRow
            Dim td As HtmlTableCell
            Dim i As Integer
            hdncount.Value = dtindent.Rows.Count
            For i = 0 To dtindent.Rows.Count - 1

                tr = New HtmlTableRow

                td = New HtmlTableCell
                td.InnerHtml = "<input id ='hdnreqvendor_detail_id" & i & "' name ='hdnreqvendor_detail_id" & i & "'  type='hidden' value= '" + dtindent.Rows(i).Item("reqvendor_detail_id").ToString + "'/>"
                td.Style.Add("display", "none")
                tr.Cells.Add(td)

                td = New HtmlTableCell
                td.InnerHtml = "<input id ='hdnitem_code" & i & "' name ='hdnitem_code" & i & "'  type='hidden' value= '" + dtindent.Rows(i).Item("item_code").ToString + "'/>"
                td.Style.Add("display", "none")
                tr.Cells.Add(td)

                td = New HtmlTableCell
                td.InnerHtml = dtindent.Rows(i).Item("trans_date").ToString
                tr.Cells.Add(td)


                td = New HtmlTableCell
                td.InnerHtml = dtindent.Rows(i).Item("rack_no").ToString
                tr.Cells.Add(td)



                td = New HtmlTableCell
                td.InnerHtml = dtindent.Rows(i).Item("item_name").ToString
                tr.Cells.Add(td)


                td = New HtmlTableCell
                td.InnerHtml = dtindent.Rows(i).Item("part_no").ToString
                tr.Cells.Add(td)



                td = New HtmlTableCell
                td.InnerHtml = "<span  id ='lblreq_qty" & i & "' name ='lblreq_qty" & i & "' >" + dtindent.Rows(i).Item("req_qty").ToString + "</span>"
                tr.Cells.Add(td)

                td = New HtmlTableCell
                td.InnerHtml = "<span style='color:Green' id ='lblrem_qty" & i & "' name ='lblrem_qty" & i & "' >" + dtindent.Rows(i).Item("remain_qty").ToString + "</span>"
                tr.Cells.Add(td)


                td = New HtmlTableCell
                td.InnerHtml = "<input style='width:50px'  id ='txtorderqty" & i & "' name ='txtorderqty" & i & "'  type='text' value= '" + dtindent.Rows(i).Item("remain_qty").ToString + "'  onblur='remain_qty(this.value," & i & ");'/>"
                tr.Cells.Add(td)
                td.Style.Add("width", "10px")

                td = New HtmlTableCell
                td.InnerHtml = "<span style='color:red' id ='lblrem_qty_" & i & "' name ='lblrem_qty_" & i & "' >0</span>"
                tr.Cells.Add(td)

                td = New HtmlTableCell
                td.InnerHtml = "<input type='text' id ='txtvendor" & i & "' name ='txtvendor" & i & "'  Onfocus='return fillvendor(""txtvendor" & i & """)' />"
                tr.Cells.Add(td)

                Dim dtCDate As BasicFrame.WebControls.BDPLite
                dtCDate = New BasicFrame.WebControls.BDPLite
                dtCDate.TextBoxStyle.Width = 80
                dtCDate.SelectedDate = Now.Date
                dtCDate.ID = "txtorderdate" & (i)
                td = New HtmlTableCell
                td.Controls.Add(dtCDate)
                tr.Cells.Add(td)


                td = New HtmlTableCell
                td.InnerHtml = "<input type='checkbox' id ='chkclosed" & i & "' name ='chkclosed" & i & "'   />"
                tr.Cells.Add(td)


                tblreqdatails.Rows.Add(tr)
            Next
            show()

        End Sub
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = Con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            For i = 0 To hdncount.Value - 1
                Dim str As String = (Request.Form("chkclosed" & i & ""))

                If str = "on" Then
                    cmd = New SqlCommand("Ins_updatestatus", Con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@reqvendor_detail_id", Request.Form("hdnreqvendor_detail_id" & i & ""))
                    Con.Open()
                    cmd.ExecuteNonQuery()
                    Con.Close()
                Else
                    Dim vendorid As String = ExecuteQuery("select isnull(vendor_id,0)  from stock_vendor where vendor_name = '" & Request.Form("txtvendor" & i & "") & "'")
                    If vendorid.ToString = "" Then
                        Response.Write("<script>alert('Please Select Correct Vendor')</script>")
                        Exit Sub
                    Else
                        cmd = New SqlCommand("Ins_orderdetail", Con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@order_date ", Request.Form("txtorderdate" & i & ":TextBox"))
                        cmd.Parameters.AddWithValue("@reqvendor_detail_id", Request.Form("hdnreqvendor_detail_id" & i & ""))
                        cmd.Parameters.AddWithValue("@item_code", Request.Form("hdnitem_code" & i & ""))
                        cmd.Parameters.AddWithValue("@order_qty", Request.Form("txtorderqty" & i & ""))
                        cmd.Parameters.AddWithValue("@refno ", ddlrefno.SelectedValue)
                        cmd.Parameters.AddWithValue("@vendor_id ", vendorid)
                        cmd.Parameters.AddWithValue("@userid ", Session("UserId"))
                        cmd.Parameters.AddWithValue("@loc_id ", Session("LocID"))
                        Con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("<script>alert('Saved Successfuly');window.location.href='indent_order.aspx'</script>")
                        Con.Close()
                    End If
                End If
            Next
            show()
        End Sub

        Private Sub show()

            If ddlrefno.SelectedValue = 0 Then
                trheader.Visible = False
                trbutton.Visible = False
            Else
                trheader.Visible = True
                trbutton.Visible = True
            End If

        End Sub
    End Class
End Namespace