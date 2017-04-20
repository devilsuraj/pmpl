Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class invoice_detail
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As New SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strVendor As String = ""


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            Session("MenuId") = 10
            If Not IsPostBack Then
                tblchlitem.Visible = False
                btn_show.Attributes.Add("Onclick", "return checkchallan()")
                btnSubmit.Attributes.Add("Onclick", "return validation()")
                BDPLite1.Text = Now.Date()
            End If




        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            tblchlitem.Visible = False
            If txtvendor.Value = "" Then

                'Show_Msg(Page, "Enter and select vendor name", "invoice_detail.aspx")

            Else



                Dim html As String = ""
                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")
                hdnvendorid.Value = intvendor
                Dim ds_challan As New DataSet
                Dim da As New SqlClient.SqlDataAdapter("view_invoice_challanitem '" & intvendor & "','" & txtchalan.Text & "'", con)
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds_challan)
                Dim strstid As Integer = 0
                If (ds_challan.Tables(0).Rows.Count > 0) Then
                    trgrid.Visible = True
                    html += " <table cellspacing='0'  border='1' id='tblchallan' >"
                    Dim i, ctr As Integer
                    Dim store_id_check As String = ""
                    For i = 0 To ds_challan.Tables(0).Rows.Count - 1
                        hdnrowcount.Value = ds_challan.Tables(0).Rows.Count
                        If i = 0 Then
                            html += ("<tr Class='gridhead'>")
                            html += ("<td>Sr No</td>")
                            html += ("<td>Rec No</td>")
                            html += ("<td>Rec Date</td>")
                            html += ("<td>Challan No</td>")
                            html += ("<td>Challan Date</td>")
                            html += ("<td>po</td>")
                            html += ("<td>po_date</td>")
                            html += ("<td colspan='4'> Item Description</td>")
                            html += ("<td>Select</td>")
                            html += ("</tr>")
                        End If
                        Dim count As Integer = 0
                        Dim strstoreid As Integer = ds_challan.Tables(0).Rows(i).Item("store_id")






                        If (strstoreid = strstid) Then
                            count = count + 1
                            html += ("<tr >")

                            html += ("<td colspan='7'></td>")
                            html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
                            html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("part_no") & "</td>")
                            html += ("<td align='right'>" & ds_challan.Tables(0).Rows(i).Item("total_qty") & "</td>")
                            html += ("<td id='tdchkstore_detail_id_" & i & "'><input id='chkstore_detail_id_" & i & "' onclick='removestorecheck(this.id,""" & store_id_check & """)' name='chkstore_detail_id_" & i & "' type='checkbox' runat='server'  /><input id='hdnstoredetail_id_" & i & "' name='hdnstoredetail_id_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("store_detail_id") & "' /></td>")


                            html += ("<tr>")
                        Else
                            count = 0
                            strstid = strstoreid
                            store_id_check = "chk_" + i.ToString
                            html += ("<tr >")
                            html += ("<td align='right'>" & i + 1 & "</td>")
                            html += ("<td align='right' id='rec_no_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("rec_no") & "</td>")
                            html += ("<td align='left' id='rec_date_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("rec_date") & "</td>")
                            html += ("<td align='left' id='challan_no_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("challan_no") & "</td>")
                            html += ("<td align='left' id='challan_date_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("challan_date") & "</td>")
                            html += ("<td align='left' id='po_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("po") & "</td>")
                            html += ("<td align='left' id='podate_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("po_date") & "</td>")

                            html += ("<td Class='gridhead'>Description</td>")
                            html += ("<td Class='gridhead'>Part No</td>")
                            html += ("<td Class='gridhead'>Rec Qty</td>")
                            html += ("<td Class='gridhead'></td>")
                            Dim k As Integer = i
                            Dim tempstoreid As Integer = strstid
                            Do While strstid = tempstoreid
                                If k < ds_challan.Tables(0).Rows.Count - 1 Then
                                    k = k + 1
                                    tempstoreid = ds_challan.Tables(0).Rows(k).Item("store_id")

                                Else
                                    k = k + 1
                                    tempstoreid = 0
                                End If

                            Loop
                            k = k - 1

                            html += ("<td id='tdchk_" & i & "'><input id='chk_" & i & "' name='chk_" & i & "' type='checkbox' onclick='removestore_detailcheck(this.id," & k & ")' runat='server'  /><input id='hdnstore_id_" & i & "' name='hdnstore_id_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("store_id") & "' /></td>")

                            html += ("<tr>")
                            html += ("<tr>")

                            html += ("<td colspan='7'></td>")
                            html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
                            html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("part_no") & "</td>")
                            html += ("<td align='right'>" & ds_challan.Tables(0).Rows(i).Item("total_qty") & "</td>")
                            html += ("<td id='tdchkstore_detail_id_" & i & "'><input id='chkstore_detail_id_" & i & "' name='chkstore_detail_id_" & i & "'  onclick='removestorecheck(this.id,""" & store_id_check & """)'  type='checkbox' runat='server'  /><input id='hdnstoredetail_id_" & i & "' name='hdnstoredetail_id_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("store_detail_id") & "' /></td>")
                            html += ("<tr>")

                        End If

                    Next
                    html += ("</table>")
                    htmlchallan.Text = html

                Else
                    Response.Write("<script>alert ('Record Not Found');window.location.href='invoice_detail.aspx' </script>")
                End If

            End If

        End Sub

        Protected Sub Btn_showdetail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_showdetail.Click

            Try
                Dim strsql As StringBuilder = New StringBuilder()

                Dim allstore_id As String = ""
                Dim allstoredetail_id As String = ""
                For j = 0 To hdnrowcount.Value - 1
                    Dim store_id As String
                    Dim store_detail_id As String
                    Dim chk As String
                    Dim chk_detailid As String
                    chk = (Request.Form("chk_" & j & ""))
                    chk_detailid = (Request.Form("chkstore_detail_id_" & j & ""))

                    If chk = "on" Then
                        store_id = Request.Form("hdnstore_id_" & j & "")
                        If allstore_id = "" Then

                            allstore_id = "" & store_id & ","
                        Else
                            allstore_id = allstore_id & "" & store_id & ","
                        End If
                    End If

                    If chk_detailid = "on" Then
                        store_detail_id = Request.Form("hdnstoredetail_id_" & j & "")
                        If allstoredetail_id = "" Then

                            allstoredetail_id = "" & store_detail_id & ","
                        Else
                            allstoredetail_id = allstoredetail_id & "" & store_detail_id & ","
                        End If
                    End If

                Next

                Dim str_storeid As String = ""
                Dim str_store_detail_id As String = ""



                ''Dim ds_challan As New DataSet
                ''Dim da As New SqlClient.SqlDataAdapter("view_challan_detail '" & store_id & "'", con)
                ''da.SelectCommand.CommandTimeout = 0
                ''da.Fill(ds_challan)


                'strsql.Append("SELECT 10 AS sr,store_master_detail.store_detail_id,store_master.store_id, store_master_detail.item_code, ")
                'strsql.Append("store_master_detail.total_qty,Item_detail.item_name,store_master.challan_no,convert(varchar(10),challan_date,103) challan_date , ")
                'strsql.Append("store_master.vendor_id ,rec_no,convert(varchar(10),rec_date,103) as  rec_date ")
                'strsql.Append(",rack_no,subrack_no,replace(replace((isnull(part_no,'')+ ' / ' +isnull(part_no2,'') +' / ' +isnull(part_no3,'') + ")
                'strsql.Append(" ' / ' +isnull(part_no4,'')) ,'/  /  /',''),'/  /','')   part_no   ,inv_qty , ")
                'strsql.Append("(isnull(po_type,'')+ ' ' + convert(varchar(10),po_master.po_no,0)) as po ,po_master.po_date ")
                'strsql.Append(",(total_qty - inv_qty) as pen_qty,item_rate    ,po_master.po_id ")
                'strsql.Append("FROM store_master_detail ")
                'strsql.Append("inner JOIN   store_master ON store_master_detail.store_id = store_master.store_id ")
                'strsql.Append("inner JOIN   Item_detail ON store_master_detail.item_code = Item_detail.Item_code  ")
                'strsql.Append("inner JOIN   po_master ON po_master.po_str = store_master.po_type ")
                'strsql.Append("inner JOIN   po_details ON po_details.po_id = po_master.po_id ")
                'strsql.Append("where po_master.vendor_id = store_master.vendor_id ")
                'strsql.Append("and store_master_detail.Item_code = po_details.Item_code ")
                'strsql.Append("and convert(varchar(10),po_master.po_no,0) = store_master.po_no ")
                'strsql.Append("and po_master.po_date = store_master.po_date ")
                'strsql.Append("and total_qty <> inv_qty ")
                Dim str_storeiddrb() As String
                Dim drbdone As String = ""
                str_storeiddrb = allstore_id.ToString.Split(",")
                Dim len As Integer
                For len = 0 To str_storeiddrb.Length - 2
                    drbdone = ExecuteQuery("select challan_no  from store_master  where store_id = '" + str_storeiddrb(len) + "'  and flag = 0")
                    If drbdone.ToString <> "" Then
                        len = str_storeiddrb.Length
                    End If

                Next


                ' If drbdone.ToString <> "" Then

                'Response.Write("<script>alert('DRB not completed for challan  " & drbdone.ToString() & "');</script>")

                'Else
                strsql.Append("select * from #result  where ")

                If allstore_id.ToString.Length > 0 Then
                    str_storeid = allstore_id.ToString.Substring(0, allstore_id.ToString.Length - 1)
                    strsql.Append(" store_id in (" + str_storeid.ToString() + ") order by  store_detail_id")
                Else
                    If allstoredetail_id.ToString.Length > 0 Then
                        str_store_detail_id = allstoredetail_id.ToString.Substring(0, allstoredetail_id.ToString.Length - 1)
                        strsql.Append(" store_detail_id in (" + str_store_detail_id.ToString() + ") order by  store_detail_id")
                    End If
                End If

                Dim dt As DataTable = GetDatatTable("view_challan_detail  '" + strsql.ToString() + "'")

                If dt.Rows.Count > 0 Then
                    trgrid.Visible = False
                    tblchlitem.Visible = True
                    grddetail.DataSource = dt
                    grddetail.DataBind()

                    BindGridview(GridView4, con, "view_invoice_challaninvTAX")

                    txtvendorname.Text = txtvendor.Value
                Else
                    tblchlitem.Visible = False
                End If

                'End If





            Catch ex As Exception

            End Try





            ''    If (ds_challan.Tables(0).Rows.Count > 0) Then
            ''        html += " <table cellspacing='0'  border='1' id='tblitemdetail' >"
            ''        Dim i, ctr As Integer
            ''        For i = 0 To ds_challan.Tables(0).Rows.Count - 1
            ''            hdnrowcount.Value = ds_challan.Tables(0).Rows.Count
            ''            If i = 0 Then
            ''                html += ("<tr>")
            ''                html += ("<td>Part No</td>")
            ''                html += ("<td>LF No</td>")
            ''                html += ("<td>Description</td>")
            ''                html += ("<td>Rec Qty</td>")
            ''                html += ("<td>Qty To be invoiced</td>")
            ''                html += ("<td>Invoice Qty</td>")
            ''                html += ("<td>Discount %</td>")
            ''                html += ("<td>Tax %</td>")
            ''                html += ("<td>Amt With Tax</td>")
            ''                html += ("<td>Amt Witout Tax</td>")
            ''                html += ("</tr>")
            ''            End If

            ''            html += ("<tr>")

            ''            html += ("<td id='tdpartno_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("Part_no") & "</td>")
            ''            html += ("<td id='tdlfno_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("rack_no") & "</td>")
            ''            html += ("<td id='tditem_name_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
            ''            html += ("<td id='tdrecqty_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("total_qty") & "</td>")
            ''            html += ("<td id='tdpenqty_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("pen_qty") & "</td>")
            ''            html += ("<td id='tdinvqty_" & i & "'><input size ='10px' id='inv_qty_" & i & "' type='text' name='inv_qty_" & i & "' value='" & ds_challan.Tables(0).Rows(i).Item("pen_qty") & "' >")
            ''            html += ("<td id='tddisc_" & i & "'><input size ='10px' onblur=calc(this.id) id='disc_" & i & "' type='text' name='disc_" & i & "'  >")

            ''            html += ("<td id='tdtax_" & i & "'><input size ='10px' id='tax_" & i & "' type='text' name='tax_" & i & "'  >")

            ''            html += ("<td id='tddisc_" & i & "'><input size ='10px'  id='amttax_" & i & "' type='text' name='amttax_" & i & "'  >")
            ''            html += ("<td id='tddisc_" & i & "'><input size ='10px' id='amtwitouttax_" & i & "' type='text' name='amtwitouttax_" & i & "'  >")





            ''            'html += ("<td id='item_name_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
            ''            'html += ("<td id='qty_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("total_qty") & "</td>")
            ''            'html += ("<td id='tdchk_" & i & "'><input id='chk_" & i & "' type='checkbox' /><input id='hdnstore_id_" & i & "' type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("store_id") & "' /></td>")

            ''            html += ("<tr>")

            ''        Next
            ''    End If
            ''    html += ("</table>")
            ''    htmlitemdetail.Text = html



        End Sub

        Protected Sub GridView4_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView4.RowDataBound
            Try

                If e.Row.RowType = DataControlRowType.DataRow Then
                    Dim txtp As TextBox
                    txtp = e.Row.FindControl("txtper")
                    Dim chper As CheckBox
                    chper = e.Row.FindControl("chper")


                    Dim txta As TextBox
                    txta = e.Row.FindControl("txtamt")
                    'txtp.Attributes.Add("onblur", "valid_vatgrid('" + txtp.ClientID + "','" + txta.ClientID + "'), vatgrid()")

                    Dim txtn As TextBox
                    txtn = e.Row.FindControl("txtname")
                    Dim lblp As Label
                    lblp = e.Row.FindControl("lblper")

                    txtp.Attributes.Add("onfocus", "checkreadonly('" + txtp.ClientID + "','" + txta.ClientID + "','" + txtn.ClientID + "','1')")
                    txta.Attributes.Add("onfocus", "checkreadonly('" + txtp.ClientID + "','" + txta.ClientID + "','" + txtn.ClientID + "','2')")
                    txtp.Attributes.Add("onblur", "vatgrid()")
                    chper.Attributes.Add("onclick", "vatgrid1('" + txtp.ClientID + "','" + txta.ClientID + "','" + chper.ClientID + "')")
                    'chper.Attributes.Add("onclick", "vatgrid1()")
                    txta.Attributes.Add("onblur", "vatgrid()")

                    'txta.Attributes.Add("onblur", "valid_vatgrid('" + txtp.ClientID + "','" + txta.ClientID + "'),vatgrid()")




                    If txtn.Text = "FREIGHT/PMT" Or txtn.Text = "OTHER CHARGES" Or txtn.Text = "HANDLING CHARGES" Or txtn.Text = "TRANSPORTATION" Or txtn.Text = "PACKING CHARGE" Then
                        chper.Visible = True
                    Else
                        chper.Visible = False
                    End If
                    'If radexise.SelectedValue = 1 Then
                    '    If txtn.Text = "EXCISE" Or txtn.Text = "S CESS" Or txtn.Text = "H CESS" Then
                    '        txtp.Text = "0.00"
                    '        txta.Text = "0.00"
                    '    End If

                    'End If

                    'If txtn.Text = "OTHER CHARGES" Then
                    '    txtp.ReadOnly = True
                    '    txta.ReadOnly = False
                    '    txta.MaxLength = 4
                    '    'txtp.Style.Add("Readonly", "Readonly")
                    'End If
                End If


            Catch ex As Exception

            End Try

        End Sub

        Protected Sub grddetail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grddetail.RowDataBound
            Select Case e.Row.RowType
                Case ListItemType.AlternatingItem, ListItemType.Item


                    Dim ddltax As DropDownList
                    ddltax = e.Row.FindControl("ddltaxamt")
                    Fill_Combo("vat_id", "vat_rate", "vat_master", ddltax, con, "", "select")
                    If radexise.SelectedValue = 0 Then
                        ddltax.Enabled = False
                    End If
            End Select

            Try
                If e.Row.RowType = DataControlRowType.DataRow Then
                    Dim txtinvq As TextBox
                    txtinvq = e.Row.FindControl("txtinv")
                    Dim txtr As Decimal

                    ' txtr = e.Row.FindControl("item_rate")
                    'txtr = Convert.ToDecimal(e.Row.Cells(8).Text)
                    Dim txtpen As Decimal
                    txtpen = Convert.ToDecimal(e.Row.Cells(10).Text)

                    Dim txtdis As TextBox
                    txtdis = e.Row.FindControl("txtdis")


                    Dim txtrate As TextBox
                    txtrate = e.Row.FindControl("txtitemrate")
                    txtr = txtrate.Text

                    Dim hdndisc As HiddenField
                    hdndisc = e.Row.FindControl("hdndisc")

                    Dim hdntotaldisc As HiddenField
                    hdntotaldisc = e.Row.FindControl("hdntotaldisc")

                    Dim ddlvat As DropDownList
                    ddlvat = e.Row.FindControl("ddltaxamt")

                    Dim hdntax As HiddenField
                    hdntax = e.Row.FindControl("hdntax")

                    Dim hdntaxamt As HiddenField
                    hdntaxamt = e.Row.FindControl("hdntaxamt")

                    Dim txtwittax As Label
                    txtwittax = e.Row.FindControl("txtwittax")

                    Dim hdnwittax As HiddenField
                    hdnwittax = e.Row.FindControl("hdnwittax")

                    Dim amtwithottax As Label
                    amtwithottax = e.Row.FindControl("txtamtwitouttax")


                    Dim hdnamtwitouttax As HiddenField
                    hdnamtwitouttax = e.Row.FindControl("hdnamtwitouttax")

                    ' txtinvq.Attributes.Add("onblur", "Calculatedisc(" + txtinvq.ClientID + ", " + txtpen.ToString() + "," + txtr.ToString() + "," + amtwithottax.ClientID + "," + txtdis.ClientID + "," + hdndisc.ClientID + "," + hdntotaldisc.ClientID + ")")
                    'txtdis.Attributes.Add("onblur", "Calculatedisc(" + txtinvq.ClientID + ", " + txtpen.ToString() + "," + txtr.ToString() + "," + amtwithottax.ClientID + "," + txtdis.ClientID + "," + hdndisc.ClientID + "," + hdntotaldisc.ClientID + ")")
                    txtrate.Attributes.Add("onblur", "Calculatedisc(" + txtinvq.ClientID + ", " + txtpen.ToString() + "," + txtrate.ClientID + "," + amtwithottax.ClientID + "," + txtdis.ClientID + "," + hdndisc.ClientID + "," + hdntotaldisc.ClientID + "," + ddlvat.ClientID + "," + hdntax.ClientID + "," + txtwittax.ClientID + "," + hdntaxamt.ClientID + "," + hdnwittax.ClientID + "," + hdnamtwitouttax.ClientID + ")")
                    txtinvq.Attributes.Add("onblur", "Calculatedisc(" + txtinvq.ClientID + ", " + txtpen.ToString() + "," + txtrate.ClientID + "," + amtwithottax.ClientID + "," + txtdis.ClientID + "," + hdndisc.ClientID + "," + hdntotaldisc.ClientID + "," + ddlvat.ClientID + "," + hdntax.ClientID + "," + txtwittax.ClientID + "," + hdntaxamt.ClientID + "," + hdnwittax.ClientID + "," + hdnamtwitouttax.ClientID + ")")
                    txtdis.Attributes.Add("onblur", "Calculatedisc(" + txtinvq.ClientID + ", " + txtpen.ToString() + "," + txtrate.ClientID + "," + amtwithottax.ClientID + "," + txtdis.ClientID + "," + hdndisc.ClientID + "," + hdntotaldisc.ClientID + "," + ddlvat.ClientID + "," + hdntax.ClientID + "," + txtwittax.ClientID + "," + hdntaxamt.ClientID + "," + hdnwittax.ClientID + "," + hdnamtwitouttax.ClientID + ")")
                    ddlvat.Attributes.Add("onchange", "Calculatedisc(" + txtinvq.ClientID + ", " + txtpen.ToString() + "," + txtrate.ClientID + "," + amtwithottax.ClientID + "," + txtdis.ClientID + "," + hdndisc.ClientID + "," + hdntotaldisc.ClientID + "," + ddlvat.ClientID + "," + hdntax.ClientID + "," + txtwittax.ClientID + "," + hdntaxamt.ClientID + "," + hdnwittax.ClientID + "," + hdnamtwitouttax.ClientID + ")")
                End If
            Catch ex As Exception

            End Try

        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim j, i As Integer
            Try


                Dim exciseper As Decimal
                Dim exciseamt As Decimal
                Dim scessper As Decimal
                Dim scessamt As Decimal
                Dim hsessper As Decimal
                Dim hcessamt As Decimal
                Dim vatcstper As Decimal
                Dim vatcstamt As Decimal
                Dim freightper As Decimal
                Dim freightamt As Decimal
                Dim handlingchrgper As Decimal
                Dim handlingchrgamt As Decimal
                Dim transpper As Decimal
                Dim transpamt As Decimal
                Dim othertaxper As Decimal
                Dim othertaxamt As Decimal
                Dim cashdisctaxper As Decimal
                Dim cashdisctaxamt As Decimal
                Dim vatper As Decimal
                Dim vatamount As Decimal

                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")
                'For j = 0 To GridView3.Rows.Count - 1
                cmd.CommandText = "ins_inv_master"
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@invoice_no", Trim(txtinvno.Text))
                cmd.Parameters.AddWithValue("@inv_date", BDPLite1.Text)
                cmd.Parameters.AddWithValue("@vendorid", intvendor)
                If radexise.SelectedValue = 0 Then
                    cmd.Parameters.AddWithValue("@subtot", hdnsubtotalwithouttax.Value)
                Else
                    cmd.Parameters.AddWithValue("@subtot", hdnsubtotal.Value)
                End If

                ''cmd.Parameters.AddWithValue("@subtot",  lblsubtotal.Text)

                'cmd.Parameters.AddWithValue("@store_id", GridView3.Rows(j).Cells(0).Text)
                'cmd.Parameters.AddWithValue("@vendorid", GridView3.Rows(j).Cells(0).Text)
                'cmd.Parameters.AddWithValue("@pono", GridView3.Rows(j).Cells(4).Text)
                'cmd.Parameters.AddWithValue("@podate", GridView3.Rows(j).Cells(5).Text)
                i = 0
                For i = 0 To GridView4.Rows.Count - 1
                    Dim asd As String = GridView4.Rows(i).Cells(1).Text
                    Dim txt1 As TextBox = GridView4.Rows(i).Cells(1).FindControl("txtname")
                    Dim txtper As TextBox = GridView4.Rows(i).Cells(2).FindControl("txtper")
                    Dim txtamt As TextBox = GridView4.Rows(i).Cells(3).FindControl("txtamt")
                    Dim hdnamt As HiddenField = GridView4.Rows(i).Cells(3).FindControl("hdnamt")

                    If txt1.Text = "EXCISE" Then
                        cmd.Parameters.AddWithValue("@exciseper", txtper.Text)
                        cmd.Parameters.AddWithValue("@exciseamt", hdnamt.Value)
                        exciseper = txtper.Text
                        exciseamt = hdnamt.Value
                    End If
                    If txt1.Text = "S CESS" Then
                        cmd.Parameters.AddWithValue("@scessper", txtper.Text)
                        cmd.Parameters.AddWithValue("@scessamt", hdnamt.Value)
                        scessper = txtper.Text
                        scessamt = hdnamt.Value
                    End If
                    If txt1.Text = "H CESS" Then
                        cmd.Parameters.AddWithValue("@hsessper", txtper.Text)
                        cmd.Parameters.AddWithValue("@hcessamt", hdnamt.Value)
                        hsessper = txtper.Text
                        hcessamt = hdnamt.Value

                    End If
                    If txt1.Text = "VAT/CST" Then
                       
                        cmd.Parameters.AddWithValue("@vat_per", txtper.Text)
                        cmd.Parameters.AddWithValue("@vat_amt", hdnamt.Value)
                        vatcstper = txtper.Text
                        vatcstamt = hdnamt.Value

                        If radexise.SelectedValue = 0 Then
                            cmd.Parameters.AddWithValue("@vat_cst", "0")
                        Else
                            cmd.Parameters.AddWithValue("@vat_cst", "1")
                        End If

                    End If
                    If txt1.Text = "FREIGHT/PMT" Then
                        cmd.Parameters.AddWithValue("@freightper", txtper.Text)
                        cmd.Parameters.AddWithValue("@freightamt", hdnamt.Value)
                        freightper = txtper.Text
                        freightamt = hdnamt.Value
                    End If
                    If txt1.Text = "HANDLING CHARGES" Then
                        cmd.Parameters.AddWithValue("@handlingchrgper", txtper.Text)
                        cmd.Parameters.AddWithValue("@handlingchrgamt", hdnamt.Value)
                        handlingchrgper = txtper.Text
                        handlingchrgamt = hdnamt.Value
                    End If
                    If txt1.Text = "TRANSPORTATION" Then
                        cmd.Parameters.AddWithValue("@transpper", txtper.Text)
                        cmd.Parameters.AddWithValue("@transpamt", hdnamt.Value)
                        transpper = txtper.Text
                        transpamt = hdnamt.Value
                    End If
                    If txt1.Text = "OTHER CHARGES" Then
                        cmd.Parameters.AddWithValue("@othertaxper", txtper.Text)
                        cmd.Parameters.AddWithValue("@othertaxamt", hdnamt.Value)
                        othertaxper = txtper.Text
                        othertaxamt = hdnamt.Value
                    End If
                    If txt1.Text = "CASH DISCOUNT" Then
                        cmd.Parameters.AddWithValue("@cashdisctaxper", txtper.Text)
                        cmd.Parameters.AddWithValue("@cashdisctaxamt", hdnamt.Value)
                        cashdisctaxper = txtper.Text
                        cashdisctaxamt = hdnamt.Value
                    End If
                Next
                'cmd.Parameters.AddWithValue("@grandtot", lblgrandtotal.Text)
                cmd.Parameters.AddWithValue("@grandtot", hdngrandtotal.Value)
                cmd.Parameters.AddWithValue("@sysdate", Now.Date)
                cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                If radexise.SelectedValue = 0 Then
                    cmd.Parameters.AddWithValue("@is_excise", 1)
                Else
                    cmd.Parameters.AddWithValue("@is_excise", 0)
                End If
                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                con.Open()
                '' Response.End()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                con.Close()

                For i = 0 To grddetail.Rows.Count - 1

                    cmd = New SqlCommand("ins_inv_Detalis", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    Dim rate As TextBox = grddetail.Rows(i).FindControl("txtitemrate")
                    Dim invqty As TextBox = grddetail.Rows(i).FindControl("txtinv")

                    Dim txtdis As TextBox = grddetail.Rows(i).FindControl("txtdis")
                    Dim hdndisc As HiddenField = grddetail.Rows(i).FindControl("hdndisc")
                    Dim hdntotaldisc As HiddenField = grddetail.Rows(i).FindControl("hdntotaldisc")

                    Dim ddltaxamt As DropDownList = grddetail.Rows(i).FindControl("ddltaxamt")
                    Dim hdntax As HiddenField = grddetail.Rows(i).FindControl("hdntax")
                    Dim hdntaxamt As HiddenField = grddetail.Rows(i).FindControl("hdntaxamt")

                    Dim txtwittax As Label = grddetail.Rows(i).FindControl("txtwittax")
                    Dim txtamtwitouttax As Label = grddetail.Rows(i).FindControl("txtamtwitouttax")

                    Dim hdnwittax As HiddenField = grddetail.Rows(i).FindControl("hdnwittax")
                    Dim hdnamtwitouttax As HiddenField = grddetail.Rows(i).FindControl("hdnamtwitouttax")


                    Dim store_id As HiddenField = grddetail.Rows(i).FindControl("store_id")
                    Dim store_detail_id As HiddenField = grddetail.Rows(i).FindControl("store_detail_id")
                    Dim item_code As HiddenField = grddetail.Rows(i).FindControl("item_code")
                    Dim po_id As HiddenField = grddetail.Rows(i).FindControl("po_id")


                    cmd.Parameters.AddWithValue("@invid", maxid)
                    cmd.Parameters.AddWithValue("@store_id", store_id.Value)
                    cmd.Parameters.AddWithValue("@storedtlid", store_detail_id.Value)
                    cmd.Parameters.AddWithValue("@item_code", item_code.Value)
                    cmd.Parameters.AddWithValue("@poid", po_id.Value)
                    cmd.Parameters.AddWithValue("@qty", invqty.Text)
                    cmd.Parameters.AddWithValue("@rate", rate.Text)
                    If radexise.SelectedValue = 0 Then
                        cmd.Parameters.AddWithValue("@subtotal", hdnsubtotalwithouttax.Value)
                    Else
                        cmd.Parameters.AddWithValue("@subtotal", hdnsubtotal.Value)
                    End If
                    cmd.Parameters.AddWithValue("@dis_per", txtdis.Text)
                    cmd.Parameters.AddWithValue("@dis_amt", hdndisc.Value)
                    cmd.Parameters.AddWithValue("@rate_after_disc", hdntotaldisc.Value)

                    If radexise.SelectedValue = 0 Then
                        cmd.Parameters.AddWithValue("@vat_per", vatcstper)
                        cmd.Parameters.AddWithValue("@vat_amt", vatcstamt)
                        cmd.Parameters.AddWithValue("@rate_after_vat", 0)
                        cmd.Parameters.AddWithValue("@amtwithtax", 0)
                    Else
                        cmd.Parameters.AddWithValue("@vat_per", ddltaxamt.SelectedItem.Text)
                        cmd.Parameters.AddWithValue("@vat_amt", hdntax.Value)
                        cmd.Parameters.AddWithValue("@rate_after_vat", (Convert.ToDecimal(hdntotaldisc.Value) + Convert.ToDecimal(hdntax.Value)))
                        cmd.Parameters.AddWithValue("@amtwithtax", hdnwittax.Value)
                    End If



                    cmd.Parameters.AddWithValue("@excise_per", exciseper)
                    cmd.Parameters.AddWithValue("@excise_amt", exciseamt)
                    cmd.Parameters.AddWithValue("@scess_per", scessper)
                    cmd.Parameters.AddWithValue("@scess_amt", scessamt)
                    cmd.Parameters.AddWithValue("@hsess_per", hsessper)
                    cmd.Parameters.AddWithValue("@hcess_amt", hcessamt)
                    cmd.Parameters.AddWithValue("@freight_per", freightper)
                    cmd.Parameters.AddWithValue("@freight_amt", freightamt)
                    cmd.Parameters.AddWithValue("@handlingchrg_per", handlingchrgper)
                    cmd.Parameters.AddWithValue("@handlingchrg_amt", handlingchrgamt)
                    cmd.Parameters.AddWithValue("@transp_per", transpper)
                    cmd.Parameters.AddWithValue("@transp_amt", transpamt)
                    cmd.Parameters.AddWithValue("@othertax_per", othertaxper)
                    cmd.Parameters.AddWithValue("@othertax_amt", othertaxamt)
                    cmd.Parameters.AddWithValue("@cashdisctaxper", cashdisctaxper)
                    cmd.Parameters.AddWithValue("@cashdisctaxamt", cashdisctaxamt)

                    cmd.Parameters.AddWithValue("@amtwitouttax", hdnamtwitouttax.Value)
                    If radexise.SelectedValue = 0 Then
                        cmd.Parameters.AddWithValue("@is_excise", 1)
                    Else
                        cmd.Parameters.AddWithValue("@is_excise", 0)
                    End If

                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                Next
                Response.Write("<script>alert('Saved Successfuly');window.location.href='invoice_detail.aspx'</script>")


            Catch ex As Exception

                Response.Write("<script>alert(Error);</script>")

            Finally


            End Try
        End Sub

    End Class

End Namespace

