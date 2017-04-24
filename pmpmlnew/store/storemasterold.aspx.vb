Imports System.Data.SqlClient
Namespace KDMT
    Partial Class storemasterold
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strSubRackNo As String = ""
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Try
                    Session("MenuId") = 10
                    Dim SQL As String

                    txtvendor.Value = Request.QueryString("vendor")
                    txtPoNo.Text = Request.QueryString("PoNo")

                    strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    save_vendor.Attributes.Add("onclick", "return validatevendor();")
                    check.Checked = False
                    If Not Session("LocID").ToString Is Nothing Then
                        ' edit_combo(ddlvendor, "Vendor_id", "Vendor_name", "stock_vendor", "loc_id = '" & Session("LocID") & "'")
                        BDPLite1.SelectedDate = Now.Date
                        BDPLite2.SelectedDate = Now.Date
                        bdpPoDate.SelectedDate = Now.Date
                        bdpbilldate.SelectedDate = Now.Date
                        bdpRecDate.SelectedDate = Now.Date
                        txtvendor.Focus()
                        SQL = "select item_name,item_name from item_master where loc_id = '" & Session("LocID") & "' "
                        strSubRackNo = getAutoCompleteList(SQL, "item_name")

                    Else
                        Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                    End If

                Catch ex As Exception

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
            Try

                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")


                cmd = New SqlCommand("Ins_storehtmasterold", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@part_type", radparttype.SelectedValue)
                cmd.Parameters.AddWithValue("@vendor_id", intvendor)
                cmd.Parameters.AddWithValue("@security_date", BDPLite1.SelectedDate)
                cmd.Parameters.AddWithValue("@challan_date", BDPLite2.SelectedDate)
                cmd.Parameters.AddWithValue("@challan_no ", txtchalan.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                cmd.Parameters.AddWithValue("@po_date", bdpPoDate.SelectedDate)
                cmd.Parameters.AddWithValue("@po_no", txtPoNo.Text)
                cmd.Parameters.AddWithValue("@Inward_no", txtInwardNo.Text)
                cmd.Parameters.AddWithValue("@getpassno ", txtgate.Text)

                cmd.Parameters.AddWithValue("@bill_no ", txtbill.Text)
                cmd.Parameters.AddWithValue("@bill_date", bdpbilldate.SelectedDate)
                cmd.Parameters.AddWithValue("@rec_no ", txtRecNo.Text)
                cmd.Parameters.AddWithValue("@rec_date", bdpRecDate.SelectedDate)
                cmd.Parameters.AddWithValue("@drb_no ", txtdrb.Text)


                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()

                con.Close()
                ' Dim maxid As Integer
                con.Open()
                ' maxid = GetMaxIdwithloc("store_id", Session("locid"), con, "store_master")
                con.Close()
                If Hid_Rec.Value <> "" Then
                    'Dim i As Integer
                    Dim str As String = Hid_Rec.Value
                    Dim myarray As Array = Split(Hid_Rec.Value, "^")
                    Dim j As Integer
                    j = Grd_Item.Rows.Count - 1

                    For i = 0 To myarray.Length - 2
                        If myarray(i) <> "" Then
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


                            cmd = New SqlCommand("Ins_storehtdetailold", con)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.Add(New SqlParameter("@storeid ", maxid))
                            cmd.Parameters.Add(New SqlParameter("@available_qty ", mainarray(3)))
                            cmd.Parameters.Add(New SqlParameter("@item_code", str2))
                            cmd.Parameters.Add(New SqlParameter("@challanqty", mainarray(4)))
                            cmd.Parameters.Add(New SqlParameter("@rate", mainarray(5)))
                            cmd.Parameters.Add(New SqlParameter("@quantity", mainarray(6)))
                            cmd.Parameters.Add(New SqlParameter("@returnable", "0"))

                            con.Open()
                            cmd.ExecuteNonQuery()
                            Response.Write("<script>if(confirm('Are You Want Print')){window.location.href='../report/rptDRBreport.aspx?SrNo=" & maxid & "';} else {alert('Saved Successfuly');window.location.href='storemasterold.aspx';}</script>")

                            'Response.Write("<script>alert('Saved Successfuly');window.location.href='storemasterold.aspx'</script>")
                            con.Close()

                            Hid_Rec.Value = ""
                        End If

                    Next
                End If


            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            'Response.Redirect("storemaster.aspx")
        End Sub
        Protected Sub check_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles check.CheckedChanged
            Try

                display()

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub save_vendor_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles save_vendor.Click
            Try


                Dim str As String = ExecuteQuery("select vendor_name  from stock_vendor where vendor_name = '" & txtvendorname.Text & "' ")

                If str.ToString <> "" Then
                    ' Call Show_Msg(Page, "This Vendor already Exist", "storemaster.aspx")
                    ' Response.Write("<script>alert('This Vendor already Exist');window.location.href='storemaster.aspx'</script>")
                    Response.Write("<script>alert('This Vendor already Exist')</script>")

                Else
                    cmd = New SqlCommand("Ins_stock_vendor", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@vendor_name ", txtvendorname.Text)
                    cmd.Parameters.AddWithValue("@add1 ", txtadd1.Text)
                    cmd.Parameters.AddWithValue("@add2 ", txtadd2.Text)
                    cmd.Parameters.AddWithValue("@capital ", txtcapital.Text)
                    cmd.Parameters.AddWithValue("@loc_id ", Session("locid"))
                    cmd.Parameters.AddWithValue("@contact_name ", txtcontactnname.Text)
                    cmd.Parameters.AddWithValue("@contact_no ", txtcontactno.Text)

                    con.Open()
                    cmd.ExecuteNonQuery()
                    ' Call Show_Msg(Page, "Saved Successfuly", "storemaster.aspx")
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='storemaster.aspx'</script>")
                    check.Checked = False
                    display()
                    con.Close()

                End If
            Catch ex As Exception

            Finally

            End Try
        End Sub
        Private Sub display()
            Try


                If check.Checked = True Then
                    trvendor.Visible = True
                    tblmain.Visible = False

                Else
                    trvendor.Visible = False
                    tblmain.Visible = True

                End If
            Catch ex As Exception

            Finally
                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try


        End Sub
    End Class

End Namespace