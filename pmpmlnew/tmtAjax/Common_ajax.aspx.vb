Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Common_ajax
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr2 As SqlClient.SqlDataReader
        Dim sql1 As String

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Dim Str As String = ""
            Dim state As Integer = 0
            Dim strAction As String = Request.QueryString("action")

            If strAction = "ReceiveDetails" Then

                Try
                    Dim hdnrwcnt As Integer = Request.QueryString("hdnrwcnt")
                    Dim radparttype As String = Request.QueryString("radparttype")
                    Dim txtpotype As String = Request.QueryString("txtpotype")
                    Dim txtpono As Integer = Request.QueryString("txtpono")
                    Dim txtvendor As String = Request.QueryString("txtvendor")
                    Dim dtpoDate As String = Request.QueryString("dtpoDate")
                    Dim txtinwardno As String = Request.QueryString("txtinwardno")
                    Dim dtsecuritydate As String = Request.QueryString("dtsecuritydate")
                    Dim txtchalan As String = Request.QueryString("txtchalan")
                    Dim dtchalandate As String = Request.QueryString("dtchalandate")
                    Dim txtbill As String = Request.QueryString("txtbill")
                    Dim dtbilldate As String = Request.QueryString("dtbilldate")
                    Dim dtrecdate As String = Request.QueryString("dtrecdate")
                    Dim txtrecno As String = Request.QueryString("txtrecno")
                    Dim txtgate As String = Request.QueryString("txtgate")

                    Dim receivedetails As String = Request.QueryString("receivedetails")

                    Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor & "' ")

                    cmd = New SqlCommand("Ins_storemaster", Con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@part_type", radparttype)
                    cmd.Parameters.AddWithValue("@vendor_id", vendor)
                    cmd.Parameters.AddWithValue("@security_date", dtsecuritydate)
                    cmd.Parameters.AddWithValue("@challan_date", dtchalandate)
                    cmd.Parameters.AddWithValue("@challan_no ", txtchalan)
                    cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                    cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                    cmd.Parameters.AddWithValue("@po_date", dtpoDate)
                    cmd.Parameters.AddWithValue("@po_type", txtpotype)
                    cmd.Parameters.AddWithValue("@po_no", txtpono)
                    cmd.Parameters.AddWithValue("@Inward_no", txtinwardno)
                    cmd.Parameters.AddWithValue("@getpassno ", txtgate)
                    cmd.Parameters.AddWithValue("@bill_no ", txtbill)
                    cmd.Parameters.AddWithValue("@bill_date", dtbilldate)
                    cmd.Parameters.AddWithValue("@Rec_No ", txtrecno)
                    cmd.Parameters.AddWithValue("@Rec_Date", dtrecdate)
                    cmd.Parameters.AddWithValue("@drb_no ", "0")

                    Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                    strmaxid.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(strmaxid)

                    Con.Open()
                    cmd.ExecuteNonQuery()
                    Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                    Con.Close()

                    If receivedetails <> "" Then
                        'Dim i As Integer

                        Dim myarray As Array = Split(receivedetails, "|")
                        Dim j As Integer
                        j = myarray.Length - 1

                        For i = 0 To myarray.Length - 2
                            If myarray(i) <> "" Then
                                Dim mainarray As Array = Split(myarray(i), "^")

                                Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & mainarray(4) & "','" & mainarray(2) & "','" & mainarray(1) & "'")

                                cmd = New SqlCommand("Ins_storedetail", Con)
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@storeid ", maxid)
                                cmd.Parameters.AddWithValue("@available_qty ", mainarray(5))
                                cmd.Parameters.AddWithValue("@item_code", itemcode)
                                cmd.Parameters.AddWithValue("@challanqty", mainarray(8))
                                cmd.Parameters.AddWithValue("@rate", mainarray(10))
                                cmd.Parameters.AddWithValue("@quantity", mainarray(8))

                                cmd.Parameters.AddWithValue("@returnable", "0")
                                cmd.Parameters.AddWithValue("@pen_qty", mainarray(9))
                                cmd.Parameters.AddWithValue("@po_detail_id", mainarray(0))

                                Con.Open()
                                cmd.ExecuteNonQuery()

                                Con.Close()

                            End If

                        Next

                        state = 4
                    End If

                Catch ex As Exception

                End Try
                If state = 4 Then
                    Response.Write("Add")
                Else
                    Response.Write("OptFail")
                End If
            End If

            If strAction = "checkpoexists" Then
                Dim strpotype As String = ""
                Dim intpono As Integer = 0
                Dim exists As Integer = 0
                Try

                    strpotype = Request.QueryString("potype")
                    intpono = Request.QueryString("pono")
                    Dim dtpoDate As String = Request.QueryString("dtpoDate")
                    Dim pocat As Integer = Request.QueryString("poCat")

                    exists = ExecuteQuery("po_check '" & intpono & "' ,'" & strpotype & "','" & dtpoDate & "','" & pocat & "' ")
                    If exists <> 0 Then
                        Response.Write("Duplicate")
                    End If
                Catch ex As Exception

                End Try
            End If

            If strAction = "getpoDetails" Then
                Dim strvendor As String = ""
                Dim strpotype As String = ""
                Dim poyear As String = ""
                Dim intpono As Integer = 0
                Dim dt As New DataTable
                strvendor = Request.QueryString("vendor")
                strpotype = Request.QueryString("potype")
                poyear = Request.QueryString("poyear")
                intpono = Request.QueryString("pono")
                Dim dept As String = IIf(Session("Dept_type").ToString = "SP", 1, 2)
                'dt = GetDatatTable("SELECT PO_Str,Po_No,PO_Date  FROM PO_Master WHERE PO_Str = '" & strpotype & "' AND Po_No = " & intpono & " vendor) 
                dt = GetDatatTable("SELECT Vendor_Name,PO_Str,Po_No  FROM PO_Master INNER JOIN Stock_Vendor ON Stock_Vendor.Vendor_Id = PO_Master.Vendor_Id WHERE Vendor_Name = '" & strvendor & "' AND PO_Str = '" & strpotype & "' AND Po_No = " & intpono & " And po_fin_year = '" & poyear & "' and item_id = '" & dept.ToString & "' ")
                If dt.Rows.Count = 1 Then
                    Response.Write(getViewpoDetails(strvendor, strpotype, intpono, poyear, dept))
                End If
            End If

            'nilesh changes start
            If strAction = "getpoDetails1" Then
                Dim strvendor As String = ""
                Dim strpotype As String = ""
                Dim poyear As String = ""
                Dim intpono As Integer = 0
                'Dim intpono As String = ""
                Dim dt As New DataTable
                strvendor = Request.QueryString("vendor")
                strpotype = Request.QueryString("potype")
                poyear = Request.QueryString("poyear")
                intpono = Request.QueryString("pono")
                Dim dept As String = IIf(Session("Dept_type").ToString = "SP", 1, 2)
                'dt = GetDatatTable("SELECT PO_Str,Po_No,PO_Date  FROM PO_Master WHERE PO_Str = '" & strpotype & "' AND Po_No = " & intpono & " vendor) 
                dt = GetDatatTable("SELECT Vendor_Name,PO_Str,Po_No  FROM PO_Master INNER JOIN Stock_Vendor ON Stock_Vendor.Vendor_Id = PO_Master.Vendor_Id WHERE Vendor_Name = '" & strvendor & "' AND PO_Str = '" & strpotype & "' AND Po_No = " & intpono & " And po_fin_year = '" & poyear & "' and item_id = '" & dept.ToString & "' ")
                If dt.Rows.Count = 1 Then
                    Response.Write(getViewpoDetails1(strvendor, strpotype, intpono, poyear, dept))
                End If
            End If
            'nilesh changes end


            If strAction = "getpoDetailsdt" Then
                Dim strvendor As String = ""
                Dim strpotype As String = ""
                Dim strPODate As String = ""
                Dim intpono As Integer = 0
                Dim dt As New DataTable
                strvendor = Request.QueryString("vendor")
                strpotype = Request.QueryString("potype")
                intpono = Request.QueryString("pono")
                strPODate = Request.QueryString("dtpo")
                'strPODate = strPODate.Substring(3, 4) & strPODate.Substring(0, 2) & strPODate.Substring(6, 5)

                Response.Write(getViewpoDetailsDate(strvendor, strpotype, intpono, strPODate))
            End If

            If strAction = "getoilpoDetails" Then
                Dim strvendor As String = ""
                Dim strpotype As String = ""
                Dim poyear As String = ""
                Dim intpono As Integer = 0
                Dim dt As New DataTable
                strvendor = Request.QueryString("vendor")
                strpotype = Request.QueryString("potype")
                poyear = Request.QueryString("poyear")
                intpono = Request.QueryString("pono")
                'dt = GetDatatTable("SELECT PO_Str,Po_No,PO_Date  FROM PO_Master WHERE PO_Str = '" & strpotype & "' AND Po_No = " & intpono & " vendor) 
                dt = GetDatatTable("SELECT Vendor_Name,PO_Str,Po_No  FROM oilpo_master INNER JOIN Stock_Vendor ON Stock_Vendor.Vendor_Id = oilpo_master.Vendor_Id  WHERE Vendor_Name = '" & strvendor & "' AND PO_Str = '" & strpotype & "' AND Po_No = " & intpono & " And po_fin_year = '" & poyear & "'")
                If dt.Rows.Count = 1 Then
                    Response.Write(getViewoilpoDetails(strvendor, intpono, poyear))
                End If
            End If

            If strAction = "getpoNo" Then
                Dim strTemp As New StringBuilder
                Dim strVendor As String = ""
                strVendor = Request.QueryString("vendor")
                Dim dt As New DataTable
                dt = GetDatatTable("View_po_No '" & strVendor & "','" & Session("Deptid").ToString() & "'")
                'dt = GetDatatTable("SELECT Vendor_Name,PO_Str,Po_No  FROM PO_Master INNER JOIN PO_Details ON PO_Details.PO_id = PO_Master.po_id INNER JOIN Stock_Vendor ON Stock_Vendor.Vendor_Id = PO_Master.Vendor_Id WHERE Vendor_Name = '" & strVendor & "' AND isnull(po_flag,0) <> 1 ")
                strTemp.Append("PoNo!")
                For i = 0 To dt.Rows.Count - 1
                    strTemp.Append(dt.Rows(i).Item("PO_Str") & " | " & dt.Rows(i).Item("PO_No") & " | " & dt.Rows(i).Item("po_fin_year") & "!")
                Next
                Response.Write(strTemp.ToString)
            End If

            If strAction = "getoilpoNo" Then
                Dim strTemp As New StringBuilder
                Dim strVendor As String = ""
                strVendor = Request.QueryString("vendor")
                Dim dt As New DataTable
                dt = GetDatatTable("View_oilpo_No '" & strVendor & "'")
                'dt = GetDatatTable("SELECT Vendor_Name,PO_Str,Po_No  FROM PO_Master INNER JOIN PO_Details ON PO_Details.PO_id = PO_Master.po_id INNER JOIN Stock_Vendor ON Stock_Vendor.Vendor_Id = PO_Master.Vendor_Id WHERE Vendor_Name = '" & strVendor & "' AND isnull(po_flag,0) <> 1 ")
                strTemp.Append("PoNo!")
                For i = 0 To dt.Rows.Count - 1
                    strTemp.Append(dt.Rows(i).Item("PO_Str") & " | " & dt.Rows(i).Item("PO_No") & " | " & dt.Rows(i).Item("po_fin_year") & "!")
                Next
                Response.Write(strTemp.ToString)
            End If

            If Request("action") = "chkintimate" Then
                Dim intimate As String = Request.QueryString("intimate")
                sql1 = "select *  from ibc_details  where intimateno = '" & intimate & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, Con)
                Con.Open()
                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    Response.Write("Duplicate")
                End If

                Response.End()
                dr2.Close()
                Con.Close()
            End If

            If Request("action") = "chkinvoice" Then
                Dim invoice As String = Request.QueryString("invoice")
                Dim hdnvendorid As String = Request.QueryString("hdnvendorid")
                sql1 = "select *  from tbl_Store_Invoice_master  where is_delete <> 1 and  invoice_no = '" & invoice.ToString() & "' and vendorid ='" + hdnvendorid.ToString() + "' "
                Dim cmd2 As New SqlClient.SqlCommand(sql1, Con)
                Con.Open()
                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    Response.Write("Duplicate")
                End If

                Response.End()
                dr2.Close()
                Con.Close()
            End If

        End Sub
        Public Shared Function getViewpoDetails(ByVal strvendor As String, ByVal strpotype As String, ByVal intpono As Integer, ByVal poyear As String, ByVal dept As String) As String
            Dim strTemp As New StringBuilder
            Dim dt As New DataTable
            Dim dt1 As New DataTable
            Dim i As Integer = 0

            dt = GetDatatTable("View_po_Details '" & strvendor & "' ,'" & strpotype & "' ,'" & intpono & "','" & poyear & "','" & dept.ToString() & "'")
            dt1 = GetDatatTable("View_po_Master '" & strvendor & "' ,'" & strpotype & "','" & intpono & "','" & poyear & "','" & dept.ToString() & "'")
            If dt.Rows.Count <> 0 Then
                strTemp.Append("PassIndent<table id='Table1' width='100%' border='1' cellpadding='5' cellspacing='5' width='100%'>") '<tr><td>Select</td><td colspan='8'><select onchange='getViewDefectCon(this);' name='ddlInspection' id='ddlInspection' ><option value='1'>Inspected</option><option value='0'>Non Inspected</option></select></td></tr><tr class='tabheading'>")
                strTemp.Append("<tbody runat='server' id='tbodyRIndent'>")
                strTemp.Append("<tr  class='gridhead'>")
                strTemp.Append("<td>Sr No.</td>")
                strTemp.Append("<td>LF No.</td>")
                strTemp.Append("<td>Part No.</td>")
                strTemp.Append("<td>Item Name</td>")

                strTemp.Append("<td>Available Qty.</td>")
                strTemp.Append("<td>Orderd Qty.</td>")
                strTemp.Append("<td>Received Qty.</td>")
                strTemp.Append("<td>Receive Qty.</td>")
                strTemp.Append("<td>Unit.</td>")
                strTemp.Append("<td>Balance Qty.</td>")
                strTemp.Append("<td>Rate</td>")
                strTemp.Append("<td>Claim</td>")

                strTemp.Append("</tr>")
                For i = 0 To dt.Rows.Count - 1
                    strTemp.Append("<tr  id='trIndent_" & i & "' class='gridtxt'>")
                    strTemp.Append("<td id='tdsrNo_" & i & "'>" & i + 1 & "</td>")
                    strTemp.Append("<td style='display:none' id='tdID_" & i & "'>" & dt.Rows(i).Item("po_detail_id") & "</td>")
                    strTemp.Append("<td style='display:none' id='tdpart1_" & i & "'>" & dt.Rows(i).Item("part1") & "</td>")
                    strTemp.Append("<td id='tdRackNo_" & i & "'>" & dt.Rows(i).Item("rack_No") & "</td>")
                    strTemp.Append("<td id='tdPartNo_" & i & "'>" & dt.Rows(i).Item("Part_no") & "</td>")
                    strTemp.Append("<td id='tdItemName_" & i & "'>" & dt.Rows(i).Item("Item_Name") & "</td>")
                    strTemp.Append("<td id='tdAvailableQty_" & i & "'>" & dt.Rows(i).Item("Total_Stock") & "</td>")
                    strTemp.Append("<td id='tdRequiredQty_" & i & "'>" & dt.Rows(i).Item("Req_Qty") & "</td>")
                    strTemp.Append("<td id='tdreceivedQty_" & i & "'>" & dt.Rows(i).Item("received_qty") & "</td>")
                    strTemp.Append("<td id='tdreceiveQty_" & i & "'><input size ='10px' id='txtreceiveQty_" & i & "' type='text' name='txtreceiveqty_" & i & "' onblur='receive(" & i & ")' value='0' >")
                    strTemp.Append("<td id='tdRequiredUnit_" & i & "'>" & dt.Rows(i).Item("Unit") & "</td>")
                    strTemp.Append("<td id='tdbalQty_" & i & "'>" & dt.Rows(i).Item("pen_qty") & "</td>")
                    strTemp.Append("<td id='tdRate_" & i & "'><input size ='10px' id='txtRate_" & i & "' type='text' name='txtRate_" & i & "' value='" & dt.Rows(i).Item("item_rate") & "' >")
                    strTemp.Append("<td id='tdReject_" & i & "'><input id='chkclaim_" & i & "' onclick='changecolor(this.id,""" & i & """)' name='chkclaim_" & i & "' type='checkbox' runat='server'  />")

                    strTemp.Append("</tr>")
                Next
            End If
            If dt.Rows.Count = 0 Then strTemp.Append("Failpo") Else strTemp.Append("</tbody></table>|" & dt.Rows.Count)

            If dt1.Rows.Count <> 0 And dt.Rows.Count <> 0 Then
                strTemp.Append("|" & dt1.Rows(0).Item("vendor_name") & "|" & Format(CDate(dt1.Rows(0).Item("po_date")), "dd-MMM-yyyy") & "|" & dt1.Rows(0).Item("parttype") & "|" & dt1.Rows(0).Item("po_date1"))
            End If
            Return strTemp.ToString

        End Function
        'nilesh changes po start
        Public Shared Function getViewpoDetails1(ByVal strvendor As String, ByVal strpotype As String, ByVal intpono As Integer, ByVal poyear As String, ByVal dept As String) As String
            Dim strTemp As New StringBuilder
            Dim dt As New DataTable
            Dim dt1 As New DataTable
            Dim i As Integer = 0

            dt = GetDatatTable("View_po_Details '" & strvendor & "' ,'" & strpotype & "' ,'" & intpono & "','" & poyear & "','" & dept.ToString() & "'")
            dt1 = GetDatatTable("View_po_Master '" & strvendor & "' ,'" & strpotype & "','" & intpono & "','" & poyear & "','" & dept.ToString() & "'")
            If dt.Rows.Count <> 0 Then
                strTemp.Append("PassIndent<table id='Table1' width='100%' border='1' cellpadding='5' cellspacing='5' width='100%'>") '<tr><td>Select</td><td colspan='8'><select onchange='getViewDefectCon(this);' name='ddlInspection' id='ddlInspection' ><option value='1'>Inspected</option><option value='0'>Non Inspected</option></select></td></tr><tr class='tabheading'>")
                strTemp.Append("<tbody runat='server' id='tbodyRIndent'>")
                strTemp.Append("<tr  class='gridhead'>")
                strTemp.Append("<td>Sr No.</td>")
                strTemp.Append("<td>LF No.</td>")
                strTemp.Append("<td>Part No.</td>")
                strTemp.Append("<td>Item Name</td>")

                strTemp.Append("<td>Available Qty.</td>")
                ' strTemp.Append("<td>Orderd Qty.</td>")
                strTemp.Append("<td>Received Qty.</td>")
                strTemp.Append("<td>Receive Qty.</td>")
                strTemp.Append("<td>Unit.</td>")
                '  strTemp.Append("<td>Balance Qty.</td>")
                strTemp.Append("<td>Rate</td>")
                strTemp.Append("<td>Claim</td>")

                strTemp.Append("</tr>")
                For i = 0 To dt.Rows.Count - 1
                    strTemp.Append("<tr  id='trIndent_" & i & "' class='gridtxt'>")
                    strTemp.Append("<td id='tdsrNo_" & i & "'>" & i + 1 & "</td>")
                    strTemp.Append("<td style='display:none' id='tdID_" & i & "'>" & dt.Rows(i).Item("po_detail_id") & "</td>")
                    strTemp.Append("<td style='display:none' id='tdpart1_" & i & "'>" & dt.Rows(i).Item("part1") & "</td>")
                    strTemp.Append("<td id='tdRackNo_" & i & "'>" & dt.Rows(i).Item("rack_No") & "</td>")
                    strTemp.Append("<td id='tdPartNo_" & i & "'>" & dt.Rows(i).Item("Part_no") & "</td>")
                    strTemp.Append("<td id='tdItemName_" & i & "'>" & dt.Rows(i).Item("Item_Name") & "</td>")
                    strTemp.Append("<td id='tdAvailableQty_" & i & "'>" & dt.Rows(i).Item("Total_Stock") & "</td>")
                    'strTemp.Append("<td id='tdRequiredQty_" & i & "'>" & dt.Rows(i).Item("Req_Qty") & "</td>")
                    strTemp.Append("<td id='tdreceivedQty_" & i & "'>" & dt.Rows(i).Item("received_qty") & "</td>")
                    strTemp.Append("<td id='tdreceiveQty_" & i & "'><input size ='10px' id='txtreceiveQty_" & i & "' type='text' name='txtreceiveqty_" & i & "' onblur='receive(" & i & ")' value='0' >")
                    strTemp.Append("<td id='tdRequiredUnit_" & i & "'>" & dt.Rows(i).Item("Unit") & "</td>")
                    'strTemp.Append("<td id='tdbalQty_" & i & "'>" & dt.Rows(i).Item("pen_qty") & "</td>")
                    strTemp.Append("<td id='tdRate_" & i & "'><input size ='10px' id='txtRate_" & i & "' type='text' name='txtRate_" & i & "' value='" & dt.Rows(i).Item("item_rate") & "' >")
                    strTemp.Append("<td id='tdReject_" & i & "'><input id='chkclaim_" & i & "' onclick='changecolor(this.id,""" & i & """)' name='chkclaim_" & i & "' type='checkbox' runat='server'  />")

                    strTemp.Append("</tr>")
                Next
            End If
            If dt.Rows.Count = 0 Then strTemp.Append("Failpo") Else strTemp.Append("</tbody></table>|" & dt.Rows.Count)

            If dt1.Rows.Count <> 0 And dt.Rows.Count <> 0 Then
                strTemp.Append("|" & dt1.Rows(0).Item("vendor_name") & "|" & Format(CDate(dt1.Rows(0).Item("po_date")), "dd-MMM-yyyy") & "|" & dt1.Rows(0).Item("parttype") & "|" & dt1.Rows(0).Item("po_date1"))
            End If
            Return strTemp.ToString

        End Function
        'nilesh changes po end
        Public Shared Function getViewoilpoDetails(ByVal strvendor As String, ByVal intpono As Integer, ByVal poyear As String) As String
            Dim strTemp As New StringBuilder
            Dim dt As New DataTable
            Dim dt1 As New DataTable
            Dim i As Integer = 0

            dt = GetDatatTable("View_oilpo_Details '" & strvendor & "', '" & intpono & "','" & poyear & "'")
            dt1 = GetDatatTable("View_oilpo_Master '" & strvendor & "' ,'" & intpono & "','" & poyear & "'")
            If dt.Rows.Count <> 0 Then
                strTemp.Append("PassIndent<table id='Table1' width='100%' border='1' cellpadding='5' cellspacing='5' width='100%'>") '<tr><td>Select</td><td colspan='8'><select onchange='getViewDefectCon(this);' name='ddlInspection' id='ddlInspection' ><option value='1'>Inspected</option><option value='0'>Non Inspected</option></select></td></tr><tr class='tabheading'>")
                strTemp.Append("<tbody runat='server' id='tbodyRIndent'>")
                strTemp.Append("<tr  class='gridhead'>")
                strTemp.Append("<td>Sr No.</td>")

                strTemp.Append("<td>Item Name</td>")
                strTemp.Append("<td>Ltr Per Barrel</td>")

                strTemp.Append("<td>Ordered Barrel.</td>")
                strTemp.Append("<td>Received Barrel.</td>")
                strTemp.Append("<td>Receive Barrel.</td>")
                strTemp.Append("<td>Balance Barrel.</td>")
                strTemp.Append("<td>Rate</td>")

                strTemp.Append("</tr>")
                For i = 0 To dt.Rows.Count - 1
                    strTemp.Append("<tr  id='trIndent_" & i & "' class='gridtxt'>")
                    strTemp.Append("<td id='tdsrNo_" & i & "'>" & i + 1 & "</td>")
                    strTemp.Append("<td style='display:none' id='tdID_" & i & "'>" & dt.Rows(i).Item("oilpodetailid") & "</td>")

                    strTemp.Append("<td id='tdItemName_" & i & "'>" & dt.Rows(i).Item("oilname") & "</td>")
                    strTemp.Append("<td id='tdltrperbarrel_" & i & "'>" & dt.Rows(i).Item("ltrperbarrel") & "</td>")
                    strTemp.Append("<td id='tdorderbarrel_" & i & "'>" & dt.Rows(i).Item("orderbarrel") & "</td>")
                    strTemp.Append("<td id='tdreceivedbarrel_" & i & "'>" & dt.Rows(i).Item("receivedbarrel") & "</td>")

                    strTemp.Append("<td id='tdreceiveQty_" & i & "'><input size ='10px' id='txtreceiveQty_" & i & "' type='text' name='txtreceiveqty_" & i & "' onblur='receive(" & i & ")' value='0' >")
                    strTemp.Append("<td id='tdpenbarrel_" & i & "'>" & dt.Rows(i).Item("penbarrel") & "</td>")
                    strTemp.Append("<td id='tdRate_" & i & "'><input size ='10px' id='txtRate_" & i & "' type='text' readonly='readonly' name='txtRate_" & i & "' value='" & dt.Rows(i).Item("perltrrate") & "' >")

                    strTemp.Append("</tr>")
                Next
            End If
            If dt.Rows.Count = 0 Then strTemp.Append("Failpo") Else strTemp.Append("</tbody></table>|" & dt.Rows.Count)

            If dt1.Rows.Count <> 0 And dt.Rows.Count <> 0 Then
                strTemp.Append("|" & dt1.Rows(0).Item("vendor_name") & "|" & Format(CDate(dt1.Rows(0).Item("po_date")), "dd-MMM-yyyy") & "|" & dt1.Rows(0).Item("po_date1"))
            End If
            Return strTemp.ToString

        End Function

        Public Shared Function getViewpoDetailsDate(ByVal strvendor As String, ByVal strpotype As String, ByVal intpono As Integer, ByVal dtPoDate As String) As String
            Dim strTemp As New StringBuilder
            Dim dt As New DataTable
            Dim dt1 As New DataTable
            Dim i As Integer = 0

            dt = GetDatatTable("View_po_Details_Date '" & strvendor & "' ,'" & strpotype & "' ,'" & intpono & "','" & dtPoDate & "'")
            dt1 = GetDatatTable("View_po_Master_Date '" & strvendor & "' ,'" & strpotype & "','" & intpono & "','" & dtPoDate & "'")
            If dt.Rows.Count <> 0 Then
                strTemp.Append("PassIndent<table id='Table1' width='100%' border='1' cellpadding='5' cellspacing='5' width='100%'>") '<tr><td>Select</td><td colspan='8'><select onchange='getViewDefectCon(this);' name='ddlInspection' id='ddlInspection' ><option value='1'>Inspected</option><option value='0'>Non Inspected</option></select></td></tr><tr class='tabheading'>")
                strTemp.Append("<tbody runat='server' id='tbodyRIndent'>")
                strTemp.Append("<tr  class='gridhead'>")
                strTemp.Append("<td>Sr No.</td>")
                strTemp.Append("<td>LF No.</td>")
                strTemp.Append("<td>Part No.</td>")
                strTemp.Append("<td>Item Name</td>")

                strTemp.Append("<td>Available Qty.</td>")
                strTemp.Append("<td>Orderd Qty.</td>")
                strTemp.Append("<td>Received Qty.</td>")
                strTemp.Append("<td>Receive Qty.</td>")
                strTemp.Append("<td>Balance Qty.</td>")
                strTemp.Append("<td>Rate</td>")

                strTemp.Append("</tr>")
                For i = 0 To dt.Rows.Count - 1
                    strTemp.Append("<tr  id='trIndent_" & i & "' class='gridtxt'>")
                    strTemp.Append("<td id='tdsrNo_" & i & "'>" & i + 1 & "</td>")
                    strTemp.Append("<td style='display:none' id='tdID_" & i & "'>" & dt.Rows(i).Item("po_detail_id") & "</td>")
                    strTemp.Append("<td style='display:none' id='tdpart1_" & i & "'>" & dt.Rows(i).Item("part1") & "</td>")
                    strTemp.Append("<td id='tdRackNo_" & i & "'>" & dt.Rows(i).Item("rack_No") & "</td>")
                    strTemp.Append("<td id='tdPartNo_" & i & "'>" & dt.Rows(i).Item("Part_no") & "</td>")
                    strTemp.Append("<td id='tdItemName_" & i & "'>" & dt.Rows(i).Item("Item_Name") & "</td>")
                    strTemp.Append("<td id='tdAvailableQty_" & i & "'>" & dt.Rows(i).Item("Total_Stock") & "</td>")
                    strTemp.Append("<td id='tdRequiredQty_" & i & "'>" & dt.Rows(i).Item("Req_Qty") & "</td>")
                    strTemp.Append("<td id='tdreceivedQty_" & i & "'>" & dt.Rows(i).Item("received_qty") & "</td>")
                    strTemp.Append("<td id='tdreceiveQty_" & i & "'><input size ='10px' id='txtreceiveQty_" & i & "' type='text' name='txtreceiveqty_" & i & "' onblur='receive(" & i & ")' value='0' >")
                    strTemp.Append("<td id='tdbalQty_" & i & "'>" & dt.Rows(i).Item("pen_qty") & "</td>")
                    strTemp.Append("<td id='tdRate_" & i & "'><input size ='10px' id='txtRate_" & i & "' type='text' name='txtRate_" & i & "' value='" & dt.Rows(i).Item("item_rate") & "' >")

                    strTemp.Append("</tr>")
                Next
            End If
            If dt.Rows.Count = 0 Then strTemp.Append("Failpo") Else strTemp.Append("</tbody></table>|" & dt.Rows.Count)

            If dt1.Rows.Count <> 0 And dt.Rows.Count <> 0 Then
                strTemp.Append("|" & dt1.Rows(0).Item("vendor_name") & "|" & Format(CDate(dt1.Rows(0).Item("po_date")), "dd-MMM-yyyy") & "|" & dt1.Rows(0).Item("parttype"))
            End If
            Return strTemp.ToString

        End Function

    End Class
End Namespace
