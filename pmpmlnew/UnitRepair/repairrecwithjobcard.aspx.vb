

Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic

Namespace KDMT
    Partial Class repairrecwithjobcard
        Inherits System.Web.UI.Page

        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlDataReader
        Public strdept As String = ""
        Public stritem As String = ""
        Public strapp As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 3
            Label1.Text = Format(Now.Date, "dd/MMM/yyyy") & "  " & Now.Hour & ":" & Now.Minute & ":" & Now.Second
            If Page.IsPostBack = False Then
                Try
                    edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "' and isRepair  = '1'")
                    BDPLite1.Text = Format(Now.Date, "dd/MMM/yyyy")

                    'strdept = getAutoCompleteList("select cont_name from contractor_master where subid=1 order by cont_name", "cont_name")
                    stritem = getAutoCompleteList("select item_name from tbl_repair_item where isDelete<>'1' and ispartno = '1' order by item_name", "item_name")
                    'strapp = getAutoCompleteList("select distinct(approveby) from tbl_Repair_Recevie_dtl order by approveby", "approveby")

                    'btnSubmit.Attributes.Add("Onclick", "return ticFunction2();")
                    btnSubmit.Attributes.Add("onclick", "return ticFunction2();")
                    BDPLite1.Text = Format(Now.Date, "dd/MMM/yyyy")
                    Dim dr As SqlClient.SqlDataReader


                    con.Open()

                    Dim cmd As New SqlClient.SqlCommand("repairjobcard", con)
                    dr = cmd.ExecuteReader
                    'dr.Read()
                    If dr.Read Then
                        txtJobNo.Text = dr.GetValue(0)
                        txtJob.Text = dr.GetValue(1)

                    End If

                    con.Close()

                    If Session("LocID").ToString <> "" Then



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

            Dim userid As String
            userid = ExecuteQuery("Select UserName from User_Master where UserID=" + Session("Userid") + " and RoleID=1")

            If userid = "" Then
                Response.Write("<script>alert('Check Login');window.location.href='ItemReceiveForRepair.aspx'</script>")
            Else

                Dim type As String = ExecuteQuery("select partType  from contractor_master where cont_id = '" & ddlvendor.SelectedValue & "'")
                cmd = New SqlCommand("repairSerailNo", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.Add(New SqlParameter("@partType", type))
                cmd.Parameters.Add(New SqlParameter("@SerialNo", txtserial.Text))
                cmd.Parameters.Add(New SqlParameter("@userid", Session("Userid")))
                cmd.Parameters.Add(New SqlParameter("@sys_date", Now.Date))
                Dim strpartid As New SqlParameter("@partId", SqlDbType.BigInt)
                strpartid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strpartid)


                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxpartid As Integer = cmd.Parameters("@partId").Value.ToString
                con.Close()


                cmd = New SqlCommand("Ins_RepairRecMst", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.Add(New SqlParameter("@cont_id ", ddlvendor.SelectedValue))
                cmd.Parameters.Add(New SqlParameter("@Supervisor", txtSupervisor.Text))
                cmd.Parameters.Add(New SqlParameter("@DeliveredBy", txtDeliver.Text))
                cmd.Parameters.Add(New SqlParameter("@ReceivedBy", txtReceive.Text))
                cmd.Parameters.Add(New SqlParameter("@ReceiveDate", BDPLite1.Text))
                cmd.Parameters.Add(New SqlParameter("@uersid", Session("Userid")))
                cmd.Parameters.Add(New SqlParameter("@shift ", ddlshift.SelectedValue))
                cmd.Parameters.Add(New SqlParameter("@place ", ddlplace.SelectedValue))
                cmd.Parameters.Add(New SqlParameter("@challanNo ", txtchallanno.Text))


                con.Open()
                cmd.ExecuteNonQuery()

                con.Close()

                'Dim maxid As Integer
                con.Open()

                'maxid = GetMaxIdwithloc("issue_id", Session("locid"), con, "store_issue_master")
                con.Close()
                'If Hid_Rec.Value <> "" Then
                '    'Dim i As Integer
                '    Dim str As String = Hid_Rec.Value
                '    Dim myarray As Array = Split(Hid_Rec.Value, "|")
                '    Dim j As Integer


                '    For i = 0 To myarray.Length - 2
                '        Dim mainarray As Array = Split(myarray(i), "^")
                '        Dim sql As String
                '        Dim dr As SqlClient.SqlDataReader
                '        sql = "select item_id from item_master where item_name = '" & mainarray(0) & "'"
                '        Dim cmd1 As New SqlClient.SqlCommand(sql, con)
                '        con.Open()
                '        dr = cmd1.ExecuteReader()
                '        Dim str1 As String
                '        If dr.Read() Then
                '            str1 = dr(0)
                '        End If
                '        dr.Close()
                '        con.Close()



                Dim sql1 As String
                Dim dr1 As SqlClient.SqlDataReader
                sql1 = "select itemid from tbl_repair_item where item_name = '" & ddlitem.Text & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr1 = cmd2.ExecuteReader()
                Dim str2 As String
                If dr1.Read() Then
                    str2 = dr1(0)
                Else
                    str2 = 0
                End If
                dr1.Close()
                con.Close()

                'Dim sql2 As String
                'Dim dr2 As SqlClient.SqlDataReader
                'sql2 = "select Part_ID from part_master where is_delete <> '1' and  Part_Company_No = '" & txtserial.Text & "'"
                'Dim cmd3 As New SqlClient.SqlCommand(sql2, con)
                'con.Open()
                'dr2 = cmd3.ExecuteReader()
                'Dim str3 As String
                'If dr2.Read() Then
                '    str3 = dr2(0)
                'Else
                '    str3 = 0
                'End If
                'dr2.Close()
                'con.Close()
                '"K 17/1|NUT BOLT M- 10 x 70|erwe|192|12|12|0^"

                cmd = New SqlCommand("Ins_RepairRecDtl", con)
                cmd.CommandType = CommandType.StoredProcedure
                'cmd.Parameters.Add(New SqlParameter("@RepairRecId ", 0))
                cmd.Parameters.AddWithValue("@itemCode", str2)
                cmd.Parameters.AddWithValue("@SerialNo", txtserial.Text)
                cmd.Parameters.AddWithValue("@Qty", txtqty.Text)
                cmd.Parameters.AddWithValue("@Remark", txtremark.Text)
                cmd.Parameters.AddWithValue("@QtyDone", 0)
                cmd.Parameters.AddWithValue("@BusNo", txtbus.Text)
                cmd.Parameters.AddWithValue("@Job", txtJob.Text)
                cmd.Parameters.AddWithValue("@JobNo", txtJobNo.Text)
                cmd.Parameters.AddWithValue("@partId", maxpartid)

                con.Open()
                cmd.ExecuteNonQuery()
                Response.Write("<script>alert('Saved Successfuly');window.location.href='repairrecwithjobcard.aspx'</script>")
                con.Close()



            End If
        End Sub
       
        <WebMethod()> _
Public Shared Function GetAutoCompleteData(ByVal contid As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()
            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                ' Dim type As String = ExecuteQuery("select Part_Type_ID  from part_type_master where cont_id = " & contid & "")
                Using cmd As New SqlCommand("select item_name from tbl_repair_item where partType in (select Part_Type_ID  from part_type_master where cont_id = (" & contid & "-16))  and ispartno <> '0' and isDelete<>'1' and item_name like '%" & SearchText & "%'", con)
                    'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("item_name").ToString())
                    End While
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function

        <WebMethod()> _
Public Shared Function GetAutoCompleteSerialNo(ByVal contid As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()
            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                ' Dim type As String = ExecuteQuery("select Part_Type_ID  from part_type_master where cont_id = " & contid & "")
                Using cmd As New SqlCommand("select Part_Company_No from part_master where Part_Type in (select Part_Type_ID  from part_type_master where cont_id = " & contid & " )  and Is_Delete <> '1' and Part_Company_No like '%" & SearchText & "%' ", con)
                    'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("Part_Company_No").ToString())
                    End While
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function
    End Class
End Namespace
