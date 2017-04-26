Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class Sub_Store_Iss_New
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim sql1 As String
        Dim dr2 As SqlClient.SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                Session("MenuId") = 10
                If Request.QueryString("Opt") = "GetFill" Then
                    Dim intType As Integer = Request.QueryString("Type")
                    Dim strbinno As String = Request.QueryString("binno")
                    Dim stritemname As String = Request.QueryString("itemname")
                    Dim strPartno As String = Request.QueryString("Partno")
                    Dim strmrvno As String = Request.QueryString("mrvno")
                    GetPartItem(intType, strbinno, stritemname, strPartno, strmrvno)
                End If

                If Not IsPostBack Then

                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    'txtWMR.Text = GetMaxIdwithloc("gatepassno", Session("locid").ToString(), con, "store_issue_master") + 1
                    'edit_combo(ddlwmr, "gatepassno", "gatepassno", "Workshop_Material_Request", "isrec = '0'")

                    txtissuedate.Text = Now.Date().ToString("dd-MMM-yyyy")
                    con.Open()
                    Dim SQL As String
                    Dim dr As SqlClient.SqlDataReader

                    SQL = "select wmr_no,wmr_no from Workshop_Material_Request where wmr_isrec = '0' and wmr_locid =" & Session("locid").ToString() & " order by Workshop_Material_Request.wmr_no "
                    Dim Com As New SqlClient.SqlCommand(SQL, con)
                    ddlwmr.DataTextField = "wmr_no"
                    ddlwmr.DataValueField = "wmr_no"
                    dr = Com.ExecuteReader
                    ddlwmr.DataSource = dr
                    ddlwmr.DataBind()
                    dr.Close()
                    con.Close()
                    'Call Fill_Combo("item_name", "item_name", "item_master", ddlcat, con, "", "Select")

                End If

            Catch ex As Exception
                Response.Write("<script>alert('Error Occured While saving')</script>")

            End Try
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Dim dtitemdetail As DataTable
            Try

                Dim mtvexist As String
                mtvexist = ExecuteQuery("select issue_against_wmr_or_indent from store_issue_master  where issue_against_wmr_or_indent  = '" + ddlwmr.SelectedValue + "' and issue_type = 'WMR'")

                If mtvexist <> "" Then
                    Response.Write("<script>alert('WMR NO is already exist')</script>")
                    'Response.Write("<script>alert('MTV NO is already exist');window.location.href='storeissue.aspx'</script>")
                Else

                    Thread.CurrentThread.CurrentCulture = New CultureInfo("en-US")

                    cmd = New SqlCommand("insert_store_issue_master_against_wmr", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@cont_id", hdnVenId.Value)
                    cmd.Parameters.AddWithValue("@trans_date", txtissuedate.Text)
                    cmd.Parameters.AddWithValue("@refno", ddlwmr.SelectedItem.Text)
                    cmd.Parameters.AddWithValue("@worker_name", txtwname.Text)

                    cmd.Parameters.AddWithValue("@userid", Session("Userid").ToString())
                    cmd.Parameters.AddWithValue("@loc_id", Session("locid").ToString())
                    cmd.Parameters.AddWithValue("@gatepassno", "")
                    cmd.Parameters.AddWithValue("@approvedby", txtapproved.Text)
                    cmd.Parameters.AddWithValue("@part_of_bus", "")
                    cmd.Parameters.AddWithValue("@remark", txtremark.Text)
                    cmd.Parameters.AddWithValue("@isGatepass", 0)
                    cmd.Parameters.AddWithValue("@issue_fromloc", Session("locid"))
                    cmd.Parameters.AddWithValue("@issue_toloc", Session("locid"))
                    cmd.Parameters.AddWithValue("@issue_type", "WMR")
                    cmd.Parameters.AddWithValue("@issue_against_wmr_or_indent", ddlwmr.SelectedItem.Text)
                    Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                    strmaxid.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(strmaxid)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                    cmd.CommandTimeout = 0

                    con.Close()


                    If Hid_Rec.Value <> "" Then
                        'Dim i As Integer
                        Dim str As String = Hid_Rec.Value
                        Dim myarray As Array = Split(Hid_Rec.Value, "^")
                        Dim j As Integer


                        For i = 0 To myarray.Length - 2
                            Dim mainarray As Array = Split(myarray(i), "|")


                            If mainarray(4).ToString() <> "0" Then
                                dtitemdetail = GetDatatTable("item_stock_bal '" & mainarray(2) & "','" & mainarray(0) & "','" & mainarray(1) & "','" & Session("LocID").ToString() & "'")


                                cmd = New SqlCommand("insert_store_issue_master_detail_against_wmr", con)
                                cmd.CommandType = CommandType.StoredProcedure



                                cmd.Parameters.AddWithValue("@issue_id", maxid)
                                cmd.Parameters.AddWithValue("@item_code", dtitemdetail.Rows(0).Item("itemcode").ToString())
                                cmd.Parameters.AddWithValue("@available_qty", mainarray(3))
                                cmd.Parameters.AddWithValue("@total_qty", mainarray(4))
                                cmd.Parameters.AddWithValue("@veh_no", lblvehicle.Text)
                                cmd.Parameters.AddWithValue("@wname", txtwname.Text)
                                cmd.Parameters.AddWithValue("@jobno", txtjobyymm.Text)
                                cmd.Parameters.AddWithValue("@job", txtjobno.Text)
                                cmd.Parameters.AddWithValue("@item_serial_no", 0)
                                cmd.Parameters.AddWithValue("@issue_against_wmr", ddlwmr.SelectedItem.Text)
                                cmd.Parameters.AddWithValue("@loc_id", Session("locid").ToString())


                                con.Open()
                                cmd.ExecuteNonQuery()
                                cmd.CommandTimeout = 0
                                con.Close()


                            End If


                        Next
                        Hid_Rec.Value = ""
                        Response.Write("<script>alert('Saved Successfuly');window.location.href='Sub_Store_Iss_New.aspx'</script>")
                    End If
                End If
            Catch ex As Exception
                Hid_Rec.Value = ""
                Response.Write("<script>alert('Error Occured While saving')</script>")
            End Try
        End Sub

        <WebMethod()>
        Public Function GetAutoCompleteDataPartNo(ByVal PartNo As String, ByVal ItemName As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strcnt As String = ExecuteQuery("SELECT COUNT(Item_Name) FROM Item_Detail  WHERE  is_delete  <> 1 and Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "'")
            Dim strCondition As String = ""
            If CInt(strcnt) = 0 Then
                strCondition = "Part_No LIKE '%" & PartNo & "%'"
            ElseIf CInt(strcnt) <> 0 Then
                strCondition = "Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "' AND Part_No LIKE '%" & PartNo & "%'"
            End If

            Try
                Using cmd As New SqlCommand("SELECT Part_No FROM Item_Detail  WHERE  is_delete  <> 1 and  " & strCondition, con)
                    con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("Part_No").ToString())
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function
        <WebMethod()>
        Public Function GetAutoCompleteDataItemName(ByVal ItemName As String, ByVal PartNo As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strcnt As String = ExecuteQuery("SELECT COUNT(Part_No) FROM Item_Detail  WHERE  is_delete  <> 1 and Part_No = '" & PartNo & "' AND SubRack_No = '" & BinNo & "'")
            Dim strCondition As String = ""
            If CInt(strcnt) = 0 Then
                strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
            ElseIf CInt(strcnt) <> 0 Then
                strCondition = "Part_No = '" & PartNo & "' AND SubRack_No = '" & BinNo & "' AND Item_Name  LIKE '%" & ItemName & "%'"
            End If
            Try
                Using cmd As New SqlCommand("SELECT Item_Name FROM Item_Detail  WHERE  is_delete  <> 1 and " & strCondition, con)
                    con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("Item_Name").ToString())
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function

        <WebMethod()>
        Public Function GetAutoCompleteDataBinNo(ByVal ItemName As String, ByVal PartNo As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strCondition As String = ""
            If ItemName = "" And PartNo = "" Then
                strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
            Else
                Dim strcnt As String = ExecuteQuery("SELECT COUNT(SubRack_No) FROM Item_Detail  WHERE  is_delete  <> 1 and Part_No = '" & PartNo & "' AND Item_Name = '" & ItemName & "'")

                If CInt(strcnt) = 0 Then
                    strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
                ElseIf CInt(strcnt) <> 0 Then
                    strCondition = "Part_No = '" & PartNo & "' Item_Name = '" & ItemName & "' AND SubRack_No LIKE '%" & BinNo & "%'"
                End If
            End If

            Try
                Using cmd As New SqlCommand("SELECT SubRack_No FROM Item_Detail  WHERE  is_delete  <> 1 and  " & strCondition, con)
                    con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("SubRack_No").ToString())
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function

        Private Sub GetPartItem(ByVal Type As Integer, ByVal binno As String, ByVal itemname As String, ByVal Partno As String, ByVal wmrno As String)
            Dim locid As String = Session("locid")
            Dim dt As New DataTable
            If CInt(Type) = 3 Then
                Dim stritemdetail As String = ""
                'Dim ItemCode As String = ExecuteQuery("SELECT Item_Code FROM Item_Detail  WHERE Part_No = '" & PartItem & "' AND Item_Name = '" & arrstrcnt(0) & "' AND Subrack_No = '" & arrstrcnt(1) & "'")
                sql1 = "item_stock_bal '" & itemname & "','" & binno & "','" & Partno & "','" & locid & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    stritemdetail += "~" & dr2(0).ToString() + "~" & dr2(1).ToString() + "~" & dr2(2).ToString() + "~" & dr2(3).ToString()
                Else
                    stritemdetail += "~~~~"
                End If
                dr2.Close()
                con.Close()
                Response.Write("got~" & Type & "~" & stritemdetail & "~")

                'ElseIf CInt(Type) = 4 Then
                '    Dim strcnt As String = ExecuteQuery("SELECT Count(wmr) FROM Indent_Request_Master  WHERE Is_Delete = 0 AND MRV_No = '" & wmrno & "'")
                '    If (strcnt <> 0) Then
                '        Response.Write("Exist")
                '    ElseIf (strcnt = 0) Then
                '        Response.Write("NotExist")
                '    End If
            ElseIf CInt(Type) = 5 Then
                Dim strDetail As New StringBuilder

                'Dim StrHead As String = "<TABLE  ID='tblChallan' style='width:100%;' cellspacing='0' cellpadding='0' border='1' border-collapse='collapse' class='mytable'><thead><tr><td style='height: 40px' colspan='9' align='center'><div style='float:left; width:30%'><img id='img' src='../images/images_print.png' alt='Sikkim Nationalised  Transport' /></div><div style='float:left;text-align:center'><h2 style='padding: 0; margin: 0'>SIKKIM NATIONALISED TRANSPORT<br />GOVERNMENT OF SIKKIM</h2></div><div style='clear:both'></div><div style='float:left;'><b>From : </b>" & dtFRom.ToString("dd-MMM-yyyy") & "  <b>To :  </b>" & dtTo.ToString("dd-MMM-yyyy") & "</div><div style='float:right;'><b>Date : </b>" & Date.Now.ToString("dd-MMM-yyy") & "</div><div style='clear:both'></div></td></tr></TABLE>"
                'onblur ='Return checkqty('txtIssQty_" & i & "','" + dt.Rows(i).Item("Avl_Qty") + "','" + dt.Rows(i).Item("Req_Qty") + "')
                dt = GetDatatTable("GET_WORKSOP_MATERIAL_REQUEST  " & wmrno & " ," & locid & "")
                '''''''''temporarry using 
                If dt.Rows.Count > 0 Then
                    strDetail.Append("<TABLE  ID='tblChallan' style='width:100%'  cellspacing='0' cellpadding='0' border='1' class='mytable'><TR class='bold'><TD>Sr No</TD><TD>LF No.</TD><TD>Part No.</TD><TD>Item Name</TD><TD>Available Qty. </TD><TD>Requested Qty</TD><TD>Issue Qty</TD><TD>Balance</TD><TD>Issued_Qty</TD>")
                    For i = 0 To dt.Rows.Count - 1
                        strDetail.Append("<TR><TD>" & i + 1 & "</TD><TD ID='tdlfNo_" & i & "' align='right'>" & dt.Rows(i).Item("lfno") & "</TD><TD align='left' ID='tdPartNo_" & i & "'>" & dt.Rows(i).Item("Part_No") & "</TD><TD align='left' ID='tdItemName_" & i & "'>" & dt.Rows(i).Item("Item_Name") & "</TD>")
                        strDetail.Append("<TD align='right' ID='tdbqty_" & i & "'>" & dt.Rows(i).Item("Avl_Qty") & "</TD><TD align='right' ID='tdqty_" & i & "'>" & dt.Rows(i).Item("Req_Qty") & "</TD><TD align='right' ><input  type='text' id='txtIssQty_" & i & "' onblur='return ValIssQty(" & i & ")'  value ='0'></TD><TD align='right' ID='tdBalQty_" & i & "'>" & dt.Rows(i).Item("Bal_Qty") & "</TD><TD align='right' ID='tdIssuedQty_" & i & "'>" & dt.Rows(i).Item("Req_Qty") - dt.Rows(i).Item("Bal_Qty") & "</TD></TR>")
                    Next
                    strDetail.Append("</TABLE>")
                    Response.Write("got~" & Type & "~" & strDetail.ToString() & "~" & dt.Rows(0).Item("busno") & "~" & dt.Rows(0).Item("wmr_contid") & "~" & dt.Rows(0).Item("Cont_Name") & "~" & dt.Rows.Count & "~")

                Else
                    strDetail.Append("<TABLE  ID='tblChallan' style='width:100%' class='mytable'><TR class='bold'><TD colsapn='18' align='center'>No Record Found</TD></TR></TABLE>")
                    Response.Write("DidntGot~" & Type & "~" & strDetail.ToString() & "~")
                End If

            End If
        End Sub

        Protected Sub btnclear_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnclear.Click
            Response.Redirect("Sub_Store_Iss_New.aspx")
        End Sub
    End Class
End Namespace
