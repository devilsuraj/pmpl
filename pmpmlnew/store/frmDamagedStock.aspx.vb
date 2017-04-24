Imports System.Data.SqlClient
Namespace KDMT


    Partial Class frmDamagedStock
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10
            If Page.IsPostBack = False Then

                btnSubmit.Attributes.Add("onclick", "return validate();")
                BDPLite1.SelectedDate = Now.Date

                con.Open()
                Dim SQL As String
                Dim dr As SqlClient.SqlDataReader
                SQL = "select item_name,item_name from item_master where loc_id = '" & Session("LocID") & "' "

                Dim Com As New SqlClient.SqlCommand(SQL, con)
                ddlcat.DataTextField = "item_name"
                ddlcat.DataValueField = "item_name"
                dr = Com.ExecuteReader
                ddlcat.DataSource = dr
                ddlcat.DataBind()

                Com.Dispose()
                Com = Nothing
                dr.Close()
                dr = Nothing
                con.Close()
                Label1.Text = Session("UserName")
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


            cmd = New SqlCommand("Ins_storedamagemaster", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@trans_date", BDPLite1.SelectedDate)
            cmd.Parameters.AddWithValue("@userid", Session("Userid"))
            cmd.Parameters.AddWithValue("@loc_id", Session("locid"))
            cmd.Parameters.AddWithValue("@desc", txtDescription.Text)
            cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue)
            con.Open()
            cmd.ExecuteNonQuery()

            con.Close()
            Dim maxid As Integer
            con.Open()

            maxid = GetMaxIdwithloc("damaged_stock_id", Session("locid"), con, "store_damage_stock_master")
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


                    cmd = New SqlCommand("Ins_storedamagedetail", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add(New SqlParameter("@damage_stock_id ", maxid))
                    cmd.Parameters.Add(New SqlParameter("@available_qty ", mainarray(2)))
                    cmd.Parameters.Add(New SqlParameter("@item_code", str2))
                    cmd.Parameters.Add(New SqlParameter("@quantity", mainarray(3)))
                    cmd.Parameters.Add(New SqlParameter("@refno", mainarray(4)))
                    cmd.Parameters.Add(New SqlParameter("@sp", mainarray(5)))
                    cmd.Parameters.Add(New SqlParameter("@remark", mainarray(6)))
                    cmd.Parameters.Add(New SqlParameter("@damage_type", ddlType.SelectedValue))
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                    Hid_Rec.Value = ""
                Next
            End If
        End Sub

    End Class
End Namespace