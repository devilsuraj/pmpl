
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class Sub_Store_Indent_Request
        Inherits System.Web.UI.Page
        Shared Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dt As New DataTable
        Dim dt1 As New DataTable
        Dim jobno As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                Session("MenuId") = 10
                Dim intType As Integer = Request.QueryString("Type")
                Dim strPartItem As String = Request.QueryString("PartItem")
                Dim mrvdate As String = Request.QueryString("indentdate")
                If Not IsPostBack Then
                    'If Session("LocID").ToString() = "10" Then
                    '    edit_combo(ddlLocation, "Depo_Code", "Depo_Name", "Depo_Master", "0=0")
                    'Else
                    '    edit_combo(ddlLocation, "Depo_Code", "Depo_Name", "Depo_Master", "Depo_Code=" & Session("LocID").ToString() & "")
                    'End If
                    edit_combo(ddlLocation, "Depo_Code", "Depo_Name", "Depo_Master", "Depo_Code=" & Session("LocID").ToString() & "")
                    ddlLocation.SelectedValue = Session("LocID").ToString()

                    'btnadd.Attributes.Add("Onclick", " return ValidateSave();")
                    'btnaddandsave.Attributes.Add("Onclick", "return ValidateSave();")

                    txttodate.Text = Now.Date().ToString("dd-MMM-yyyy")

                    Thread.CurrentThread.CurrentCulture = New CultureInfo("en-US")
                    lblindent.Text = ExecuteQuery("getindentno '" & txttodate.Text & "'," & Session("LocID").ToString())
                    txttodate.Focus()
                    'Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", ddlDefectType, Con)
                    'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
                End If
                If strPartItem <> "" Then
                    GetPartItem(intType, strPartItem, mrvdate)
                End If

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub btnadd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnadd.Click
            addrecords()

            txtBusNo.Text = ""
        End Sub

        Protected Sub grddetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddetails.ItemDataBound
            'If e.Item.Cells(3).Text = jobno.ToString Then
            '    e.Item.Cells(3).Text = ""
            '    e.Item.Cells(4).Text = ""

            'Else
            '    jobno = e.Item.Cells(3).Text

            'End If
        End Sub
        Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
            save()
        End Sub

        Protected Sub btnaddandsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnaddandsave.Click
            addrecords()
            save()
        End Sub

        Private Sub addrecords()
            Try
                'If txtBusNo.Text = "" Then
                '    lblerror.Text = "Please Enter Bus No"
                'Else
                lblerror.Text = ""

                dt.Columns.Add("sr")

                dt.Columns.Add("jobno")
                dt.Columns.Add("busno")
                dt.Columns.Add("binno")
                dt.Columns.Add("partno")
                dt.Columns.Add("itemname")
                dt.Columns.Add("avbqty")
                dt.Columns.Add("reqqty")
                dt1.Columns.Add("sr")

                dt1.Columns.Add("jobno")
                dt1.Columns.Add("busno")
                dt1.Columns.Add("binno")
                dt1.Columns.Add("partno")
                dt1.Columns.Add("itemname")
                dt1.Columns.Add("avbqty")
                dt1.Columns.Add("reqqty")
                Dim dr As DataRow
                dr = dt.NewRow
                Dim dr1 As DataRow
                dr1 = dt1.NewRow
                Dim i As Integer = 0
                Dim b As Integer = 1
                Dim str As String = String.Empty
                Dim j As Integer = 0
                Dim b1 As Integer = 1
                Dim presenent As String = ""


                If grddetails.Items.Count > 0 Then
                    dt1.Rows.Clear()
                    b1 = 1

                    For j = 0 To grddetails.Items.Count - 1
                        dt1.Rows.Add(b1, grddetails.Items(j).Cells(1).Text, grddetails.Items(j).Cells(2).Text, grddetails.Items(j).Cells(3).Text, grddetails.Items(j).Cells(4).Text, grddetails.Items(j).Cells(5).Text, grddetails.Items(j).Cells(6).Text, grddetails.Items(j).Cells(7).Text)
                        b1 = b1 + 1
                    Next

                    Dim myarray As Array = Split(Hid_Rec.Value, "|")
                    Dim k As Integer

                    b = b1
                    For i = 0 To myarray.Length - 2
                        Dim mainarray As Array = Split(myarray(i), "^")
                        dt1.Rows.Add(b, (txtBusNo.Text), txtBusNo.Text, mainarray(0), mainarray(1), mainarray(2), mainarray(3), mainarray(4))
                        b = b + 1
                    Next
                Else
                    Dim myarray As Array = Split(Hid_Rec.Value, "|")
                    Dim k As Integer

                    b = b1
                    For i = 0 To myarray.Length - 2
                        Dim mainarray As Array = Split(myarray(i), "^")
                        dt1.Rows.Add(b, (txtBusNo.Text), txtBusNo.Text, mainarray(0), mainarray(1), mainarray(2), mainarray(3), mainarray(4))
                        b = b + 1
                    Next

                End If

                grddetails.DataSource = dt1
                grddetails.DataBind()
                If dt1.Rows.Count > 0 Then
                    trsave.Visible = True

                Else
                    trsave.Visible = False
                End If
                Hid_Rec.Value = ""

                ' End If

            Catch ex As Exception

            End Try
        End Sub
        Private Sub GetPartItem(ByVal Type As Integer, ByVal PartItem As String, ByVal mrvdate As String)
            If CInt(Type) = 1 Then
                Dim strcnt As String = ExecuteQuery("SELECT Item_Name + '~' + rack_No FROM Item_Detail  WHERE is_delete  <> 1 and Part_No = '" & PartItem & "'")
                If (strcnt <> "") Then
                    Response.Write("got~" & Type & "~" & strcnt & "~")
                End If
            ElseIf CInt(Type) = 2 Then
                Dim strcnt As String = ExecuteQuery("SELECT Part_No + '~' + rack_No FROM Item_Detail  WHERE is_delete  <> 1 and Item_Name = '" & PartItem & "'")
                If (strcnt <> "") Then
                    Response.Write("got~" & Type & "~" & strcnt & "~")
                End If
            ElseIf CInt(Type) = 3 Then
                Dim strcnt As String = ExecuteQuery("SELECT Part_No + '~' + Item_Name  FROM Item_Detail  WHERE is_delete  <> 1 and rack_No = '" & PartItem & "'")
                If (strcnt <> "") Then
                    Response.Write("got~" & Type & "~" & strcnt & "~")
                End If
            ElseIf CInt(Type) = 4 Then
                Dim strcnt As String = ExecuteQuery("SELECT Count(MRV_No) FROM Indent_Request_Master  WHERE Is_Delete = 0 AND MRV_No = '" & PartItem & "' and Indent_Date =  '" & mrvdate & "'")
                If (strcnt <> 0) Then
                    Response.Write("Exist")
                ElseIf (strcnt = 0) Then
                    Response.Write("NotExist")
                End If
            End If
        End Sub

        Private Sub save()
            Try

                lblindent.Text = ExecuteQuery("getindentno '" & txttodate.Text & "'," & ddlLocation.SelectedValue)
                cmd = New SqlCommand
                ds = New DataSet
                DA = New SqlDataAdapter
                cmd.Connection = Con
                cmd.CommandType = CommandType.StoredProcedure
                Dim i As Integer




                cmd = New SqlCommand("ins_indent_request_master", Con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@Ind_No", lblindent.Text)
                cmd.Parameters.AddWithValue("@Ind_Date", txttodate.Text)
                cmd.Parameters.AddWithValue("@Ind_ApproveBy", ddlapprovedby.SelectedValue)
                cmd.Parameters.AddWithValue("@Ind_Remark", txtremark.Text)

                cmd.Parameters.AddWithValue("@ind_userID", Session("UserId").ToString())
                'cmd.Parameters.AddWithValue("@ind_locid", Session("LocID").ToString())
                cmd.Parameters.AddWithValue("@ind_locid", ddlLocation.SelectedValue)



                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)


                Con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                Con.Close()

                For j = 0 To grddetails.Items.Count - 1

                    Dim jobno As Array = Split(grddetails.Items(j).Cells(1).Text, "/")
                    Dim code As String = ExecuteQuery("select item_code from item_detail where Rack_No = '" & grddetails.Items(j).Cells(3).Text.Replace("&nbsp;", "") & "' AND Part_No = '" & grddetails.Items(j).Cells(4).Text.Replace("&nbsp;", "") & "' AND item_name  = '" & grddetails.Items(j).Cells(5).Text.Replace("&nbsp;", "") & "'")
                    'Dim code As String = ExecuteQuery("select item_code from item_detail where is_delete  <> 1 and rack_no = '" & grddetails.Items(j).Cells(3).Text.Replace("&nbsp;", "") & "' ")

                    cmd = New SqlCommand("ins_Indent_Request_Details", Con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@Inddet_masterid", maxid)
                    cmd.Parameters.AddWithValue("@Inddet_itemcode", code)
                    cmd.Parameters.AddWithValue("@Inddet_reqqty", grddetails.Items(j).Cells(7).Text)
                    cmd.Parameters.AddWithValue("@Inddet_userid", Session("UserId").ToString())
                    cmd.Parameters.AddWithValue("@inddet_locid", ddlLocation.SelectedValue)


                    Con.Open()
                    cmd.ExecuteNonQuery()
                    Con.Close()
                    cmd.Parameters.Clear()

                    'If (Decimal.Parse(grddetails.Items(j).Cells(7).Text) = 0) Then

                    '    cmd = New SqlCommand("ins_pending_indent", Con)
                    '    cmd.CommandType = CommandType.StoredProcedure
                    '    cmd.Parameters.AddWithValue("@indent_master_id", maxid)
                    '    cmd.Parameters.AddWithValue("@ind_itemcode", code)
                    '    cmd.Parameters.AddWithValue("@avbqty", grddetails.Items(j).Cells(7).Text)
                    '    cmd.Parameters.AddWithValue("@req_qty", grddetails.Items(j).Cells(8).Text)
                    '    cmd.Parameters.AddWithValue("@isclose", 0)
                    '    cmd.Parameters.AddWithValue("@closereason", "")
                    '    Con.Open()
                    '    cmd.ExecuteNonQuery()
                    '    Con.Close()
                    'End If
                Next

                Response.Write("<script>alert('Saved Successfuly');window.location.href='Sub_Store_Indent_Request.aspx'</script>")


            Catch ex As Exception
                Con.Close()
            End Try
        End Sub

        <WebMethod()>
        Public Shared Function GetAutoCompleteDataPartNo(ByVal PartNo As String, ByVal ItemName As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strcnt As String = ExecuteQuery("SELECT COUNT(Item_Name) FROM Item_Detail  WHERE is_delete  <> 1 and Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "'")
            Dim strCondition As String = ""
            If CInt(strcnt) = 0 Then
                strCondition = "Part_No LIKE '%" & PartNo & "%'"
            ElseIf CInt(strcnt) <> 0 Then
                strCondition = "Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "' AND Part_No LIKE '%" & PartNo & "%'"
            End If

            Try
                Using cmd As New SqlCommand("SELECT Part_No FROM Item_Detail  WHERE is_delete  <> 1 and " & strCondition, Con)
                    Con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("Part_No").ToString())
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    Con.Close()

                End Using
            Catch ex As Exception
                Con.Close()
            Finally
                Con.Close()
            End Try
            Return result
        End Function
        <WebMethod()>
        Public Shared Function GetAutoCompleteDataItemName(ByVal ItemName As String, ByVal PartNo As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strCondition As String = ""
            If PartNo = "" And BinNo = "" Then
                strCondition = "Item_Name LIKE '%" & ItemName & "%'"
            Else
                Dim strcnt As String = ExecuteQuery("SELECT COUNT(Part_No) FROM Item_Detail  WHERE is_delete  <> 1 and Part_No = '" & PartNo & "' AND SubRack_No = '" & BinNo & "'")

                If CInt(strcnt) = 0 Then
                    strCondition = "Item_Name LIKE '%" & ItemName & "%'"
                ElseIf CInt(strcnt) <> 0 Then
                    strCondition = "Part_No = '" & PartNo & "' AND SubRack_No = '" & BinNo & "' AND Item_Name  LIKE '%" & ItemName & "%'"
                End If
            End If

            Try
                Using cmd As New SqlCommand("SELECT Item_Name FROM Item_Detail  WHERE  is_delete  <> 1 and  " & strCondition, Con)
                    Con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("Item_Name").ToString())
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    Con.Close()

                End Using
            Catch ex As Exception
                Con.Close()
            Finally
                Con.Close()
            End Try
            Return result
        End Function

        <WebMethod()>
        Public Shared Function GetAutoCompleteDataBinNo(ByVal ItemName As String, ByVal PartNo As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strCondition As String = ""
            If ItemName = "" And PartNo = "" Then
                strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
            Else
                Dim strcnt As String = ExecuteQuery("SELECT COUNT(SubRack_No) FROM Item_Detail  WHERE  is_delete  <> 1 and  Part_No = '" & PartNo & "' AND Item_Name = '" & ItemName & "'")

                If CInt(strcnt) = 0 Then
                    strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
                ElseIf CInt(strcnt) <> 0 Then
                    strCondition = "Part_No = '" & PartNo & "' Item_Name = '" & ItemName & "' AND SubRack_No LIKE '%" & BinNo & "%'"
                End If
            End If

            Try
                Using cmd As New SqlCommand("SELECT SubRack_No FROM Item_Detail  WHERE  is_delete  <> 1 and  " & strCondition, Con)
                    Con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("SubRack_No").ToString())
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    Con.Close()

                End Using
            Catch ex As Exception
                Con.Close()
            Finally
                Con.Close()
            End Try
            Return result
        End Function

        <System.Web.Script.Services.ScriptMethod(),
      System.Web.Services.WebMethod()>
        Public Shared Function GetAutoCompleteLfNumber(ByVal BinNo As String) As List(Of String)

            Dim cmd As SqlCommand = New SqlCommand
            cmd.CommandText = "select rack_no from item_detail where  is_delete <> '1' AND rack_no  like @SearchText + '%'"
            cmd.Parameters.AddWithValue("@SearchText", BinNo)
            cmd.Connection = Con
            If Con.State = ConnectionState.Closed Then
                Con.Open()
            End If
            Dim customers As List(Of String) = New List(Of String)
            Dim sdr As SqlDataReader = cmd.ExecuteReader
            While sdr.Read
                customers.Add(sdr("rack_no").ToString)
            End While
            Con.Close()
            Return customers
        End Function


    End Class

End Namespace
