Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rptGlassPO
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim dt As DataTable
        Dim da As SqlDataAdapter
        Dim sql19 As String
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
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
                    Dim potype As String = Request.QueryString("potype")
                    Dim pono As Integer = Request.QueryString("PoNo")
                    Dim poyear As String = Request.QueryString("poyear")
                    Dim category As Integer = Request.QueryString("category")
                    Dim vendor As String = Request.QueryString("vendor")

                    drpType.SelectedValue = category
                    drbPoType.SelectedValue = potype
                    txtPONo.Text = pono
                    ddlfinancecalendar.SelectedItem.Text = poyear
                    txtvendor.Text = vendor.ToString()

                    showdata(category, potype, pono, poyear, vendor)
                End If
            End If

        End Sub
        Protected Sub btn_showpo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_showpo.Click
            If ddlprinttype.SelectedItem.Text = "front" Then

                tblback.Visible = False
                Table1.Visible = True
                If txtvendor.Text = "" Or txtPONo.Text = "" Then
                    Response.Write("<script>alert ('Please Enter Vendor and Po No') </script>")

                Else
                    showdata(drpType.SelectedValue, drbPoType.SelectedValue, txtPONo.Text, ddlfinancecalendar.SelectedItem.Text, txtvendor.Text)
                End If

            Else

                showback()
                tblback.Visible = True
                Table1.Visible = False

            End If

        End Sub
        Private Sub showdata(ByVal category As Integer, ByVal potype As String, ByVal pono As Integer, ByVal poyear As String, ByVal vendor As String)
            Try
                cmd = New SqlCommand("view_po_details_po '1','" & category & "','" & potype & "','" & pono & "','" & poyear & "','" & vendor & "'", con)
                da = New SqlDataAdapter(cmd)
                dt = New DataTable
                da.Fill(dt)

                If dt.Rows.Count <> 0 Then
                    Table1.Visible = True

                    lblVendorName.Text = (StrConv(dt.Rows(0)("vendor_name").ToString(), VbStrConv.ProperCase))

                    lblAdd1.Text = dt.Rows(0)("add1").ToString()
                    lblAdd2.Text = dt.Rows(0)("add2").ToString()
                    lblPONoStr.Text = dt.Rows(0)("po_str").ToString()
                    lblPONo.Text = dt.Rows(0)("po_no").ToString()
                    lblPoDate.Text = dt.Rows(0)("po_date").ToString()
                    lblORN.Text = dt.Rows(0)("po_our_ref_no").ToString()
                    lblYRN.Text = dt.Rows(0)("po_your_ref_no").ToString()
                    lblYRD.Text = dt.Rows(0)("po_your_ref_date").ToString()
                    lblORD.Text = dt.Rows(0)("po_our_ref_date").ToString()
                    lblref_asrtu.Text = dt.Rows(0)("ref_asrtu").ToString()

                    Dim ds_tics As New DataSet
                    lblprinttype.Text = ddlprint.SelectedItem.Text

                    Try

                        If con.State = ConnectionState.Closed Then
                            con.Open()
                        End If
                        'Dim da As New SqlClient.SqlDataAdapter("view_Glass_PO_details '2'," & drpType.SelectedValue & "," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)
                        Dim da As New SqlClient.SqlDataAdapter("view_Glass_PO_details '2'," & drbPoType.SelectedValue & ",'" & txtPONo.Text & "','" & ddlfinancecalendar.SelectedItem.Text & "','" & txtvendor.Text & "'", con)

                        da.SelectCommand.CommandTimeout = 0
                        da.Fill(ds_tics)
                        Dim html As String = ""
                        If (ds_tics.Tables(0).Rows.Count > 0) Then
                            html += " <table cellspacing='0' cellpadding='3' rules='all' border='1' id='Table1' style='font-weight: normal; font-style: normal; text-decoration: none;  border-collapse: collapse;'>"
                            Dim i, ctr As Integer
                            Dim tic_den_des_printed As String = ""

                            For i = 0 To ds_tics.Tables(0).Rows.Count - 1
                                Dim cell4, cell5, cell6, cell7, style, style1 As String

                                'cell1 = ds_tics.Tables(0).Rows(i)("lfno").ToString()
                                'cell2 = ds_tics.Tables(0).Rows(i)("bin_no").ToString()
                                'cell3 = ds_tics.Tables(0).Rows(i)("part_no").ToString()
                                cell4 = ds_tics.Tables(0).Rows(i)("Glassname").ToString()
                                cell6 = ds_tics.Tables(0).Rows(i)("item_amt").ToString()
                                cell7 = ds_tics.Tables(0).Rows(i)("item_rate").ToString()
                                cell5 = ds_tics.Tables(0).Rows(i)("item_qty").ToString()
                        
                                style = "style='font-family: Times New Roman; font-size: 15px;'"
                                style1 = "style='font-family: Times New Roman; font-size: 12px;font-weight:bold'"

                                If ctr = 0 Then
                                    html += "<tr>"
                                    html += "<td align='right' " + style1 + ">" + "Sr No" + "</td>"
                                    If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
                                        'html += "<td align='right' " + style1 + ">" + "Lf No" + "</td>"
                                        'html += "<td align='center'" + style1 + ">" + "Bin No" + "</td>"
                                    End If
                                    'html += "<td align='left' " + style1 + ">" + "Maker's identification No Or Code No" + "</td>"
                                    html += "<td align='left' " + style1 + ">" + "Nomenclature" + "</td>"
                                    html += "<td align='right' " + style1 + ">" + "Quantity" + "</td>"
                                    html += "<td align='right' " + style1 + ">" + "Rate" + "</td>"
                                    html += "<td align='right' " + style1 + ">" + "Amount Rs" + "</td>"

                                    html += "</tr>"
                                End If
                                html += "<tr>"
                                html += "<td align='right' " + style + ">" & (i + 1) & "</td>"
                                If ddlprint.SelectedItem.Text <> "ORIGINAL" Then
                                    'html += "<td align='right' " + style + ">" + cell1 + "</td>"
                                    'html += "<td align='Center'" + style + ">" + cell2 + "</td>"
                                End If

                                'html += "<td align='left' " + style + ">" + cell3 + "</td>"
                                html += "<td align='left' " + style + ">" + cell4 + "</td>"
                                html += "<td align='right' " + style + ">" + cell5 + "</td>"
                                html += "<td align='right' " + style + ">" + cell7 + "</td>"
                                html += "<td align='right' " + style + ">" + cell6 + "</td>"

                                html += "</tr>"

                                ctr = ctr + 1
                                If i = 14 Or ((i = ds_tics.Tables(0).Rows.Count - 1) And i < 14) Then

                                    Dim span As String = "<span style='font-family: Times New Roman; font-size: 12px;'>"
                                    Dim span3 As String = "<span style='font-family: Times New Roman; font-size: 18px;'>"
                                    Dim span2 As String = "<span style='font-family: Times New Roman; font-size: 15px;text-decoration:underline'>"

                                    html += "<tr>"
                                    html += "<td align='left' colspan='8' style='font-weight: bold'>"
                                    html += span + dt.Rows(0)("special_discount").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='8' style='font-weight: bold'>"
                                    html += "INSTRUCTION"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td colspan='8'>"
                                    html += "<table align='center' cellspacing='0' style='width: 650px'>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='3'>"
                                    html += span + "(1) Bill and Challans should be sent in triplicate,</span>"
                                    html += "</td>"
                                    html += "<td align='left' colspan='1' rowspan='6' valign='top'>"
                                    html += "<span style='font-size: 13px'>This purchase is made under the</span> <br />"
                                    html += span + "powers vested in me underthe</span><br />"
                                    html += span + "B.P.M.C. Act, 1994 Chapter,</span><br />"
                                    html += span + "Section(1)(i)(2) Exection</span><br />"
                                    html += span + "of contract waived</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='3'>"
                                    html += span + " 2) Payment will be made</span>"
                                    html += span2 + dt.Rows(0)("payment_Mode").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"

                                    html += "<td align='left' colspan='3'>"
                                    html += span + "3) Discount</span> "
                                    html += span2 + dt.Rows(0)("Discount_Material_Amout").ToString() + "</span>"
                                    html += " <span style='font-size: 12px'> % on Value of material on total amount</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='2'>"
                                    html += span + "4) Fright will be borne by   <u><b>You</b></u></span>"
                                    html += span2 + dt.Rows(0)("Fright").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "    <td align='left' colspan='2'>"
                                    html += span + "5) Bank charges/commission will be borne by  <u><b>You</b></u></span>"

                                    lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                                    html += span2 + dt.Rows(0)("Bank_Charges_Borne_by").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='3'>"
                                    html += span + "6) Good to be sent by </span>"
                                    html += span2 + dt.Rows(0)("Good_Sent_By").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='2'>"
                                    html += span + "7) Delivert should be completed by </span>"
                                    html += span2 + dt.Rows(0)("Delivery_completed_By").ToString() + "</span>"
                                    html += "</td>"
                                    html += "<td align='center' colspan='2'>"
                                    html += "<span style='font-family: Times New Roman; font-size: 18px;'><b>Stores Officer</b></span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='2'>"
                                    html += span + "8) Validity Period </span>"
                                    html += span2 + dt.Rows(0)("Validity_Period").ToString() + "</span>"
                                    html += "</td>"
                                    html += "<td align='center' colspan='2'>"
                                    html += span + "PMPML</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' colspan='2'>"
                                    html += span + "8) Note .................................</br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;................................... </span>"
                                    html += "</td>"
                                    html += "</table> <br />"

                                    html += " <table align='center' cellspacing='0' style='width: 650px;'>"
                                    html += "     <tr>"
                                    html += "<td align='left' style='width: 50%' rowspan='2' valign='top'>"
                                    html += span + "Total Commitment Rs. </span>"
                                    html += span2 + dt.Rows(0)("total").ToString() + "</span>"
                                    html += span + "Yr.</span>"
                                    html += span2 + dt.Rows(0)("Year1").ToString() + "</span>"
                                    html += "</td>"
                                    html += "<td align='left' style='width: 50%'>"
                                    html += span + "Rate sanctioned by TC/TransportManager </span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "    <td align='left' style='width: 50%'>"
                                    html += "Res.No.  </span> "
                                    html += span2 + dt.Rows(0)("res_no").ToString() + "</span>"
                                    html += "&nbsp;&nbsp;" + span + "Dt &nbsp; :&nbsp;</span>"
                                    html += span2 + dt.Rows(0)("DT_Trans_Manager").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                    html += span + "Entd in B/C Regr </span>"
                                    html += span2 + dt.Rows(0)("B_C_Reg").ToString() + "</span>"
                                    html += span + "Sr.No.</span>"
                                    html += span2 + dt.Rows(0)("SrNo").ToString() + "</span>"
                                    html += "</td>"
                                    html += "<td align='left' style='width: 50%'>"
                                    html += span + "Purchase Authorised by </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                    html += span2 + dt.Rows(0)("Purchas_Authorised_By").ToString()
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "    <td align='left' style='width: 50%'>"
                                    html += span + "Budegt Account Hd  </span>"
                                    html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                    html += span2 + dt.Rows(0)("Budget_Account_HD").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                    html += span + "Audited by </span>"
                                    html += span2 + dt.Rows(0)("Audited_By").ToString() + "</span>"
                                    html += span + "CL: </span>"
                                    html += span2 + dt.Rows(0)("CL").ToString() + "</span>"
                                    html += span + "DT: </span>"
                                    html += span2 + dt.Rows(0)("DT").ToString() + "</span>"
                                    html += "</td>"
                                    html += "<td align='left' style='width: 50%'>"
                                    html += span + "Prepared by</span>"
                                    html += span2 + dt.Rows(0)("Prepared_By").ToString() + "</span>"
                                    html += span + "Checked by</span>"
                                    html += span2 + dt.Rows(0)("Checked_By").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "<td align='left' style='width: 50%'>"
                                    html += span + "Indent Ref No . </span>"
                                    html += span2 + dt.Rows(0)("Indent_Ref_No").ToString() + "</span>"
                                    html += "</td>"
                                    html += "</tr>"
                                    html += "<tr>"
                                    html += "    <td align='left' rowspan='2' valign='top' style='width: 50%'>"
                                    html += span + "Audited Officer </span>"
                                    html += span2 + dt.Rows(0)("Audit_officer").ToString() + "</span>"
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

            Catch ex As Exception
            Finally
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
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

    End Class
End Namespace

