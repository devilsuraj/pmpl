Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing

Namespace kdmt

    Partial Class newissue
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter



        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then

                Dim txtissueqty As TextBox
                Dim txtlfno As TextBox
                Dim txtitem As TextBox
                Dim txtPartNo As TextBox
                Dim Select1 As ListBox
                Dim lblavb As Label
                Dim lblitem As Label
                Dim lblbal As Label

                txtlfno = e.Item.FindControl("txtlfno")
                txtitem = e.Item.FindControl("txtitemname")
                txtPartNo = e.Item.FindControl("txtpartno")
                Select1 = e.Item.FindControl("Select1")
                lblavb = e.Item.FindControl("lblavb")
                lblitem = e.Item.FindControl("lblitem")
                lblbal = e.Item.FindControl("lblbal")
                txtissueqty = e.Item.FindControl("txtissueqty")


                'txtlfno.Attributes.Add("Onblur", "emptytext('" + txtPartNo.ClientID + "','" + txtitem.ClientID + "')")
                'txtlfno.Attributes.Add("Onblur", "emptytext('" + txtPartNo.ClientID + "','" + txtitem.ClientID + "'); ajaxFunction('" + txtlfno.ClientID + "','" + txtitem.ClientID + "','" + txtPartNo.ClientID + "','" + Select1.ClientID + "','" + lblitem.ClientID + "','1')")
                txtlfno.Attributes.Add("Onchange", "emptytext('" + txtPartNo.ClientID + "','" + txtitem.ClientID + "'); ajaxFunction('" + txtlfno.ClientID + "','" + txtitem.ClientID + "','" + txtPartNo.ClientID + "','" + Select1.ClientID + "','" + lblitem.ClientID + "','1')")

                'txtPartNo.Attributes.Add("Onblur", "emptytextpart('" + txtlfno.ClientID + "','" + txtitem.ClientID + "');ajaxFunction('" + txtlfno.ClientID + "','" + txtitem.ClientID + "','" + txtPartNo.ClientID + "','" + Select1.ClientID + "','" + lblitem.ClientID + "','2');")
                txtPartNo.Attributes.Add("Onchange", "emptytextpart('" + txtlfno.ClientID + "','" + txtitem.ClientID + "');")

                txtitem.Attributes.Add("onpropertychange", " ajaxFunction('" + txtlfno.ClientID + "','" + txtitem.ClientID + "','" + txtPartNo.ClientID + "','" + Select1.ClientID + "','" + lblitem.ClientID + "','3')")
                txtitem.Attributes.Add("Onblur", "return check1('" + txtlfno.ClientID + "','" + txtitem.ClientID + "','" + txtPartNo.ClientID + "','" + Select1.ClientID + "','" + lblavb.ClientID + "','" + lblitem.ClientID + "')")


                Select1.Attributes.Add("Onclick", "return select('" + txtitem.ClientID + "','" + Select1.ClientID + "')")

                txtissueqty.Attributes.Add("Onblur", "checkqty('" + txtissueqty.ClientID + "','" + lblavb.ClientID + "','" + e.Item.Cells(5).Text + "','" + lblbal.ClientID + "')")
                txtissueqty.Attributes.Add("Onfocus", "hidelist('" + Select1.ClientID + "')")


                If e.Item.Cells(11).Text <> 0 Then
                    lblitem.Text = "Yes"
                Else
                    lblitem.Text = "No"
                    lblitem.ForeColor = Color.Red

                End If
            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            ' Try


            cmd = New SqlCommand("Ins_storeissuemasternew", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@worker_name ", txtwname.Text)
            cmd.Parameters.AddWithValue("@trans_date", BDPLite1.SelectedDate)
            cmd.Parameters.AddWithValue("@refno ", ddlindent.SelectedValue)
            cmd.Parameters.AddWithValue("@getpassno ", txtgate.Text)
            cmd.Parameters.AddWithValue("@cont_id", dgresult.Items(0).Cells(10).Text)
            cmd.Parameters.AddWithValue("@userid", Session("Userid"))
            cmd.Parameters.AddWithValue("@loc_id", Session("locid"))
            cmd.Parameters.AddWithValue("@approvedby ", txtapproved.Text)
            cmd.Parameters.AddWithValue("@part_of_bus ", "pmpml")
            cmd.Parameters.AddWithValue("@remark ", txtremark.Text)

            Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
            strmaxid.Direction = ParameterDirection.Output
            cmd.Parameters.Add(strmaxid)


            con.Open()
            cmd.ExecuteNonQuery()
            Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
            con.Close()


            For i = 0 To dgresult.Items.Count - 1
                Dim sql1 As String

                Dim txtlf As TextBox
                Dim txtpart As TextBox
                Dim txtname As TextBox
                Dim txtissueqty As TextBox
                Dim lblavb As Label
                Dim lblitem As Label
                Dim lblbal As Label

                txtlf = dgresult.Items(i).FindControl("txtlfno")
                txtpart = dgresult.Items(i).FindControl("txtpartno")
                txtname = dgresult.Items(i).FindControl("txtitemname")
                txtissueqty = dgresult.Items(i).FindControl("txtissueqty")

                lblavb = dgresult.Items(i).FindControl("lblavb")



                Dim dr1 As SqlClient.SqlDataReader
                sql1 = "item_stock_bal '" & txtname.Text & "','" & txtlf.Text & "','" & txtpart.Text & "','" & Session("locid") & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr1 = cmd2.ExecuteReader()
                Dim str2 As String
                If dr1.Read() Then
                    str2 = dr1(4)
                Else
                    str2 = 0
                End If
                dr1.Close()
                con.Close()


                fnExecuteNonQuery("update Indent_Request_details  set itemcode = '" & str2.ToString & "' ,avbqty = '" & lblavb.Text & "' ,issueqty = '" & txtissueqty.Text & "' where indent_dtl_id = '" & dgresult.Items(i).Cells(1).Text & "'")

                Dim penqty As Decimal = Convert.ToDouble(Val(dgresult.Items(i).Cells(5).Text) - Val(txtissueqty.Text))
                If penqty >= 0 Then


                    cmd = New SqlCommand("ins_pending_indent", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@itemcode", str2.ToString())
                    cmd.Parameters.AddWithValue("@last_indentno", ddlindent.SelectedValue)
                    cmd.Parameters.AddWithValue("@pen_qty", penqty)
                    cmd.Parameters.AddWithValue("@updatedate", BDPLite1.SelectedDate())
                    cmd.Parameters.AddWithValue("@indentloc", dgresult.Items(0).Cells(10).Text)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                    cmd.Parameters.Clear()

                End If

                If txtissueqty.Text <> 0 Then

                    cmd = New SqlCommand("Ins_storeissuedetail", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@issue_id ", maxid)
                    cmd.Parameters.AddWithValue("@available_qty ", dgresult.Items(i).Cells(5).Text)
                    cmd.Parameters.AddWithValue("@item_code", str2.ToString())
                    cmd.Parameters.AddWithValue("@quantity", txtissueqty.Text)
                    cmd.Parameters.AddWithValue("@veh_no", "")
                    cmd.Parameters.AddWithValue("@returnable", "0")
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                End If

            Next
            Response.Write("<script>alert('Saved Successfuly');window.location.href='newissue.aspx'</script>")

        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10
            If Not IsPostBack Then
                edit_combo(ddlindent, "IndentNo", "depoindent", "Indent_Request_Master", "is_issued<>1")
                btnSubmit.Attributes.Add("Onclick", "return validate()")
                BDPLite1.SelectedDate = Now.Date()
            End If
        End Sub

        Protected Sub ddlindent_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlindent.SelectedIndexChanged
            Try

                BindGrid(dgresult, con, "view_excelindent '" & ddlindent.SelectedValue & "'")

            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace

