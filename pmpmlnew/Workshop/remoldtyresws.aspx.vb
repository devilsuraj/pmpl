Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class remoldtyresws
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
                    BDPreqdate.SelectedDate = Now.Date
                    btnSubmit.Attributes.Add("Onclick", "return validate ()")

                    edit_combo(ddlgatepasstype, "gatepasstypeid", "gatepasstypedesc", "tbl_gatepasstype", "type = " & ddltoloc.SelectedValue & "  order by gatepasstypedesc ")
                    edit_combo(nmmtdept, "gpdeptid", "gpdeptdesc", "tbl_gatepassdept", "gpdeptid=3")

                    BindGrid(dgresult, con, "view_remold_tyres")

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

            BindGrid(dgresult, con, "view_remold_tyres")
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
        'Sub maxid()
        '    Try
        '        Dim intid As Integer
        '        intid = 0
        '        intid = ExecuteQuery("select isnull(max(gatepasstypeno),0) from gatepassmst ")
        '        If intid = 0 Then
        '            intid = 1
        '            hdngatepassno.Value = 1
        '        Else
        '            intid = intid + 1
        '            hdngatepassno.Value = intid

        '        End If
        '        txtchallanno.Text = DateAndTime.Now.Date.Year.ToString() + "/" + ExecuteQuery("select gpdeptcode  from tbl_gatepassdept  where gpdeptid = " & nmmtdept.SelectedValue & "") + "/" + intid.ToString()
        '    Catch ex As Exception
        '    End Try
        'End Sub
        Function getid() As String
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
                Return txtchallanno.Text
            Catch ex As Exception
            End Try
        End Function
        Protected Sub nmmtdept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles nmmtdept.SelectedIndexChanged
            'maxid()
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
                Dim strgatepass As String
                strgatepass = getid()

                cmd = New SqlCommand("Ins_storerRepairGatepassMst", con)
                cmd.CommandType = CommandType.StoredProcedure


                cmd.Parameters.AddWithValue("@gatepasstype", ddlgatepasstype.SelectedValue)
                cmd.Parameters.AddWithValue("@gatepasstypeno", hdngatepassno.Value)
                cmd.Parameters.AddWithValue("@nmmtchallan", txtnmmtchalan.Text)
                cmd.Parameters.AddWithValue("@challanno", strgatepass)
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



                    Dim txtmfgyear As TextBox = CType(dgresult.Items(i).Cells(3).FindControl("txtmfgyear"), TextBox)

                    Dim ddlplanetype As DropDownList = CType(dgresult.Items(i).Cells(6).FindControl("ddlptype"), DropDownList)
                    Dim ddlhotcold As DropDownList = CType(dgresult.Items(i).Cells(7).FindControl("ddlhotcold"), DropDownList)
                    Dim txtremark As TextBox = CType(dgresult.Items(i).Cells(8).FindControl("txtremark"), TextBox)

                    Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(9).FindControl("chkselect"), CheckBox)



                    If chkselect.Checked = True Then
                        Dim isreturn As Integer = 1
                        'If myarray(i) <> "" Then
                        '    Dim mainarray As Array = Split(myarray(i), "^")
                        cmd = New SqlCommand("Ins_storerRepairGatepassdetail", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@gatemstid", id)
                        cmd.Parameters.AddWithValue("@issueid", "")
                        cmd.Parameters.AddWithValue("@partno", dgresult.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@itemname", "Tyre")
                        cmd.Parameters.AddWithValue("@companyno", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@nmmtno", dgresult.Items(i).Cells(3).Text)
                        cmd.Parameters.AddWithValue("@mfgyear", txtmfgyear.Text)
                        cmd.Parameters.AddWithValue("@compname", dgresult.Items(i).Cells(5).Text)
                        cmd.Parameters.AddWithValue("@remoldtype", ddlplanetype.SelectedItem.Text)
                        cmd.Parameters.AddWithValue("@hotcold", ddlhotcold.SelectedValue)

                        cmd.Parameters.AddWithValue("@qty", "1")
                        cmd.Parameters.AddWithValue("@unit", "NOS")
                        cmd.Parameters.AddWithValue("@remark", txtremark.Text)
                        cmd.Parameters.AddWithValue("@isreturn", isreturn)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("<script>alert('Gatepass No: " + txtchallanno.Text + "');</script>")
                        con.Close()

                        cmd = New SqlCommand("Ins_updatepartmaster", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@companyno", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@nmmtno", dgresult.Items(i).Cells(3).Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("<script>alert('Saved Successfuly');if(confirm('Do You Want To Print Gatepass')){window.location.href = '../store/printgatepass.aspx?challanno=" + txtchallanno.Text + "' }</script>")
                        con.Close()
                    End If

                Next

            Catch ex As Exception
            End Try
        End Sub

        Protected Sub print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles print.Click

            Response.Redirect("../store/printgatepass.aspx")
        End Sub


        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then

                Dim txtmfgyear As TextBox = CType(e.Item.FindControl("txtmfgyear"), TextBox)
                txtmfgyear.Attributes.Add("Onblur", "checkyear (" + txtmfgyear.ClientID + ")")
            End If





        End Sub
    End Class
End Namespace

