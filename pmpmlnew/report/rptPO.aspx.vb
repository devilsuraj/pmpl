
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rptcontractorwise
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim dt As DataTable
        Dim da As SqlDataAdapter
        Dim sql19 As String
        Dim potype1 As String
        Dim fyear As String
        Dim lyear As String
        Dim pager1 As Integer
        Dim srno1 As Integer = 2
        Public strvendor As String = ""
        Dim srno As Integer = 0


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim i As Integer = 1
                For i = 1 To 6
                    Dim fin_year As String = GetFinYear(i)
                    ddlfinancecalendar.Items.Add(New ListItem(fin_year, i))
                Next
                If Request.QueryString("potype") Is Nothing Then
                    bdppodate.SelectedDate = Now.Date
                    Table1.Visible = False
                Else
                    'Dim potype As String = Request.QueryString("potype")
                    'Dim pono As Integer = Request.QueryString("PoNo")
                    'Dim poyear As String = Request.QueryString("poyear")
                    'Dim category As Integer = Request.QueryString("category")
                    'Dim vendor As String = Request.QueryString("vendor")                   
                    Dim potype As String = Request.QueryString("potype")
                    Dim pono As Integer = Request.QueryString("PoNo")
                    Dim poyear As String = Request.QueryString("poyear")
                    Dim category As Integer = Request.QueryString("category")
                    Dim vendor As String = Request.QueryString("vendor")
                    strvendor = getAutoCompleteList("select vendor_name from stock_vendor order by vendor_name", "vendor_name")

                    Dim srno2 As Integer = Request.QueryString("srno")
                    srno = srno2
                    Dim srno3 As Integer = Request.QueryString("srno1")
                    srno1 = srno3
                    drpType.SelectedValue = category
                    drbPoType.SelectedValue = potype
                    txtPONo.Text = pono
                    ddlfinancecalendar.SelectedItem.Text = poyear
                    txtvendor.Text = vendor.ToString()
                    'bdppodate.SelectedDate = PODATE
                    showdata(category, potype, pono, poyear, vendor)
                End If
            End If
            strvendor = getAutoCompleteList("select vendor_name from stock_vendor order by vendor_name", "vendor_name")

        End Sub
        Protected Sub btn_showpo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_showpo.Click

            If ddlprinttype.SelectedItem.Text = "front" Then
                'Dim strcalendar As String = ddlfinancecalendar.SelectedItem.Text
                tblback.Visible = False
                Table1.Visible = True
                If txtvendor.Text = "" Or txtPONo.Text = "" Then
                    Response.Write("<script>alert ('Please Enter Vendor and Po No') </script>")

                Else
                    showdata(drpType.SelectedValue, drbPoType.SelectedValue, txtPONo.Text, ddlfinancecalendar.SelectedItem.Text, txtvendor.Text)
                    'strvendor = getAutoCompleteList("select vendor_name from stock_vendor order by vendor_name", "vendor_name")
                End If
            Else

                showback()
                tblback.Visible = True
                Table1.Visible = False

            End If

        End Sub
        Public Function TrimRight4Characters(ByVal str As String) As String
            If 9 >= str.Length Then
                Return str.Substring(0, str.Length - 5)
            Else
                Return str
            End If
        End Function

        Private Sub showdata(ByVal category As Integer, ByVal potype As String, ByVal pono As Integer, ByVal poyear As String, ByVal vendor As String)

            If srno <= 0 Then
                Try
                    Dim style2 As String
                    Dim html1 As String
                    Dim fyear As String


                    lblprinttype.Visible = True
                    lblPoDate.Visible = True
                    lblPONoStr.Visible = True
                    lblPONo.Visible = True
                    lblVendorName.Visible = True
                    lblAdd1.Visible = True
                    lblORN.Visible = True
                    lblORD.Visible = True
                    lblAdd2.Visible = True
                    lblYRN.Visible = True
                    lblYRD.Visible = True
                    lblContctno.Visible = True
                    lblref_asrtu.Visible = True
                    lblmail.Visible = True
                    lblpmpadd.Visible = True
                    lblpmpadd2.Visible = True
                    lblphnos.Visible = True
                    lblmail.Text = " Email :pmpmlstore@yahoo.com"

                    lblpmpadd.Text = " Main Bldg.Near IncomeTax Office"

                    lblpmpadd2.Text = " Shankarseth Road"

                    lblphnos.Text = " Ph :24503307/220"
                    lblfax.Visible = True
                    lblfax.Text = "Fax: 24441268"
                    lblponos.Visible = True
                    lblponos.Text = "P.O. NO. :  "
                    lblpodates.Visible = True
                    lblpodates.Text = "Date : "
                    lblcontactnos.Visible = True
                    lblcontactnos.Text = "Contact No : "
                    lblourrefnos.Visible = True
                    lblourrefnos.Text = "Our Ref. No. "
                    lblyourrefnos.Visible = True
                    lblyourrefnos.Text = "Your Ref. No. "
                    lblrefdates.Visible = True
                    lblrefdates.Text = " Date"
                    lblrefrs.Visible = True
                    lblrefrs.Text = "Ref : "
                    lbltandc.Visible = True
                    lbltandc.Text = " Please Supply the articles as per details given below on conditions state hereunder and overleaf as will as in accordance with the Terms and conditions in the acceptance of your tender"
                    lblcodenos.Visible = True
                    lblcodenos.Text = "Code No."
                    lblpmpmls.Visible = True
                    lblpmpmls.Text = " Pune Mahanagar Parivahan Mahamandal Limited"
                    lblswargets.Visible = True
                    lblswargets.Text = "Swargate, Pune 411037"
                    lblms.Visible = True
                    lblms.Text = " M/s."
                    lbltoms.Visible = True
                    lbltoms.Text = " TO,"
                    lblorndates.Visible = True
                    lblorndates.Text = "Date"


                    fyear = ddlfinancecalendar.SelectedItem.Text
                    fyear = TrimRight4Characters(fyear)
                    Dim lyear As String
                    lyear = fyear + 1
                    html1 += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
                    style2 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"
                    cmd = New SqlCommand("view_po_details_po '1','" & category & "','" & potype & "','" & pono & "','" & poyear & "','" & vendor & "'", con)

                    'cmd.CommandType = CommandType.StoredProcedure
                    'cmd.Parameters.AddWithValue("@type", "'1'")
                    'cmd.Parameters.AddWithValue("@poid", "'113'")
                    'cmd.Parameters.AddWithValue("@vendorid", CONT)
                    da = New SqlDataAdapter(cmd)
                    dt = New DataTable
                    da.Fill(dt)

                    If dt.Rows.Count <> 0 Then
                        Table1.Visible = True

                        lblVendorName.Text = (StrConv(dt.Rows(0)("vendor_name").ToString(), VbStrConv.ProperCase))
                        lblContctno.Text = dt.Rows(0)("contact_name").ToString() + " - " + dt.Rows(0)("contact_no").ToString()

                        lblAdd1.Text = dt.Rows(0)("add1").ToString()
                        lblAdd2.Text = dt.Rows(0)("add2").ToString()
                        If dt.Rows(0)("po_str").ToString() = "T" Then
                            potype1 = "TC"
                        Else
                            potype1 = dt.Rows(0)("po_str").ToString()
                        End If
                        lblPONoStr.Text = potype1 'dt.Rows(0)("po_str").ToString()
                        lblPONo.Text = dt.Rows(0)("po_no").ToString()
                        lblPoDate.Text = dt.Rows(0)("po_date").ToString()
                        lblORN.Text = dt.Rows(0)("po_our_ref_no").ToString()
                        lblYRN.Text = dt.Rows(0)("po_your_ref_no").ToString()
                        lblYRD.Text = dt.Rows(0)("po_your_ref_date").ToString()
                        lblORD.Text = dt.Rows(0)("po_our_ref_date").ToString()
                        lblref_asrtu.Text = dt.Rows(0)("ref_asrtu").ToString()
                        'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()
                        'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                        Dim ds_tics As New DataSet
                        lblprinttype.Text = ddlprint.SelectedItem.Text
                        'Dim CONT As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                        'lblcontractor.Text = "Depo Name : " + DropDownList1.SelectedItem.Text
                        'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy")
                        'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yyyy")
                        'If Page.IsPostBack Then
                        'BindGrid(grdstock, con, "View_PO_Details '" & fromdate & "' ,'" & todate & "','" & CONT & "'")
                        'BindGrid(grdstock, con, "view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "' ")

                        Try

                            If con.State = ConnectionState.Closed Then
                                con.Open()
                            End If
                            Dim da As New SqlClient.SqlDataAdapter("view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)

                            da.SelectCommand.CommandTimeout = 0
                            da.Fill(ds_tics)
                            Dim html As String = ""
                            If (ds_tics.Tables(0).Rows.Count > 0) Then
                                html += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
                                Dim i, ctr As Integer
                                Dim tic_den_des_printed As String = ""

                                For i = 0 To ds_tics.Tables(0).Rows.Count - 1
                                    Dim cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, style, style1 As String

                                    cell1 = ds_tics.Tables(0).Rows(i)("lfno").ToString()
                                    cell2 = ds_tics.Tables(0).Rows(i)("bin_no").ToString()
                                    cell3 = ds_tics.Tables(0).Rows(i)("part_no").ToString()
                                    cell4 = ds_tics.Tables(0).Rows(i)("item_name").ToString()
                                    cell5 = ds_tics.Tables(0).Rows(i)("item_qty").ToString()
                                    cell6 = ds_tics.Tables(0).Rows(i)("item_rate").ToString()
                                    cell7 = ds_tics.Tables(0).Rows(i)("item_amt").ToString()
                                    cell8 = ds_tics.Tables(0).Rows(i)("Unit").ToString()


                                    style = "style='font-family: Times New Roman; font-size: 15px;'"
                                    style1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

                                    If ctr = 0 Then
                                        html += "<tr>"
                                        html += "<td align='right' " + style1 + ">" + "Sr No" + "</td>"
                                        If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
                                            html += "<td align='right' " + style1 + ">" + "Lf No" + "</td>"
                                            html += "<td align='center'" + style1 + ">" + "Bin No" + "</td>"
                                        End If
                                        html += "<td align='left' " + style1 + "colspan='2'>" + "Maker's identification No Or Code No" + "</td>"
                                        html += "<td align='left' " + style1 + "colspan='5'>" + "Nomenclature" + "</td>"
                                        html += "<td align='right' " + style1 + ">" + "Quantity" + "</td>"
                                        html += "<td align='right' " + style1 + ">" + "Unit" + "</td>"
                                        html += "<td align='right' " + style1 + ">" + "Rate" + "</td>"
                                        html += "<td align='right' " + style1 + "colspan='3'>" + "Amount Rs" + "</td>"

                                        html += "</tr>"
                                    End If
                                    html += "<tr>"
                                    html += "<td align='right' " + style + ">" & (i + 1) & "</td>"
                                    If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
                                        html += "<td align='right' " + style + ">" + cell1 + "</td>"
                                        html += "<td align='Center'" + style + ">" + cell2 + "</td>"
                                    End If

                                    html += "<td align='left' " + style + " colspan='2'>" + cell3 + "</td>"
                                    html += "<td align='left' " + style + "colspan='5'>" + cell4 + "</td>"
                                    html += "<td align='right' " + style + ">" + cell5 + "</td>"
                                    html += "<td align='right' " + style + ">" + cell8 + "</td>"
                                    html += "<td align='right' " + style + ">" + cell6 + "</td>"
                                    html += "<td align='right' " + style + "colspan='3'>" + cell7 + "</td>"

                                    html += "</tr>"

                                    ctr = ctr + 1
                                    If i = 14 Or ((i = ds_tics.Tables(0).Rows.Count - 1) And i < 14) Then

                                        Dim span As String = "<span style='font-family: Times New Roman; font-size: 12px;'>"
                                        Dim span3 As String = "<span style='font-family: Times New Roman; font-size: 18px;'>"
                                        Dim span2 As String = "<span style='font-family: Times New Roman; font-size: 15px;text-decoration:underline'>"

                                        html += "<tr>"
                                        html += "<td align='left' colspan='16' style='font-weight: bold'>"
                                        html += span + dt.Rows(0)("special_discount").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        'New                                   

                                        Dim ds_poschedule As New DataSet
                                        'lblprinttype.Text = ddlprint.SelectedItem.Text
                                        'Try
                                        If con.State = ConnectionState.Closed Then
                                            con.Open()   'view_po_schedule_new
                                        End If
                                        Dim da1 As New SqlClient.SqlDataAdapter("view_po_schedule_new '1'," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
                                        'Dim da As New SqlClient.SqlDataAdapter("view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
                                        da1.SelectCommand.CommandTimeout = 0
                                        da1.Fill(ds_poschedule)
                                        Dim count1 As Integer
                                        count1 = ds_poschedule.Tables(0).Rows.Count ' ds_poschedule.Tables(0).Rows.Count
                                        If (ds_poschedule.Tables(0).Rows.Count > 0) Then
                                            html += "<tr>"
                                            html += "<td align='left' colspan='14' style='font-weight: bold'>"
                                            html += "Delivery Schedule"
                                            html += "</td>"
                                            html += "</tr>"

                                            Dim s, ctr1 As Integer
                                            Dim tic_den_des_printed1 As String = ""

                                            Dim styles, styles1 As String

                                            styles = "style='font-family: Times New Roman; font-size: 15px;'"
                                            styles1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

                                            If ctr1 = 0 Then
                                                html += "<tr>"
                                                html += "<td align='right' " + styles1 + ">" + "Sr No" + "</td>"

                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "Item No" + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "APRIL " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "MAY " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "JUN " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "JULY " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "AUG " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "SEPT " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "OCT " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "NOV " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "DEC " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "JAN " + lyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "FEB " + lyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "MAR " + lyear + "</td>"


                                                html += "</tr>"
                                            End If

                                            Dim count2 As Integer = ds_poschedule.Tables(0).Rows.Count
                                            'Dim calc As Integer 
                                            If (ds_poschedule.Tables(0).Rows.Count / 3) >= 0 Then

                                                'For s = srno To count2 - 1 ' ds_poschedule.Tables(0).Rows.Count / 3 - 1

                                                For s = srno To ds_poschedule.Tables(0).Rows.Count - (ds_poschedule.Tables(0).Rows.Count - srno1) 'srno1)

                                                    Dim cellc1, cellc2, cellc3, cellc4, cellc5, cellc6, cellc7, cellc8, cellc9, cellc10, cellc11, cellc12, cellc13 As String
                                                    Try


                                                        cellc1 = ds_poschedule.Tables(0).Rows(s)("srno1").ToString()

                                                        cellc2 = ds_poschedule.Tables(0).Rows(s)("mon1").ToString()
                                                        cellc3 = ds_poschedule.Tables(0).Rows(s)("mon2").ToString()

                                                        cellc4 = ds_poschedule.Tables(0).Rows(s)("mon3").ToString()
                                                        cellc5 = ds_poschedule.Tables(0).Rows(s)("mon4").ToString()

                                                        cellc6 = ds_poschedule.Tables(0).Rows(s)("mon5").ToString()
                                                        cellc7 = ds_poschedule.Tables(0).Rows(s)("mon6").ToString()

                                                        cellc8 = ds_poschedule.Tables(0).Rows(s)("mon7").ToString()
                                                        cellc9 = ds_poschedule.Tables(0).Rows(s)("mon8").ToString()

                                                        cellc10 = ds_poschedule.Tables(0).Rows(s)("mon9").ToString()
                                                        cellc11 = ds_poschedule.Tables(0).Rows(s)("mon10").ToString()

                                                        cellc12 = ds_poschedule.Tables(0).Rows(s)("mon11").ToString()
                                                        cellc13 = ds_poschedule.Tables(0).Rows(s)("mon12").ToString()

                                                        styles = "style='font-family: Times New Roman; font-size: 15px;'"
                                                        styles1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"


                                                        html += "<tr>"
                                                        html += "<td align='Center' " + styles + ">" & (s + 1) & "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc1 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc2 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc3 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc4 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc5 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc6 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc7 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc8 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc9 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc10 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc11 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc12 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc13 + "</td>"

                                                        html += "</tr>"
                                                    Catch ex As Exception

                                                    End Try
                                                Next
                                            End If


                                            'End
                                            srno1 = srno1 + 3
                                            srno = srno + 3
                                            html += "<tr>"
                                            html += "<td align='right' colspan='7' style='font-weight: bold'>"
                                            html += "<h> Count : " & count1 & "</h>"
                                            html += "</td>"
                                            html += "<td align='right' colspan='7' style='font-weight: bold'>"


                                            html += "<a href='rptPO.aspx?poyear=" & ddlfinancecalendar.SelectedItem.Text & "&potype=" & drbPoType.SelectedItem.Text & "&PoNo=" & txtPONo.Text & "&vendor=" & txtvendor.Text & "&category=" & drpType.SelectedValue & "&srno=" & srno & " &srno1=" & srno1 & "  '> Continued Next Page </a>" 'sr=" & srno & "
                                            html += "</td>"
                                            html += "</tr>"

                                        End If
                                        html += "<tr>"
                                        html += "<td align='left' colspan='16' style='font-weight: bold'>"
                                        html += "INSTRUCTION"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td colspan='16'>"
                                        html += "<table align='center' cellspacing='0' style='width: 650px'>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        html += span + "<b>(1) Bill and Challans should be sent in triplicate,</span>"
                                        html += "</td>"
                                        'New
                                        html1 += "<tr>"
                                        html1 += "<td align='center' colspan='7' " + style2 + ">" + "Delivery Shedule" + "</td>"
                                        html1 += "</tr>"

                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "    Month     " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "    Shedule    " + "</td>"
                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "        " + "</td>"
                                        html1 += "</tr>"
                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "        " + "</td>"
                                        html1 += "</tr>"
                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "       " + "</td>"
                                        html1 += "</tr>"
                                        html1 += "</table>"
                                        'End
                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        html += span + "<b> 2) Payment will be made</span>"
                                        html += span2 + dt.Rows(0)("payment_Mode").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        html += span + "<b> 3) Vat Tax Extra </span>"
                                        html += span + " <u> as applicable </u></span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        html += span + "<b> 4) Exise Duty </span>"
                                        html += span + "<u> as applicable </u></span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        html += "<td align='left' colspan='3'>"
                                        html += span + "<b>5) Discount </span> "
                                        html += span2 + dt.Rows(0)("Discount_Material_Amout").ToString() + "</span>"
                                        html += " <span style='font-size: 12px'>  %  on Value of material on total amount</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        html += span + "<b>6) Fright will be borne by   <u><b></b></u></span>"
                                        html += span2 + dt.Rows(0)("Fright").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "    <td align='left' colspan='2'>"
                                        html += span + "<b>7) Bank charges/commission will be borne by </span>"

                                        lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                                        html += span2 + dt.Rows(0)("Bank_Charges_Borne_by").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        html += span + "<b>8) Goods to be sent by GPT/TCI/ARC&nbsp; </span>"
                                        html += span + "<u><b>With, for minimum 60 days demarage free period <b></u></span>"
                                        ' html += span2 + dt.Rows(0)("Good_Sent_By").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        html += span + "<b>9) Delivery should be completed by </span>"
                                        html += span2 + dt.Rows(0)("Delivery_completed_By").ToString() + "</span>"
                                        html += "</td>"

                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        ' html += span + "8) Validity Period </span>"
                                        '   html += span2 + dt.Rows(0)("Validity_Period").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        html += span + "<b>10) Note :</b><br><b>* Material should be in antirusted and with proper packing<br> &nbsp;&nbsp;&nbsp; to avoid external and Internal damage.</br> * For Nut,Bolts,Washer packing should be of 1 KG. </b></span>"
                                        html += "</td>"


                                        html += "</table> <br />"

                                        html += " <table align='center' cellspacing='0' style='width: 650px;'>"
                                        html += "     <tr >"
                                        html += "<td rowspan='2' align='left' style='width: 50%' valign='top'>"
                                        html += span + "<b>Total Commitment Rs. </span>"
                                        html += span2 + dt.Rows(0)("total").ToString() + "</span>"
                                        html += span + "Yr.</span>"
                                        html += span2 + dt.Rows(0)("Year1").ToString() + "</span>"
                                        html += "</td>"
                                        html += "<td align='center'    colspan='0'>"
                                        html += "<span style='font-family: Times New Roman; font-size: 18px;'><br><br><br><b>Stores Officer</b></span>"
                                        html += "<center><b>PMPML</b>"
                                        html += "</td>"
                                        'html += "<td align='left' style='width: 50%'>"
                                        ' html += span + "Rate sanctioned by TC/TransportManager </span>"
                                        'html += "</td>"
                                        html += "</tr>"
                                        ' html += "<tr>"
                                        '  html += "<td align='center' colspan='0'  style='width: 50%'>"
                                        ' html += span + "<br><b><h3>PMPML</h3</b></span>"
                                        '   html += "</td>"
                                        ' html += "    <td align='left' style='width: 50%'>"
                                        '  html += "Res.No.  </span> "
                                        ' html += span2 + dt.Rows(0)("res_no").ToString() + "</span>"
                                        ' html += "&nbsp;&nbsp;" + span + "Dt &nbsp; :&nbsp;</span>"
                                        ' html += span2 + dt.Rows(0)("DT_Trans_Manager").ToString() + "</span>"
                                        'html += "</td>"

                                        ' html += "</tr>"
                                        '  html += "<tr>"
                                        '  html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                        '    html += span + "Entd in B/C Regr </span>"
                                        '   html += span2 + dt.Rows(0)("B_C_Reg").ToString() + "</span>"
                                        ' html += span + "Sr.No.</span>"
                                        '   html += span2 + dt.Rows(0)("SrNo").ToString() + "</span>"
                                        '  html += "</td>"
                                        '  html += "<td align='left' style='width: 50%'>"
                                        '    html += span + "Purchase Authorised by </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                        '    html += span2 + dt.Rows(0)("Purchas_Authorised_By").ToString()
                                        '   html += "</td>"
                                        '   html += "</tr>"
                                        '    html += "<tr>"
                                        '    html += "    <td align='left' style='width: 50%'>"
                                        '     html += span + "Budegt Account Hd  </span>"
                                        '   html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                        '   html += span2 + dt.Rows(0)("Budget_Account_HD").ToString() + "</span>"
                                        '  html += "</td>"
                                        '  html += "</tr>"
                                        '   html += "<tr>"
                                        '  html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                        '    html += span + "Audited by </span>"
                                        '     html += span2 + dt.Rows(0)("Audited_By").ToString() + "</span>"
                                        '      html += span + "CL: </span>"
                                        '     html += span2 + dt.Rows(0)("CL").ToString() + "</span>"
                                        '   html += span + "DT: </span>"
                                        '   html += span2 + dt.Rows(0)("DT").ToString() + "</span>"
                                        '  html += "</td>"
                                        '   html += "<td align='left' style='width: 50%'>"

                                        '  html += span + "Prepared by</span>"
                                        '  html += span2 + dt.Rows(0)("Prepared_By").ToString() + "</span>"
                                        ' html += span + "Checked by</span>"
                                        '   html += span2 + dt.Rows(0)("Checked_By").ToString() + "</span>"
                                        '  html += "</td>"
                                        ' html += "</tr>"
                                        '  ''  html += "<tr>"
                                        ' html += "<td align='left' style='width: 50%'>"
                                        '   html += span + "Indent Ref No . </span>"
                                        '   html += span2 + dt.Rows(0)("Indent_Ref_No").ToString() + "</span>"
                                        '  html += "</td>"
                                        '  html += "</tr>"
                                        html += "<tr>"
                                        html += "    <td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                        '  html += span + "Audited Officer </span>"
                                        '  html += span2 + dt.Rows(0)("Audit_officer").ToString() + "</span>"
                                        html += "</td>"

                                        html += "</tr>"
                                        html += "</table>"
                                        html += "</td>"
                                        html += "</tr>"
                                    End If
                                    If i = 14 Or i = 44 Or i = 74 Then
                                        ctr = 0
                                        html += "</table>"
                                        html += "<div style='page-break-before:always;font-size:1;margin:0;border:0;'></div>"
                                        html += "<div style='height:10px'> &nbsp;</div>"
                                        html += " <table cellspacing='0' style='width: 650px' cellpadding='3' rules='all' border='1' id='Table" + i.ToString() + "' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"

                                        html += " <tr>"
                                        html += "<td colspan='8' align='center'> "
                                        html += "<strong><span style='font-size: 15pt'>Pune Mahanagar Parivahan Mahamandal Limited </span>"
                                        html += "</strong>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += " <td align='left' colspan='4'>"
                                        html += "<strong><span style='font-size: 14pt'>Swargate, Pune 411037&nbsp; </span></strong>"
                                        html += " </td>"
                                        html += " <td align='right' colspan='4'>"
                                        html += "<strong><span style='font-size: 14pt'>" & dt.Rows(0)("po_str").ToString() & " &nbsp;  " & dt.Rows(0)("po_no").ToString() & "</span></strong>"
                                        html += " </td>"
                                        html += " </tr>"
                                    End If

                                Next
                                html += "</table>"
                                htmldetails.Text = html
                                ''clear()
                            End If

                        Catch ex As Exception

                        Finally
                            If con.State = ConnectionState.Open Then
                                con.Close()
                            End If
                        End Try


                    Else
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False

                    End If

                    'If ds_tics.Tables(0).Rows.Count = 0 Then
                    '    Response.Write("<script>alert ('Record Not Found') </script>")
                    '    Table1.Visible = False
                    'Else
                    '    Table1.Visible = True
                    'End If
                Catch ex As Exception
                Finally
                    strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                End Try
            Else
                Try
                    Dim style2 As String
                    Dim html1 As String
                    Dim fyear As String


                    fyear = ddlfinancecalendar.SelectedItem.Text
                    fyear = TrimRight4Characters(fyear)
                    Dim lyear As String
                    lyear = fyear + 1
                    html1 += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
                    style2 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"
                    cmd = New SqlCommand("view_po_details_po '1','" & category & "','" & potype & "','" & pono & "','" & poyear & "','" & vendor & "'", con)

                    'cmd.CommandType = CommandType.StoredProcedure
                    'cmd.Parameters.AddWithValue("@type", "'1'")
                    'cmd.Parameters.AddWithValue("@poid", "'113'")
                    'cmd.Parameters.AddWithValue("@vendorid", CONT)
                    da = New SqlDataAdapter(cmd)
                    dt = New DataTable
                    da.Fill(dt)

                    If dt.Rows.Count <> 0 Then
                        Table1.Visible = True

                        '     lblVendorName.Text = (StrConv(dt.Rows(0)("vendor_name").ToString(), VbStrConv.ProperCase))
                        '     lblContctno.Text = dt.Rows(0)("contact_no").ToString()

                        '  lblAdd1.Text = dt.Rows(0)("add1").ToString()
                        '     lblAdd2.Text = dt.Rows(0)("add2").ToString()
                        If dt.Rows(0)("po_str").ToString() = "T" Then
                            potype1 = "TC"
                        Else
                            potype1 = dt.Rows(0)("po_str").ToString()
                        End If
                        ' lblPONoStr.Text = potype1 'dt.Rows(0)("po_str").ToString()
                        '   lblPONo.Text = dt.Rows(0)("po_no").ToString()
                        '     lblPoDate.Text = dt.Rows(0)("po_date").ToString()
                        '      lblORN.Text = dt.Rows(0)("po_our_ref_no").ToString()
                        '      lblYRN.Text = dt.Rows(0)("po_your_ref_no").ToString()
                        '       lblYRD.Text = dt.Rows(0)("po_your_ref_date").ToString()
                        '       lblORD.Text = dt.Rows(0)("po_our_ref_date").ToString()
                        '       lblref_asrtu.Text = dt.Rows(0)("ref_asrtu").ToString()
                        'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()
                        'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                        Dim ds_tics As New DataSet
                        lblprinttype.Text = ddlprint.SelectedItem.Text
                        'Dim CONT As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                        'lblcontractor.Text = "Depo Name : " + DropDownList1.SelectedItem.Text
                        'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy")
                        'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yyyy")
                        'If Page.IsPostBack Then
                        'BindGrid(grdstock, con, "View_PO_Details '" & fromdate & "' ,'" & todate & "','" & CONT & "'")
                        'BindGrid(grdstock, con, "view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "' ")

                        Try

                            If con.State = ConnectionState.Closed Then
                                con.Open()
                            End If
                            Dim da As New SqlClient.SqlDataAdapter("view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)

                            da.SelectCommand.CommandTimeout = 0
                            da.Fill(ds_tics)
                            Dim html As String = ""
                            If (ds_tics.Tables(0).Rows.Count > 0) Then
                                html += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
                                Dim i, ctr As Integer
                                Dim tic_den_des_printed As String = ""

                                For i = 0 To ds_tics.Tables(0).Rows.Count - 1
                                    Dim cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, style, style1 As String

                                    '   cell1 = ds_tics.Tables(0).Rows(i)("lfno").ToString()
                                    '   cell2 = ds_tics.Tables(0).Rows(i)("bin_no").ToString()
                                    '   cell3 = ds_tics.Tables(0).Rows(i)("part_no").ToString()
                                    '   cell4 = ds_tics.Tables(0).Rows(i)("item_name").ToString()
                                    '   cell5 = ds_tics.Tables(0).Rows(i)("item_qty").ToString()
                                    '   cell6 = ds_tics.Tables(0).Rows(i)("item_rate").ToString()
                                    '   cell7 = ds_tics.Tables(0).Rows(i)("item_amt").ToString()
                                    '   cell8 = ds_tics.Tables(0).Rows(i)("Unit").ToString()


                                    style = "style='font-family: Times New Roman; font-size: 15px;'"
                                    style1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

                                    If ctr = 0 Then
                                        '      html += "<tr>"
                                        '      html += "<td align='right' " + style1 + ">" + "Sr No" + "</td>"
                                        If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
                                            '         html += "<td align='right' " + style1 + ">" + "Lf No" + "</td>"
                                            '        html += "<td align='center'" + style1 + ">" + "Bin No" + "</td>"
                                        End If
                                        '      html += "<td align='left' " + style1 + "colspan='1'>" + "Maker's identification No Or Code No" + "</td>"
                                        '     html += "<td align='left' " + style1 + "colspan='6'>" + "Nomenclature" + "</td>"
                                        '    html += "<td align='right' " + style1 + ">" + "Quantity" + "</td>"
                                        '   html += "<td align='right' " + style1 + ">" + "Unit" + "</td>"
                                        ''  html += "<td align='right' " + style1 + ">" + "Rate" + "</td>"
                                        ' html += "<td align='right' " + style1 + "colspan='3'>" + "Amount Rs" + "</td>"

                                        '     html += "</tr>"
                                    End If
                                    '     html += "<tr>"
                                    '  html += "<td align='right' " + style + ">" & (i + 1) & "</td>"
                                    If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
                                        '        html += "<td align='right' " + style + ">" + cell1 + "</td>"
                                        '       html += "<td align='Center'" + style + ">" + cell2 + "</td>"
                                    End If

                                    '          html += "<td align='left' " + style + " colspan='1'>" + cell3 + "</td>"
                                    '         html += "<td align='left' " + style + "colspan='6'>" + cell4 + "</td>"
                                    '        html += "<td align='right' " + style + ">" + cell5 + "</td>"
                                    '       html += "<td align='right' " + style + ">" + cell8 + "</td>"
                                    ''      html += "<td align='right' " + style + ">" + cell6 + "</td>"
                                    'html += "<td align='right' " + style + "colspan='3'>" + cell7 + "</td>"
                                    '
                                    html += "</tr>"

                                    ctr = ctr + 1
                                    If i = 14 Or ((i = ds_tics.Tables(0).Rows.Count - 1) And i < 14) Then

                                        Dim span As String = "<span style='font-family: Times New Roman; font-size: 12px;'>"
                                        Dim span3 As String = "<span style='font-family: Times New Roman; font-size: 18px;'>"
                                        Dim span2 As String = "<span style='font-family: Times New Roman; font-size: 15px;text-decoration:underline'>"

                                        '   html += "<tr>"
                                        '    html += "<td align='left' colspan='14' style='font-weight: bold'>"
                                        '    html += span + dt.Rows(0)("special_discount").ToString() + "</span>"
                                        '    html += "</td>"
                                        '    html += "</tr>"

                                        'New                                   

                                        Dim ds_poschedule As New DataSet
                                        'lblprinttype.Text = ddlprint.SelectedItem.Text
                                        'Try
                                        If con.State = ConnectionState.Closed Then
                                            con.Open()
                                        End If
                                        Dim da1 As New SqlClient.SqlDataAdapter("view_po_schedule_new '1'," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
                                        'Dim da As New SqlClient.SqlDataAdapter("view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
                                        da1.SelectCommand.CommandTimeout = 0
                                        da1.Fill(ds_poschedule)
                                        Dim count1 As Integer
                                        count1 = ds_poschedule.Tables(0).Rows.Count ' ds_poschedule.Tables(0).Rows.Count
                                        If (ds_poschedule.Tables(0).Rows.Count > 0) Then
                                            html += "<tr>"
                                            html += "<td align='left' colspan='14' style='font-weight: bold'>"
                                            html += "Delivery Schedule"
                                            html += "</td>"
                                            html += "</tr>"

                                            Dim s, ctr1 As Integer
                                            Dim tic_den_des_printed1 As String = ""

                                            Dim styles, styles1 As String

                                            styles = "style='font-family: Times New Roman; font-size: 15px;'"
                                            styles1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

                                            If ctr1 = 0 Then
                                                html += "<tr>"
                                                html += "<td align='right' " + styles1 + ">" + "Sr No" + "</td>"

                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "Item No" + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "APRIL " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "MAY " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "JUN " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "JULY " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "AUG " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "SEPT " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "OCT " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "NOV " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "DEC " + fyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "JAN " + lyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "FEB " + lyear + "</td>"
                                                html += "<td align='Center' " + styles1 + " colspan='1'>" + "MAR " + lyear + "</td>"


                                                html += "</tr>"
                                            End If

                                            Dim count2 As Integer = ds_poschedule.Tables(0).Rows.Count
                                            'Dim calc As Integer 
                                            If (ds_poschedule.Tables(0).Rows.Count / 3) >= 0 Then

                                                'For s = srno To count2 - 1 ' ds_poschedule.Tables(0).Rows.Count / 3 - 1

                                                For s = srno To ds_poschedule.Tables(0).Rows.Count - 1 '(ds_poschedule.Tables(0).Rows.Count - srno1) 'srno1)

                                                    Dim cellc1, cellc2, cellc3, cellc4, cellc5, cellc6, cellc7, cellc8, cellc9, cellc10, cellc11, cellc12, cellc13 As String
                                                    Try


                                                        cellc1 = ds_poschedule.Tables(0).Rows(s)("srno1").ToString()

                                                        cellc2 = ds_poschedule.Tables(0).Rows(s)("mon1").ToString()
                                                        cellc3 = ds_poschedule.Tables(0).Rows(s)("mon2").ToString()

                                                        cellc4 = ds_poschedule.Tables(0).Rows(s)("mon3").ToString()
                                                        cellc5 = ds_poschedule.Tables(0).Rows(s)("mon4").ToString()

                                                        cellc6 = ds_poschedule.Tables(0).Rows(s)("mon5").ToString()
                                                        cellc7 = ds_poschedule.Tables(0).Rows(s)("mon6").ToString()

                                                        cellc8 = ds_poschedule.Tables(0).Rows(s)("mon7").ToString()
                                                        cellc9 = ds_poschedule.Tables(0).Rows(s)("mon8").ToString()

                                                        cellc10 = ds_poschedule.Tables(0).Rows(s)("mon9").ToString()
                                                        cellc11 = ds_poschedule.Tables(0).Rows(s)("mon10").ToString()

                                                        cellc12 = ds_poschedule.Tables(0).Rows(s)("mon11").ToString()
                                                        cellc13 = ds_poschedule.Tables(0).Rows(s)("mon12").ToString()

                                                        styles = "style='font-family: Times New Roman; font-size: 15px;'"
                                                        styles1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"


                                                        html += "<tr>"
                                                        html += "<td align='Center' " + styles + ">" & (s + 1) & "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc1 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc2 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc3 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc4 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc5 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc6 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc7 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc8 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc9 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc10 + "</td>"
                                                        html += "<td align='Center'" + styles + " colspan='1'>" + cellc11 + "</td>"

                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc12 + "</td>"
                                                        html += "<td align='Center' " + styles + " colspan='1'>" + cellc13 + "</td>"

                                                        html += "</tr>"
                                                    Catch ex As Exception

                                                    End Try
                                                Next
                                            End If


                                            'End
                                            'srno1 = srno1 + 3
                                            'srno = srno + 3
                                            html += "<tr>"
                                            html += "<td align='right' colspan='7' style='font-weight: bold'>"
                                            '  html += "<h> Count : " & count1 & "</h>"
                                            html += "</td>"
                                            html += "<td align='right' colspan='7' style='font-weight: bold'>"


                                            html += "<a href='rptPO.aspx?poyear=" & ddlfinancecalendar.SelectedItem.Text & "&potype=" & drbPoType.SelectedItem.Text & "&PoNo=" & txtPONo.Text & "&vendor=" & txtvendor.Text & "&category=" & drpType.SelectedValue & "&srno=" & srno & " &srno1=" & srno1 & "  '>  </a>" 'sr=" & srno & "
                                            html += "</td>"
                                            html += "</tr>"

                                        End If
                                        html += "<tr>"
                                        html += "<td align='left' colspan='14' style='font-weight: bold'>"
                                        '  html += "INSTRUCTION"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td colspan='14'>"
                                        html += "<table align='center' cellspacing='0' style='width: 650px'>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        '  html += span + "<b>(1) Bill and Challans should be sent in triplicate,</span>"
                                        html += "</td>"
                                        'New
                                        html1 += "<tr>"
                                        html1 += "<td align='center' colspan='7' " + style2 + ">" + "Delivery Shedule" + "</td>"
                                        html1 += "</tr>"

                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "    Month     " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "    Shedule    " + "</td>"
                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "        " + "</td>"
                                        html1 += "</tr>"
                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "        " + "</td>"
                                        html1 += "</tr>"
                                        html1 += "<tr>"
                                        html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
                                        html1 += "<td align='right' " + style2 + ">" + "       " + "</td>"
                                        html1 += "</tr>"
                                        html1 += "</table>"
                                        'End
                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        '  html += span + "<b> 2) Payment will be made</span>"
                                        '  html += span2 + dt.Rows(0)("payment_Mode").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        '  html += span + "<b> 3) Vat Tax Extra </span>"
                                        ' html += span2 + dt.Rows(0)("vat").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        '   html += span + "<b> 2) Exise Duty </span>"
                                        '   html += span2 + dt.Rows(0)("ed").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"

                                        html += "<td align='left' colspan='3'>"
                                        '  html += span + "<b>4) Discount </span> "
                                        ' html += span2 + dt.Rows(0)("Discount_Material_Amout").ToString() + "</span>"
                                        html += " <span style='font-size: 12px'><br><br><br><br><br></span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        '   html += span + "<b>4) Fright will be borne by   <u><b></b></u></span>"
                                        '   html += span2 + dt.Rows(0)("Fright").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "    <td align='left' colspan='2'>"
                                        '   html += span + "<b>5) Bank charges/commission will be borne by  <u><b></b></u></span>"

                                        '    lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                                        '   html += span2 + dt.Rows(0)("Bank_Charges_Borne_by").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='3'>"
                                        ' html += span + "<b>6) Goods to be sent &nbsp; </span>"
                                        '  html += span + "<u><b>With, for minimum 60 days demarage free period <b></u></span>"
                                        ' html += span2 + dt.Rows(0)("Good_Sent_By").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        '  html += span + "<b>7) Delivert should be completed by <u>GPT / TCI / ARC </u></span>"
                                        '  html += span2 + dt.Rows(0)("Delivery_completed_By").ToString() + "</span>"
                                        html += "</td>"

                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        ' html += span + "8) Validity Period </span>"
                                        '   html += span2 + dt.Rows(0)("Validity_Period").ToString() + "</span>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += "<td align='left' colspan='2'>"
                                        ' html += span + "<b>8) Note :</b><br><b>* Material should be in antirusted and with proper packing<br> to avoid external and Internal damage.</br> * For Nut,Bolts,Washer packing should be of 1 KG. </b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>"
                                        html += "</td>"

                                        html += "</table> <br />"

                                        html += " <table align='center' cellspacing='0' style='width: 650px;'>"
                                        html += "     <tr >"
                                        html += "<td rowspan='2' align='left' style='width: 50%' valign='top'>"
                                        ' html += span + "<b>Total Commitment Rs. </span>"
                                        '  html += span2 + dt.Rows(0)("total").ToString() + "</span>"
                                        '   html += span + "Yr.</span>"
                                        '   html += span2 + dt.Rows(0)("Year1").ToString() + "</span>"
                                        html += "</td>"
                                        html += "<td align='center' colspan='0'>"
                                        html += "<span style='font-family: Times New Roman; font-size: 18px;'><br><br><br><b>Stores Officer</b></span>"
                                        html += "<center><b>PMPML</b>"
                                        html += "</td>"

                                        'html += "<td align='left' style='width: 50%'>"
                                        ' html += span + "Rate sanctioned by TC/TransportManager </span>"
                                        'html += "</td>"
                                        html += "</tr>"
                                        ' html += "<tr>"
                                        '  html += "<td align='center' colspan='0'  style='width: 50%'>"
                                        ' html += span + "<br><b><h3>PMPML</h3</b></span>"
                                        '   html += "</td>"
                                        ' html += "    <td align='left' style='width: 50%'>"
                                        '  html += "Res.No.  </span> "
                                        ' html += span2 + dt.Rows(0)("res_no").ToString() + "</span>"
                                        ' html += "&nbsp;&nbsp;" + span + "Dt &nbsp; :&nbsp;</span>"
                                        ' html += span2 + dt.Rows(0)("DT_Trans_Manager").ToString() + "</span>"
                                        'html += "</td>"

                                        ' html += "</tr>"
                                        '  html += "<tr>"
                                        '  html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                        '    html += span + "Entd in B/C Regr </span>"
                                        '   html += span2 + dt.Rows(0)("B_C_Reg").ToString() + "</span>"
                                        ' html += span + "Sr.No.</span>"
                                        '   html += span2 + dt.Rows(0)("SrNo").ToString() + "</span>"
                                        '  html += "</td>"
                                        '  html += "<td align='left' style='width: 50%'>"
                                        '    html += span + "Purchase Authorised by </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                        '    html += span2 + dt.Rows(0)("Purchas_Authorised_By").ToString()
                                        '   html += "</td>"
                                        '   html += "</tr>"
                                        '    html += "<tr>"
                                        '    html += "    <td align='left' style='width: 50%'>"
                                        '     html += span + "Budegt Account Hd  </span>"
                                        '   html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                        '   html += span2 + dt.Rows(0)("Budget_Account_HD").ToString() + "</span>"
                                        '  html += "</td>"
                                        '  html += "</tr>"
                                        '   html += "<tr>"
                                        '  html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                        '    html += span + "Audited by </span>"
                                        '     html += span2 + dt.Rows(0)("Audited_By").ToString() + "</span>"
                                        '      html += span + "CL: </span>"
                                        '     html += span2 + dt.Rows(0)("CL").ToString() + "</span>"
                                        '   html += span + "DT: </span>"
                                        '   html += span2 + dt.Rows(0)("DT").ToString() + "</span>"
                                        '  html += "</td>"
                                        '   html += "<td align='left' style='width: 50%'>"

                                        '  html += span + "Prepared by</span>"
                                        '  html += span2 + dt.Rows(0)("Prepared_By").ToString() + "</span>"
                                        ' html += span + "Checked by</span>"
                                        '   html += span2 + dt.Rows(0)("Checked_By").ToString() + "</span>"
                                        '  html += "</td>"
                                        ' html += "</tr>"
                                        '  ''  html += "<tr>"
                                        ' html += "<td align='left' style='width: 50%'>"
                                        '   html += span + "Indent Ref No . </span>"
                                        '   html += span2 + dt.Rows(0)("Indent_Ref_No").ToString() + "</span>"
                                        '  html += "</td>"
                                        '  html += "</tr>"
                                        html += "<tr>"
                                        html += "    <td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                        '  html += span + "Audited Officer </span>"
                                        '  html += span2 + dt.Rows(0)("Audit_officer").ToString() + "</span>"
                                        html += "</td>"

                                        html += "</tr>"
                                        html += "</table>"
                                        html += "</td>"
                                        html += "</tr>"
                                    End If
                                    If i = 14 Or i = 44 Or i = 74 Then
                                        ctr = 0
                                        html += "</table>"
                                        html += "<div style='page-break-before:always;font-size:1;margin:0;border:0;'></div>"
                                        html += "<div style='height:10px'> &nbsp;</div>"
                                        html += " <table cellspacing='0' style='width: 650px' cellpadding='3' rules='all' border='1' id='Table" + i.ToString() + "' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"

                                        html += " <tr>"
                                        html += "<td colspan='8' align='center'> "
                                        ' html += "<strong><span style='font-size: 15pt'>Pune Mahanagar Parivahan Mahamandal Limited </span>"
                                        html += "</strong>"
                                        html += "</td>"
                                        html += "</tr>"
                                        html += "<tr>"
                                        html += " <td align='left' colspan='4'>"
                                        html += "<strong><span style='font-size: 14pt'>Swargate, Pune 411037&nbsp; </span></strong>"
                                        html += " </td>"
                                        html += " <td align='right' colspan='4'>"
                                        '  html += "<strong><span style='font-size: 14pt'>" & dt.Rows(0)("po_str").ToString() & " &nbsp;  " & dt.Rows(0)("po_no").ToString() & "</span></strong>"
                                        html += " </td>"
                                        html += " </tr>"
                                    End If

                                Next
                                html += "</table>"
                                htmldetails.Text = html
                                ''clear()
                            End If

                        Catch ex As Exception

                        Finally
                            If con.State = ConnectionState.Open Then
                                con.Close()
                            End If
                        End Try


                    Else
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False

                    End If

                    'If ds_tics.Tables(0).Rows.Count = 0 Then
                    '    Response.Write("<script>alert ('Record Not Found') </script>")
                    '    Table1.Visible = False
                    'Else
                    '    Table1.Visible = True
                    'End If
                Catch ex As Exception
                Finally
                    strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                End Try
            End If
            ' End If
        End Sub
        Private Sub showback()
            Dim html As String = ""
            Dim span As String = "<span style='font-family: Times New Roman; font-size: 14px;'>"
            Dim span2 As String = "<span style='font-family: Times New Roman; font-size: 15px;text-decoration:underline'>"
            html += " <table cellspacing='0' cellpadding='0' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"

            html += "<tr>"
            html += "<td align='left' colspan='8' style='font-weight: bold'>"
            html += "</br> </br>  </br></br> </br>  </br></br> </br>  </br>" + span + " 1)	Supplies will not be accepted if these are not according to our specification and / or according to the </br> "
            html += " approved sample. If this material is not removed by the supplier within one week from the issue of the  </br> "
            html += " notice by the PMPML. A ground rent is liable to be charged in the sole discretion of the CMD/JMD.</br> "
            html += "  </br> </br>   "
            html += " 2) If the firm fails to supply any stores or, fails to replace any stores rejected by the  competant authoroty "
            html += " of PMPML or any person on his behalf within the time stipulated in this purchase order the stores   </br> "
            html += " competant authoroty  shall be entitled to purchas such store from any other source and at such price as   </br> "
            html += " the competant authoroty  order the firm  Manager shall in his  discretion think fit and if such price  </br> "
            html += " exceeds the price mentioned   in this purchase shall be responsible to pay the difference between the price  </br> "
            html += "  at which such store have  to be purchased and the price shown in this purchase order. </br></br>  "
            html += "  3) In the case of non delivery and / or delayed delivery the chairman and managing director / joint   </br> "
            html += " managing director or any person on his behalf reserves the right to either rejecting the delivery and / </br> "
            html += "  or to levy such penalty which he think fit  in his sole discretion. </br></br>  "
            html += "4)  Suppliers are requested to observe the following timing for effecting deliveries at the PMPML  Stores. </br> "
            html += "  </br> </br>"
            html += " On all week days except &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;      11.00 a.m to 4.30 noon. </br></br> "
            html += " Holidays and Sundays </br></br>  "
            html += " On Saturday </br></br>  "
            html += "  Deliveries will not be accepted if they are not made during the above mentioned timing. </br> </br> "
            html += "  5)  The payment in respect of the supplies against the purchase order will have to be accepted by cheque </br> "
            html += " issued by the P.M.P.M.L on a Schedule Bank. </br> " + "</span>"
            html += "</td>"
            html += "</tr>"
            html += "</table>"
            htmldetailsback.Text = html
        End Sub
        Private Function GetFinYear(ByVal yearinc As Integer)
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

        Private Sub clear()
            drpType.SelectedValue = 0
            drbPoType.SelectedValue = 0
            txtPONo.Text = ""
            txtvendor.Text = ""
        End Sub
        Private Function last_po()
            'If ddlfinancecalendar.SelectedItem.Text = "2014-2015" Or ddlfinancecalendar.SelectedItem.Text = "2013-2014" Or ddlfinancecalendar.SelectedItem.Text = "2012-2013" Or ddlfinancecalendar.SelectedItem.Text = "2011-2012" Then
            '    lblprinttype.Visible = True
            '    lblPoDate.Visible = True
            '    lblPONoStr.Visible = True
            '    lblPONo.Visible = True
            '    lblVendorName.Visible = True
            '    lblAdd1.Visible = True
            '    lblORN.Visible = True
            '    lblORD.Visible = True
            '    lblAdd2.Visible = True
            '    lblYRN.Visible = True
            '    lblYRD.Visible = True
            '    lblContctno.Visible = True
            '    lblref_asrtu.Visible = True
            '    lblmail.Text = " Email :pmpmlstore@yahoo.com"
            '    lblmail.Visible = True
            '    lblpmpadd.Visible = True
            '    lblpmpadd.Text = " Main Bldg.Near IncomeTax Office"
            '    lblpmpadd2.Visible = True
            '    lblpmpadd2.Text = " Shankarseth Road"
            '    lblphnos.Visible = True
            '    lblphnos.Text = " Ph :24503307/220"
            '    lblfax.Visible = True
            '    lblfax.Text = "Fax: 24441268"
            '    lblponos.Visible = True
            '    lblponos.Text = "P.O. NO. :  "
            '    lblpodates.Visible = True
            '    lblpodates.Text = "Date : "
            '    lblcontactnos.Visible = True
            '    lblcontactnos.Text = "Contact No : "
            '    lblourrefnos.Visible = True
            '    lblourrefnos.Text = "Our Ref. No. "
            '    lblyourrefnos.Visible = True
            '    lblyourrefnos.Text = "Your Ref. No. "
            '    lblrefdates.Visible = True
            '    lblrefdates.Text = " Date"
            '    lblrefrs.Visible = True
            '    lblrefrs.Text = "Ref : "
            '    lbltandc.Visible = True
            '    lbltandc.Text = " Please Supply the articles as per details given below on conditions state hereunder and overleaf as will as in accordance with the Terms and conditions in the acceptance of your tender"
            '    lblcodenos.Visible = True
            '    lblcodenos.Text = "Code No."
            '    lblpmpmls.Visible = True
            '    lblpmpmls.Text = " Pune Mahanagar Parivahan Mahamandal Limited"
            '    lblswargets.Visible = True
            '    lblswargets.Text = "Swargate, Pune 411037"
            '    lblms.Visible = True
            '    lblms.Text = " M/s."
            '    lbltoms.Visible = True
            '    lbltoms.Text = " TO,"
            '    lblorndates.Visible = True
            '    lblorndates.Text = "Date"
            '    Try
            '        Dim style2 As String
            '        Dim html1 As String
            '        html1 += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
            '        style2 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"
            '        cmd = New SqlCommand("view_po_details_po '1','" & category & "','" & potype & "','" & pono & "','" & poyear & "','" & vendor & "'", con)

            '        'cmd.CommandType = CommandType.StoredProcedure
            '        'cmd.Parameters.AddWithValue("@type", "'1'")
            '        'cmd.Parameters.AddWithValue("@poid", "'113'")
            '        'cmd.Parameters.AddWithValue("@vendorid", CONT)
            '        da = New SqlDataAdapter(cmd)
            '        dt = New DataTable
            '        da.Fill(dt)

            '        If dt.Rows.Count <> 0 Then
            '            Table1.Visible = True

            '            lblVendorName.Text = (StrConv(dt.Rows(0)("vendor_name").ToString(), VbStrConv.ProperCase))
            '            lblContctno.Text = dt.Rows(0)("contact_name").ToString() + " - " + dt.Rows(0)("contact_no").ToString()
            '            lblAdd1.Text = dt.Rows(0)("add1").ToString()
            '            lblAdd2.Text = dt.Rows(0)("add2").ToString()
            '            If dt.Rows(0)("po_str").ToString() = "T" Then
            '                potype1 = "TC"
            '            Else
            '                potype1 = dt.Rows(0)("po_str").ToString()
            '            End If
            '            lblPONoStr.Text = potype1 'dt.Rows(0)("po_str").ToString()
            '            lblPONo.Text = dt.Rows(0)("po_no").ToString()
            '            lblPoDate.Text = dt.Rows(0)("po_date").ToString()
            '            lblORN.Text = dt.Rows(0)("po_our_ref_no").ToString()
            '            lblYRN.Text = dt.Rows(0)("po_your_ref_no").ToString()
            '            lblYRD.Text = dt.Rows(0)("po_your_ref_date").ToString()
            '            lblORD.Text = dt.Rows(0)("po_our_ref_date").ToString()
            '            lblref_asrtu.Text = dt.Rows(0)("ref_asrtu").ToString()
            '            'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()
            '            'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

            '            Dim ds_tics As New DataSet
            '            lblprinttype.Text = ddlprint.SelectedItem.Text
            '            'Dim CONT As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

            '            'lblcontractor.Text = "Depo Name : " + DropDownList1.SelectedItem.Text
            '            'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy")
            '            'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yyyy")
            '            'If Page.IsPostBack Then
            '            'BindGrid(grdstock, con, "View_PO_Details '" & fromdate & "' ,'" & todate & "','" & CONT & "'")
            '            'BindGrid(grdstock, con, "view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "' ")

            '            Try

            '                If con.State = ConnectionState.Closed Then
            '                    con.Open()
            '                End If
            '                Dim da As New SqlClient.SqlDataAdapter("view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)

            '                da.SelectCommand.CommandTimeout = 0
            '                da.Fill(ds_tics)
            '                Dim html As String = ""
            '                If (ds_tics.Tables(0).Rows.Count > 0) Then
            '                    html += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
            '                    Dim i, ctr As Integer
            '                    Dim tic_den_des_printed As String = ""

            '                    For i = 0 To ds_tics.Tables(0).Rows.Count - 1
            '                        Dim cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, style, style1 As String

            '                        cell1 = ds_tics.Tables(0).Rows(i)("lfno").ToString()
            '                        cell2 = ds_tics.Tables(0).Rows(i)("bin_no").ToString()
            '                        cell3 = ds_tics.Tables(0).Rows(i)("part_no").ToString()
            '                        cell4 = ds_tics.Tables(0).Rows(i)("item_name").ToString()
            '                        cell5 = ds_tics.Tables(0).Rows(i)("item_qty").ToString()
            '                        cell6 = ds_tics.Tables(0).Rows(i)("item_rate").ToString()
            '                        cell7 = ds_tics.Tables(0).Rows(i)("item_amt").ToString()
            '                        cell8 = ds_tics.Tables(0).Rows(i)("Unit").ToString()

            '                        style = "style='font-family: Times New Roman; font-size: 15px;'"
            '                        style1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

            '                        If ctr = 0 Then
            '                            html += "<tr>"
            '                            html += "<td align='right' " + style1 + ">" + "Sr No" + "</td>"
            '                            If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
            '                                html += "<td align='right' " + style1 + ">" + "Lf No" + "</td>"
            '                                html += "<td align='center'" + style1 + ">" + "Bin No" + "</td>"
            '                            End If
            '                            html += "<td align='left' " + style1 + ">" + "Maker's identification No Or Code No" + "</td>"
            '                            html += "<td align='left' " + style1 + ">" + "Nomenclature" + "</td>"
            '                            html += "<td align='right' " + style1 + ">" + "Quantity" + "</td>"
            '                            html += "<td align='right' " + style1 + ">" + "Unit" + "</td>"
            '                            html += "<td align='right' " + style1 + ">" + "Rate" + "</td>"
            '                            html += "<td align='right' " + style1 + ">" + "Amount Rs" + "</td>"

            '                            html += "</tr>"
            '                        End If
            '                        html += "<tr>"
            '                        html += "<td align='right' " + style + ">" & (i + 1) & "</td>"
            '                        If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
            '                            html += "<td align='right' " + style + ">" + cell1 + "</td>"
            '                            html += "<td align='Center'" + style + ">" + cell2 + "</td>"
            '                        End If

            '                        html += "<td align='left' " + style + ">" + cell3 + "</td>"
            '                        html += "<td align='left' " + style + ">" + cell4 + "</td>"
            '                        html += "<td align='right' " + style + ">" + cell5 + "</td>"
            '                        html += "<td align='right' " + style + ">" + cell8 + "</td>"
            '                        html += "<td align='right' " + style + ">" + cell6 + "</td>"
            '                        html += "<td align='right' " + style + ">" + cell7 + "</td>"

            '                        html += "</tr>"

            '                        ctr = ctr + 1
            '                        If i = 14 Or ((i = ds_tics.Tables(0).Rows.Count - 1) And i < 14) Then

            '                            Dim span As String = "<span style='font-family: Times New Roman; font-size: 12px;'>"
            '                            Dim span3 As String = "<span style='font-family: Times New Roman; font-size: 18px;'>"
            '                            Dim span2 As String = "<span style='font-family: Times New Roman; font-size: 15px;text-decoration:underline'>"

            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='9' style='font-weight: bold'>"
            '                            html += span + dt.Rows(0)("special_discount").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"

            '                            'New
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='9' style='font-weight: bold'>"
            '                            html += "Delivery Schedule"
            '                            html += "</td>"
            '                            html += "</tr>"

            '                            Dim ds_poschedule As New DataSet
            '                            'lblprinttype.Text = ddlprint.SelectedItem.Text
            '                            'Try
            '                            If con.State = ConnectionState.Closed Then
            '                                con.Open()
            '                            End If
            '                            Dim da1 As New SqlClient.SqlDataAdapter("view_po_schedule '1'," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
            '                            'Dim da As New SqlClient.SqlDataAdapter("view_po_details_po '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
            '                            da1.SelectCommand.CommandTimeout = 0
            '                            da1.Fill(ds_poschedule)
            '                            If (ds_poschedule.Tables(0).Rows.Count > 0) Then

            '                                Dim s, ctr1 As Integer
            '                                Dim tic_den_des_printed1 As String = ""

            '                                Dim styles, styles1 As String

            '                                styles = "style='font-family: Times New Roman; font-size: 15px;'"
            '                                styles1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

            '                                If ctr1 = 0 Then
            '                                    html += "<tr>"
            '                                    html += "<td align='right' " + styles1 + ">" + "Sr No" + "</td>"

            '                                    html += "<td align='Center' " + styles1 + " colspan='3'>" + "Item No" + "</td>"
            '                                    html += "<td align='Center' " + styles1 + " colspan='2'>" + "Supply Quantity" + "</td>"
            '                                    html += "<td align='Center' " + styles1 + " colspan='3'>" + "Month" + "</td>"

            '                                    html += "</tr>"
            '                                End If
            '                                For s = 0 To ds_poschedule.Tables(0).Rows.Count - 1
            '                                    Dim cellc1, cellc2, cellc3 As String

            '                                    cellc1 = ds_poschedule.Tables(0).Rows(s)("Item_no").ToString()
            '                                    cellc2 = ds_poschedule.Tables(0).Rows(s)("stockqua").ToString()
            '                                    cellc3 = ds_poschedule.Tables(0).Rows(s)("shmonth").ToString()

            '                                    'styles = "style='font-family: Times New Roman; font-size: 15px;'"
            '                                    'styles1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

            '                                    'If ctr1 = 0 Then
            '                                    '    html += "<tr>"
            '                                    '    html += "<td align='right' " + styles1 + ">" + "Sr No" + "</td>"

            '                                    '    html += "<td align='Center' " + styles1 + " colspan='3'>" + "Item No" + "</td>"
            '                                    '    html += "<td align='Center' " + styles1 + " colspan='2'>" + "Supply Quantity" + "</td>"
            '                                    '    html += "<td align='Center' " + styles1 + " colspan='3'>" + "Month" + "</td>"

            '                                    '    html += "</tr>"
            '                                    'End If
            '                                    html += "<tr>"
            '                                    html += "<td align='Center' " + styles + ">" & (s + 1) & "</td>"

            '                                    html += "<td align='Center' " + styles + " colspan='3'>" + cellc1 + "</td>"
            '                                    html += "<td align='Center'" + styles + " colspan='2'>" + cellc2 + "</td>"

            '                                    html += "<td align='Center' " + styles + " colspan='3'>" + cellc3 + "</td>"
            '                                    html += "</tr>"
            '                                Next
            '                            End If
            '                            'End

            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='9' style='font-weight: bold'>"
            '                            html += "INSTRUCTION"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td colspan='9'>"
            '                            html += "<table align='center' cellspacing='0' style='width: 650px'>"
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='3'>"
            '                            html += span + "(1) Bill and Challans should be sent in triplicate,</span>"
            '                            html += "</td>"
            '                            'New
            '                            html1 += "<tr>"
            '                            html1 += "<td align='center' colspan='7' " + style2 + ">" + "Delivery Shedule" + "</td>"
            '                            html1 += "</tr>"

            '                            html1 += "<tr>"
            '                            html1 += "<td align='left' colspan='7' " + style2 + ">" + "    Month     " + "</td>"
            '                            html1 += "<td align='right' " + style2 + ">" + "    Shedule    " + "</td>"
            '                            html1 += "<tr>"
            '                            html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
            '                            html1 += "<td align='right' " + style2 + ">" + "        " + "</td>"
            '                            html1 += "</tr>"
            '                            html1 += "<tr>"
            '                            html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
            '                            html1 += "<td align='right' " + style2 + ">" + "        " + "</td>"
            '                            html1 += "</tr>"
            '                            html1 += "<tr>"
            '                            html1 += "<td align='left' colspan='7' " + style2 + ">" + "         " + "</td>"
            '                            html1 += "<td align='right' " + style2 + ">" + "       " + "</td>"
            '                            html1 += "</tr>"
            '                            html1 += "</table>"
            '                            'End
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='3'>"
            '                            html += span + " 2) Payment will be made</span>"
            '                            html += span2 + dt.Rows(0)("payment_Mode").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"

            '                            html += "<td align='left' colspan='3'>"
            '                            html += span + "3) Discount</span> "
            '                            html += span2 + dt.Rows(0)("Discount_Material_Amout").ToString() + "</span>"
            '                            html += " <span style='font-size: 12px'> % on Value of material on total amount</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='2'>"
            '                            html += span + "4) Fright will be borne by   <u><b>You</b></u></span>"
            '                            html += span2 + dt.Rows(0)("Fright").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "    <td align='left' colspan='2'>"
            '                            html += span + "5) Bank charges/commission will be borne by  <u><b>You</b></u></span>"

            '                            lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

            '                            html += span2 + dt.Rows(0)("Bank_Charges_Borne_by").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='3'>"
            '                            html += span + "6) Good to be sent by </span>"
            '                            html += span2 + dt.Rows(0)("Good_Sent_By").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='2'>"
            '                            html += span + "7) Delivert should be completed by </span>"
            '                            html += span2 + dt.Rows(0)("Delivery_completed_By").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "<td align='center' colspan='2'>"
            '                            html += "<span style='font-family: Times New Roman; font-size: 18px;'><b>Stores Officer</b></span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='2'>"
            '                            html += span + "8) Validity Period </span>"
            '                            html += span2 + dt.Rows(0)("Validity_Period").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "<td align='center' colspan='2'>"
            '                            html += span + "PMPML</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' colspan='2'>"
            '                            html += span + "8) Note .................................</br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;................................... </span>"
            '                            html += "</td>"
            '                            html += "</table> <br />"

            '                            html += " <table align='center' cellspacing='0' style='width: 650px;'>"
            '                            html += "     <tr>"
            '                            html += "<td align='left' style='width: 50%' rowspan='2' valign='top'>"
            '                            html += span + "Total Commitment Rs. </span>"
            '                            html += span2 + dt.Rows(0)("total").ToString() + "</span>"
            '                            html += span + "Yr.</span>"
            '                            html += span2 + dt.Rows(0)("Year1").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "<td align='left' style='width: 50%'>"
            '                            html += span + "Rate sanctioned by TC/TransportManager </span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "    <td align='left' style='width: 50%'>"
            '                            html += "Res.No.  </span> "
            '                            html += span2 + dt.Rows(0)("res_no").ToString() + "</span>"
            '                            html += "&nbsp;&nbsp;" + span + "Dt &nbsp; :&nbsp;</span>"
            '                            html += span2 + dt.Rows(0)("DT_Trans_Manager").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
            '                            html += span + "Entd in B/C Regr </span>"
            '                            html += span2 + dt.Rows(0)("B_C_Reg").ToString() + "</span>"
            '                            html += span + "Sr.No.</span>"
            '                            html += span2 + dt.Rows(0)("SrNo").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "<td align='left' style='width: 50%'>"
            '                            html += span + "Purchase Authorised by </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            '                            html += span2 + dt.Rows(0)("Purchas_Authorised_By").ToString()
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "    <td align='left' style='width: 50%'>"
            '                            html += span + "Budegt Account Hd  </span>"
            '                            html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            '                            html += span2 + dt.Rows(0)("Budget_Account_HD").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
            '                            html += span + "Audited by </span>"
            '                            html += span2 + dt.Rows(0)("Audited_By").ToString() + "</span>"
            '                            html += span + "CL: </span>"
            '                            html += span2 + dt.Rows(0)("CL").ToString() + "</span>"
            '                            html += span + "DT: </span>"
            '                            html += span2 + dt.Rows(0)("DT").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "<td align='left' style='width: 50%'>"
            '                            html += span + "Prepared by</span>"
            '                            html += span2 + dt.Rows(0)("Prepared_By").ToString() + "</span>"
            '                            html += span + "Checked by</span>"
            '                            html += span2 + dt.Rows(0)("Checked_By").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "<td align='left' style='width: 50%'>"
            '                            html += span + "Indent Ref No . </span>"
            '                            html += span2 + dt.Rows(0)("Indent_Ref_No").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += "    <td align='left' rowspan='2' valign='top' style='width: 50%'>"
            '                            html += span + "Audited Officer </span>"
            '                            html += span2 + dt.Rows(0)("Audit_officer").ToString() + "</span>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "</table>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                        End If
            '                        If i = 14 Or i = 44 Or i = 74 Then
            '                            ctr = 0
            '                            html += "</table>"
            '                            html += "<div style='page-break-before:always;font-size:1;margin:0;border:0;'></div>"
            '                            html += "<div style='height:10px'> &nbsp;</div>"
            '                            html += " <table cellspacing='0' style='width: 650px' cellpadding='3' rules='all' border='1' id='Table" + i.ToString() + "' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"

            '                            html += " <tr>"
            '                            html += "<td colspan='8' align='center'> "
            '                            html += "<strong><span style='font-size: 15pt'>Pune Mahanagar Parivahan Mahamandal Limited </span>"
            '                            html += "</strong>"
            '                            html += "</td>"
            '                            html += "</tr>"
            '                            html += "<tr>"
            '                            html += " <td align='left' colspan='4'>"
            '                            html += "<strong><span style='font-size: 14pt'>Swargate, Pune 411037&nbsp; </span></strong>"
            '                            html += " </td>"
            '                            html += " <td align='right' colspan='4'>"
            '                            html += "<strong><span style='font-size: 14pt'>" & dt.Rows(0)("po_str").ToString() & " &nbsp;  " & dt.Rows(0)("po_no").ToString() & "</span></strong>"
            '                            html += " </td>"
            '                            html += " </tr>"
            '                        End If

            '                    Next
            '                    html += "</table>"
            '                    htmldetails.Text = html
            '                    ''clear()
            '                End If

            '            Catch ex As Exception

            '            Finally
            '                If con.State = ConnectionState.Open Then
            '                    con.Close()
            '                End If
            '            End Try


            '        Else
            '            Response.Write("<script>alert ('Record Not Found') </script>")
            '            Table1.Visible = False

            '        End If

            '        'If ds_tics.Tables(0).Rows.Count = 0 Then
            '        '    Response.Write("<script>alert ('Record Not Found') </script>")
            '        '    Table1.Visible = False
            '        'Else
            '        '    Table1.Visible = True
            '        'End If
            '    Catch ex As Exception
            '    Finally
            '        strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            '    End Try

            'Else
        End Function
      

    End Class
End Namespace


