Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Master_ajax
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Dim strSql As String = ""
            Dim intExst As String = ""
            Dim indentno As Integer = 0
            Dim strAction As String = Request.QueryString("action")
            Dim intId As Integer = Request.QueryString("Id")
            Dim strDelType As String = Request.QueryString("deltype")
            Dim strInsertType As String = Request.QueryString("InsType")
            Dim strUpdateType As String = Request.QueryString("UpType")
            Dim intOptype As Integer = Request.QueryString("Optype")


            If strAction = "VehicleMaster" Then
                Dim strBusNo As String = Request.QueryString("BusNo")
                Dim intBusType As Integer = Request.QueryString("BusType")
                Dim intBusCompany As Integer = Request.QueryString("BusCompany")
                Dim strModelNo As String = Request.QueryString("ModelNo")
                Dim intFuel As Integer = Request.QueryString("Fuel")
                Dim dtFitRenewalDate As String = Request.QueryString("FitRenewalDate")
                Dim dtRTODate As String = Request.QueryString("RTODate")
                Dim dtDepoDate As String = Request.QueryString("DepoDate")
                Dim dtPutDate As String = Request.QueryString("PutDate")
                Dim intCurStatus As Integer = Request.QueryString("CurStatus")

                strSql = "Ins_Vehicle_Master " & intId & ",'" & strBusNo & "'," & intBusType & "," & intBusCompany & ",'" & strModelNo & "','" & dtDepoDate & "','" & dtRTODate & "','" & dtFitRenewalDate & "','" & dtPutDate & "'," & intCurStatus & "," & intFuel & ",1," & intOptype
                intExst = ExecuteQuery(strSql)
            ElseIf strAction = "ForceDeletetInd" Then
                strSql = "UPDATE Indent_Request_Details SET Force_Close = 1 WHERE Indent_Details_ID = " & intId
                fnExecuteNonQuery(strSql)
                Response.End()
            ElseIf strAction = "Authentication" Then
                strSql = "Update Indent_Request_Master SET Authentic = 1 WHERE Indent_Id = " & intId
                intExst = ExecuteQuery(strSql)
            ElseIf strAction = "PartType" Then
                Dim intPartType As Integer = Request.QueryString("TypeId")
                Dim dt As DataTable
                Dim i As Integer = 0
                Dim strRepType As New StringBuilder
                Dim strCondition As String = ""
                If intPartType <> 0 Then
                    strCondition = " WHERE Part_Type_ID = " & intPartType
                End If

                strSql = "SELECT DISTINCT Repair_ID, Repair_Type FROM Repair_Type_Master " & strCondition & " ORDER BY Repair_Type"
                dt = GetDatatTable(strSql)
                strRepType.Append("Repair")
                For i = 0 To dt.Rows.Count - 1
                    strRepType.Append("Repair" & dt.Rows(i).Item("Repair_ID") & "~" & dt.Rows(i).Item("Repair_Type") & "|")
                Next
                intOptype = 3
                Response.Write(strRepType.ToString)
                ElseIf strAction = "PartMaster" Then
                    Dim intPartType As Integer = Request.QueryString("PartType")
                    Dim strPartCompanyNo As String = Request.QueryString("PartCompanyNo")
                    Dim strPartCompany As String = Request.QueryString("PartCompany")
                    Dim strPartWSNo As String = Request.QueryString("PartWSNo")
                    Dim strPartSize As String = Request.QueryString("PartSize")
                    Dim dtCompDate As String = Request.QueryString("CompDate")
                    Dim dtWSDate As String = Request.QueryString("WSDate")
                    If strPartSize <> "" Then strPartSize = strPartSize.Replace("'", "''")
                    strSql = "Ins_Part_Master " & intId & "," & intPartType & ",'" & strPartCompanyNo & "','" & strPartCompany & "','" & strPartWSNo & "','" & strPartSize & "','" & dtCompDate & "','" & dtWSDate & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)
                ElseIf strAction = "ScrapDetails" Then
                    Dim intScrapType As Integer = Request.QueryString("ScrapType")
                    Dim strScrapCompanyNo As String = Request.QueryString("ScrapCompanyNo")
                    Dim intScrapRsn As Integer = Request.QueryString("ScrapRsn")
                    Dim dtScrapDate As String = Request.QueryString("ScrapDate")
                    Dim strDescription As String = Request.QueryString("Description")

                    strSql = "Ins_Scrap_Details " & intId & "," & intScrapType & ",'" & strScrapCompanyNo & "'," & intScrapRsn & ",'" & dtScrapDate & "','" & strDescription & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)
                ElseIf strAction = "DefectDetails" Then
                    Dim dtDefectDate As String = Request.QueryString("DefectDate")
                    Dim strBusNo As String = Request.QueryString("BusNo")
                    Dim strDriverNo As String = Request.QueryString("DriverNo")
                    Dim strDefectTime As String = Request.QueryString("DefectTime")
                    Dim intDefPriority As Integer = Request.QueryString("DefPriority")
                    Dim strDescription As String = Request.QueryString("Description")

                    strSql = "Ins_Defect_Details " & intId & ",'" & dtDefectDate & "','" & strBusNo & "','" & strDriverNo & "','" & strDefectTime & "'," & intDefPriority & ",'" & strDescription & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)
                ElseIf strAction = "BreakdownDetails" Then
                    Dim dtBrkdwnDate As String = Request.QueryString("BrkdwnDate")
                    Dim strBusNo As String = Request.QueryString("BusNo")
                    Dim strDriverNo As String = Request.QueryString("DriverNo")
                    Dim strConductor As String = Request.QueryString("Conductor")
                Dim intBrkdwnPlace As String = Request.QueryString("BrkdwnPlace")
                    Dim strReason As String = Request.QueryString("Reason")
                    Dim strInfoTime As String = Request.QueryString("InfoTime")
                    Dim strMsgRcdTime As String = Request.QueryString("MsgRcdTime")
                    Dim strArrTime As String = Request.QueryString("ArrTime")
                    Dim strActTimeFrom As String = Request.QueryString("ActTimeFrom")
                    Dim strActTimeTo As String = Request.QueryString("ActTimeTo")
                    Dim strRemark As String = Request.QueryString("Remark")

                strSql = "Ins_Breakdown_Details " & intId & ",'" & dtBrkdwnDate & "','" & strBusNo & "','" & strDriverNo & "','" & strConductor & "','" & intBrkdwnPlace & "','" & strReason & "','" & strInfoTime & "','" & strMsgRcdTime & "','" & strArrTime & "','" & strActTimeFrom & "','" & strActTimeTo & "','" & strRemark & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)
                ElseIf strAction = "RetreadingDetails" Then
                    Dim intVendorName As Integer = Request.QueryString("VendorName")
                    Dim dtDate As String = Request.QueryString("Date")
                    Dim intPartType As Integer = Request.QueryString("PartType")
                    Dim strPartNo As String = Request.QueryString("PartNo")
                    Dim intProcessType As Integer = Request.QueryString("ProcessType")
                    Dim strDescription As String = Request.QueryString("Description")

                    strSql = "Ins_Retreading_Details " & intId & "," & intVendorName & ",'" & dtDate & "'," & intPartType & ",'" & strPartNo & "'," & intProcessType & ",'" & strDescription & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)
                ElseIf strAction = "PartRepairDetails" Then
                    Dim intPartType As Integer = Request.QueryString("PartType")
                    Dim strPartNo As String = Request.QueryString("PartNo")
                    Dim intRepairType As Integer = Request.QueryString("RepairType")
                    Dim dtRepairDate As String = Request.QueryString("RepairDate")
                    Dim strDescription As String = Request.QueryString("Description")

                    strSql = "Ins_Part_Repair_Details " & intId & "," & intPartType & ",'" & strPartNo & "','" & dtRepairDate & "'," & intRepairType & ",'" & strDescription & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)
                ElseIf strAction = "Status" Then
                    Dim intType As Integer = Request.QueryString("Type")
                    Dim intTypeID As Integer = Request.QueryString("TypeID")
                    Dim strMech As String = Request.QueryString("Mech")
                    Dim intWorkStatus As Integer = Request.QueryString("WorkStatus")
                    Dim dtWorkDate As String = Request.QueryString("WorkDate")
                    Dim strWorkRemark As String = Request.QueryString("WorkRemark")

                    strSql = "Ins_Status " & intId & "," & intType & "," & intTypeID & ",'" & strMech & "','" & dtWorkDate & "'," & intWorkStatus & ",'" & strWorkRemark & "',1," & intOptype
                    intExst = ExecuteQuery(strSql)

                ElseIf strAction = "Inspection" Then
                    Dim intType As Integer = Request.QueryString("Type")
                    Dim intTypeID As Integer = Request.QueryString("TypeID")
                    Dim strBusNo As String = Request.QueryString("BusNo")
                    Dim strCheckBy As String = Request.QueryString("CheckBy")
                    Dim strInspTime As String = Request.QueryString("InspTime")
                    Dim strCheckDate As String = Request.QueryString("CheckDate")
                    Dim strDescription As String = Request.QueryString("Description")

                    strSql = "Ins_Inspection " & intId & "," & intType & "," & intTypeID & ",'" & strBusNo & "','" & strCheckBy & "','" & strInspTime & "','" & strCheckDate & "','" & strDescription & "',1," & intOptype
                intExst = ExecuteQuery(strSql)

            ElseIf strAction = "PartHistory" Then
                Dim strBusNo As String = Request.QueryString("BusNo")
                Dim intPartType As Integer = Request.QueryString("PartType")
                Dim strPartNo As String = Request.QueryString("PartNo")
                Dim intPartPosition As Integer = Request.QueryString("PartPosition")
                Dim intPartStatus As Integer = Request.QueryString("PartStatus")
                Dim intReason As Integer = Request.QueryString("Reason")
                Dim strPHDate As String = Request.QueryString("PHDate")
                Dim strPartKm As String = Request.QueryString("PartKm")

                strSql = "Ins_Part_History " & intId & ",'" & strBusNo & "'," & intPartType & ",'" & strPartNo & "'," & intPartPosition & "," & intPartStatus & "," & intReason & ",'" & strPHDate & "','" & strPartKm & "',1," & intOptype
                intExst = ExecuteQuery(strSql)

                ElseIf strAction = "IndentDetails" Then

                    Dim strIndentDate As String = Request.QueryString("indentdate")
                    Dim strApprovedby As String = Request.QueryString("approvedby")
                    Dim strRemark As String = Request.QueryString("remark")
                    Dim strIndentdetails As String = Request.QueryString("Indentdetails")
                    Dim strDefectId As String = Request.QueryString("defId")

                    If intOptype <> 0 Then

                        strSql = "alter_Indent_master " & intId & "," & strDefectId & ",'" & strIndentDate & "','" & strApprovedby & "','" & strRemark & "','" & strIndentdetails & "',1," & intOptype
                        intExst = ExecuteQuery(strSql)

                    Else

                        cmd = New SqlCommand("Ins_Indent_master", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@Defect_Id", CInt(strDefectId))
                        cmd.Parameters.AddWithValue("@Indentdate", strIndentDate)
                        cmd.Parameters.AddWithValue("@Approvedby", strApprovedby)
                        cmd.Parameters.AddWithValue("@Remark", strRemark)
                        cmd.Parameters.AddWithValue("@User_ID", Session("Userid"))

                        Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                        strmaxid.Direction = ParameterDirection.Output
                        cmd.Parameters.Add(strmaxid)

                        Dim indent As New SqlParameter("@Indent_No", SqlDbType.BigInt)
                        indent.Direction = ParameterDirection.Output
                        cmd.Parameters.Add(indent)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                        indentno = cmd.Parameters("@Indent_No").Value.ToString
                        con.Close()
                        ''''''''''



                        If strIndentdetails.ToString <> "" Then
                            'Dim i As Integer
                            Dim myarray As Array = Split(strIndentdetails.ToString, "|")
                            Dim j As Integer
                            j = myarray.Length - 1

                            For i = 0 To myarray.Length - 2
                                If myarray(i) <> "" Then
                                    Dim mainarray As Array = Split(myarray(i), "^")

                                    strSql = "get_itemcode '" & mainarray(2) & "', '" & mainarray(0) & "', '" & mainarray(1) & "'"
                                    Dim stritemcode As String
                                    stritemcode = ExecuteQuery(strSql)


                                    cmd = New SqlCommand("Ins_Indent_details", con)
                                    cmd.CommandType = CommandType.StoredProcedure
                                    cmd.Parameters.AddWithValue("@Indent_master_id", maxid)
                                    cmd.Parameters.AddWithValue("@Indent_item_code", stritemcode)
                                    cmd.Parameters.AddWithValue("@Indent_bus_no", mainarray(3))
                                    cmd.Parameters.AddWithValue("@Indent_Req_qty", mainarray(4))
                                    cmd.Parameters.AddWithValue("@User_ID", Session("Userid"))


                                    con.Open()
                                    cmd.ExecuteNonQuery()
                                    'Response.Write("<script>alert('Saved Successfuly');window.location.href='storemaster.aspx'</script>")
                                    con.Close()
                                End If

                            Next
                        End If
                        ''''''''''
                        intOptype = 10
                        intExst = 10

                    End If

                ElseIf strAction = "IssueDetails" Then

                    Dim strIndentNo As String = Request.QueryString("IndentNo")
                    Dim intVendor As Integer = Request.QueryString("Vendor")
                    Dim strIssueDate As String = Request.QueryString("IssueDate")
                    Dim strWName As String = Request.QueryString("Wname")
                    Dim strApproved As String = Request.QueryString("Approvedby")
                    Dim strPartBus As String = Request.QueryString("PartBus")
                    Dim strGate As String = Request.QueryString("Gate")
                    Dim strRemark As String = Request.QueryString("Remark")
                    Dim strIndentdetails As String = Request.QueryString("Indentdetails")
                    Dim strDefectId As String = Request.QueryString("defId")
                    'Dim dr As SqlClient.SqlDataReader
                    If intOptype <> 0 Then

                        'strSql = "alter_Indent_master " & intId & "," & strDefectId & ",'" & strIndentDate & "','" & strApprovedby & "','" & strRemark & "','" & strIndentdetails & "',1," & intOptype
                        'intExst = ExecuteQuery(strSql)

                    Else

                    cmd = New SqlCommand("Ins_storeissuemaster_New", con)
                        cmd.CommandType = CommandType.StoredProcedure


                        cmd.Parameters.AddWithValue("@cont_id", intVendor)
                        cmd.Parameters.AddWithValue("@trans_date", strIssueDate)
                        cmd.Parameters.AddWithValue("@refno", strIndentNo)
                        cmd.Parameters.AddWithValue("@worker_name", strWName)
                        cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                        cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                        cmd.Parameters.AddWithValue("@getpassno ", strGate)
                        cmd.Parameters.AddWithValue("@approvedby", strApproved)
                        cmd.Parameters.AddWithValue("@part_of_bus ", strPartBus)
                        cmd.Parameters.AddWithValue("@remark", strRemark)


                        Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                        strmaxid.Direction = ParameterDirection.Output
                        cmd.Parameters.Add(strmaxid)

                        'Dim indent As New SqlParameter("@Indent_No", SqlDbType.BigInt)
                        'indent.Direction = ParameterDirection.Output
                        'cmd.Parameters.Add(indent)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        Dim maxid As Integer = cmd.Parameters("@maxid").Value.ToString
                        'indentno = cmd.Parameters("@Indent_No").Value.ToString
                        con.Close()
                        ''''''''''



                        If strIndentdetails.ToString <> "" Then
                            'Dim i As Integer
                            Dim myarray As Array = Split(strIndentdetails.ToString, "|")
                            Dim j As Integer
                            j = myarray.Length - 1

                            For i = 0 To myarray.Length - 2
                                If myarray(i) <> "" Then
                                    Dim mainarray As Array = Split(myarray(i), "^")

                                    strSql = "get_itemcode '" & mainarray(3) & "', '" & mainarray(1) & "', '" & mainarray(2) & "'"
                                    Dim stritemcode As String
                                    stritemcode = ExecuteQuery(strSql)


                                cmd = New SqlCommand("Ins_storeissuedetail_New", con)
                                    cmd.CommandType = CommandType.StoredProcedure
                                    cmd.Parameters.AddWithValue("@Detail_ID", mainarray(0))
                                    cmd.Parameters.AddWithValue("@indent_no", intVendor)
                                    cmd.Parameters.AddWithValue("@issue_id", maxid)
                                    cmd.Parameters.AddWithValue("@item_code", stritemcode)
                                    cmd.Parameters.AddWithValue("@veh_no", mainarray(4))
                                    cmd.Parameters.AddWithValue("@available_qty", mainarray(5))
                                    cmd.Parameters.AddWithValue("@Req_qty", mainarray(6))
                                    cmd.Parameters.AddWithValue("@quantity", mainarray(7))
                                    cmd.Parameters.AddWithValue("@Pen_qty", mainarray(8))
                                    cmd.Parameters.AddWithValue("@returnable", Session("Userid"))


                                    con.Open()
                                    cmd.ExecuteNonQuery()
                                    'Response.Write("<script>alert('Saved Successfuly');window.location.href='storemaster.aspx'</script>")
                                    con.Close()
                                End If

                            Next
                        End If
                        ''''''''''
                        'intOptype = 10
                        intExst = 10

                    End If

                End If

                If intOptype = 0 And intExst <> "1" Then
                    Response.Write("Add")
                ElseIf intOptype = 1 And intExst <> "1" Then
                    Response.Write("Edit")
                ElseIf intOptype = 2 And intExst <> "1" Then
                    Response.Write("Delete")
                ElseIf intExst = "1" Then
                    Response.Write("Duplicate")
                ElseIf intOptype = 10 Then
                    Response.Write("indentno" & indentno)
                ElseIf intOptype = 3 Then
                Else
                    Response.Write("OptFail")
                End If

        End Sub
    End Class
End Namespace
