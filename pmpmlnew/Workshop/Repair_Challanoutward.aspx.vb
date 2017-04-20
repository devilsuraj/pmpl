Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Repair_Challanoutward
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strdept As String = ""
        Public stritem As String = ""
        Public strapp As String = ""
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            'strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            'strdept = getAutoCompleteList("select cont_name from contractor_master where subid=1 order by cont_name", "cont_name")
            stritem = getAutoCompleteList("select item_name from tbl_Repair_Item order by item_name", "item_name")
            'strapp = getAutoCompleteList("select distinct(approveby) from tbl_Repair_Recevie_dtl order by approveby", "approveby")

            btnSubmit.Attributes.Add("onclick", "return ValidateSave();")
            ImageButtonupdate.Attributes.Add("onclick", "return validateSave1();")
            If Page.IsPostBack = False Then
                Try
                    hdnrwcnt.Value = ""
                    hdndetail.Value = ""
                    edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "type = " & ddltoloc.SelectedValue & "  order by gatepasstypedesc ")
                    edit_combo(nmmtdept, "gpdeptid", "gpdeptdesc", "tbl_gatepassdept", "0=0  ")

                    If Not Session("LocID").ToString Is Nothing Then
                        BDPLite1.SelectedDate = Now.Date
                        secdate.SelectedDate = Now.Date
                        BDPreqdate.SelectedDate = Now.Date
                    Else
                        Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                    End If
                Catch ex As Exception
                End Try
            End If
        End Sub
        Sub maxid()
            Try
                Dim intid As Integer
                intid = 0
                intid = ExecuteQuery("select isnull(max(gatepasstypeno),0) from gatepassmst ")
                If intid = 0 Then
                    intid = 1
                    hdngatepassno.Value = 1
                Else
                    intid = intid + 1
                    hdngatepassno.Value = intid

                End If
                txtchallanno.Text = DateAndTime.Now.Date.Year.ToString() + "/" + ExecuteQuery("select gpdeptcode  from tbl_gatepassdept  where gpdeptid = " & nmmtdept.SelectedValue & "") + "/" + intid.ToString()
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                cmd = New SqlCommand("Ins_storerRepairGatepassMst", con)
                cmd.CommandType = CommandType.StoredProcedure


                cmd.Parameters.AddWithValue("@gatepasstype", ddlgatepasstype.SelectedValue)
                cmd.Parameters.AddWithValue("@gatepasstypeno", hdngatepassno.Value)
                cmd.Parameters.AddWithValue("@nmmtchallan", txtnmmtchalan.Text)
                cmd.Parameters.AddWithValue("@challanno", txtchallanno.Text)
                cmd.Parameters.AddWithValue("@challandate", BDPLite1.SelectedDate)
                cmd.Parameters.AddWithValue("@fromdept", nmmtdept.SelectedValue)
                cmd.Parameters.AddWithValue("@toplace", ddltoloc.SelectedValue)
                cmd.Parameters.AddWithValue("@outforwhat", ddlgatepasstype.SelectedValue)
                cmd.Parameters.AddWithValue("@vendor", txtvendor.Text)
                cmd.Parameters.AddWithValue("@reqno", txtreq.Text)
                cmd.Parameters.AddWithValue("@reqdate", BDPreqdate.SelectedDate)
                cmd.Parameters.AddWithValue("@Authorisedperson", txtauthperson.Text)
                cmd.Parameters.AddWithValue("@audesignation", txtaudesign.Text)
                cmd.Parameters.AddWithValue("@auidno", txtauid.Text)
                cmd.Parameters.AddWithValue("@busno", txtbusno.Text)
                cmd.Parameters.AddWithValue("@issuedby", txtissuename.Text)
                cmd.Parameters.AddWithValue("@issuedesignation", txtissuedesig.Text)
                cmd.Parameters.AddWithValue("@issueid", txtissueid.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@note", txtnote.Text)
                cmd.Parameters.AddWithValue("@businkm", txtbusinkm.Text)
                cmd.Parameters.AddWithValue("@busoutkm", txtbusinkm.Text)
                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)
                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                con.Close()

                Dim id As Integer
                id = maxid
                If hdndetail.Value <> "" Then
                    'Dim i As Integer
                    Dim str As String = Hid_Rec.Value
                    Dim myarray As Array = Split(hdndetail.Value, "|")

                    For i = 0 To myarray.Length - 2
                        If myarray(i) <> "" Then
                            Dim mainarray As Array = Split(myarray(i), "^")
                            cmd = New SqlCommand("Ins_storerRepairGatepassdetail", con)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@gatemstid", id)
                            cmd.Parameters.AddWithValue("@partno", mainarray(0))
                            cmd.Parameters.AddWithValue("@itemname", mainarray(1))
                            cmd.Parameters.AddWithValue("@companyno", mainarray(2))
                            cmd.Parameters.AddWithValue("@nmmtno", mainarray(3))
                            cmd.Parameters.AddWithValue("@mfgyear", mainarray(4))
                            cmd.Parameters.AddWithValue("@compname", mainarray(5))
                            cmd.Parameters.AddWithValue("@remoldtype", mainarray(6))
                            cmd.Parameters.AddWithValue("@hotcold", mainarray(7))

                            cmd.Parameters.AddWithValue("@qty", mainarray(8))
                            cmd.Parameters.AddWithValue("@unit", mainarray(9))
                            cmd.Parameters.AddWithValue("@remark", mainarray(10))
                            cmd.Parameters.AddWithValue("@isreturn", mainarray(11))
                            con.Open()
                            cmd.ExecuteNonQuery()
                            Response.Write("<script>alert('Saved Successfuly');window.location.href='Repair_Challanoutward.aspx'</script>")
                            con.Close()
                            hdndetail.Value = ""
                        End If
                    Next
                End If
            Catch ex As Exception
            End Try
        End Sub

        Protected Sub ddlgatepasstype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlgatepasstype.SelectedIndexChanged

        End Sub

        Protected Sub ImageButtonupdate_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonupdate.Click
            Try
                cmd = New SqlCommand("UPDATE_SECURITYINFO", con)
                cmd.CommandType = CommandType.StoredProcedure


                cmd.Parameters.AddWithValue("@gatemstid", hdngatepassid.Value)
                cmd.Parameters.AddWithValue("@secdepotname", txtsecname.Text)
                cmd.Parameters.AddWithValue("@securitdate", secdate.SelectedDate)
                cmd.Parameters.AddWithValue("@gateno", txtgateno.Text)
                cmd.Parameters.AddWithValue("@gatetime", txttime.Text)
                cmd.Parameters.AddWithValue("@checkedby", txtcheckedby.Text)
                cmd.Parameters.AddWithValue("@checkeddesignation", txtdesig.Text)
                cmd.Parameters.AddWithValue("@checkid", txtsecid.Text)

                con.Open()
                cmd.ExecuteNonQuery()
                Response.Write("<script>alert('Saved Successfuly');window.location.href='Repair_Challanoutward.aspx'</script>")
                con.Close()
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub radtype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles radtype.SelectedIndexChanged
            If radtype.SelectedValue = "0" Then
                tblmain.Visible = True
                tblsecurity.Visible = False


                txtoutchallanno.Text = ""
            Else
                tblmain.Visible = False
                tblsecurity.Visible = True
            End If
        End Sub

        Protected Sub txtoutchallanno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtoutchallanno.TextChanged
            Try
                Dim dt As DataTable = GetDatatTable("view_gatepassdetail  '" & txtoutchallanno.Text & "'")
                'BindGridview(gvgatepass, con, "view_gatepassdetail  '" & txtoutchallanno.Text & "'")
                If dt.Rows.Count = 0 Then
                    lblmsg.Text = "This gatepass is not exist"

                Else

                    If dt.Rows(0).Item("status").ToString = "True" Then
                        lblmsg.Text = "Information is already submitted"
                    Else
                        hdngatepassid.Value = dt.Rows(0).Item("gatemstid").ToString

                        lblmsg.Text = ""
                        '' gvgatepass.DataSource = dt
                        '' gvgatepass.DataBind()
                    End If

                End If


            Catch ex As Exception

            End Try

        End Sub

        Protected Sub ddltoloc_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddltoloc.SelectedIndexChanged
            Try
                edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "type = " & ddltoloc.SelectedValue & "")
                If ddltoloc.SelectedValue = 1 Then
                    tdven.Visible = True
                    tdvendor.Visible = True
                Else
                    tdven.Visible = False
                    tdvendor.Visible = False
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub nmmtdept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles nmmtdept.SelectedIndexChanged
            maxid()
            hdnrwcnt.Value = ""
            hdndetail.Value = ""
            Dim depttype As String = ExecuteQuery("select gpdepttype  from tbl_gatepassdept    where gpdeptid = " & nmmtdept.SelectedValue & "")
            hdndepttype.Value = depttype.ToString()
            If depttype = "0" Then
                trmain.Visible = True
                trother.Visible = False
            Else
                trmain.Visible = False
                trother.Visible = True
            End If

            If nmmtdept.SelectedValue = "3" Then
                txtqty.Text = "1"
                txtqty.ReadOnly = True
            Else
                txtqty.Text = "0"
                txtqty.ReadOnly = False
            End If
        End Sub

        Protected Sub print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles print.Click
            Response.Redirect("printgatepass.aspx")
        End Sub
    End Class
End Namespace


