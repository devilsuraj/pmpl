Imports System.Data.SqlClient
Namespace KDMT

    Partial Class AsudgaonRepairRec_Gatepass
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

            'btnSubmit.Attributes.Add("onclick", "return ValidateSave();")
            'ImageButtonupdate.Attributes.Add("onclick", "return validateSave1();")
            If Page.IsPostBack = False Then
                Try
                    hdnrwcnt.Value = ""
                    hdndetail.Value = ""
                    'edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "type = " & ddltoloc.SelectedValue & "  order by gatepasstypedesc ")
                    ' edit_combo(nmmtdept, "gpdeptid", "gpdeptdesc", "tbl_gatepassdept", "0=0  ")

                    If Not Session("LocID").ToString Is Nothing Then
                        'BDPLite1.SelectedDate = Now.Date
                        secdate.SelectedDate = Now.Date
                        BDPChalldate.SelectedDate = Now.Date
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

            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                'cmd = New SqlCommand("ins_gatepassreturn", con)
                'cmd.CommandType = CommandType.StoredProcedure


                'cmd.Parameters.AddWithValue("@gatepasstype", ddltoloc.SelectedValue)
                'cmd.Parameters.AddWithValue("@challanno", txtvendor.Text)
                'cmd.Parameters.AddWithValue("@gatepasstypeno", txtChallan.Text)
                'cmd.Parameters.AddWithValue("@reqdate", BDPChalldate.SelectedDate)
                'cmd.Parameters.AddWithValue("@nmmtchallan", txtnote.Text)

                '' cmd.Parameters.AddWithValue("@challandate", BDPLite1.SelectedDate)
                ''cmd.Parameters.AddWithValue("@fromdept", nmmtdept.SelectedValue)
                'If (ddltoloc.SelectedValue <> "1") Then
                '    cmd.Parameters.AddWithValue("@toplace", 0)
                'Else
                '    cmd.Parameters.AddWithValue("@toplace", ddltoloc.SelectedValue)
                'End If

                ''If (ddlgatepasstype.SelectedValue = "0") Then
                ''    cmd.Parameters.AddWithValue("@outforwhat", 1)
                ''Else
                ''    cmd.Parameters.AddWithValue("@outforwhat", ddlgatepasstype.SelectedValue)
                ''End If

                'cmd.Parameters.AddWithValue("@vendor", txtvendor.Text)
                ''cmd.Parameters.AddWithValue("@reqno", txtreq.Text)

                '' cmd.Parameters.AddWithValue("@Authorisedperson", txtauthperson.Text)
                '' cmd.Parameters.AddWithValue("@audesignation", txtaudesign.Text)
                '' cmd.Parameters.AddWithValue("@auidno", txtauid.Text)
                ''cmd.Parameters.AddWithValue("@busno", txtbusno.Text)
                '' cmd.Parameters.AddWithValue("@issuedby", txtissuename.Text)
                ''cmd.Parameters.AddWithValue("@issuedesignation", txtissuedesig.Text)
                '' cmd.Parameters.AddWithValue("@issueid", txtissueid.Text)
                'cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                'cmd.Parameters.AddWithValue("@note", txtnote.Text)
                '' cmd.Parameters.AddWithValue("@businkm", txtbusinkm.Text)
                '' cmd.Parameters.AddWithValue("@busoutkm", txtbusinkm.Text)
                ''cmd.Parameters.AddWithValue("@DepoLoc", ddlDepoLoc.SelectedValue)
                'Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                'strmaxid.Direction = ParameterDirection.Output
                'cmd.Parameters.Add(strmaxid)
                'con.Open()
                'cmd.ExecuteNonQuery()
                'Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                'con.Close()

                'Dim id As Integer
                'id = maxid
                'If hdndetail.Value <> "" Then
                '    'Dim i As Integer
                '    Dim str As String = Hid_Rec.Value
                '    Dim myarray As Array = Split(hdndetail.Value, "|")

                '    For i = 0 To myarray.Length - 2
                '        If myarray(i) <> "" Then






                '            Dim mainarray As Array = Split(myarray(i), "^")


                '            Dim ItemId As String = ExecuteQuery("select itemid from tbl_repair_item where item_name = " & mainarray(1) & "")
                '            cmd = New SqlCommand("ins_Asudgaongatepassreturn", con)
                '            cmd.CommandType = CommandType.StoredProcedure






                '            cmd.Parameters.AddWithValue("@inchallanno", txtChallan.Text)
                '            cmd.Parameters.AddWithValue("@recqty", mainarray(8))
                '            cmd.Parameters.AddWithValue("@recremark", mainarray(10))
                '            cmd.Parameters.AddWithValue("@recdate", BDPChalldate.SelectedDate)

                '            cmd.Parameters.AddWithValue("@ItemId", ItemId)
                '            cmd.Parameters.AddWithValue("@SerialNo", mainarray(0))
                '            cmd.Parameters.AddWithValue("@location", ddltoloc.SelectedValue)
                '            cmd.Parameters.AddWithValue("@vendor", txtvendor.Text)
                '            'cmd.Parameters.AddWithValue("@companyno", mainarray(2))
                '            ' cmd.Parameters.AddWithValue("@nmmtno", mainarray(3))
                '            ' cmd.Parameters.AddWithValue("@mfgyear", mainarray(4))
                '            'cmd.Parameters.AddWithValue("@compname", mainarray(5))
                '            'cmd.Parameters.AddWithValue("@remoldtype", mainarray(6))
                '            'cmd.Parameters.AddWithValue("@hotcold", mainarray(7))


                '            ' cmd.Parameters.AddWithValue("@unit", mainarray(9))

                '            'cmd.Parameters.AddWithValue("@isreturn", mainarray(11))





                '            con.Open()
                '            cmd.ExecuteNonQuery()
                '            'Response.Write("<script>alert('Saved Successfuly');if(confirm('Do You Want To Print Gatepass')){window.location.href = '../store/printgatepass.aspx?challanno=" + txtchallanno.Text + "' }</script>")
                '            con.Close()
                '            hdndetail.Value = ""
                '        End If
                '    Next
                'End If

                Dim check As Integer = 0
                For i = 0 To dgresult.Items.Count - 1



                    Dim txtRemark As TextBox = CType(dgresult.Items(i).Cells(6).FindControl("txtRemark"), TextBox)
                    'Dim chkReturn As CheckBox = CType(dgresult.Items(i).Cells(8).FindControl("chkreturn"), CheckBox)
                    Dim chkSelect As CheckBox = CType(dgresult.Items(i).Cells(9).FindControl("chkselect"), CheckBox)

                    If chkSelect.Checked = True Then

                        'cmd = New SqlCommand("Ins_storerRepairGatepassdetail", con)
                        'cmd.CommandType = CommandType.StoredProcedure
                        'cmd.Parameters.AddWithValue("@gatemstid", id)
                        'cmd.Parameters.AddWithValue("@issueid", dgresult.Items(i).Cells(1).Text)
                        'cmd.Parameters.AddWithValue("@partno", dgresult.Items(i).Cells(2).Text)
                        'cmd.Parameters.AddWithValue("@itemname", dgresult.Items(i).Cells(3).Text)
                        'cmd.Parameters.AddWithValue("@companyno", "")
                        'cmd.Parameters.AddWithValue("@nmmtno", "")
                        'cmd.Parameters.AddWithValue("@mfgyear", "")
                        'cmd.Parameters.AddWithValue("@compname", "")
                        'cmd.Parameters.AddWithValue("@remoldtype", "")
                        'cmd.Parameters.AddWithValue("@hotcold", "")
                        'cmd.Parameters.AddWithValue("@qty", dgresult.Items(i).Cells(4).Text)
                        'cmd.Parameters.AddWithValue("@unit", dgresult.Items(i).Cells(5).Text)
                        'cmd.Parameters.AddWithValue("@remark", txtRemark.Text)
                        'If (chkReturn.Checked = "True") Then
                        '    cmd.Parameters.AddWithValue("@isreturn", "Yes")
                        'Else
                        '    cmd.Parameters.AddWithValue("@isreturn", "No")
                        'End If


                        Dim ItemId As String = ExecuteQuery("select itemid from tbl_repair_item where item_name = '" & dgresult.Items(i).Cells(3).Text & "'")
                        cmd = New SqlCommand("ins_Asudgaongatepassreturn", con)
                        cmd.CommandType = CommandType.StoredProcedure






                        cmd.Parameters.AddWithValue("@inchallanno", txtChallan.Text)
                        cmd.Parameters.AddWithValue("@recqty", dgresult.Items(i).Cells(4).Text)
                        cmd.Parameters.AddWithValue("@recremark", txtRemark.Text) '  dgresult.Items(i).Cells(6).Text)
                        cmd.Parameters.AddWithValue("@recdate", BDPChalldate.SelectedDate)

                        cmd.Parameters.AddWithValue("@ItemId", ItemId)
                        cmd.Parameters.AddWithValue("@SerialNo", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@location", ddltoloc.SelectedValue)
                        cmd.Parameters.AddWithValue("@vendor", txtvendor.Text)




                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                        check = 1

                    End If

                Next
                'If check = 1 Then
                '    Response.Write("<script>alert('Saved Successfuly');if(confirm('Do You Want To Print Gatepass')){window.location.href = '../store/printgatepass.aspx?challanno=" + txtchallanno.Text + "' }</script>")
                'Else
                '    Response.Write("<script>alert('Please Tick the boxes ')</script>")
                'End If


            Catch ex As Exception
            End Try
            Response.Redirect("AsudgaonRepairRec_Gatepass.aspx")
            ' BindGrid(dgresult, con, "viewGatepassStoreIssue")

        End Sub


        'Protected Sub ddlgatepasstype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlgatepasstype.SelectedIndexChanged

        'End Sub

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

        'Protected Sub radtype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles radtype.SelectedIndexChanged
        '    If radtype.SelectedValue = "0" Then
        '        tblmain.Visible = True
        '        tblsecurity.Visible = False
        '        txtoutchallanno.Text = ""
        '    Else
        '        tblmain.Visible = False
        '        tblsecurity.Visible = True
        '    End If
        'End Sub

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
                'Dim depttype As String = ExecuteQuery("select gpdepttype  from tbl_gatepassdept    where gpdeptid = " & nmmtdept.SelectedValue & "")
                'hdndepttype.Value = depttype.ToString()
                'If depttype = "0" Then
                '    trmain.Visible = True
                '    trother.Visible = False
                'Else
                '    trmain.Visible = False
                '    trother.Visible = True
                'End If
                'edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "type = " & ddltoloc.SelectedValue & "")
                'If ddltoloc.SelectedValue = 0 Then
                '    ddlgatepasstype.Visible = "False"
                'Else
                '    ddlgatepasstype.Visible = "True"
                'End If
                If ddltoloc.SelectedValue = 1 Then
                    tdven.Visible = True
                    tdvendor.Visible = True
                Else
                    tdven.Visible = False
                    tdvendor.Visible = False
                End If
                BindGrid(dgresult, con, "viewGatepassStoreIssue")
                trgate.Visible = "True"
                trother.Visible = "True"
            Catch ex As Exception
            End Try
        End Sub

        'Protected Sub nmmtdept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles nmmtdept.SelectedIndexChanged
        '    maxid()
        '    hdnrwcnt.Value = ""
        '    hdndetail.Value = ""
        '    '    'Dim depttype As String = ExecuteQuery("select gpdepttype  from tbl_gatepassdept    where gpdeptid = " & nmmtdept.SelectedValue & "")
        '    '    'hdndepttype.Value = depttype.ToString()
        '    '    'If depttype = "0" Then
        '    '    '    trmain.Visible = True
        '    '    '    trother.Visible = False
        '    '    'Else
        '    '    '    trmain.Visible = False
        '    '    '    trother.Visible = True
        '    '    'End If

        '    '    If nmmtdept.SelectedValue = "3" Then
        '    '        txtqty.Text = "1"
        '    '        txtqty.ReadOnly = True
        '    '    Else
        '    '        txtqty.Text = "0"
        '    '        txtqty.ReadOnly = False
        '    '    End If
        'End Sub

        Protected Sub print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles print.Click
            Response.Redirect("printgatepass.aspx")
        End Sub

        Protected Sub btnadd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnadd.Click
            Dim dt As New DataTable
            Dim dt1 As New DataTable
            Try
                dt.Columns.Add("srno")
                dt.Columns.Add("issue_id")
                dt.Columns.Add("part_no")
                dt.Columns.Add("item_name")
                dt.Columns.Add("total_qty")
                dt.Columns.Add("unit")
                dt.Columns.Add("txtRemark")
                dt.Columns.Add("ischeck")
                dt.Columns.Add("chkreturn")


                dt1.Columns.Add("srno")
                dt1.Columns.Add("issue_id")
                dt1.Columns.Add("part_no")
                dt1.Columns.Add("item_name")
                dt1.Columns.Add("total_qty")
                dt1.Columns.Add("unit")
                dt1.Columns.Add("txtRemark")
                dt1.Columns.Add("ischeck")
                dt1.Columns.Add("chkreturn")



                Dim dr As DataRow
                dr = dt.NewRow
                Dim dr1 As DataRow
                dr1 = dt1.NewRow
                Dim i As Integer = 0
                Dim k As Integer = 0
                Dim b As Integer = 1
                Dim str As String = String.Empty
                Dim j As Integer = 0
                Dim b1 As Integer = 1
                Dim presenent As String = ""


                If dgresult.Items.Count > 0 Then
                    'dt1.Rows.Clear()  'comented on 15/01
                    b1 = 1
                    For j = 0 To dgresult.Items.Count - 1
                        dt1.Rows.Add(b1, dgresult.Items(j).Cells(1).Text, dgresult.Items(j).Cells(2).Text, dgresult.Items(j).Cells(3).Text, dgresult.Items(j).Cells(4).Text, dgresult.Items(j).Cells(5).Text, dgresult.Items(j).Cells(6).Text, dgresult.Items(j).Cells(7).Text)
                        b1 = b1 + 1
                    Next



                    dt1.Rows.Add(b1, 0, txtPartNo.Text, txtitem1.Text, txtqty1.Text, ddlunit1.SelectedItem.Text, txtremark1.Text, IIf(chkreturn1.Checked = True, 1, 0))
                    b1 = b1 + 1

                    'If Select1.Items(i).Enabled = True Then
                Else
                    dt.Rows.Add(b, 0, txtPartNo.Text, txtitem1.Text, txtqty1.Text, ddlunit1.SelectedItem.Text, txtremark1.Text, IIf(chkreturn1.Checked = True, 1, 0))
                    b1 = b1 + 1
                End If

                i = 0

                If dgresult.Items.Count = 0 Then
                    dgresult.DataSource = dt
                    dgresult.DataBind()
                Else
                    dgresult.DataSource = dt1
                    dgresult.DataBind()
                End If

                txtPartNo.Text = ""
                txtitem1.Text = ""
                txtqty1.Text = ""
                ddlunit1.Text = ""
                txtremark1.Text = ""
                txtPartNo.Focus()
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound

            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
                Dim chkselect As CheckBox
                chkselect = e.Item.Cells(8).FindControl("chkreturn")
                If e.Item.Cells(7).Text = "1" Then
                    chkselect.Checked = "True"
                Else
                    chkselect.Checked = "False"
                End If
            End If

        End Sub







    End Class

End Namespace