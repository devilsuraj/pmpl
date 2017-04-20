Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic
Namespace kdmt
    Partial Class sub_store_rec_new
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try

                If Page.IsPostBack = False Then


                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    Dim dr1 As SqlDataReader
                    'Dim sql1 As String = " SELECT DISTINCT (IRM.Indent_No), IRM.Indent_No FROM Indent_Request_Master IRM INNER JOIN Indent_Request_Details IRD ON IRM.Indent_ID = IRD.Indent_Master_ID WHERE IRM.Is_Delete = 0 AND IRD.Indent_Flag = 0 AND IRM.Ind_LocId = " & Session("LocID").ToString() & ""
                    Dim sql1 As String = " SELECT DISTINCT (IRM.Ind_No ), IRM.Ind_No FROM Indent_Request_Master IRM INNER JOIN Indent_Request_Details IRD ON IRM.Ind_ID  = IRD.Inddet_masterid  WHERE IRM.ind_isdel  = 0 AND IRD.Inddet_penqty <> 0 and ind_isrec = '0' AND IRM.Ind_LocId = " & Session("LocID").ToString()
                    cmd = New SqlCommand(sql1, con)
                    con.Open()
                    dr1 = cmd.ExecuteReader()
                    ddlRef.DataTextField = "Ind_No"
                    ddlRef.DataValueField = "Ind_No"
                    ddlRef.DataSource = dr1
                    ddlRef.DataBind()
                    con.Close()

                    ddlRef.Items.Insert(0, New ListItem("Select", "0"))
                    txtrecdate.Text = Now.Date().ToString("dd-MMM-yyyy")
                    txtsecuritydate.Text = Now.Date().ToString("dd-MMM-yyyy")

                    'ddlvendor.DataBind()
                    'ddlvendor.Items.Insert(0, New ListItem("Select", "0"))
                    'edit_combo(ddlvendor, "Vendor_id", "Vendor_name", "stock_vendor", "loc_id = '" & Session("LocID") & "'")
                    ' BindGrid(grddetails, con, "GetIssuedItem '" & Session("LocID").ToString() & "'")
                    'Call Fill_Combo("Vendor_id", "Vendor_name", "stock_vendor", ddlvendor, con, "", "Select")
                    'BDPLite1.SelectedDate = Now.Date

                    con.Open()
                    Dim SQL As String
                    Dim dr As SqlClient.SqlDataReader
                    SQL = "select item_name,item_name from item_master where  loc_id = '" & Session("LocID") & "' "
                    Dim Com As New SqlClient.SqlCommand(SQL, con)
                    dr = Com.ExecuteReader
                    Com.Dispose()
                    Com = Nothing
                    dr.Close()
                    dr = Nothing
                    con.Close()

                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click


            Dim j As Integer
            For j = 0 To grddetails.Items.Count - 1
                Dim txtissueqty As TextBox = CType(grddetails.Items(j).Cells(6).FindControl("txtissueqty"), TextBox)
                Dim reqQty As Decimal = Decimal.Parse(grddetails.Items(j).Cells(5).Text)
                If (Decimal.Parse(txtissueqty.Text) > reqQty) Then
                    Response.Write("<script>alert('Issued Quantity Can not be greater than Required Quantity')</script>")
                    txtissueqty.Focus()
                    Exit Sub
                ElseIf Decimal.Parse(txtissueqty.Text) < 0 Then
                    Response.Write("<script>alert('No Negative values Allowed ')</script>")
                    txtissueqty.Focus()
                    Exit Sub
                End If

            Next




            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try
                cmd = New SqlCommand("ins_store_master_subdepot_receieve", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@trans_date", txtrecdate.Text)
                cmd.Parameters.AddWithValue("@challan_no ", 0)
                cmd.Parameters.AddWithValue("@challan_date", txtrecdate.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                cmd.Parameters.AddWithValue("@Inward_no", txtinwardno.Text)
                cmd.Parameters.AddWithValue("@getpassno", txtgate.Text)
                cmd.Parameters.AddWithValue("@security_date", txtrecdate.Text)
                cmd.Parameters.AddWithValue("@Rec_No", txtrecno.Text)
                cmd.Parameters.AddWithValue("@Rec_Date", txtrecdate.Text)
                cmd.Parameters.AddWithValue("@inward_regno", 0)
                cmd.Parameters.AddWithValue("@Rec_FromLoc", 10)
                cmd.Parameters.AddWithValue("@Rec_ToLoc", Session("LocID"))
                cmd.Parameters.AddWithValue("@rec_type", "ByIndent")
                cmd.Parameters.AddWithValue("@rec_against_indentno", ddlRef.SelectedValue)
                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                con.Close()


                For i = 0 To grddetails.Items.Count - 1
                    Dim txtissueqty As TextBox = CType(grddetails.Items(i).Cells(6).FindControl("txtissueqty"), TextBox)
                    'Dim txtworker As TextBox = CType(grddetails.Items(i).Cells(8).FindControl("txtworker"), TextBox)
                    If txtissueqty.Text = "" Then txtissueqty.Text = 0

                    If (Decimal.Parse(txtissueqty.Text) = 0) Then

                    Else

                        'For i = 0 To myarray.Length - 2
                        '    If myarray(i) <> "" Then
                        '        Dim mainarray As Array = Split(myarray(i), ",")
                        cmd = New SqlCommand("ins_store_master_detail_substorerecive", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.Add(New SqlParameter("@store_id ", maxid))
                        cmd.Parameters.Add(New SqlParameter("@Item_Code", grddetails.Items(i).Cells(7).Text))
                        cmd.Parameters.Add(New SqlParameter("@Available_Qty ", grddetails.Items(i).Cells(4).Text))
                        cmd.Parameters.Add(New SqlParameter("@total_qty", txtissueqty.Text))
                        cmd.Parameters.Add(New SqlParameter("@inddet_id", grddetails.Items(i).Cells(8).Text))


                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()

                        Hid_Rec.Value = ""
                    End If

                Next
                Response.Write("<script>alert('Saved Successfuly');window.location.href='sub_store_rec_new.aspx'</script>")
            Catch ex As Exception
                Response.Write("<script>alert('Error Occured While saving')</script>")
            End Try

        End Sub
        <WebMethod()> _
        Public Shared Function GetAutoCompleteData(ByVal SubId As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()

            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                Dim category As String
                If SubId = "" Then
                    category = " Item_detail.item_name like '%" & SearchText & "%'"
                Else
                    category = " item_master.item_name = '" & SubId & "'  and Item_detail.item_name like '%" & SearchText & "%' "
                End If

                Using cmd As New SqlCommand("select Item_detail.item_name   from Item_detail inner join item_master on item_master.item_id  = Item_detail.Item_id  where is_delete  <> 1 and  " & category & "  ", con)
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

        Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click

            Try
                Dim dt As DataTable = New DataTable()
                BindGrid(grddetails, con, "view_indent_request '" & ddlRef.SelectedValue.ToString() & "','" & Session("LocID").ToString() & "'")
                dt = GetDatatTable("view_indent_request '" & ddlRef.SelectedValue.ToString() & "','" & Session("LocID").ToString() & "'")
                If grddetails.Items.Count > 0 Then
                    grddetails.Visible = True
                    ddlRef.SelectedValue = CDbl(dt.Rows(0).Item("Indent_No").ToString())

                Else
                    grddetails.Visible = False
                    Response.Write("<script>alert('No Such Indent');window.location.href='sub_store_rec_new.aspx'</script>")
                    Exit Sub
                End If


                Using cmd As New SqlCommand("select * from store_master inner join store_master_detail on store_master_detail.store_id = store_master.store_id where subindentno = '" & ddlRef.SelectedValue & "'  AND store_master_detail.isdelete = '0'", con)
                    'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    If (dr.Read) Then
                        grddetails.Visible = False
                        Response.Write("<script>alert('Items Already Received');window.location.href='sub_store_rec_new.aspx'</script>")
                    End If
                    con.Close()

                End Using


            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
