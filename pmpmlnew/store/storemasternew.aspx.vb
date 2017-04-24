Imports System.Data.SqlClient
Namespace KDMT
    Partial Class storemaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strSubRackNo As String = ""
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            If Page.IsPostBack = False Then
                Try
                    Session("MenuId") = 10
                    Dim SQL As String
                    txtPOtype.Focus()

                    'radparttype.SelectedValue = Session("Dept_type").ToString()
                    lblType.Text = Session("Dept_type").ToString()
                    txtRecNo.Text = ExecuteQuery("max_receipt_no '" & Session("Dept_type").ToString() & "'")
                    btnSubmit.Attributes.Add("onclick", "return validate();ValidateSave();")
                    save_vendor.Attributes.Add("onclick", "return validatevendor();")
                    check.Checked = False
                    If Not Session("LocID").ToString Is Nothing Then
                        ' edit_combo(ddlvendor, "Vendor_id", "Vendor_name", "stock_vendor", "loc_id = '" & Session("LocID") & "'")
                        BDPLite1.Text = Now.Date.ToString("dd-MMM-yyyy")
                        BDPLite2.Text = Now.Date.ToString("dd-MMM-yyyy")
                        'bdpPoDate.Text = Now.Date.ToString("dd-MM-yyyy")
                        bdpbilldate.Text = Now.Date.ToString("dd-MMM-yyyy")
                        bdpRecDate.Text = Now.Date.ToString("dd-MMM-yyyy")
                        'txtvendor.Focus()
                        SQL = "select item_name,item_name from item_master where loc_id = '" & Session("LocID") & "' "
                        strSubRackNo = getAutoCompleteList(SQL, "item_name")

                    Else
                        Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                    End If

                Catch ex As Exception

                End Try
            End If
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

                    con.Open()
                    cmd.ExecuteNonQuery()
                    ' Call Show_Msg(Page, "Saved Successfuly", "storemaster.aspx")
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='storemasternew.aspx'</script>")
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

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try
                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")
                Dim fin_year As String = GetFinYear(1)
                cmd = New SqlCommand("Ins_storemaster", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@part_type", lblType.Text)
                cmd.Parameters.AddWithValue("@vendor_id", intvendor)
                cmd.Parameters.AddWithValue("@security_date", bdpRecDate.Text)
                cmd.Parameters.AddWithValue("@challan_date", BDPLite2.Text)
                cmd.Parameters.AddWithValue("@challan_no ", txtchalan.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                cmd.Parameters.AddWithValue("@po_date", hdnPoDate.Value)
                cmd.Parameters.AddWithValue("@po_no", hdnPoNo.Value)
                cmd.Parameters.AddWithValue("@po_type", hdnPOtype.Value)
                cmd.Parameters.AddWithValue("@Inward_no", txtInwardNo.Text)
                cmd.Parameters.AddWithValue("@getpassno ", txtgate.Text)
                cmd.Parameters.AddWithValue("@bill_no ", txtbill.Text)
                cmd.Parameters.AddWithValue("@bill_date", bdpbilldate.Text)
                cmd.Parameters.AddWithValue("@Rec_No ", txtRecNo.Text)
                cmd.Parameters.AddWithValue("@Rec_Date", bdpRecDate.Text)
                cmd.Parameters.AddWithValue("@drb_no ", txtdrb.Text)
                cmd.Parameters.AddWithValue("@fy ", fin_year)

                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                con.Close()

                If hdnrwcnt.Value <> "" Then

                    'Dim i As Integer
                    Dim str As String = hdnrwcnt.Value
                    Dim myarray As Array = Split(hdndetail.Value, "|")
                    Dim j As Integer
                    j = myarray.Length - 1

                    For i = 0 To myarray.Length - 2
                        If myarray(i) <> "" Then
                            Dim mainarray As Array = Split(myarray(i), "^")
                            Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & mainarray(4) & "','" & mainarray(2) & "','" & mainarray(1) & "'")
                            cmd = New SqlCommand("Ins_storedetail", con)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@storeid ", maxid)
                            cmd.Parameters.AddWithValue("@available_qty ", mainarray(5))
                            cmd.Parameters.AddWithValue("@item_code", itemcode)
                            cmd.Parameters.AddWithValue("@challanqty", mainarray(8))
                            cmd.Parameters.AddWithValue("@rate", mainarray(10))
                            cmd.Parameters.AddWithValue("@quantity", mainarray(8))
                            cmd.Parameters.AddWithValue("@returnable", "0")
                            cmd.Parameters.AddWithValue("@pen_qty", mainarray(9))
                            cmd.Parameters.AddWithValue("@po_detail_id", mainarray(0))

                            con.Open()
                            cmd.ExecuteNonQuery()

                            con.Close()

                            Hid_Rec.Value = ""

                            If mainarray(11) > 0 Then

                                cmd = New SqlCommand("ins_claimdetail", con)
                                cmd.CommandType = CommandType.StoredProcedure

                                cmd.Parameters.AddWithValue("@storeid", maxid)
                                cmd.Parameters.AddWithValue("@itemcode", itemcode)
                                cmd.Parameters.AddWithValue("@vendorid", intvendor)
                                cmd.Parameters.AddWithValue("@challanno", txtchalan.Text)
                                cmd.Parameters.AddWithValue("@recqty", mainarray(8))
                                cmd.Parameters.AddWithValue("@claimqty", 0)
                                cmd.Parameters.AddWithValue("@claimtype", 0)

                                con.Open()
                                cmd.ExecuteNonQuery()
                                con.Close()

                            End If

                        End If
                    Next
                End If

                Response.Write("<script>alert('Saved Successfuly');window.location.href='storemasternew.aspx'</script>")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            'Response.Redirect("storemaster.aspx")
        End Sub

        Protected Sub radparttype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles radparttype.SelectedIndexChanged
            txtRecNo.Text = ExecuteQuery("max_receipt_no '" & radparttype.SelectedValue & "'")
        End Sub

        Private Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = DateTime.Now.Date
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function
    End Class

End Namespace