Imports System.Data.SqlClient
Namespace KDMT
    Partial Class oilreceipt
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
                    Dim SQL As String
                    txtPOtype.Focus()
                    txt_recno.Text = ExecuteQuery("Oil_max_receipt_no")
                    'txt_recno.Text = ExecuteQuery("Oil_max_receipt_no '" & Session("Dept_type").ToString() & "'")
                    edit_combo(ddldepot, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "'")
                    btnSubmit.Attributes.Add("onclick", "return validate();ValidateSave();")

                    If Not Session("LocID").ToString Is Nothing Then
                        bdpchallandate.SelectedDate = Now.Date
                        bdprecdate.SelectedDate = Now.Date
                        BDPchqdate.SelectedDate = Now.Date
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
                recfyyear.Value = GetFinYear(1)
                cmd = New SqlCommand("ins_oilrecmaster", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@vendor", intvendor)
                cmd.Parameters.AddWithValue("@oilrecdate", bdprecdate.SelectedDate)
                cmd.Parameters.AddWithValue("@challan_no ", txtchalan.Text)
                cmd.Parameters.AddWithValue("@challan_date", bdpchallandate.SelectedDate)

                cmd.Parameters.AddWithValue("@chqno ", txtchqno.Text)
                cmd.Parameters.AddWithValue("@chqdate", BDPchqdate.SelectedDate)
                cmd.Parameters.AddWithValue("@chqamt ", txtchqamt.Text)

                cmd.Parameters.AddWithValue("@pono", hdnPoNo.Value)
                cmd.Parameters.AddWithValue("@podate", hdnPoDate.Value)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@locid", Session("LocID"))
                cmd.Parameters.AddWithValue("@oilfy", recfyyear.Value)
                cmd.Parameters.AddWithValue("@recno", txt_recno.Text)

                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                con.Close()

                Dim issuemaxid As String = "0"
                If ddldepot.SelectedValue <> "1" And ddldepot.SelectedValue <> "2" Then
                    cmd.Parameters.Clear()
                    cmd = New SqlCommand("ins_oilissuemaster", con)
                    cmd.CommandType = CommandType.StoredProcedure


                    cmd.Parameters.AddWithValue("@oilissuedate", bdprecdate.SelectedDate)
                    cmd.Parameters.AddWithValue("@oilrefno", "")
                    cmd.Parameters.AddWithValue("@workername", "")
                    cmd.Parameters.AddWithValue("@oiligatepass", "")
                    cmd.Parameters.AddWithValue("@oilapprovedby", "")
                    cmd.Parameters.AddWithValue("@oilissuedepot", ddldepot.SelectedValue)
                    cmd.Parameters.AddWithValue("@remark", "")
                    cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                    cmd.Parameters.AddWithValue("@locid", Session("LocID"))


                    Dim strissuemaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                    strmaxid.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(strmaxid)

                    con.Open()
                    cmd.ExecuteNonQuery()
                    issuemaxid = cmd.Parameters("@maxid").Value.ToString()
                    con.Close()
                End If
                If hdnrwcnt.Value <> "" Then
                    'Dim i As Integer
                    Dim str As String = hdnrwcnt.Value
                    Dim myarray As Array = Split(hdndetail.Value, "|")
                    Dim j As Integer
                    j = myarray.Length - 1

                    For i = 0 To myarray.Length - 2
                        If myarray(i) <> "" Then
                            Dim mainarray As Array = Split(myarray(i), "^")
                            If mainarray(5) <> 0 Then

                                ' Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & mainarray(4) & "','" & mainarray(2) & "','" & mainarray(1) & "'")
                                cmd = New SqlCommand("ins_oilrecdetail", con)
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@oilrecmstid ", maxid)
                                cmd.Parameters.AddWithValue("@oilitemname", mainarray(1))
                                cmd.Parameters.AddWithValue("@rate", mainarray(7))
                                cmd.Parameters.AddWithValue("@ltrperbarrel", mainarray(2))
                                cmd.Parameters.AddWithValue("@recbarrel", mainarray(5))
                                cmd.Parameters.AddWithValue("@oilpodetailid", mainarray(0))

                                con.Open()
                                cmd.ExecuteNonQuery()

                                con.Close()
                                If ddldepot.SelectedValue <> "1" And ddldepot.SelectedValue <> "2" Then
                                    Dim issuetotal As Decimal = mainarray(2) * mainarray(5)
                                    cmd = New SqlCommand("ins_issuedetail", con)
                                    cmd.CommandType = CommandType.StoredProcedure

                                    cmd.Parameters.AddWithValue("@oilissueid", issuemaxid)
                                    cmd.Parameters.AddWithValue("@oilitemname", mainarray(1))
                                    cmd.Parameters.AddWithValue("@issueltrperbarrel", mainarray(2))
                                    cmd.Parameters.AddWithValue("@issuebarrel", mainarray(5))
                                    cmd.Parameters.AddWithValue("@issuetotal", issuetotal)


                                    con.Open()
                                    cmd.ExecuteNonQuery()
                                    con.Close()
                                End If
                            End If
                            Response.Write("<script>alert('Saved Successfuly');window.location.href='oilreceipt.aspx'</script>")
                            hdndetail.Value = ""
                        End If

                    Next
                End If


            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        Public Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = bdprecdate.SelectedDate
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
