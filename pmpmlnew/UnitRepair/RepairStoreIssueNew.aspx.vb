Imports System.Data.SqlClient
Namespace KDMT
    Partial Class RepairStoreIssueNew
        Inherits System.Web.UI.Page

        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strdept As String = ""
        Public stritem As String = ""
        Public strapp As String = ""
        Public strserialNo As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Label1.Text = Format(Now.Date, "dd/MMM/yyyy") & "  " & Now.Hour & ":" & Now.Minute & ":" & Now.Second
            txtjob.Text = ExecuteQuery("(SELECT RIGHT('0' + RTRIM(year(getdate())), 2)+ RIGHT('0' + RTRIM(month(getdate())), 2))")
            stritem = getAutoCompleteList("select item_name from tbl_repair_item where isDelete<>'1' order by item_name", "item_name")
            If Page.IsPostBack = False Then
                Try
                    btnSubmit.Attributes.Add("onclick", "return validate();")

                    'onclick = "validate_indent()"
                    If Session("LocID").ToString <> "" Then

                        tbodyIndent.Visible = False
                        stritem = getAutoCompleteList("select item_name from tbl_repair_item where isDelete<>'1' order by item_name", "item_name")
                        strserialNo = getAutoCompleteList("select Part_Company_No from part_master where Is_Delete <> '1' and part_type<>'1'", "Part_Company_No")
                        'lblissuedate.Text = Format(Now.Date, "dd/MMM/yyyy")
                        BDPLite1.SelectedDate = Format(Now.Date, "dd/MMM/yyyy")
                        'stritem = getAutoCompleteList("select item_name from tbl_Repair_Item order by item_name", "item_name")
                        edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "' and isRepair  = '0'")

                        Dim userid As String
                        userid = ExecuteQuery("Select UserName from User_Master where UserID=" + Session("Userid") + " and RoleID=1")

                        If userid = "" Then
                            btnSubmit.Enabled = False
                        Else
                        End If
                    Else
                        Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                    End If
                Catch ex As Exception
                    Response.Write(ex.Message)
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
            ' Try

            'Dim userid As String
            'userid = ExecuteQuery("Select UserName from User_Master where UserID=" + Session("Userid") + " and RoleID=1")

            'If userid = "" Then
            '    Response.Write("<script>alert('Check Login');window.location.href='storeissue.aspx'</script>")
            'Else

            cmd = New SqlCommand("Ins_UnitRepairIssuemst", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@requestno", txtref.Text)
            cmd.Parameters.AddWithValue("@trans_date", BDPLite1.SelectedDate)
            cmd.Parameters.AddWithValue("@gatepassno", txtgate.Text)
            cmd.Parameters.AddWithValue("@deprt", ddlvendor.SelectedValue)
            cmd.Parameters.AddWithValue("@supervisor", txtapproved.Text)
            cmd.Parameters.AddWithValue("@sysdate", Now.Date)
            cmd.Parameters.AddWithValue("@userid", Session("Userid"))

            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()

            Dim id As Integer
            id = ExecuteQuery("select isnull(max(repairissueid),0) from UnitRepairIssuemst")

            If Hid_Rec.Value <> "" Then
                'Dim i As Integer
                Dim str As String = Hid_Rec.Value
                Dim myarray As Array = Split(Hid_Rec.Value, "|")
                'Dim j As Integer
                'j = Grd_Item.Rows.Count - 1

                For i = 0 To myarray.Length - 2
                    Dim mainarray As Array = Split(myarray(i), "^")

                    cmd = New SqlCommand("Ins_UnitRepairIssuedtl", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add(New SqlParameter("@repairissuemst", id))
                    cmd.Parameters.Add(New SqlParameter("@itemname", mainarray(0)))
                    cmd.Parameters.Add(New SqlParameter("@serial", mainarray(1)))
                    cmd.Parameters.Add(New SqlParameter("@busno", mainarray(3)))
                    cmd.Parameters.Add(New SqlParameter("@qty", mainarray(5)))
                    Dim jobno As Array = Split(mainarray(2), "/")
                    cmd.Parameters.Add(New SqlParameter("@JobNo", jobno(0)))
                    cmd.Parameters.Add(New SqlParameter("@NewJobNo", jobno(1)))

                    'cmd.Parameters.Add(New SqlParameter("@job", 0))
                    'cmd.Parameters.Add(New SqlParameter("@jobno", 0))

                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                    Hid_Rec.Value = ""
                Next
                Response.Write("<script>alert('Saved Successfuly');window.location.href='RepairStoreIssueNew.aspx'</script>")
            End If
            txtref.Text = ""
            'BDPLite1.SelectedDate = Format(Now.Date, "dd/MMM/yyyy")

            'txtitem.Value = ""
            'txtsupervisor.Value = ""
            txtBusNo.Text = ""
            txtqty.Text = ""
            'End If
        End Sub

        Protected Sub ddlvendor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlvendor.SelectedIndexChanged
            If (ddlvendor.SelectedValue = "0") Then
                tbodyIndent.Visible = False
            Else
                tbodyIndent.Visible = True
            End If
        End Sub
    End Class
        End Namespace

