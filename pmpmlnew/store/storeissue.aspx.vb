Imports System.Data.SqlClient
Namespace KDMT
    Partial Class storeissue
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Session("MenuId") = 10
                Try
                    lbldepttype.Text = (Session("Dept_type").ToString)
                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    If Session("LocID").ToString <> "" Then
                        ddlvendor.Focus()
                        edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "'")
                        BDPLite1.Text = Now.Date
                    Else
                        Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                    End If
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
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


            cmd = New SqlCommand("Ins_storeissuemaster", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@worker_name ", txtwname.Text)
            cmd.Parameters.AddWithValue("@trans_date", BDPLite1.Text)
            cmd.Parameters.AddWithValue("@refno ", txtref.Text)
            cmd.Parameters.AddWithValue("@getpassno ", txtgate.Text)
            cmd.Parameters.AddWithValue("@cont_id", ddlvendor.SelectedValue)
            cmd.Parameters.AddWithValue("@userid", Session("Userid"))
            cmd.Parameters.AddWithValue("@loc_id", Session("locid"))
            cmd.Parameters.AddWithValue("@approvedby ", txtapproved.Text)
            cmd.Parameters.AddWithValue("@part_of_bus ", txtpart_of_bus.Text)
            cmd.Parameters.AddWithValue("@remark ", txtremark.Text)

            Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
            strmaxid.Direction = ParameterDirection.Output
            cmd.Parameters.Add(strmaxid)


            con.Open()
            cmd.ExecuteNonQuery()
            Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
            con.Close()

            'Dim maxid As Integer
            con.Open()

            'maxid = GetMaxIdwithloc("issue_id", Session("locid"), con, "store_issue_master")
            con.Close()
            If Hid_Rec.Value <> "" Then
                'Dim i As Integer
                Dim str As String = Hid_Rec.Value
                Dim myarray As Array = Split(Hid_Rec.Value, "^")
                Dim j As Integer
                '    j = Grd_Item.Rows.Count - 1

                For i = 0 To myarray.Length - 2
                    Dim mainarray As Array = Split(myarray(i), "|")

                    Dim sql1 As String
                    Dim dr1 As SqlClient.SqlDataReader
                    sql1 = "select item_code from item_detail where rack_no = '" & mainarray(0) & "' and item_name = '" & mainarray(2) & "' "
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


                    cmd = New SqlCommand("Ins_storeissuedetail", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add(New SqlParameter("@issue_id ", maxid))
                    cmd.Parameters.Add(New SqlParameter("@available_qty ", mainarray(3)))
                    cmd.Parameters.Add(New SqlParameter("@item_code", str2))
                    cmd.Parameters.Add(New SqlParameter("@quantity", mainarray(4)))
                    cmd.Parameters.Add(New SqlParameter("@veh_no", mainarray(6)))
                    cmd.Parameters.Add(New SqlParameter("@returnable", "0"))
                    con.Open()
                    cmd.ExecuteNonQuery()
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='storeissue.aspx'</script>")
                    con.Close()

                    Hid_Rec.Value = ""
                Next
            End If
        End Sub


        
        
    End Class
End Namespace
