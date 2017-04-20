Imports System.Data.SqlClient
Namespace KDMT
    Partial Class ClamAfterRecived
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DT As DataTable
        Dim DR As SqlDataReader
        Dim DA As SqlClient.SqlDataAdapter
        Public strSubRackNo As String = ""
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            Session("MenuId") = 10
            If Page.IsPostBack = False Then
                Try
                    Dim i As Integer = 1
                    For i = 1 To 6
                        Dim fin_year As String = GetFinYear(i)
                        ddlrecyear.Items.Add(New ListItem(fin_year, i))
                    Next


                    Dim SQL As String
                    ' txtPOtype.Focus()

                    'radparttype.SelectedValue = Session("Dept_type").ToString()
                    lblType.Text = Session("Dept_type").ToString()
                    'txtRecNo.Text = ExecuteQuery("max_receipt_no '" & Session("Dept_type").ToString() & "'")
                    btnSubmit.Attributes.Add("onclick", "return validate();ValidateSave();")
                    save_vendor.Attributes.Add("onclick", "return validatevendor();")
                    'BtnShow.Attributes.Add("onclick", "return getpo();")

                    check.Checked = False
                    If Not Session("LocID").ToString Is Nothing Then
                        ' edit_combo(ddlvendor, "Vendor_id", "Vendor_name", "stock_vendor", "loc_id = '" & Session("LocID") & "'")
                        BDPLite1.Text = Now.Date
                        BDPLite2.Text = Now.Date
                        'bdpPoDate.Text = Now.Date.ToString("dd-MM-yyyy")
                        'bdpbilldate.Text = Now.Date
                        'bdpRecDate.Text = Now.Date
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
                    'Response.Write("<script>alert('Saved Successfuly');window.location.href='storemasternew.aspx'</script>")
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='ClamAfterRecived.aspx'</script>")
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
                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Text & "' ")
                Dim flag As String = 1
                Dim flag_save As String = 0

                For i = 0 To grdstock.Items.Count - 1
                    Dim chkqty As HiddenField = grdstock.Items(i).Cells(6).FindControl("hdnchkqty")
                    '  Dim TxtRECQTY As TextBox = grdstock.Items(i).Cells(6).FindControl("TxtRECQTY")
                    Dim Lbltotalqty As TextBox = grdstock.Items(i).Cells(6).FindControl("txttotalqty")
                    Dim CheckBox1 As CheckBox = grdstock.Items(i).Cells(9).FindControl("CheckBox1")
                    Dim Lblstore_id As Label = grdstock.Items(i).Cells(10).FindControl("Lblstore_id")
                    'Dim LBLItemCode As Label = grdstock.Items(i).Cells(11).FindControl("LBLItemCode")
                    Dim itemcode As String = grdstock.Items(i).Cells(10).Text
                    Dim storeidexist As String = ExecuteQuery("select storeid  from claim_detail  where storeid  ='" & Lblstore_id.Text & "' and itemcode = '" & itemcode & "' ")


                    If CheckBox1.Checked Then
                        flag = 2
                        If storeidexist = "" Then
                            flag_save = 1
                            If Lbltotalqty.Text <> "" And Lbltotalqty.Text <= chkqty.Value And Not Lbltotalqty.Text.Trim().StartsWith("0") Then
                                flag_save = 2
                                'If CheckBox1.Checked = True Then
                                'If TryCast(row.FindControl("CheckBox1"), CheckBox).Checked Then
                                cmd = New SqlCommand("AfterRecIns_claim_detail", con)
                                cmd.CommandType = CommandType.StoredProcedure

                                cmd.Parameters.AddWithValue("@store_id", Lblstore_id.Text)

                                cmd.Parameters.AddWithValue("@vendorid", intvendor)
                                'cmd.Parameters.AddWithValue("@vendorid", txtvendorname.Text)
                                cmd.Parameters.AddWithValue("@challanno", txtchalan.Text)
                                'cmd.Parameters.AddWithValue("@recqty", Lbltotalqty.Text)
                                cmd.Parameters.AddWithValue("@claimqty", Lbltotalqty.Text)
                                cmd.Parameters.AddWithValue("@claimtype", 0)
                                cmd.Parameters.AddWithValue("@claimdate", BDPLite2.Text)
                                cmd.Parameters.AddWithValue("@itemcode", grdstock.Items(i).Cells(10).Text)
                                'cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))

                                con.Open()
                                cmd.ExecuteNonQuery()
                                con.Close()

                            End If

                        Else
                            Response.Write("<script>alert('This Item Is Already Claimed');window.location.href='../store/ClamAfterRecived.aspx'</script>")
                        End If
                        'Else
                        '    Response.Write("<script>alert('Your Not Check The Claim');window.location.href='../store/ClamAfterRecived.aspx'</script>")

                    End If
                Next
                If flag = 1 Then
                    Response.Write("<script>alert('You Have Not Selected Item');</script>")
                ElseIf flag_save = 2 Then
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='../store/ClamAfterRecived.aspx'</script>")
                ElseIf flag_save = 1 Then
                    Response.Write("<script>alert('Enter Proper Quantity !');</script>")
                End If
                'Response.Write("<script>alert('Saved Successfuly');window.location.href='../store/ClamAfterRecived.aspx'</script>")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        End Sub

        Protected Sub radparttype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles radparttype.SelectedIndexChanged
            ' txtRecNo.Text = ExecuteQuery("max_receipt_no '" & radparttype.SelectedValue & "'")
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
        Protected Sub txtRecNo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtRecNo.TextChanged

        End Sub
        Protected Sub BtnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnShow.Click
            Try

                Dim dt As New DataTable
                'Dim fromdate As String = BDPLite1.Text
                'Dim todate As String = BDPLite2.Text
                'Label3.Text = "( " + IIf(ddldepttype.SelectedValue = "SP", "Spare Parts", "Hardware") + " )"
                'Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                'Label2.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                dt = GetDatatTable("VIEW_AfterRec'" & txtRecNo.Text & "','" & lblType.Text & "','" & ddlrecyear.SelectedItem.Text & "'")
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    'Table1.Visible = False

                Else
                    For i = 0 To dt.Rows.Count - 1

                        txtvendor.Text = dt.Rows(i).Item("vendor_name")
                        txtchalan.Text = dt.Rows(i).Item("challan_no")
                        txtbill.Text = dt.Rows(i).Item("bill_no")
                        bdpPoDate.Text = dt.Rows(i).Item("po_date")
                        HiddenField1.Value = dt.Rows(i).Item("po_str")
                        HiddenField2.Value = dt.Rows(i).Item("po_no")
                        HiddenField3.Value = dt.Rows(i).Item("po_fin_year")
                        txtPOtype.Text = dt.Rows(i).Item("potype")




                        'lblSupName.Text = dt.Rows(i).Item("vendor_name")
                        'lblBlNo.Text = dt.Rows(i).Item("Bill_No")
                        'lblBlDT.Text = dt.Rows(i).Item("Bill_Date")
                        'lblChNo.Text = dt.Rows(i).Item("Challan_No")
                        'lblChDT.Text = dt.Rows(i).Item("Challan_Date")
                        ''If ddldepttype.SelectedValue = "SP" Then
                        ''    lblDRBNo.Text = ddldrbtype.SelectedValue + " - " + txtdrbno.Text
                        ''Else
                        ''    lblDRBNo.Text = txtdrbno.Text
                        ''End If
                        'lblOrdNo.Text = dt.Rows(i).Item("PO_type") + " " + dt.Rows(i).Item("PO_No")
                        'lblOrdDT.Text = dt.Rows(i).Item("PO_Date")
                        'lblRecNo.Text = dt.Rows(0).Item("Rec_No")
                        'lblRecDate.Text = dt.Rows(0).Item("Rec_Date")
                        ''lblPMPLNo.Text = dt.Rows(i).Item("vendor_name")
                        'lblSerNo.Text = dt.Rows(i).Item("Store_Id")
                    Next
                    Dim dept As String = IIf(Session("Dept_type").ToString = "SP", 1, 2)
                    'BindGrid(grdstock, con, "View_po_Details_AfterClam'" & txtvendor.Text & "','" & HiddenField1.Value & "','" & HiddenField2.Value & "','" & HiddenField3.Value & "','" & dept & "'")
                    BindGrid(grdstock, con, "VIEW_AfterRec_Gride'" & txtRecNo.Text & "','" & lblType.Text & "','" & ddlrecyear.SelectedItem.Text & "'")
                  
                    'BindGrid(grdstock, con, "VIEW_cont_receive_report_Print '" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "'")
                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        'Table1.Visible = False
                        'Else
                        ' Table1.Visible = True
                    End If
                End If

            Catch ex As Exception
            Finally
                ' strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub

        Protected Sub grdstock_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdstock.DataBinding
            
        End Sub
    End Class
   

End Namespace

