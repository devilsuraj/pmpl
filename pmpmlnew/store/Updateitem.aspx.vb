Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Updateitem
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10
            If Page.IsPostBack = False Then
                btnSubmit.Attributes.Add("onclick", "return validate ()")
                'Call edit_combo(ddlitmcat, "cat_id", "item_cat_name", "item_cat_master", "0=0")
                Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "'")
                ddlCategory.SelectedValue = 1

            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Dim errMsg As String
            'Dim sqlquerystring As String = ("Update item_detail set item_name='" & txtname.Text & "',part_no = '" & Txtpartno.Text & "',unit='" & txtunit.Text & "',rack_no='" & txtrackno.Text & "' where item_code=" & txtcode.Text & "")



            Try


                cmd = New SqlCommand("update_itemdetail", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@item_code", HiddenField1.Value)
                cmd.Parameters.AddWithValue("@item_name", txtname.Text)
                cmd.Parameters.AddWithValue("@part_no", Txtpartno.Text)
                'add multiple  part by shital
                cmd.Parameters.AddWithValue("@part_no2", txtPartNo2.Text)
                cmd.Parameters.AddWithValue("@part_no3", txtPartNo3.Text)
                cmd.Parameters.AddWithValue("@part_no4", txtPartNo4.Text)
                ' end
                cmd.Parameters.AddWithValue("@room_no", txtroomno.Text)
                cmd.Parameters.AddWithValue("@rack_no", txtlfno.Text)
                cmd.Parameters.AddWithValue("@subrack_no", txtsubrack.Text)
                cmd.Parameters.AddWithValue("@reorder", txtreorder.Text)
                cmd.Parameters.AddWithValue("@max_level", txtmax.Text)
                cmd.Parameters.AddWithValue("@min_level", txtmin.Text)
                cmd.Parameters.AddWithValue("@make", txtmake.Text)
                cmd.Parameters.AddWithValue("@unit", txtunit.Text)
                cmd.Parameters.AddWithValue("@Consumation", txtConsumation.Text)
                cmd.Parameters.AddWithValue("@rate", txtRate.Text)
                cmd.Parameters.AddWithValue("@Item_id", ddlCategory.SelectedValue)

                con.Open()
                cmd.Transaction = con.BeginTransaction

                cmd.ExecuteNonQuery()
                cmd.Transaction.Commit()
                cmd.Dispose()
                con.Close()
                Response.Write("<script> alert ('Updated Successfully');window.location.href ='Updateitem.aspx'</script>")
            Catch
                cmd.Transaction.Rollback()
                cmd.Dispose()
                con.Close()
                errMsg = Err.Description

                Response.Write("<script> alert ( " & errMsg & ")</script>")
            Finally
                cmd.Dispose()
                con.Close()
            End Try
            ' Call Show_Msg(Page, "Updated Successfully", "Updateitem.aspx")
        End Sub


        Protected Sub txtcode_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtcode.TextChanged
            Try
                txtitem.Text = ""
                Dim sql As String
                'comment by shital
                ' sql = "select item_detail.item_name, item_master.item_name as categotry,item_detail.item_code,isnull(part_no,'')part_no ,room_no,rack_no,subrack_no,reorder,max_level,min_level,isnull(unit,'nos')as unit,isnull(part_no2,'')part_no2  ,isnull(part_no3,'')part_no3  ,isnull(part_no4,'')part_no4 from item_detail inner join item_master on item_master.item_id = item_detail.item_id where item_code ='" & txtcode.Text & "'"
                sql = "select item_detail.item_name, item_master.item_id as categotry,item_detail.item_code,isnull(part_no,'')part_no ,room_no,rack_no,subrack_no,reorder,max_level,min_level,isnull(unit,'nos')as unit,isnull(part_no2,'')part_no2  ,isnull(part_no3,'')part_no3  ,isnull(part_no4,'')part_no4,isnull(consumation,'')consumation,isnull(rate,'')rate from item_detail inner join item_master on item_master.item_id = item_detail.item_id where item_code ='" & txtcode.Text & "'"

                Dim dr As SqlClient.SqlDataReader
                cmd = New SqlClient.SqlCommand(sql, con)
                con.Open()
                dr = cmd.ExecuteReader()

                If dr.Read() Then
                    HiddenField1.Value = txtcode.Text

                    txtname.Text = dr(0)
                    ddlCategory.SelectedValue = dr(1)
                    Txtpartno.Text = dr(3)
                    txtroomno.Text = dr(4)
                    txtlfno.Text = dr(5)
                    txtsubrack.Text = dr(6)
                    txtreorder.Text = dr(7)
                    txtmax.Text = dr(8)
                    txtmin.Text = dr(9)
                    txtunit.Text = dr(10)
                    'ddlitmcat.SelectedValue = dr(4)

                    'addd by shital
                    txtPartNo2.Text = dr(11)
                    txtPartNo3.Text = dr(12)
                    txtPartNo4.Text = dr(13)
                    txtConsumation.Text = dr(14)
                    txtRate.Text = dr(15)
                End If
                dr.Close()
                con.Close()
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnclear_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnclear.Click
            Response.Redirect("Updateitem.aspx")
        End Sub
    End Class
End Namespace
