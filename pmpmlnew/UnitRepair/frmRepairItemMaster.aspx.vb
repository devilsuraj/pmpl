Imports System.Data.SqlClient
Namespace KDMT
    Partial Class frmRepairItemMaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public stritem As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 3
            If Page.IsPostBack = False Then
                btnSubmit.Attributes.Add("onclick", "return validate();")
                BDPLite1.Text = Now.Date
                edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "' and isRepair  = '1'")
            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            Try


                'Dim sql As String = "select  *  from item_detail  where item_name = '" & txtname.Text & "' and loc_id = '" & Session("locid").ToString & "' "

                Dim sql As String = "select  *  from tbl_repair_item  where item_name = '" & txtname.Text & "'"
                cmd = New SqlCommand(sql, con)
                con.Open()
                Dim dr As SqlDataReader
                dr = cmd.ExecuteReader()
                If dr.Read() Then

                    Response.Write("<script>alert('Item already Exists');window.location.href='frmRepairItemMaster.aspx'</script>")

                    'Response.Write("jbkbkub")
                Else
                    If con.State = ConnectionState.Open Then
                        con.Close()
                    End If
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd = New SqlCommand("Ins_RepairItemmaster", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@itemname", Trim(txtname.Text))
                    cmd.Parameters.AddWithValue("@transdate", BDPLite1.Text)
                    cmd.Parameters.AddWithValue("@unit", txtunit.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                    cmd.Parameters.AddWithValue("@is_delete", 0)
                    cmd.Parameters.AddWithValue("@ispartno", ddlserialno.SelectedValue)
                    cmd.Parameters.AddWithValue("@defectopening", txtDefectStatus.Text)
                    cmd.Parameters.AddWithValue("@busopening", txtBusStock.Text)
                    cmd.Parameters.AddWithValue("@storeopening", txtStoreStock.Text)
                    cmd.Parameters.AddWithValue("@contid", ddlvendor.SelectedValue)
                    cmd.Parameters.AddWithValue("@Remark ", txtRemark.Text)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='frmRepairItemMaster.aspx'</script>")
                    con.Close()
                    clear()
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        Sub clear()
            txtname.Text = ""
            txtunit.Text = ""
        End Sub
    End Class
End Namespace
