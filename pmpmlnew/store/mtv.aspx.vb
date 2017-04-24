Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic
Namespace Kdmt
    Partial Class MTV
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Session("MenuId") = 10
                'Label1.Text = Format(Now.Date, "dd/MMM/yyyy") & "  " & Now.Hour & ":" & Now.Minute & ":" & Now.Second
                If Page.IsPostBack = False Then
                    Try
                        'txtref.Text = ExecuteQuery("(SELECT RIGHT('0' + RTRIM(year(getdate())), 2)+ RIGHT('0' + RTRIM(month(getdate())), 2)+ RIGHT('0' + RTRIM(day(getdate())), 2))")
                        btnSubmit.Attributes.Add("onclick", "return validate();")
                        If Session("LocID").ToString <> "" Then
                            'edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "'")
                            ddlDepot.Items.Insert(0, New ListItem("Select", "0"))
                            ddlRef.Items.Insert(0, New ListItem("Select", "0"))

                            txtissuedate.Text = Now.Date().ToString("dd-MMM-yyyy")
                            'BDPLite1.Text = Format(Now.Date, "dd/MMM/yyyy")
                            If ddlvendor.SelectedValue = 1 Then
                                edit_combo(ddlDepot, "Depo_Code", "Depo_Name", "Depo_Master", "depo_code <> " & Session("LocID").ToString & "")
                            Else
                                ddlDepot.DataSource = ""
                                ddlDepot.DataBind()
                                ddlRef.DataSource = ""
                                ddlRef.DataBind()
                                ddlDepot.Items.Insert(0, New ListItem("Select", "0"))
                                ddlRef.Items.Insert(0, New ListItem("Select", "0"))
                            End If



                            'edit_combo(ddlRef, "Indent_No", "Indent_No", "Indent_Request_Master IRM INNER JOIN Indent_Request_Details IRD ON IRM.Indent_ID = IRD.Indent_Master_ID", "IRM.Is_Delete = 0 AND IRD.Indent_Flag = 0 AND IRM.Ind_LocId = ")

                        End If

                    Catch ex As Exception
                        Response.Write(ex.Message)
                    End Try
                End If
            End If
        End Sub
        'Protected Sub txtref_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtref.TextChanged

        'End Sub

        Protected Sub grddetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddetails.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
                Dim txtissueqty As TextBox = CType(e.Item.Cells(8).FindControl("txtissueqty"), TextBox)
                Dim lblreqqty As Label = CType(e.Item.Cells(7).FindControl("lblreqqty"), Label)
                Dim lblavbqty As Label = CType(e.Item.Cells(7).FindControl("lblavbqty"), Label)

                '    txtissueqty.Attributes.Add("Onblur", "return checkqty('" + txtissueqty.ClientID + "','" + lblavbqty.Text + "','" + lblreqqty.Text + "')")

            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try


                cmd = New SqlCommand("Ins_storeissuemaster", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@cont_id", ddlvendor.SelectedValue)
                cmd.Parameters.AddWithValue("@trans_date", txtissuedate.Text)
                cmd.Parameters.AddWithValue("@refno ", ddlRef.SelectedValue)
                cmd.Parameters.AddWithValue("@worker_name ", txtwname.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@loc_id", Session("locid"))
                cmd.Parameters.AddWithValue("@getpassno ", txtgate.Text)
                cmd.Parameters.AddWithValue("@approvedby", txtapproved.Text)
                cmd.Parameters.AddWithValue("@remark", txtremark.Text)


                cmd.Parameters.AddWithValue("@issue_fromloc", Session("locid"))
                cmd.Parameters.AddWithValue("@issue_toloc", ddlDepot.SelectedValue)
                cmd.Parameters.AddWithValue("@issue_type", "Indent")
                cmd.Parameters.AddWithValue("@issue_against_wmr_or_indent", ddlRef.SelectedValue)



                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)
                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                con.Close()

                For i = 0 To grddetails.Items.Count - 1
                    Dim lblavbqty As Label = CType(grddetails.Items(i).Cells(7).FindControl("lblavbqty"), Label)
                    Dim lblreqqty As Label = CType(grddetails.Items(i).Cells(7).FindControl("lblreqqty"), Label)
                    Dim txtissueqty As TextBox = CType(grddetails.Items(i).Cells(8).FindControl("txtissueqty"), TextBox)
                    Dim txtworker As TextBox = CType(grddetails.Items(i).Cells(8).FindControl("txtworker"), TextBox)
                    If txtissueqty.Text = "" Then txtissueqty.Text = 0

                    If (Decimal.Parse(txtissueqty.Text) = 0) Then

                    Else


                        cmd = New SqlCommand("Ins_storeissuedetail_new", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@issue_id", maxid)
                        cmd.Parameters.AddWithValue("@item_code", grddetails.Items(i).Cells(8).Text)
                        cmd.Parameters.AddWithValue("@available_qty", lblavbqty.Text)
                        cmd.Parameters.AddWithValue("@quantity", txtissueqty.Text)
                        cmd.Parameters.AddWithValue("@veh_no", "")
                        cmd.Parameters.AddWithValue("@returnable", 0)
                        cmd.Parameters.AddWithValue("@wname", txtworker.Text)
                        cmd.Parameters.AddWithValue("@Indent_Details_ID", grddetails.Items(i).Cells(9).Text)
                        cmd.Parameters.AddWithValue("@Req_Qty", lblreqqty.Text)
                        cmd.Parameters.AddWithValue("@loc_id", Session("locid"))

                        con.Open()
                        cmd.ExecuteNonQuery()

                        con.Close()
                    End If

                Next
                Response.Write("<script>alert('Saved Successfuly');window.location.href='mtv.aspx'</script>")

            Catch ex As Exception
                Response.Write("<script>alert('Error Occured While saving')</script>")
            Finally
                con.Close()
            End Try

        End Sub

        Protected Sub ddlDepot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDepot.SelectedIndexChanged
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Dim dr As SqlDataReader
            Dim sql As String = "Show_indent_no " & ddlDepot.SelectedValue & ",'indentissue'"
            cmd = New SqlCommand(sql, Con)
            Con.Open()
            dr = cmd.ExecuteReader()
            ddlRef.DataTextField = "Ind_No"
            ddlRef.DataValueField = "Ind_No"
            ddlRef.DataSource = dr
            ddlRef.DataBind()
            Con.Close()

            ddlRef.Items.Insert(0, New ListItem("Select", "0"))

        End Sub


        Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
            Try
                Dim dt As DataTable = New DataTable()
                BindGrid(grddetails, con, "view_indent_request '" & ddlRef.SelectedValue.ToString() & "','" & ddlDepot.SelectedValue.ToString() & "'")
                dt = GetDatatTable("view_indent_request '" & ddlRef.SelectedValue.ToString() & "','" & ddlDepot.SelectedValue.ToString() & "'")
                If grddetails.Items.Count > 0 Then
                    trsave.Visible = True
                    grddetails.Visible = True
                    ddlRef.SelectedValue = CDbl(dt.Rows(0).Item("Indent_No").ToString())
                    txtMRVNo.Text = dt.Rows(0).Item("MRV_No").ToString()
                Else
                    trsave.Visible = False
                    grddetails.Visible = False
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub ddlvendor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlvendor.SelectedIndexChanged
            If ddlvendor.SelectedValue = 1 Then
                edit_combo(ddlDepot, "Depo_Code", "Depo_Name", "Depo_Master", "0=0")
            Else
                ddlDepot.DataSource = ""
                ddlDepot.DataBind()
                ddlRef.DataSource = ""
                ddlRef.DataBind()
                ddlDepot.Items.Insert(0, New ListItem("Select", "0"))
                ddlRef.Items.Insert(0, New ListItem("Select", "0"))
            End If
        End Sub

        Protected Sub btnclear_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnclear.Click
            Response.Redirect("MTVNo.aspx")
        End Sub

        <WebMethod()>
        Public Shared Function GetAutoCompletereceivername(ByVal SubId As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()

            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                Using cmd As New SqlCommand("select emp_name from emp_master where  emp_name like '%" & SearchText & "%' ", con)
                    'Using cmd As New SqlCommand("select emp_name from emp_master where loc_id='" + SubId + "' and emp_name like '%" & SearchText & "%' ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("emp_name").ToString())
                    End While
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function
    End Class
End Namespace

