Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Serialization

Namespace KDMT
    Partial Class Ajaxstore
        Inherits System.Web.UI.Page
        Dim chString, choice As String
        Dim DA As SqlDataAdapter
        Dim DA1 As SqlDataAdapter
        Dim strvalue As String
        Dim strvalue1 As String
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim ds As DataSet = New DataSet("Authors")
        Dim action As String
        Dim sql1 As String
        Dim to_km As String
        Dim from_km As String
        Dim ActFair As String
        Dim dr2 As SqlClient.SqlDataReader
        Dim dr3 As SqlClient.SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Response.CacheControl = "no-cache"
            Session("MenuId") = 10
            'If Not IsPostBack Then
            If Request("action") = "glassbalandLandB" Then
                Dim type As String = Request.QueryString("type")
                Dim pono As String = Request.QueryString("pono")
                Dim vendorname As String = Request.QueryString("vendorname")
                Dim glasstype As String = Request.QueryString("glasstype")
                Dim glassname As String = Request.QueryString("glassname")
                Dim poyear As String = Request.QueryString("poyear")

                Dim cmd2 As New SqlClient.SqlCommand
                cmd2 = New SqlCommand("glassbalandLandB", con)
                cmd2.CommandType = CommandType.StoredProcedure
                cmd2.Parameters.AddWithValue("@TYPE", Trim(type))
                cmd2.Parameters.AddWithValue("@PONO", Trim(pono))
                cmd2.Parameters.AddWithValue("@po_fin_year", Trim(poyear))
                cmd2.Parameters.AddWithValue("@vendor_name", vendorname)
                cmd2.Parameters.AddWithValue("@glassname", glasstype)
                cmd2.Parameters.AddWithValue("@itemname", glassname)

                con.Open()
                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = dr2(0).ToString() + "|" + dr2(1).ToString & "|" + dr2(2).ToString
                End While
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If
            If Request("action") = "checkvehicle" Then

                Dim vechno As String = Request.QueryString("vechno")
                Dim Fueltype As String = Request.QueryString("Fueltype")
                Dim Strcode As String = ""
                sql1 = "Fuel_bus_exists '" & vechno & "','" & Fueltype & "'"
                Dim cmd4 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd4.ExecuteReader
                If dr2.Read() Then
                    Dim i As String = dr2(0)
                    Response.Write(i)
                    Response.End()
                Else
                    Response.Write(9)
                    Response.End()
                End If
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "chkrepaiitemsrno" Then
                Dim itemName As String = Request.QueryString("itemName")

                Dim drnew As SqlDataReader
                'Dim sql As String = "select * from item_detail where item_name= '" & itemid & "' and loc_id = '" & locid & "'"
                Dim sql As String = "select * from tbl_repair_item where ispartno = '1' and item_name = '" & itemName & "'"
                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                drnew = cmd.ExecuteReader
                If drnew.Read Then
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("")
                    'Response.Write(strvalue1)
                    Response.End()
                Else
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("NO-SUCH-ITEM")
                    'Response.Write(strvalue1)
                    Response.End()
                End If
            End If

            If Request("action") = "ritemqty" Then
                Dim value As String = Request.QueryString("itemid")
                Dim itemid As Integer
                'sql1 = "select itemid   from tbl_Repair_Item Where  item_name= '" & value & "'"
                itemid = ExecuteQuery("select itemid   from tbl_Repair_Item Where  item_name= '" & value & "'")
                'sql1 = "current_repair_stock'" & itemname & "'"
                Dim sql2 = "current_repair_stock '" & itemid & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql2, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.HasRows = 0 Then

                Else
                    If dr2.Read Then
                        strvalue = Convert.ToString(dr2(0)) + "|" + Convert.ToString(dr2(1)) '+ "|" + Convert.ToString(dr2(2)) + "|" + Convert.ToString(dr2(3).ToString())
                    End If
                    Response.Flush()
                    Response.Write(strvalue)
                    'Response.Write(strvalue1)
                    Response.End()
                    dr2.Close()
                    con.Close()
                End If
            End If

            If Request("action") = "getbusno" Then
                Dim job As String = Request.QueryString("newjob")
                Dim jobno As String = Request.QueryString("newjobno")
                Dim itemcode As String = Request.QueryString("itemcode")
                'Change by Khan Faisal  21 Dec 2013 
                'sql1 = "select  busno  from JobOrderCard_Master where locid='0' and newjob= '" & job & "'and newjobno= '" & jobno & "'"
                sql1 = "check_jobclosedtimevalidity '" & job & "','" & jobno & "','" & itemcode.ToString() & "'"

                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then
                    strvalue = Convert.ToString(dr2(0)) + "|" + Convert.ToString(dr2(1)) + "|" + Convert.ToString(dr2(2)) + "|" + Convert.ToString(dr2(3).ToString()) + "|" + Convert.ToString(dr2(4).ToString())
                Else
                    strvalue = "empty"
                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If


            If Request("action") = "checkvechexist" Then

                Dim vechno As String = Request.QueryString("vechno")
                Dim Fueltype As String = Request.QueryString("Fueltype")
                Dim Strcode As String = ""
                sql1 = "Fuel_bus_others_exists '" & vechno & "','" & Fueltype & "'"
                Dim cmd4 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd4.ExecuteReader
                If dr2.Read() Then
                    Dim i As String = dr2(0)
                    Response.Write(i)
                    Response.End()
                Else
                    Response.Write(9)
                    Response.End()
                End If
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "chkbusdetailsjob_Docking" Then
                Dim value As String = Request.QueryString("busno")
                Dim locid As String = Session("locid")

                'sql1 = "select JOC_id,joccode from JobOrderCard_Master where JobOrderCard_Master.busno like '%" & value & "%' and JobOrderCard_Master.locid = 0 and docking=1"
                sql1 = "select JOC_id,joccode,newjob,newjobno from JobOrderCard_Master where JobOrderCard_Master.busno = '" & value & "' and docking=1 and locid = 0"
                Dim str As String

                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then

                    strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3)
                    'str = ExecuteQuery("view_inspdeffectdetails " & dr2(0) & "")

                    'strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(5) & "!" & dr2(6) & "!" & dr2(7) & "!" & str
                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "chkjobbusdetails" Then
                Dim value As String = Request.QueryString("busno")
                Dim newjob As String = Request.QueryString("newjob")
                Dim newjobno As String = Request.QueryString("newjobno")
                Dim locid As String = Session("locid")
                ' sql1 = "view_itemdetail '%" & value & "%' "
                Dim jobs As String = ""
                sql1 = "view_jobsubdetails '" & value & "','" & newjob & "','" & newjobno & "' "
                Dim da As New SqlClient.SqlDataAdapter(sql1, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)

                'Dim cmd3 As New SqlClient.SqlCommand(sql1, con)
                'con.Open()
                'Dim ds As New DataSet
                Dim i As Integer = 0
                'ds = cmd3.ExecuteScalar
                For i = 0 To ds.Tables(0).Rows.Count - 1
                    If jobs = "" Then
                        jobs = ds.Tables(0).Rows(i).Item(6).ToString
                    Else
                        jobs = jobs + " , " + ds.Tables(0).Rows(i).Item(6).ToString
                    End If
                Next
                'If (dr2.Read) Then
                'End If
                'dr2.Close()
                con.Close()

                sql1 = "view_jobdetails '','" & value & "','" & newjob & "','" & newjobno & "' "
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then

                    strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(5) & "!" & dr2(6) & "!" & dr2(7) & "!" & dr2(8) & "!" & dr2(9) & "!" & jobs & "!" & dr2(11) & "!" & dr2(12)

                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "chkdeffectplace" Then
                Dim busno As String = Request.QueryString("busno")
                Dim newjob As String = Request.QueryString("newjob")
                Dim newjobno As String = Request.QueryString("newjobno")

                Dim dr2 As SqlDataReader
                'Dim sql As String = "select * from item_detail where item_name= '" & itemid & "' and loc_id = '" & locid & "'"
                Dim sql As String = "select deffectplace from JobOrderCard_Master where  newjob = '" & newjob & "' and newjobno='" & newjobno & "' and busno='" & busno & "'"
                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                dr2 = cmd.ExecuteReader
                If (dr2.Read) Then

                    strvalue = strvalue + dr2(0)

                End If


                Response.Flush()
                Response.Write(strvalue)
                dr2.Close()
                con.Close()
                Response.End()

            End If

            If Request("action") = "chkbusdetails" Then
                Dim value As String = Request.QueryString("busno")
                Dim locid As String = Session("locid")
                Dim value1 As String = Request.QueryString("deffpl")
                ' sql1 = "view_itemdetail '%" & value & "%' "
                Dim id1, id2 As String
                Dim jobno As String = ""
                id1 = GetMaxId("JOC_id", con, "JobOrderCard_Master")
                Dim ln As Integer
                ln = id1.Length
                Dim dt1 As String
                dt1 = Format(Now.Date, "ddMyy")
                dt1 = IIf(dt1.Length = 5, Format(Now.Date, "ddmMyy"), Format(Now.Date, "ddMyy"))
                If ln = 1 Then
                    jobno = "00000" & id1 & Session("LocID") & value & dt1
                    '"-" & ddldeffect.SelectedValue & "-"
                    id2 = "00000" & id1
                ElseIf ln = 2 Then
                    jobno = "0000" & id1 & Session("LocID") & value & dt1
                    id2 = "0000" & id1
                ElseIf ln = 3 Then
                    jobno = "000" & id1 & Session("LocID") & value & dt1
                    id2 = "000" & id1
                ElseIf ln = 4 Then
                    jobno = "00" & id1 & Session("LocID") & value & dt1
                    id2 = "00" & id1
                ElseIf ln = 5 Then
                    jobno = "0" & id1 & Session("LocID") & value & dt1
                    id2 = "0" & id1
                ElseIf ln >= 6 Then
                    jobno = id1 & Session("LocID") & value & dt1
                    id2 = id1
                End If
                con.Close()

                sql1 = "view_busdetails '" & value & "' "
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then
                    Dim lock As Integer = 0
                    Dim lock1 As String
                    lock1 = ExecuteQuery("select locid  from dbo.JobOrderCard_Master  where busno = '" + value + "'  and locid <>  1")
                    'lock = IIf(lock1 = "", 0, 1)
                    If value1 = "true" Then
                        strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(6) & "!" & dr2(7) & "!" & jobno
                        Session("insp") = dr2(5)
                    Else
                        If (lock1 <> "0" And lock1 <> "1") Then
                            strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(6) & "!" & dr2(7) & "!" & jobno
                            Session("insp") = dr2(5)
                        ElseIf lock1 = 0 Then
                            strvalue = ""
                        Else
                            strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(6) & "!" & dr2(7) & "!" & jobno
                            Session("insp") = dr2(5)
                            'Response.Write("<script language=javascript>alert('Job Already Opened')</script>")
                        End If
                    End If
                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "chkbus" Then
                Dim vechno As String = Request.QueryString("busno")


                'sql1 = "select vech_no,fuel_type,fuel_comp.comp_Desc,Vech_id from vech_master inner join fuel_comp on fuel_comp.comp_id = vech_master.comp_id where is_delete='0' and vech_no= '" & vechno & "' and fuel_type='" & Fueltype & "' "
                sql1 = "select *  from vech_master where is_delete='0' and vech_no= '" & vechno & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then
                    strvalue = dr2(0)
                Else
                    strvalue = "empty"
                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "chkbusDefect" Then
                Dim vechno As String = Request.QueryString("busno")


                'sql1 = "select vech_no,fuel_type,fuel_comp.comp_Desc,Vech_id from vech_master inner join fuel_comp on fuel_comp.comp_id = vech_master.comp_id where is_delete='0' and vech_no= '" & vechno & "' and fuel_type='" & Fueltype & "' "
                sql1 = "select busno from JobOrderCard_Master where jobdate>=dateadd(dd,-8,getdate()) and  busno= '" & vechno & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then
                    strvalue = dr2(0)
                Else
                    strvalue = "empty"
                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If



            'For Ticket Denomination
            If Request("action") = "item" Then
                Dim value As String = Request.QueryString("itemname")
                Dim locid As String = Session("locid")
                sql1 = "Select item_name From item_detail Where item_name like '%" & value & "%' "
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemnamedeptwisenew" Then
                Dim itemid As String = Session("Deptid").ToString()
                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                Dim lfno As String = Request.QueryString("lfno")
                Dim strbinno As String = Request.QueryString("partno")

                If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                'If strbinno <> "" Then strbinno = " AND subrack_no='" & strbinno & "'"

                If itemid = "1" Then
                    sql1 = "select  item_detail.item_name,rack_no,subrack_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " &
                                "where item_detail.item_name  like '%" & Trim(item) & "%' and is_delete <> 1 and item_master.item_id = '1'" & lfno '& strbinno
                Else
                    sql1 = "select  item_detail.item_name,rack_no,subrack_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " &
                               "where item_detail.item_name  like '%" & Trim(item) & "%' and is_delete <> 1 and item_master.item_id in(2,3,4)" & lfno '& strbinno
                End If
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemdetail" Then
                Dim value As String = Request.QueryString("itemname")
                Dim locid As String = Session("locid")
                sql1 = "view_itemdetail '%" & value & "%' "
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then

                    strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(5) & "!" & dr2(6) & "!" & dr2(7) & "!" & dr2(8) & "!" & dr2(9) & "!" & dr2(10) & "!" & dr2(11)

                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemrejectiondetails" Then
                Dim itemname As String = Request.QueryString("itemname")
                Dim lfno As String = Request.QueryString("lfno")
                Dim txtvendor As String = Request.QueryString("txtvendor")
                Dim txtrejectionqty As String = Request.QueryString("txtrejectionqty")
                Dim txtchallan As String = Request.QueryString("txtchallan")

                Dim locid As String = Session("locid")

                'sql1 = "select smd.item_code from store_master_detail as smd inner join item_detail as id ON id.item_code = smd.item_code inner join store_master as sm on sm.store_id = smd.store_id where sm.challan_no = '1069' and smd.item_code = 4714 and sm.vendor_id = 167"

                'sql1 = "sd.item_code select total_stock,item_detail.amount from stock_master inner join item_detail on  stock_master.item_code = item_detail.item_code where item_name= '" & itemid & "' and loc_id = '" & locid & "'"
                sql1 = "view_rejitemcheck '" & txtchallan & "','" & txtvendor & "','" & lfno & "','" & itemname & "','" & txtrejectionqty & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    strvalue = Convert.ToString(dr2(0))
                End If
                Response.Flush()
                Response.Write(strvalue)
                'Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemnamedeptwiseglass" Then
                Dim itemid As String = Session("Deptid").ToString()
                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                'Dim lfno As String = Request.QueryString("lfno")
                'Dim strPartNo As String = Request.QueryString("partno")

                'If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                'If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "

                'If itemid = "1" Then
                'sql1 = "select  Glassname FROM Glassmaster where Glassname like '%" & Trim(item) & "%' "
                'Else
                sql1 = "select  Glassname FROM Glassmaster where Glassname like '%" & Trim(item) & "%'"
                'End If
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If


            If Request("action") = "itemdetailrack" Then
                Dim room As String = Request.QueryString("room")
                Dim lfno As String = Request.QueryString("lfno")
                Dim locid As String = Session("locid")
                Dim binno As String = Request.QueryString("bin")
                ' sql1 = "view_itemdetailrack '" & room & "','" & lfno & "' "
                sql1 = "view_itemdetailrack '" & room & "','" & lfno & "','" & binno & "' "

                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If (dr2.Read) Then
                    '       strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(5) & "!" & dr2(6) & "!" & dr2(7) & "!" & dr2(8) & "!" & dr2(9) & "!" & dr2(10) & "!" & dr2(11)
                    strvalue = dr2(0) & "!" & dr2(1) & "!" & dr2(2) & "!" & dr2(3) & "!" & dr2(4) & "!" & dr2(5) & "!" & dr2(6) & "!" & dr2(7) & "!" & dr2(8) & "!" & dr2(9) & "!" & dr2(10) & "!" & dr2(11) & "!" & dr2(12) & "!" & dr2(13) & "!" & dr2(14) & "!" & dr2(15) & "!" & dr2(16)

                End If
                Response.Flush()
                Response.Write(strvalue)
                Response.End()
                dr2.Close()
                con.Close()
            End If


            If Request("action") = "chkintimate" Then
                Dim intimate As String = Request.QueryString("intimate")
                sql1 = "select *  from ibc_details  where intimateno = " & intimate & ""
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()
                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    Response.Write("alreadyexist")
                End If

                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemname" Then
                Dim itemid As String = Request.QueryString("itemid")
                Dim locid As String = Session("locid")
                sql1 = "select  item_detail.item_name from item_detail inner join item_master on item_master.item_id=item_detail.item_id  where item_master.item_name = '" & itemid & "' "
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemname1" Then
                Dim itemid As String = Request.QueryString("itemid")
                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                Dim lfno As String = Request.QueryString("lfno")
                Dim strPartNo As String = Request.QueryString("partno")

                If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "


                sql1 = "select  item_detail.item_name,rack_no,part_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " &
                            "where item_detail.item_name  like '%" & Trim(item) & "%' " & lfno & strPartNo

                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "chkitemname" Then
                Dim itemid As String = Request.QueryString("itemid")
                Dim locid As String = Session("locid")

                Dim drnew As SqlDataReader
                Dim sql As String = "select * from item_detail where item_name= '" & itemid & "' "
                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                drnew = cmd.ExecuteReader
                If drnew.Read Then
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("")
                    'Response.Write(strvalue1)
                    Response.End()
                Else
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("NO-SUCH-ITEM")
                    'Response.Write(strvalue1)
                    Response.End()
                End If
            End If

            If Request("action") = "itemnamedeptwise" Then
                Dim itemid As String = Session("Deptid").ToString()
                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                Dim lfno As String = Request.QueryString("lfno")
                Dim strPartNo As String = Request.QueryString("partno")

                If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "

                If itemid = "1" Then
                    sql1 = "select  item_detail.item_name,rack_no,part_no,item_detail.subrack_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " &
                                "where item_detail.item_name  like '%" & Trim(item) & "%' and is_delete <> 1  and item_master.item_id = '1'" & lfno & strPartNo
                Else
                    sql1 = "select  item_detail.item_name,rack_no,part_no,item_detail.subrack_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " &
                               "where item_detail.item_name  like '%" & Trim(item) & "%' and is_delete <> 1  and item_master.item_id in(2,3,4)" & lfno & strPartNo
                End If
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "oilitemname" Then
                Dim itemid As String = Session("Deptid").ToString()
                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                'Dim lfno As String = Request.QueryString("lfno")
                'Dim strPartNo As String = Request.QueryString("partno")

                'If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                'If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "

                'If itemid = "1" Then
                'sql1 = "select  item_detail.item_name,rack_no,part_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " & _
                '            "where item_detail.item_name  like '%" & Trim(item) & "%' and is_delete <> 1 and item_detail.loc_id = '" & locid & "' and item_master.item_id = '1'" & lfno & strPartNo
                'Else
                '    sql1 = "select  item_detail.item_name,rack_no,part_no from item_detail inner join item_master on item_master.item_id=item_detail.item_id  " & _
                '               "where item_detail.item_name  like '%" & Trim(item) & "%' and is_delete <> 1 and item_detail.loc_id = '" & locid & "' and item_master.item_id in(2,3,4)" & lfno & strPartNo
                'End If

                sql1 = "select  oilname from oilitemmaster where oilname  like '%" & Trim(item) & "%' and is_delete <> 1 "

                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "itemnamedeptwiseglass" Then
                Dim itemid As String = Session("Deptid").ToString()
                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                'Dim lfno As String = Request.QueryString("lfno")
                'Dim strPartNo As String = Request.QueryString("partno")

                'If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                'If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "

                'If itemid = "1" Then
                'sql1 = "select  Glassname FROM Glassmaster where Glassname like '%" & Trim(item) & "%' "
                'Else
                sql1 = "select  Glassname FROM Glassmaster where Glassname like '%" & Trim(item) & "%'"
                'End If
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "oilitemname" Then

                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                'Dim lfno As String = Request.QueryString("lfno")
                'Dim strPartNo As String = Request.QueryString("partno")

                'If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                'If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "

                'If itemid = "1" Then
                'sql1 = "select  Glassname FROM Glassmaster where Glassname like '%" & Trim(item) & "%' "
                'Else
                sql1 = "select  oilname FROM oilitemmaster where oilname like '%" & Trim(item) & "%' "
                'End If
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "oilitemnameandbarrel" Then

                Dim item As String = Request.QueryString("item")
                Dim locid As String = Session("locid")
                'Dim lfno As String = Request.QueryString("lfno")
                'Dim strPartNo As String = Request.QueryString("partno")

                'If lfno <> "" Then lfno = " AND rack_no='" & lfno & "' "
                'If strPartNo <> "" Then strPartNo = " AND part_no='" & strPartNo & "' or part_no2='" & strPartNo & "' or part_no3='" & strPartNo & "' or part_no4='" & strPartNo & "' "

                'If itemid = "1" Then
                'sql1 = "select  Glassname FROM Glassmaster where Glassname like '%" & Trim(item) & "%' "
                'Else
                sql1 = "select  convert (varchar (15),ltrperbarrel,0)  + ' | ' + convert (varchar (15),stockbarrel,0) FROM oilstockmaster   where oilitemname like '%" & Trim(item) & "%' "
                'End If
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                While dr2.Read
                    strvalue = strvalue + dr2(0) & "!"
                End While
                Response.Write(strvalue)
                Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()

            End If

            If Request("action") = "Authentication" Then
                Dim Part_Type As String = ""


                'If Session("Dept_code") = 1 Then
                '    Part_Type = "sp"
                'ElseIf Session("Dept_code") = 2 Then
                '    Part_Type = "hw"
                'End If

                Dim strid As String = Request.QueryString("storeid")
                Dim strMID As String = Request.QueryString("MID")
                Dim cnt As String = Request.QueryString("cnt")
                Dim drbdate As String = Request.QueryString("drbdate")
                Dim rdbsp As String = Request.QueryString("rdbsp")
                Dim drbno As String = Request.QueryString("drbno")
                Dim arrstrid() As String
                Dim arrrdbsp() As String
                Dim arrdrbno() As String
                Dim arrMID() As String
                arrstrid = strid.Split("-")
                arrrdbsp = rdbsp.Split("-")
                arrdrbno = drbno.Split("|")
                arrMID = strMID.Split("-")
                Dim cmd As SqlClient.SqlCommand
                Dim fin_year As String = GetFinYear(1)

                If Session("Dept_code") = 2 Then

                    For i = 0 To cnt - 1
                        cmd = New SqlCommand("Upd_Authentication_for_hardware", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@store_id", arrstrid(i))
                        'If arrdrbno.Length > 1 Then
                        cmd.Parameters.AddWithValue("@sub_part_type", "HW")
                        cmd.Parameters.AddWithValue("@sub_invert_no", arrdrbno(i))
                        'Else
                        '    Response.Write("<script>alert('Please Enter DRB No properly (.. - ..)')<script>")
                        '    Exit Sub
                        'End If
                        cmd.Parameters.AddWithValue("@MID", arrMID(i))
                        cmd.Parameters.AddWithValue("@drbdate", drbdate)
                        cmd.Parameters.AddWithValue("@fydrb", fin_year)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("Authenticated")
                        con.Close()
                    Next

                Else

                    For i = 0 To cnt - 1
                        cmd = New SqlCommand("Upd_Authentication", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@store_id", arrstrid(i))
                        If arrdrbno.Length > 1 Then
                            cmd.Parameters.AddWithValue("@sub_part_type", arrrdbsp(i))
                            cmd.Parameters.AddWithValue("@sub_invert_no", arrdrbno(i))
                        Else
                            Response.Write("<script>alert('Please Enter DRB No properly (.. - ..)')<script>")
                            Exit Sub
                        End If
                        cmd.Parameters.AddWithValue("@MID", arrMID(i))
                        cmd.Parameters.AddWithValue("@drbdate", drbdate.ToString)
                        cmd.Parameters.AddWithValue("@fydrb", fin_year)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("Authenticated")
                        con.Close()
                    Next
                End If
                'Response.Write("<script>if(confirm('Are You Want to Print')){window.location.href='../report/rptDRBreport.aspx?SrNo=" & strMID & "';} else {alert('Saved Successfuly');window.location.href='Authenticate_receive.aspx';}</script>")
                'Dim drnew As SqlDataReader
                'Dim sql As String = "select * from item_detail where item_name= '" & itemid & "' and loc_id = '" & locid & "'"

            End If


            If Request("action") = "getchartvaluemwmc" Then
                Dim row As Dictionary(Of String, Object)
                Dim rows As New List(Of Dictionary(Of String, Object))()
                Dim serializer As New JavaScriptSerializer()
                Dim poyear As String = Request.QueryString("poyear")
                Dim cmd2 As New SqlClient.SqlCommand
                Dim dt As DataTable = GetDatatTable(
                        "SELECT  SUM(total_qty) as distance , concat(DateName( month , DateAdd( month ,  MONTH(trans_date) , -1 ) ),' ', year(trans_date)) as date " &
                          "FROM store_issue_detail  a inner join store_issue_master b on a.issue_id=b.issue_id " &
                          "where year(trans_date) = " + poyear + " " &
                         "GROUP BY MONTH(trans_date) ,year(trans_date) order by year(trans_date)")
                For Each dr As DataRow In dt.Rows
                    row = New Dictionary(Of String, Object)()
                    For Each col As DataColumn In dt.Columns
                        row.Add(col.ColumnName, dr(col))
                    Next
                    rows.Add(row)
                Next
                Response.Write(serializer.Serialize(rows))
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "geomchanged" Then
                Dim ID As String = Request.QueryString("id")
                Dim sql As String = "max_drb_no 'om'"
                Dim i As Integer = 0
                Dim dr As SqlClient.SqlDataReader

                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                dr = cmd.ExecuteReader
                dr.Read()
                If IsDBNull(dr.GetValue(0)) = True Then
                    i = 1
                Else
                    i = dr.GetValue(0)
                End If
                cmd.Dispose()
                dr.Close()
                con.Close()
                Response.Write("omNo^" & i & "^" & ID)
            End If

            If Request("action") = "chkvendorname" Then
                Dim vendorname As String = Request.QueryString("vendorname")
                Dim drnew As SqlDataReader
                Dim sql As String = "select vendor_id  from stock_vendor  where vendor_name  = '" & vendorname.ToString & "'"
                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                drnew = cmd.ExecuteReader
                If drnew.Read Then
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("")
                    Response.End()
                Else
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("NO-SUCH-ITEM")
                    Response.End()
                End If
            End If


            If Request("action") = "chkdieselvendorname" Then
                Dim vendorname As String = Request.QueryString("vendorname")
                Dim drnew As SqlDataReader
                Dim sql As String = "select fuel_vendor_desc  from Fuel_vendor  where fuel_vendor_desc  = '" & vendorname.ToString & "'"
                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                drnew = cmd.ExecuteReader
                If drnew.Read Then
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("")
                    Response.End()
                Else
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("NO-SUCH-ITEM")
                    Response.End()
                End If
            End If

            If Request("action") = "chkdeponame" Then
                Dim deponame As String = Request.QueryString("deponame")
                Dim drnew As SqlDataReader
                Dim sql As String = "select cont_id  from  contractor_master  where cont_name  = '" & deponame.ToString & "'"
                Dim cmd As New SqlClient.SqlCommand(sql, con)
                con.Open()
                drnew = cmd.ExecuteReader
                If drnew.Read Then
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("")
                    Response.End()
                Else
                    drnew.Close()
                    con.Close()
                    Response.Flush()
                    Response.Write("NO-SUCH-ITEM")
                    Response.End()
                End If
            End If


            If Request("action") = "itemqty" Then
                Dim itemid As String = Request.QueryString("itemid")
                Dim lfno As String = Request.QueryString("lfno")
                Dim partno As String = Request.QueryString("partno")
                Dim locid As String = Session("locid")


                ' sql1 = "select total_stock,item_detail.amount from stock_master inner join item_detail on  stock_master.item_code = item_detail.item_code where item_name= '" & itemid & "' and loc_id = '" & locid & "'"
                sql1 = "item_stock_bal '" & itemid & "','" & lfno & "','" & partno & "','" & locid & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    strvalue = Convert.ToString(dr2(0)) + "|" + Convert.ToString(dr2(1)) + "|" + Convert.ToString(dr2(2)) + "|" + Convert.ToString(dr2(3).ToString()) + "|" + Convert.ToString(dr2(4).ToString())
                End If
                Response.Flush()
                Response.Write(strvalue)
                'Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            If Request("action") = "itemqtynew" Then
                Dim itemid As String = Request.QueryString("itemid")
                Dim lfno As String = Request.QueryString("lfno")
                Dim partno As String = Request.QueryString("partno")
                Dim locid As String = Session("locid")


                ' sql1 = "select total_stock,item_detail.amount from stock_master inner join item_detail on  stock_master.item_code = item_detail.item_code where item_name= '" & itemid & "' and loc_id = '" & locid & "'"
                sql1 = "item_stock_bal '" & itemid & "','" & lfno & "','" & partno & "','" & locid & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    strvalue = Convert.ToString(dr2(0)) + "|" + Convert.ToString(dr2(1)) + "|" + Convert.ToString(dr2(2)) + "|" + Convert.ToString(dr2(3).ToString()) + "|" + Convert.ToString(dr2(4).ToString())
                    If strvalue = "||||" Then
                        strvalue = "empty"
                    End If
                Else
                    strvalue = "empty"
                End If
                Response.Flush()
                Response.Write(strvalue)
                'Response.Write(strvalue1)
                Response.End()
                dr2.Close()
                con.Close()
            End If

            'If Request("action") = "itemqtyglass" Then
            '    Dim itemid As String = Request.QueryString("itemid")
            '    'Dim lfno As String = Request.QueryString("lfno")
            '    'Dim partno As String = Request.QueryString("partno")
            '    Dim locid As String = Session("locid")


            '    ' sql1 = "select total_stock,item_detail.amount from stock_master inner join item_detail on  stock_master.item_code = item_detail.item_code where item_name= '" & itemid & "' and loc_id = '" & locid & "'"
            '    sql1 = "item_stock_bal '" & itemid & "','" & lfno & "','" & partno & "','" & locid & "'"
            '    Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
            '    con.Open()

            '    dr2 = cmd2.ExecuteReader
            '    If dr2.Read Then
            '        strvalue = Convert.ToString(dr2(0)) + "|" + Convert.ToString(dr2(1)) + "|" + Convert.ToString(dr2(2)) + "|" + Convert.ToString(dr2(3).ToString())
            '    End If
            '    Response.Flush()
            '    Response.Write(strvalue)
            '    'Response.Write(strvalue1)
            '    Response.End()
            '    dr2.Close()
            '    con.Close()
            'End If

            If Request("action") = "POMaster" Then
                Dim cmd As SqlClient.SqlCommand
                Dim txtpono As Integer = Request.QueryString("PONo")
                Dim vendorId As String = Request.QueryString("vendorId")
                Dim PONoId As String = Request.QueryString("PONoId")
                Dim PODate As String = Request.QueryString("PODate")
                Dim OurRefNo As String = Request.QueryString("OurRefNo")
                Dim dtOurRefNo As String = Request.QueryString("dtOurRefNo")
                Dim YourRefNo As String = Request.QueryString("YourRefNo")
                Dim dtYourRefNo As String = Request.QueryString("dtYourRefNo")
                Dim strIndentdetails As String = Request.QueryString("Indentdetails")
                Dim intOptype As Integer = Request.QueryString("Optype")

                Dim txtPayment As String = Request.QueryString("txtPayment")
                Dim txtDescount As String = Request.QueryString("txtDescount")
                Dim txtFright As String = Request.QueryString("txtFright")
                Dim txtBankCharges As String = Request.QueryString("txtBankCharges")
                Dim txtGoodsent As String = Request.QueryString("txtGoodsent")
                Dim txtDelivery As String = Request.QueryString("txtDelivery")
                Dim txtValidityPeriod As String = Request.QueryString("txtValidityPeriod")
                Dim txtYear As String = Request.QueryString("txtYear")
                Dim txtBCReg As String = Request.QueryString("txtBCReg")
                Dim txtSrNo As String = Request.QueryString("txtSrNo")
                Dim txtAudited As String = Request.QueryString("txtAudited")
                Dim txtAudit_officer As String = Request.QueryString("txtAudit_officer")
                Dim txtCl As String = Request.QueryString("txtCl")
                Dim Date1_TextBox As String = Request.QueryString("Date1_TextBox")
                Dim Date2_TextBox As String = Request.QueryString("Date2_TextBox")
                Dim txtResNo As String = Request.QueryString("txtResNo")
                Dim txtPurchase As String = Request.QueryString("txtPurchase")
                Dim txtBudgetAccount As String = Request.QueryString("txtBudgetAccount")
                Dim txtPreparedby As String = Request.QueryString("txtPreparedby")
                Dim txtCheckedBy As String = Request.QueryString("txtCheckedBy")
                Dim txtIndentRefNo As String = Request.QueryString("txtIndentRefNo")

                Dim txtspdiscount As String = Request.QueryString("txtspdiscount")
                Dim txtvat As Double = Request.QueryString("txtvat")
                Dim txted As Double = Request.QueryString("txted")
                Dim ddlCategory As String = Request.QueryString("ddlCategory")



                Dim dr As SqlClient.SqlDataReader
                If intOptype <> 0 Then
                    'Dim strSql As String
                    '          "alter_Indent_master " & intId & "," & strDefectId & ",'" & strIndentDate & "','" & strApprovedby & "','" & strRemark & "','" & strIndentdetails & "'," & intOptype
                    'strSql = "alter_Indent_master " & ID & ", " & vendorId & "','" & PONoId & ",'" & PODate & "','" & OurRefNo & "','" & dtOurRefNo & "','" & YourRefNo & "'," & dtYourRefNo
                    'intExst = ExecuteQuery(strSql)

                Else


                    cmd = New SqlCommand("Ins_PO_Master", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@vendor_id", vendorId)
                    cmd.Parameters.AddWithValue("@po_str", PONoId)
                    cmd.Parameters.AddWithValue("@po_no ", txtpono)
                    cmd.Parameters.AddWithValue("@po_date", PODate)
                    cmd.Parameters.AddWithValue("@po_our_ref_no", OurRefNo)
                    cmd.Parameters.AddWithValue("@po_our_ref_date ", dtOurRefNo)
                    cmd.Parameters.AddWithValue("@po_your_ref_no ", YourRefNo)
                    cmd.Parameters.AddWithValue("@po_your_ref_date", dtYourRefNo)

                    cmd.Parameters.AddWithValue("@payment_Mode", txtPayment)
                    cmd.Parameters.AddWithValue("@Discount_Material_Amout", txtDescount)
                    cmd.Parameters.AddWithValue("@Fright", txtFright)
                    cmd.Parameters.AddWithValue("@Bank_Charges_Borne_by", txtBankCharges)
                    cmd.Parameters.AddWithValue("@Delivery_completed_By", txtDelivery)
                    cmd.Parameters.AddWithValue("@Validity_Period", txtValidityPeriod)
                    cmd.Parameters.AddWithValue("@Good_Sent_By", txtGoodsent)
                    cmd.Parameters.AddWithValue("@Year", txtYear)

                    cmd.Parameters.AddWithValue("@B_C_Reg", txtBCReg)
                    cmd.Parameters.AddWithValue("@SrNo", txtSrNo)
                    cmd.Parameters.AddWithValue("@CL", txtCl)
                    cmd.Parameters.AddWithValue("@DT", Date1_TextBox)
                    cmd.Parameters.AddWithValue("@Audited_By", txtAudited)
                    cmd.Parameters.AddWithValue("@Audit_officer ", txtAudit_officer)
                    cmd.Parameters.AddWithValue("@Res_No", txtResNo)
                    cmd.Parameters.AddWithValue("@DT_Trans_Manager ", Date2_TextBox)

                    cmd.Parameters.AddWithValue("@Purchas_Authorised_By", txtPurchase)

                    cmd.Parameters.AddWithValue("@Budget_Account_HD", txtBudgetAccount)
                    cmd.Parameters.AddWithValue("@Prepared_By", txtPreparedby)
                    cmd.Parameters.AddWithValue("@Checked_By", txtCheckedBy)
                    cmd.Parameters.AddWithValue("@Indent_Ref_No", txtIndentRefNo)

                    cmd.Parameters.AddWithValue("@special_discount", txtspdiscount)
                    cmd.Parameters.AddWithValue("@vat", txtvat)
                    cmd.Parameters.AddWithValue("@ed", txted)
                    cmd.Parameters.AddWithValue("@item_id", ddlCategory)

                    Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                    strmaxid.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(strmaxid)

                    con.Open()
                    cmd.ExecuteNonQuery()
                    Dim maxid As String = cmd.Parameters("@maxid").Value.ToString
                    con.Close()

                    'strmaxid = cmd.Parameters.Add("@maxid", SqlDbType.BigInt).Direction = ParameterDirection.Output
                    'Dim strmaxid As Integer = cmd.Parameters.Add("Return_Value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue

                    If strIndentdetails.ToString <> "" Then
                        'Dim i As Integer

                        Dim myarray As Array = Split(strIndentdetails.ToString, "|")
                        Dim j As Integer
                        j = myarray.Length - 1
                        Dim strSql As String

                        For i = 0 To myarray.Length - 1
                            If myarray(i) <> "" Then
                                Dim mainarray As Array = Split(myarray(i), "^")

                                'strSql = "get_itemcode '" & mainarray(0) & "',  '" & mainarray(2) & "','" & mainarray(3) & "','" & mainarray(4) & "'"
                                'Dim stritemcode As String
                                'stritemcode = ExecuteQuery(strSql)
                                Dim strq As String = "get_itemcode '" & Trim(mainarray(2)) & "','" & mainarray(0) & "' , '" & Trim(mainarray(1)) & "'"
                                Dim Itemcode As String = ExecuteQuery(strq)

                                'Dim strq As String = "select item_code from Item_detail where rack_no = '" & mainarray(0) & "'  and part_no= '" & Trim(mainarray(1)) & "' or part_no2= '" & Trim(mainarray(1)) & "' or part_no3= '" & Trim(mainarray(1)) & "' or part_no4= '" & Trim(mainarray(1)) & "' and item_name='" & Trim(mainarray(2)) & "'"
                                'Dim Itemcode As Integer = ExecuteQuery(strq)

                                'strSql = "UPDATE Indent_Request_Details SET Indent_item_code = stritemcode,Indent_bus_no = mainarray(4),Indent_Req_qty = mainarray(6) WHERE Indent_Details_Id = " & mainarray(0)
                                'fnExecuteNonQuery(strSql)
                                cmd = New SqlCommand("Ins_PO_Details", con)
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@po_id", maxid)
                                cmd.Parameters.AddWithValue("@item_id", Itemcode)
                                cmd.Parameters.AddWithValue("@item_qty", mainarray(3))
                                cmd.Parameters.AddWithValue("@item_rate", mainarray(4))
                                cmd.Parameters.AddWithValue("@item_amt", mainarray(5))

                                con.Open()
                                cmd.ExecuteNonQuery()

                                con.Close()
                            End If

                        Next
                    End If
                End If
                Response.Write("Add")
                Response.End()

            End If

            If Request("action") = "getAuthenticDetails" Then
                Dim storeid As Integer = Request.QueryString("storeid")
                Dim parttype As String = Request.QueryString("parttype")
                Response.Write(getAuthenticDetails(storeid, parttype))
            End If

            If Request("action") = "Authenticationforstn" Then
                Dim Part_Type As String = ""

                'If Session("Dept_code") = 1 Then
                '    Part_Type = "sp"
                'ElseIf Session("Dept_code") = 2 Then
                '    Part_Type = "hw"
                'End If

                Dim strid As String = Request.QueryString("storeid")
                Dim strMID As String = Request.QueryString("MID")
                Dim cnt As String = Request.QueryString("cnt")
                Dim drbdate As String = Request.QueryString("drbdate")
                Dim rdbsp As String = Request.QueryString("rdbsp")
                Dim drbno As String = Request.QueryString("drbno")
                Dim arrstrid() As String
                Dim arrrdbsp() As String
                Dim arrdrbno() As String
                Dim arrMID() As String
                Dim strstn As String
                strstn = "STN"
                arrstrid = strid.Split("-")
                arrrdbsp = rdbsp.Split("-")
                arrdrbno = drbno.Split("|")
                arrMID = strMID.Split("-")
                Dim cmd As SqlClient.SqlCommand
                Dim fin_year As String = GetFinYear(1)

                If Session("Dept_code") = 2 Then

                    For i = 0 To cnt - 1
                        cmd = New SqlCommand("Upd_Authentication_for_STN", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@store_id", arrstrid(i))
                        'If arrdrbno.Length > 1 Then
                        cmd.Parameters.AddWithValue("@sub_part_type", strstn)
                        cmd.Parameters.AddWithValue("@sub_invert_no", arrdrbno(i))
                        'Else
                        '    Response.Write("<script>alert('Please Enter DRB No properly (.. - ..)')<script>")
                        '    Exit Sub
                        'End If
                        cmd.Parameters.AddWithValue("@MID", arrMID(i))
                        cmd.Parameters.AddWithValue("@drbdate", drbdate.ToString)
                        cmd.Parameters.AddWithValue("@fydrb", fin_year)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("Authenticated")
                        con.Close()
                    Next

                    'Else
                    '    For i = 0 To cnt - 1
                    '        cmd = New SqlCommand("Upd_Authentication", con)
                    '        cmd.CommandType = CommandType.StoredProcedure

                    '        cmd.Parameters.AddWithValue("@store_id", arrstrid(i))
                    '        If arrdrbno.Length > 1 Then
                    '            cmd.Parameters.AddWithValue("@sub_part_type", arrrdbsp(i))
                    '            cmd.Parameters.AddWithValue("@sub_invert_no", arrdrbno(i))
                    '        Else
                    '            Response.Write("<script>alert('Please Enter DRB No properly (.. - ..)')<script>")
                    '            Exit Sub
                    '        End If
                    '        cmd.Parameters.AddWithValue("@MID", arrMID(i))
                    '        cmd.Parameters.AddWithValue("@drbdate", drbdate.ToString)
                    '        cmd.Parameters.AddWithValue("@fydrb", fin_year)
                    '        con.Open()
                    '        cmd.ExecuteNonQuery()
                    '        Response.Write("Authenticated")
                    '        con.Close()
                    '    Next
                End If
                'Response.Write("<script>if(confirm('Are You Want to Print')){window.location.href='../report/rptDRBreport.aspx?SrNo=" & strMID & "';} else {alert('Saved Successfuly');window.location.href='Authenticate_receive.aspx';}</script>")
                'Dim drnew As SqlDataReader
                'Dim sql As String = "select * from item_detail where item_name= '" & itemid & "' and loc_id = '" & locid & "'"

            End If

            'Nilesh Code Changes Start'

            If Request("action") = "Authenticationforkit" Then
                Dim Part_Type As String = ""

                Dim strid As String = Request.QueryString("storeid")
                Dim strMID As String = Request.QueryString("MID")
                Dim cnt As String = Request.QueryString("cnt")
                Dim drbdate As String = Request.QueryString("drbdate")
                Dim rdbsp As String = Request.QueryString("rdbsp")
                Dim drbno As String = Request.QueryString("drbno")
                Dim arrstrid() As String
                Dim arrrdbsp() As String
                Dim arrdrbno() As String
                Dim arrMID() As String
                Dim strkit As String
                strkit = "KIT"
                arrstrid = strid.Split("-")
                arrrdbsp = rdbsp.Split("-")
                arrdrbno = drbno.Split("|")
                arrMID = strMID.Split("-")
                Dim cmd As SqlClient.SqlCommand
                Dim fin_year As String = GetFinYear(1)

                If Session("Dept_code") = 2 Then

                    For i = 0 To cnt - 1
                        cmd = New SqlCommand("Upd_Authentication_for_KIT", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@store_id", arrstrid(i))

                        cmd.Parameters.AddWithValue("@sub_part_type", strkit)
                        cmd.Parameters.AddWithValue("@sub_invert_no", arrdrbno(i))

                        cmd.Parameters.AddWithValue("@MID", arrMID(i))
                        cmd.Parameters.AddWithValue("@drbdate", drbdate.ToString)
                        cmd.Parameters.AddWithValue("@fydrb", fin_year)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        Response.Write("Authenticated")
                        con.Close()
                    Next


                End If
            End If

            If Request("action") = "getindentno" Then
                Dim indentdate As String = Request.QueryString("date")
                Dim locid As String = Request.QueryString("locid")
                'Dim locid As String = Session("locid")
                strvalue = ExecuteQuery("getindentno '" & indentdate & "'," & locid)
                Response.Write("indent" + strvalue)
                Response.End()
            End If
        End Sub
        Public Function getAuthenticDetails(ByVal storeid As Integer, ByVal parttype As String) As String
            Dim strTemp As New StringBuilder
            Dim strID As String = ""
            Dim strMono As String = ""
            Dim dt As New DataTable
            Dim i As Integer = 0
            Dim strMID As String = ""
            Dim fydrbyear As String = ""

            dt = GetDatatTable("view_receive_detail_storeid " & storeid & " ,'" & parttype & "'")

            strTemp.Append("<table border='1' cellspacing='0' width='100%' cellpadding='0' width='100%'>")
            strTemp.Append("<tr class='gridhead'>")
            strTemp.Append("<td>Part Name</td>")
            strTemp.Append("<td>Part No</td>")
            strTemp.Append("<td>DRB NO</td>")
            strTemp.Append("<td>LF NO/Bin No</td>")
            strTemp.Append("<td>Available Qty</td>")
            strTemp.Append("<td>Rec Qty</td>")
            strTemp.Append("<td>New Balance</td>")
            If dt.Rows.Count <> 0 Then
                If Session("Dept_code") = 1 And dt.Rows(0).Item("part_type").ToString.ToLower = "sp" Then
                    strTemp.Append("<td>SP</td>")
                    strTemp.Append("<td>OM</td>")
                End If
            End If

            For i = 0 To dt.Rows.Count - 1
                strTemp.Append("<tr class='gridtxt'>")
                strTemp.Append("<td id='tdItemName_" & i & "'>" & dt.Rows(i).Item("Item_Name") & "</td>")
                strTemp.Append("<td id='tdpartNo_" & i & "'>" & dt.Rows(i).Item("part_no") & "</td>")
                'strTemp.Append("<td id='tddrbNo_" & i & "'>" & dt.Rows(i).Item("part_type") & " - " & dt.Rows(i).Item("invert_no") & "</td>")
                strTemp.Append("<td id='tddrbNo_" & i & "'><input type='text' ID='txtdrbNo_" & i & "' value='" & dt.Rows(i).Item("invert_no") & "' /></td>")
                strTemp.Append("<td id='tdrack_" & i & "'>" & dt.Rows(i).Item("rack_no") & "</td>")
                strTemp.Append("<td id='tdavb_qty_" & i & "'>" & dt.Rows(i).Item("avb_qty") & "</td>")
                strTemp.Append("<td id='tdQty_" & i & "'>" & dt.Rows(i).Item("total_qty") & "</td>")
                strTemp.Append("<td id='tdbalafter_" & i & "'>" & dt.Rows(i).Item("bal_after") & "</td>")
                If Session("Dept_code") = 1 And dt.Rows(0).Item("part_type").ToString.ToLower = "sp" Then
                    'strTemp.Append("<td id='tdsp_" & i & "'><input id='radsp_" & i & "' type='radio' Onclick='chkradio(" & i & ",this)' /></td>")
                    'strTemp.Append("<td id='tdom_" & i & "'><input id='radom_" & i & "' type='radio' Onclick='chkradio(" & i & ",this)' /></td>")
                    strTemp.Append("<td id='tdsp_" & i & "'><input id='radsp_" & i & "' type='radio' onclick='spchanged(" & i & ");' name=" & i & " value='sp' checked = 'checked' /></td>")
                    strTemp.Append("<td id='tdom_" & i & "'><input id='radom_" & i & "' type='radio' onclick='omchanged(" & i & ");' name=" & i & " value='om' /></td>")
                End If
                strID += dt.Rows(i).Item("store_detail_id") & "-"
                strMono = dt.Rows(i).Item("sub_invert_no")
                strMID += dt.Rows(i).Item("Store_Id") & "-"
                strTemp.Append("</tr>")
            Next
            If strTemp.Length = 0 Then strTemp.Append("FailScrapMaster") Else strTemp.Append("</table><input type='hidden' id='hdnID' value='" & strID & "' /><input type='hidden' id='hdnMID' value='" & strMID & "' />^" & dt.Rows.Count & "^" & strMono)
            Return strTemp.ToString

        End Function

        Public Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = DateTime.Now.Date
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function


    End Class
End Namespace
