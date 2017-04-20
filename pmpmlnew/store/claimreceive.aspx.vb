Imports System.Data.SqlClient
Namespace KDMT
    Partial Class claimreceive
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strSubRackNo As String = ""
        Public strVendor As String = ""


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            btnsubmit.Attributes.Add("Onclick", "return validate()")
            Session("MenuId") = 10
            If Not IsPostBack Then
                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                bdpRecDate.Text = Now.Date()
                BDPLite2.Text = Now.Date()
                tblmain.Visible = True
                txtRecNo.Text = ExecuteQuery("max_receipt_no '" & Session("Dept_type").ToString() & "'")
            End If
        End Sub
        Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
            Try



                ' Dim vendor As Integer = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  =  '" + txtvendor.Text + "'")
                For i = 0 To dgresult.Items.Count - 1

                    Dim maxid As String

                    If i = 0 Then
                        cmd = New SqlCommand
                        ds = New DataSet
                        DA = New SqlDataAdapter
                        cmd.Connection = con
                        cmd.CommandType = CommandType.StoredProcedure


                        Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Text & "' ")
                        Dim fin_year As String = GetFinYear(1)
                        cmd = New SqlCommand("Ins_storemaster", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@part_type", Session("Dept_type"))
                        cmd.Parameters.AddWithValue("@vendor_id", intvendor)
                        cmd.Parameters.AddWithValue("@security_date", bdpRecDate.Text)
                        cmd.Parameters.AddWithValue("@challan_date", BDPLite2.Text)
                        cmd.Parameters.AddWithValue("@challan_no ", txtchalan.Text)
                        cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                        cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                        cmd.Parameters.AddWithValue("@po_date", dgresult.Items(i).Cells(5).Text)
                        cmd.Parameters.AddWithValue("@po_no", dgresult.Items(i).Cells(7).Text)
                        cmd.Parameters.AddWithValue("@po_type", dgresult.Items(i).Cells(6).Text)
                        cmd.Parameters.AddWithValue("@Inward_no", " ")
                        cmd.Parameters.AddWithValue("@getpassno ", " ")
                        cmd.Parameters.AddWithValue("@bill_no ", "")
                        cmd.Parameters.AddWithValue("@bill_date", BDPLite2.Text)
                        cmd.Parameters.AddWithValue("@Rec_No ", txtRecNo.Text)
                        cmd.Parameters.AddWithValue("@Rec_Date", bdpRecDate.Text)
                        cmd.Parameters.AddWithValue("@drb_no ", "")
                        cmd.Parameters.AddWithValue("@fy ", fin_year)

                        Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                        strmaxid.Direction = ParameterDirection.Output
                        cmd.Parameters.Add(strmaxid)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        maxid = cmd.Parameters("@maxid").Value.ToString()
                        con.Close()
                    End If

                    Dim txtxlaimqty As TextBox = dgresult.Items(i).Cells(18).FindControl("txtclaimrejqty")


                    If txtxlaimqty.Text <> "" Then

                        cmd = New SqlCommand("Ins_storedetail", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@storeid ", maxid)
                        cmd.Parameters.AddWithValue("@available_qty ", "0")
                        cmd.Parameters.AddWithValue("@item_code", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@challanqty", txtxlaimqty.Text)
                        cmd.Parameters.AddWithValue("@rate", "0")
                        cmd.Parameters.AddWithValue("@quantity", txtxlaimqty.Text)

                        cmd.Parameters.AddWithValue("@returnable", "0")
                        cmd.Parameters.AddWithValue("@pen_qty", (dgresult.Items(i).Cells(3).Text - txtxlaimqty.Text))
                        cmd.Parameters.AddWithValue("@po_detail_id", dgresult.Items(i).Cells(4).Text)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()



                        ''''''''''''''''''''''''

                        cmd = New SqlCommand("ins_claimreceive", con)
                        cmd.CommandType = CommandType.StoredProcedure


                        cmd.Parameters.AddWithValue("@claimid", dgresult.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@itemcode", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@vendorid", txtvendor.Text)
                        cmd.Parameters.AddWithValue("@claimqty", txtxlaimqty.Text)
                        cmd.Parameters.AddWithValue("@storeidrec", maxid)
                        cmd.Parameters.AddWithValue("@claimrecdate", bdpRecDate.Text)
                        cmd.Parameters.AddWithValue("@recno", txtRecNo.Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        ' Call Show_Msg(Page, "Saved Successfuly", "storemaster.aspx")
                        Response.Write("<script>alert('Saved Successfuly');window.location.href='claimreceive.aspx'</script>")
                        con.Close()
                    End If
                Next

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub radparttype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles radparttype.SelectedIndexChanged
            Try
                binddata()
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound


            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
                Dim txtclaimrejqty As TextBox = CType(e.Item.Cells(18).FindControl("txtclaimrejqty"), TextBox)

                txtclaimrejqty.Attributes.Add("Onblur", "checkqty('" + txtclaimrejqty.ClientID + "','" + e.Item.Cells(16).Text + "')")

            End If

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


        Private Sub binddata()
            Try
                BindGrid(dgresult, con, "view_claim '" & radparttype.SelectedValue & "','" & txtvendor.Text & "'")
                If dgresult.Items.Count > 0 Then
                    tblmain.Visible = True
                    btnsubmit.Visible = True
                Else
                    tblmain.Visible = False
                    btnsubmit.Visible = False
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                binddata()
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
