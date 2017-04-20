Imports System.Data.SqlClient
Namespace KDMT
    Partial Class RepairItemReceivedNew
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

            Try
                stritem = getAutoCompleteList("select item_name from item_detail where item_name like '%as%'  order by item_name", "item_name")
                'btnSubmit.Attributes.Add("onclick", "return validatevendor();")
                If Page.IsPostBack = False Then
                    'Try
                    'maxid()
                    edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "' and isRepair  = '1'")
                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    'If Not Session("LocID").ToString Is Nothing Then
                    'BDPLite1.Text = Now.Date
                    BDPLite1.SelectedDate = Format(Now.Date, "dd/MMM/yyyy")
                    gridbind()

                End If
            Catch ex As Exception

            End Try
        End Sub
        Private Sub gridbind()
            BindGrid(dgresult, con, "RepairItemReceive'" & ddlvendor.SelectedValue & "'")
            If dgresult.Items.Count > 0 Then
                dgresult.Visible = True
                trsave.Visible = True

            Else
                dgresult.Visible = False
                trsave.Visible = False

            End If


        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Dim maxid As Integer
            cmd = New SqlCommand("Ins_UnitRepairReceivemst", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@inwardno", txtInwardNo.Text)
            cmd.Parameters.AddWithValue("@trans_date", BDPLite1.SelectedDate)
            cmd.Parameters.AddWithValue("@dept", ddlvendor.SelectedValue)
            cmd.Parameters.AddWithValue("@userid", Session("Userid"))
            cmd.Parameters.AddWithValue("@submittedby", txtSubmitted.Text)
            cmd.Parameters.AddWithValue("@receivedby", txtReceived.Text)
            Dim strid As New SqlParameter("@repairrecvid", SqlDbType.BigInt)
            strid.Direction = ParameterDirection.Output
            cmd.Parameters.Add(strid)

            con.Open()
            cmd.ExecuteNonQuery()
            maxid = cmd.Parameters("@repairrecvid").Value.ToString
            con.Close()

            'Dim id As Integer
            'id = ExecuteQuery("select isnull(max(repairrecvid),0) from UnitRepairReceivemst")
            For i = 0 To dgresult.Items.Count - 1
                Dim txtqty As TextBox = CType(dgresult.Items(i).Cells(6).FindControl("txtRemark"), TextBox)
                'Dim txtWrkDone As TextBox = CType(dgresult.Items(i).Cells(11).FindControl("txtWrkDone"), TextBox)
                'Dim ddlResult As DropDownList = CType(dgresult.Items(i).Cells(12).FindControl("ddlResult"), DropDownList)
                'Dim bdpfromdate As BasicFrame.WebControls.BDPLite
                'bdpfromdate = CType(dgresult.Items(i).Cells(9).FindControl("bdpfromdate"), BasicFrame.WebControls.BDPLite)
                'Dim bdpTodate As BasicFrame.WebControls.BDPLite
                'bdpTodate = CType(dgresult.Items(i).Cells(10).FindControl("bdpTodate"), BasicFrame.WebControls.BDPLite)
                Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(6).FindControl("chkselect"), CheckBox)

                If chkselect.Checked = True Then
                    cmd = New SqlCommand("Ins_UnitRepairReceivedtl", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@repairrecvidmst", maxid)
                    cmd.Parameters.AddWithValue("@itemcode", dgresult.Items(i).Cells(2).Text)
                    cmd.Parameters.AddWithValue("@serialNO", dgresult.Items(i).Cells(4).Text)
                    cmd.Parameters.AddWithValue("@qty", dgresult.Items(i).Cells(5).Text)
                    cmd.Parameters.AddWithValue("@Remark", dgresult.Items(i).Cells(6).Text)
                    cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                    cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                    cmd.Parameters.AddWithValue("@RepairWorkId", dgresult.Items(i).Cells(1).Text)

                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                End If

            Next






            'If Hid_Rec.Value <> "" Then
            '    'Dim i As Integer
            '    Dim str As String = Hid_Rec.Value
            '    Dim myarray As Array = Split(Hid_Rec.Value, "|")
            '    For i = 0 To myarray.Length - 2
            '        Dim mainarray As Array = Split(myarray(i), "^")
            '        Dim sql As String
            '        Dim dr As SqlClient.SqlDataReader
            '        Dim sql1 As String
            '        Dim dr1 As SqlClient.SqlDataReader
            '        sql1 = "select item_code from item_detail where item_name = '" & mainarray(0) & "'"
            '        Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
            '        con.Open()
            '        dr1 = cmd2.ExecuteReader()
            '        Dim str2 As String
            '        If dr1.Read() Then
            '            str2 = dr1(0)
            '        Else
            '            str2 = 0
            '        End If
            '        dr1.Close()
            '        con.Close()
            '        cmd = New SqlCommand("Ins_storeRepairRecevdetail", con)
            '        cmd.CommandType = CommandType.StoredProcedure
            '        cmd.Parameters.Add(New SqlParameter("@repairrecvidmst", id))
            '        cmd.Parameters.Add(New SqlParameter("@itemCode", str2))
            '        cmd.Parameters.Add(New SqlParameter("@serialNO", mainarray(1)))
            '        cmd.Parameters.Add(New SqlParameter("@qty", mainarray(2)))
            '        con.Open()
            '        cmd.ExecuteNonQuery()
            '        con.Close()
            '        Hid_Rec.Value = ""
            '    Next

            'End If
            Response.Write("<script>alert('Saved Successfuly');window.location.href='RepairItemReceivedNew.aspx'</script>")
            Response.Write("<script>alert('Saved Successfuly');</script>")

            'maxid()
            'BDPLite1.SelectedDate = Now.Date
            'txtdept.Value = ""
            'txtvendor.Value = ""
            'txtchallanno.Text = ""
            'BDPLite2.SelectedDate = Now.Date
            'txtitem.Value = ""
            'txtapproveby.Value = ""
            'txtqty.Text = ""
        End Sub




        Protected Sub ddlvendor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlvendor.SelectedIndexChanged
            BindGrid(dgresult, con, "RepairItemReceive'" & ddlvendor.SelectedValue & "'")
            If dgresult.Items.Count > 0 Then
                dgresult.Visible = True
                trsave.Visible = True

            Else
                dgresult.Visible = False
                trsave.Visible = False

            End If
        End Sub


        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.Cells(4).Text = "0" Then
                e.Item.Cells(4).Text = "NA"
            End If

        End Sub
    End Class
End Namespace
