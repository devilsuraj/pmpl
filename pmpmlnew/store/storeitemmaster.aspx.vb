Imports System.Data.SqlClient
Namespace KDMT
    Partial Class storeitemmaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Session("MenuId") = 10
                btnSubmit.Attributes.Add("Onclick", "return validate ()")
                txtPartNo.Focus()
                BDPLite1.Text = Now.Date().ToString("dd-MMM-yyyy")

                Call edit_combo(ddlvendor, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "'")
                Call edit_combo(ddlItemType, "item_type_id", "item_type_Name", "item_type_master", "1=1")
                ddlItemType.SelectedValue = 1
                ddlvendor.SelectedValue = 1
            End If

        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click

            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            Try


                Dim sql As String = "select  *  from item_detail  where item_name = '" & txtname.Text & "' and part_no = '" & txtPartNo.Text & "' and rack_no = '" & txtRackNo.Text & "' and loc_id = '" & Session("locid").ToString & "' "
                cmd = New SqlCommand(sql, con)
                con.Open()
                Dim dr As SqlDataReader
                dr = cmd.ExecuteReader()
                If dr.Read() Then

                    Response.Write("<script>alert('Item already Exists');window.location.href='storeitemmaster.aspx'</script>")

                    'Response.Write("jbkbkub")
                Else
                    If con.State = ConnectionState.Open Then
                        con.Close()
                    End If
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd = New SqlCommand("Ins_itemdetail", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@itemid", ddlvendor.SelectedValue)
                    cmd.Parameters.AddWithValue("@partcode", txtcode.Text)
                    cmd.Parameters.AddWithValue("@itemname", Trim(txtname.Text))
                    cmd.Parameters.AddWithValue("@amount ", txtamt.Text)
                    cmd.Parameters.AddWithValue("@reorder", txtreorder.Text)
                    cmd.Parameters.AddWithValue("@transdate", BDPLite1.Text)
                    cmd.Parameters.AddWithValue("@total_stock", txttotal.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                    cmd.Parameters.AddWithValue("@loc_id", Session("locid"))
                    cmd.Parameters.AddWithValue("@rackno", txtRackNo.Text)
                    cmd.Parameters.AddWithValue("@partno", txtPartNo.Text)
                    cmd.Parameters.AddWithValue("@roomno", txtroomno.Text)
                    cmd.Parameters.AddWithValue("@subrack", txtsubrack.Text)
                    cmd.Parameters.AddWithValue("@unit", txtunit.Text)

                    cmd.Parameters.AddWithValue("@itemtype", ddlItemType.SelectedValue)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='storeitemmaster.aspx'</script>")
                    con.Close()
                    clear()
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        Sub clear()
            txtname.Text = ""
            txtcode.Text = ""
            txtamt.Text = ""
            txtreorder.Text = ""
            txttotal.Text = ""
            txtPartNo.Text = ""
            txtRackNo.Text = ""
            txtroomno.Text = ""
            txtsubrack.Text = ""
            txtunit.Text = ""
        End Sub
    End Class
End Namespace
