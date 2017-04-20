Imports System.Data.SqlClient
Namespace KDMT
    Partial Class stockin
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter



        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            BDPLite1.SelectedDate = Now.Date

            If Not IsPostBack Then

                Call Fill_Combo("item_id", "item_name", "Item_Master", ddlvendor, con, "", "select")
                Label1.Text = Session("UserName")
            End If
        End Sub
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con

            cmd = New SqlCommand("ins_stockmaster", con)
            cmd.CommandType = CommandType.StoredProcedure
            'cmd.Parameters.Add(New SqlParameter("@itemid", ddlvendor.SelectedValue))
            cmd.Parameters.Add(New SqlParameter("@trans_date", BDPLite1.SelectedDate))
            cmd.Parameters.Add(New SqlParameter("@item_code ", ddlitemname.SelectedValue))
            cmd.Parameters.AddWithValue("@amount", txtamount.Text)
            cmd.Parameters.AddWithValue("@total_stock", txttoalstock.Text)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
        End Sub

        Protected Sub ddlvendor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlvendor.SelectedIndexChanged

            Call Fill_Combo("item_code", "item_name", "Item_detail", ddlitemname, con, "item_id=" & ddlvendor.SelectedValue & "", "select")


        End Sub

    End Class
End Namespace
