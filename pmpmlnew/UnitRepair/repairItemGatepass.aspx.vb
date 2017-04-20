Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class repairItemGatepass
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then


                Try
                    BDPLite1.SelectedDate = Now.Date
                    ' BDPreqdate.SelectedDate = Now.Date
                    btnSubmit.Attributes.Add("Onclick", "return validate ()")
                    trother.Visible = "True"
                    'edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "gatepasstypeid = '3'")
                    'edit_combo(nmmtdept, "gpdeptid", "gpdeptdesc", "tbl_gatepassdept", " gpdeptid  = '11' ")
                    'edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "' and isRepair  = '1'")
                    maxid()
                    BindGrid(dgresult, con, "repairItem_gatepass")

                Catch ex As Exception


                End Try
            End If

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

            BindGrid(dgresult, con, "repairItem_gatepass")
        End Sub

        Protected Sub txtoutchallanno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtoutchallanno.TextChanged
            Try
                Dim dt As DataTable = GetDatatTable("repairItem_gatepass  '" & txtoutchallanno.Text & "'")
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

        'Protected Sub ddltoloc_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddltoloc.SelectedIndexChanged
        '    Try
        '        edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "type = " & ddltoloc.SelectedValue & "")
        '        If ddltoloc.SelectedValue = 1 Then
        '            tdven.Visible = True
        '            tdvendor.Visible = True
        '        Else
        '            tdven.Visible = False
        '            tdvendor.Visible = False
        '        End If
        '    Catch ex As Exception

        '    End Try
        'End Sub
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
        Protected Sub nmmtdept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles nmmtdept.SelectedIndexChanged
            maxid()
            hdnrwcnt.Value = ""
            hdndetail.Value = ""
            Dim depttype As String = ExecuteQuery("select gpdepttype  from tbl_gatepassdept    where gpdeptid = " & nmmtdept.SelectedValue & "")
            hdndepttype.Value = depttype.ToString()
            'If depttype = "0" Then
            '    trmain.Visible = True
            '    trother.Visible = False
            'Else
            '    trmain.Visible = False
            '    trother.Visible = True
            'End If

            'If nmmtdept.SelectedValue = "3" Then
            '    txtqty.Text = "1"
            '    txtqty.ReadOnly = True
            'Else
            '    txtqty.Text = "0"
            '    txtqty.ReadOnly = False
            'End If
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
                cmd.Parameters.AddWithValue("@reqno", 0)
                cmd.Parameters.AddWithValue("@reqdate", 0)
                cmd.Parameters.AddWithValue("@Authorisedperson", txtauthperson.Text)
                cmd.Parameters.AddWithValue("@audesignation", txtaudesign.Text)
                cmd.Parameters.AddWithValue("@auidno", txtauid.Text)
                cmd.Parameters.AddWithValue("@busno", txtbusno.Text)
                cmd.Parameters.AddWithValue("@issuedby", txtissuename.Text)
                cmd.Parameters.AddWithValue("@issuedesignation", txtissuedesig.Text)
                cmd.Parameters.AddWithValue("@issueid", txtissueid.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@note", txtnote.Text)
                cmd.Parameters.AddWithValue("@businkm", 0)
                cmd.Parameters.AddWithValue("@busoutkm", 0)
                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)
                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                con.Close()

                Dim id As Integer
                id = maxid

                'Dim i As Integer
                Dim str As String = Hid_Rec.Value

                For i = 0 To dgresult.Items.Count - 1



                    'Dim txtmfgyear As TextBox = CType(dgresult.Items(i).Cells(3).FindControl("txtmfgyear"), TextBox)

                    'Dim ddlplanetype As DropDownList = CType(dgresult.Items(i).Cells(6).FindControl("ddlptype"), DropDownList)
                    Dim ddlunit As DropDownList = CType(dgresult.Items(i).Cells(6).FindControl("ddlunit2"), DropDownList)
                    Dim txtremark As TextBox = CType(dgresult.Items(i).Cells(6).FindControl("txtremark"), TextBox)
                    Dim txtqty As TextBox = CType(dgresult.Items(i).Cells(5).FindControl("txtqty"), TextBox)
                    Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(7).FindControl("chkselect"), CheckBox)



                    If chkselect.Checked = True Then
                        Dim isreturn As Integer = 1
                        'If myarray(i) <> "" Then
                        '    Dim mainarray As Array = Split(myarray(i), "^")
                        cmd = New SqlCommand("Ins_RepairGatepassdetail", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@gatemstid", id)
                        cmd.Parameters.AddWithValue("@serialno", Trim(dgresult.Items(i).Cells(3).Text).Replace("&nbsp;", ""))
                        cmd.Parameters.AddWithValue("@itemname", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@actqty", dgresult.Items(i).Cells(4).Text)
                        cmd.Parameters.AddWithValue("@qty", txtqty.Text)
                        cmd.Parameters.AddWithValue("@unit", ddlunit.SelectedValue)
                        cmd.Parameters.AddWithValue("@remark", txtremark.Text)
                        cmd.Parameters.AddWithValue("@isreturn", "Yes")
                        cmd.Parameters.AddWithValue("@repairworkid", dgresult.Items(i).Cells(0).Text)
                        cmd.Parameters.AddWithValue("@RepairRecDtlId", dgresult.Items(i).Cells(9).Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("<script>alert('Saved Successfuly');if(confirm('Do You Want To Print Gatepass')){window.location.href = '../store/printgatepass.aspx?challanno=" + txtchallanno.Text + "' }</script>")
                        con.Close()

                    End If

                Next

            Catch ex As Exception
            End Try
        End Sub

        Protected Sub print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Print.Click
            'Response.Redirect("../store/printgatepass.aspx")
            Response.Redirect("../store/printgatepass.aspx?gatepassno=" + txtchallanno.Text + "")
        End Sub

        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.Cells(3).Text = "0" Then
                e.Item.Cells(3).Text = "NA"
            End If
        End Sub
        Protected Sub btnadd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnadd.Click
            Dim dt As New DataTable
            Dim dt1 As New DataTable
            Try
                dt.Columns.Add("srno")
                dt.Columns.Add("RepairWorkId")
                dt.Columns.Add("Itemid")
                dt.Columns.Add("item_name")
                dt.Columns.Add("serialNo")
                dt.Columns.Add("Qty")
                dt.Columns.Add("txtqty")
                dt.Columns.Add("unit")
                dt.Columns.Add("txtRemark")
                dt.Columns.Add("RepairRecDtlId")
                dt.Columns.Add("chkselect")

                dt1.Columns.Add("srno")
                dt1.Columns.Add("RepairWorkId")
                dt1.Columns.Add("Itemid")
                dt1.Columns.Add("item_name")
                dt1.Columns.Add("serialNo")
                dt1.Columns.Add("Qty")
                dt1.Columns.Add("txtqty")
                dt1.Columns.Add("unit")
                dt1.Columns.Add("txtRemark")
                dt1.Columns.Add("RepairRecDtlId")
                dt1.Columns.Add("chkselect")




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
                        dt1.Rows.Add(b1, dgresult.Items(j).Cells(0).Text, dgresult.Items(j).Cells(1).Text, dgresult.Items(j).Cells(2).Text, dgresult.Items(j).Cells(3).Text, dgresult.Items(j).Cells(4).Text, dgresult.Items(j).Cells(5).Text, dgresult.Items(j).Cells(6).Text, dgresult.Items(j).Cells(7).Text, dgresult.Items(j).Cells(9).Text)
                        b1 = b1 + 1
                    Next



                    dt1.Rows.Add(b1, 0, 0, txtitem1.Text, txtPartNo.Text, txtqty1.Text, txtqty1.Text, ddlunit1.SelectedItem.Text, txtremark1.Text, 0)
                    b1 = b1 + 1

                    'If Select1.Items(i).Enabled = True Then
                Else
                    dt.Rows.Add(b1, 0, 0, txtitem1.Text, txtPartNo.Text, txtqty1.Text, txtqty1.Text, ddlunit1.SelectedItem.Text, txtremark1.Text, 0)
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

                txtremark1.Text = ""
                txtPartNo.Focus()
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
