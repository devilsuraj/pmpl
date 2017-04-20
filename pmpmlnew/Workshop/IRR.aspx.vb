Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class IRR
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strJocno As String = ""
        Public strBusno As String = ""
        Public strmech As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            ddlbusno.Focus()
            If Not IsPostBack Then
                'Fill_Combo("JOC_id", "JOC_No", "JobOrderCard_Master", ddljobno, con, "", "Select")
                Fill_Combo("unititemid", "uinititem", "tbl_UnitItemList", ddlrepait, con, "", "")
                txtjotime.Text = Now.Hour & ":" & Now.Minute & ":" & Now.Second
                ' strJocno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=0 order by joccode", "joccode")
                strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")
                strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            End If
            maxid()
            'BindGrid(grddeffectlist, con, "select deffect_id,deffect_decr from tbl_deffect_Master where subid=" & ddldeffect.SelectedValue & "")
            'Select1.Items.Clear()
        End Sub
        Sub maxid()
            Try
                Dim id1, id2 As String
                id1 = GetMaxId("IRR_Id", con, "Indent_Repair_Replacement_Items")
                Dim ln As Integer
                ln = id1.Length
                If ln = 1 Then
                    txtirrno.Text = "00000" & id1
                ElseIf ln = 2 Then
                    txtirrno.Text = "0000" & id1
                ElseIf ln = 3 Then
                    txtirrno.Text = "000" & id1
                ElseIf ln = 4 Then
                    txtirrno.Text = "00" & id1
                ElseIf ln = 5 Then
                    txtirrno.Text = "0" & id1
                ElseIf ln >= 6 Then
                    txtirrno.Text = id1
                End If
                Session("irrid") = id1
                con.Close()
                'txtjocno.Text = "dfgdf"
            Catch ex As Exception
            End Try
        End Sub
        Sub ddljobno_SelectedIndexCha()
            Try
                cmd = New SqlClient.SqlCommand
                ds = New DataSet
                cmd.Connection = con
                con.Open()
                DA = New SqlClient.SqlDataAdapter("select JOC_id,busno,model,chassis,kms,engine,Mechanicname from JobOrderCard_Master where joccode like '%" & ddljobno.Value & "%'", con)
                DA.Fill(ds, "tblEmp")
                'ddlbusno.SelectedIndex = ddljobno.SelectedIndex
                'ddlbusno.Text = ds.Tables("tblEmp").Rows(0).Item("busno").ToString
                Session("jobid") = ds.Tables("tblEmp").Rows(0).Item("JOC_id").ToString
                txtmodel.Text = ds.Tables("tblEmp").Rows(0).Item("model").ToString
                txtchassis.Text = ds.Tables("tblEmp").Rows(0).Item("chassis").ToString
                txtkms.Text = ds.Tables("tblEmp").Rows(0).Item("kms").ToString
                txtengine.Text = ds.Tables("tblEmp").Rows(0).Item("engine").ToString
                txtjobmachanic.Text = ds.Tables("tblEmp").Rows(0).Item("Mechanicname").ToString
                con.Close()
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        'Protected Sub ddljobno_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddljobno.SelectedIndexChanged
        '    Try
        '        cmd = New SqlClient.SqlCommand
        '        ds = New DataSet
        '        cmd.Connection = con
        '        con.Open()
        '        DA = New SqlClient.SqlDataAdapter("select JOC_id,joccode,busno,model,chassis,kms,engine,Mechanicname from JobOrderCard_Master where joccode like '%" & ddljobno.SelectedItem.Text & "%'", con)
        '        DA.Fill(ds, "tblEmp")
        '        ddlbusno.SelectedIndex = ddljobno.SelectedIndex
        '        'ddlbusno.Text = ds.Tables("tblEmp").Rows(0).Item("busno").ToString
        '        Session("jobid") = ds.Tables("tblEmp").Rows(0).Item("JOC_id").ToString
        '        txtmodel.Text = ds.Tables("tblEmp").Rows(0).Item("model").ToString
        '        txtchassis.Text = ds.Tables("tblEmp").Rows(0).Item("chassis").ToString
        '        txtkms.Text = ds.Tables("tblEmp").Rows(0).Item("kms").ToString
        '        txtengine.Text = ds.Tables("tblEmp").Rows(0).Item("engine").ToString
        '        txtjobmachanic.Text = ds.Tables("tblEmp").Rows(0).Item("Mechanicname").ToString
        '        con.Close()
        '    Catch ex As Exception
        '        Response.Write(ex.Message)
        '    End Try
        'End Sub
        'Protected Sub ddlbusno_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlbusno.SelectedIndexChanged
        '    Try
        '        cmd = New SqlClient.SqlCommand
        '        ds = New DataSet
        '        cmd.Connection = con
        '        con.Open()
        '        DA = New SqlClient.SqlDataAdapter("select JOC_id,joccode,model,chassis,kms,engine,Mechanicname from JobOrderCard_Master where busno like '%" & ddlbusno.SelectedItem.Text & "%'", con)
        '        DA.Fill(ds, "tblEmp")
        '        'ddljobno.SelectedIndex = ddlbusno.SelectedIndex
        '        'ddlbusno.Text = ds.Tables("tblEmp").Rows(0).Item("busno").ToString
        '        Session("jobid") = ds.Tables("tblEmp").Rows(0).Item("JOC_id").ToString
        '        txtmodel.Text = ds.Tables("tblEmp").Rows(0).Item("model").ToString
        '        txtchassis.Text = ds.Tables("tblEmp").Rows(0).Item("chassis").ToString
        '        txtkms.Text = ds.Tables("tblEmp").Rows(0).Item("kms").ToString
        '        txtengine.Text = ds.Tables("tblEmp").Rows(0).Item("engine").ToString
        '        txtjobmachanic.Text = ds.Tables("tblEmp").Rows(0).Item("Mechanicname").ToString
        '        con.Close()
        '    Catch ex As Exception
        '        Response.Write(ex.Message)
        '    End Try
        'End Sub
        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            Try
                maxid()
                'ddljobno.SelectedValue = 0
                'ddlbusno.SelectedValue = 0
                txtmechanic.Value = ""
                txtmodel.Text = ""
                txtchassis.Text = ""
                txtkms.Text = ""
                txtengine.Text = ""
                txtjobmachanic.Text = ""
                ddlrepait.SelectedValue = 0
                txtpartno.Text = ""
                txtremark.Text = ""
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            'Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            ddljobno_SelectedIndexCha() 'added 18/01
            Try
                If ddljobno.Value = "" Or ddlbusno.Value = "" Then
                    Call Show_Msg(Page, "Select Job Order Card No", "IRR.aspx")
                    ddljobno.Focus()
                Else
                    If txtmechanic.Value = "" Then
                        Call Show_Msg(Page, "Insert Mechanic Name ", "IRR.aspx")
                        strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")

                        txtmechanic.Focus()
                    Else
                        cmd = New SqlCommand
                        ds = New DataSet
                        DA = New SqlDataAdapter
                        cmd.Connection = con
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.CommandText = "ins_IRR_master"
                        cmd.Parameters.AddWithValue("@IRR_No", txtirrno.Text)
                        cmd.Parameters.AddWithValue("@JOC_ID", Session("jobid"))


                        cmd.Parameters.AddWithValue("@Mechanicname", txtmechanic.Value)
                        cmd.Parameters.AddWithValue("@Item_name", ddlrepait.SelectedItem.Text)
                        cmd.Parameters.AddWithValue("@part_NO", txtpartno.Text)
                        cmd.Parameters.AddWithValue("@repair_regNo", "")
                        cmd.Parameters.AddWithValue("@fit_Mechanicname", "")
                        cmd.Parameters.AddWithValue("@remark", txtremark.Text)
                        cmd.Parameters.AddWithValue("@fit_Remark", "")
                        cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                        cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                        'Call Show_Msg(Page, "Save Successfully", "Job_Order_Card.aspx")
                        'Response.Write("<script>window.location.href='../report/rptJOC.aspx?id=1'</script>")
                        Response.Write("<script>window.location.href='../report/rptIRR.aspx?id=1&irrid=" + Session("irrid") + "'</script>")

                        strJocno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=0 order by joccode", "joccode")

                        strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")
                        strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
                        Fill_Combo("unititemid", "uinititem", "tbl_UnitItemList", ddlrepait, con, "", "")
                    End If
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
    End Class
End Namespace