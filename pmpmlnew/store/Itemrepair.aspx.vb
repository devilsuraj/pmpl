
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Itemrepair
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Session("MenuId") = 10
                BDPLite1.SelectedDate = Now.Date
                Call Fill_Combo("cont_id", "cont_name", "contractor_master", ddlcont, con, "", "Select")
                'Call Fill_Combo("item_id", "item_name", "Item_Master", ddlvendor, con, "", "select")
                'Call Fill_Combo("item_name", "item_name", "item_master", ddlcat, con, "", "Select")

                Call edit_combo(ddlcat, "item_name", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "'")
                Label1.Text = Session("UserName")
            End If
        End Sub

        'Protected Sub ddlvendor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlvendor.SelectedIndexChanged
        '    Call Fill_Combo("item_code", "item_name", "Item_detail", ddlitemname, con, "item_id=" & ddlvendor.SelectedValue & "", "select")
        'End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            Dim i As Integer

            cmd = New SqlCommand("Ins_itemrepair", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.Add(New SqlParameter("@trans_date", BDPLite1.SelectedDate))
            cmd.Parameters.Add(New SqlParameter("@vech_no ", TextBox1.Text))
            cmd.Parameters.AddWithValue("@Qty", txtamount.Text)
            cmd.Parameters.AddWithValue("@gate_pass_no", txtgate.Text)
            cmd.Parameters.AddWithValue("@flag", ddlin.SelectedValue)
            cmd.Parameters.AddWithValue("@cont_id", ddlcont.SelectedValue)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()

            Dim maxid As Integer
            con.Open()
            maxid = GetMaxId1("repair_id", con, "item_repair")
            con.Close()
            If Hid_Rec.Value <> "" Then
                'Dim i As Integer
                Dim str As String = Hid_Rec.Value
                Dim myarray As Array = Split(Hid_Rec.Value, "^")
                Dim j As Integer
                j = Grd_Item.Rows.Count - 1

                For i = 0 To myarray.Length - 2
                    Dim mainarray As Array = Split(myarray(i), "|")
                    Dim sql As String
                    Dim dr As SqlClient.SqlDataReader
                    sql = "select item_id from item_master where item_name = '" & mainarray(0) & "'"
                    Dim cmd1 As New SqlClient.SqlCommand(sql, con)
                    con.Open()
                    dr = cmd1.ExecuteReader()
                    Dim str1 As String
                    If dr.Read() Then
                        str1 = dr(0)
                    End If
                    dr.Close()
                    con.Close()

                    Dim sql1 As String
                    Dim dr1 As SqlClient.SqlDataReader
                    sql1 = "select item_code from item_detail where item_name = '" & mainarray(1) & "'"
                    Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                    con.Open()
                    dr1 = cmd2.ExecuteReader()
                    Dim str2 As String
                    If dr1.Read() Then
                        str2 = dr1(0)
                    Else
                        str2 = 0
                    End If
                    dr1.Close()
                    con.Close()


                    cmd = New SqlCommand("Ins_itemrepair_detail", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add(New SqlParameter("@repair_id ", maxid))
                    cmd.Parameters.Add(New SqlParameter("@available_qty ", mainarray(2)))
                    cmd.Parameters.Add(New SqlParameter("@item_code", str2))
                    cmd.Parameters.Add(New SqlParameter("@quantity", mainarray(3)))
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                    Hid_Rec.Value = ""
                Next
            End If
            Response.Redirect("itemrepair.aspx")
        End Sub
    End Class
End Namespace