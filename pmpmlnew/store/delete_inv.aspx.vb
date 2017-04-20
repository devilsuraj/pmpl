Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class delete_inv
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10
            strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            If Not IsPostBack Then
                ' btn_del.Attributes.Add("Onclick", "return Validate ()")
                tblcontain.Visible = False
            End If

        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            Try
                fillgrid()
            Catch ex As Exception

            End Try

        End Sub

        Protected Sub btn_del_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_del.Click
            Try
                Dim i As Integer
                Dim Check As CheckBox
                Dim chk_header As CheckBox
                Dim is_delete As Integer = 0

                For j = 0 To hdnrowcount.Value - 1
                    Dim invdtid As Integer
                    Dim invid As Integer
                    Dim storedtlid As Integer
                    Dim item_code As Integer
                    Dim qty As Integer

                    Dim chk As String
                    Dim chk_detailid As String
                    chk = (Request.Form("chk_" & j & ""))
                    chk_detailid = (Request.Form("chkstore_detail_id_" & j & ""))

                    If chk = "on" Then
                        Dim counter As Integer = 0
                        Dim m As Integer = j
                        counter = Request.Form("hdncounter_" & j & "")
                        For m = j To counter
                            invid = Request.Form("hdninvid_" & m & "")
                            invdtid = Request.Form("hdninvdtid_" & m & "")
                            storedtlid = Request.Form("hdnstoredtlid_" & m & "")
                            item_code = Request.Form("hdnitem_code_" & m & "")
                            qty = Request.Form("hdnqty_" & m & "")
                            Call fnExecuteNonQuery("delete_invoice " & invdtid & "," & invid & "," & storedtlid & "," & item_code & "," & qty & "")
                            is_delete = 1
                        Next

                        j = j + counter - 1
                        'Call fnExecuteNonQuery("delete_invoice " & dgresult.Items(i).Cells(0).Text & "," & dgresult.Items(i).Cells(1).Text & "," & dgresult.Items(i).Cells(2).Text & "," & dgresult.Items(i).Cells(3).Text & "," & dgresult.Items(i).Cells(12).Text & "")
                        ' is_delete = 1
                    End If

                Next

                '' for label value 
                'chk_header = dgresult.Controls(0).Controls(0).FindControl("chk_header")

                'If chk_header.Checked Then

                '    For i = 0 To dgresult.Items.Count - 1
                '        Check = dgresult.Items(i).Cells(13).FindControl("check")
                '        If Check.Checked Then
                '            Call fnExecuteNonQuery("delete_invoice " & dgresult.Items(i).Cells(0).Text & "," & dgresult.Items(i).Cells(1).Text & "," & dgresult.Items(i).Cells(2).Text & "," & dgresult.Items(i).Cells(3).Text & "," & dgresult.Items(i).Cells(12).Text & "")
                '            is_delete = 1
                '        End If
                '    Next
                'Else
                '    For i = 0 To dgresult.Items.Count - 1
                '        Check = dgresult.Items(i).Cells(13).FindControl("check")
                '        If Check.Checked Then
                '            Call fnExecuteNonQuery("delete_invoice " & dgresult.Items(i).Cells(0).Text & ",'0'," & dgresult.Items(i).Cells(2).Text & "," & dgresult.Items(i).Cells(3).Text & "," & dgresult.Items(i).Cells(12).Text & "")
                '            is_delete = 1
                '        End If
                '    Next
                'End If
                If is_delete = 1 Then
                    Response.Write("<script>alert('Item Deleted ')</script>")
                End If

                fillgrid()

            Catch ex As Exception

            End Try
        End Sub
        Private Sub fillgrid()
            Try
                Dim fromdate As String = ""
                Dim todate As String = ""
                Dim html As String = ""
                Dim strinvid As Integer = 0
                Dim count As Integer = 0
                If bdpfromdate.Text <> "#12:00:00 AM#" Then
                    ' lbldate.Text = "IBC Date : " + bdpfromdate.Text.ToString("dd/MM/yy")
                    fromdate = bdpfromdate.Text.ToString("MM/dd/yyyy")
                End If
                If bdptodate.Text <> "#12:00:00 AM#" Then
                    'lbltodate.Text = "IBC ToDate : " + bdptodate.Text.ToString("dd/MM/yy")
                    todate = bdptodate.Text.ToString("MM/dd/yyyy")
                End If

                If txtvendor.Value = "" And txtinvoice.Text = "" And fromdate.ToString = "" And todate.ToString = "" Then
                    Response.Write("<script>alert ('Please enter search value');window.location.href='delete_inv.aspx' </script>")
                Else

                    '''''''''''''''''''''
                    Dim ds_challan As New DataSet
                    Dim da As New SqlClient.SqlDataAdapter("view_invoice '" & txtvendor.Value & "','" & txtinvoice.Text & "','" & fromdate.ToString() & "','" & todate.ToString() & "'", con)
                    da.SelectCommand.CommandTimeout = 0
                    da.Fill(ds_challan)

                    If (ds_challan.Tables(0).Rows.Count > 0) Then
                        tblcontain.Visible = True
                        html += " <table cellspacing='0'  border='1' id='tblchallan' >"
                        Dim i, ctr As Integer
                        Dim store_id_check As String = ""
                        For i = 0 To ds_challan.Tables(0).Rows.Count - 1
                            hdnrowcount.Value = ds_challan.Tables(0).Rows.Count
                            If i = 0 Then
                                html += ("<tr Class='gridhead'>")
                                html += ("<td>Sr No</td>")
                                html += ("<td>Vendor Name</td>")
                                html += ("<td>Invoice No</td>")
                                html += ("<td>Invoice Date</td>")
                                html += ("<td>Total Amt Date</td>")
                                html += ("<td colspan='6'> Item Description</td>")
                                html += ("<td>Select</td>")
                                html += ("</tr>")
                            End If

                            Dim invid As Integer = ds_challan.Tables(0).Rows(i).Item("invid")

                            If (invid = strinvid) Then

                                html += ("<tr >")

                                html += ("<td colspan='5'></td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("rack_no") & "</td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("subrack_no") & "</td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("part_no") & "</td>")
                                html += ("<td align='right'>" & ds_challan.Tables(0).Rows(i).Item("qty") & "")
                                html += ("<td align='right'>" & ds_challan.Tables(0).Rows(i).Item("landedcost") & "</td>")
                                html += ("<input id='hdninvdtid_" & i & "' name='hdninvdtid_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("invdtid") & "' />")
                                html += ("<input id='hdninvid_" & i & "' name='hdninvid_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("invid") & "' />")
                                html += ("<input id='hdnstoredtlid_" & i & "' name='hdnstoredtlid_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("storedtlid") & "' />")
                                html += ("<input id='hdnitem_code_" & i & "' name='hdnitem_code_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("item_code") & "' />")
                                html += ("<input id='hdnqty_" & i & "' name='hdnqty_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("qty") & "' />")
                                html += ("</td>")
                                html += ("<tr>")
                            Else
                                count = count + 1
                                strinvid = invid
                                store_id_check = "chk_" + i.ToString
                                html += ("<tr >")
                                html += ("<td align='right'>" & count & "</td>")
                                html += ("<td align='left' id='rec_date_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("vendor_name") & "</td>")
                                html += ("<td align='right' id='rec_no_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("invoice_no") & "</td>")
                                html += ("<td align='left' id='challan_no_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("inv_date") & "</td>")
                                html += ("<td align='right' id='challan_no_" & i & "'>" & ds_challan.Tables(0).Rows(i).Item("grand_total") & "</td>")
                                html += ("<td Class='gridhead'>Description</td>")
                                html += ("<td Class='gridhead'>LF No</td>")
                                html += ("<td Class='gridhead'>Bin No</td>")
                                html += ("<td Class='gridhead'>Part No</td>")
                                html += ("<td Class='gridhead'>Inv Qty</td>")
                                html += ("<td Class='gridhead'>Landedcost</td>")
                                html += ("<td id='tdchk_" & i & "'><input id='chk_" & i & "' name='chk_" & i & "' type='checkbox'  runat='server'  />")
                                html += ("<input id='hdninvdtid_" & i & "' name='hdninvdtid_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("invdtid") & "' />")
                                html += ("<input id='hdninvid_" & i & "' name='hdninvid_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("invid") & "' />")
                                html += ("<input id='hdnstoredtlid_" & i & "' name='hdnstoredtlid_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("storedtlid") & "' />")
                                html += ("<input id='hdnitem_code_" & i & "' name='hdnitem_code_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("item_code") & "' />")
                                html += ("<input id='hdnqty_" & i & "' name='hdnqty_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("qty") & "' />")

                                Dim k As Integer = i
                                Dim tempstoreid As Integer = strinvid
                                Do While strinvid = tempstoreid
                                    If k < ds_challan.Tables(0).Rows.Count - 1 Then
                                        k = k + 1
                                        tempstoreid = ds_challan.Tables(0).Rows(k).Item("invid")

                                    Else
                                        k = k + 1
                                        tempstoreid = 0
                                    End If

                                Loop
                                k = k - 1

                                html += ("<input id='hdncounter_" & i & "' name='hdncounter_" & i & "' runat='server'  type='hidden' value='" & k & "' />")
                                html += ("</td>")
                                'html += ("<td id='tdchk_" & i & "'><input id='chk_" & i & "' name='chk_" & i & "' type='checkbox' onclick='removestore_detailcheck(this.id," & k & ")' runat='server'  /><input id='hdnstore_id_" & i & "' name='hdnstore_id_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("store_id") & "' /></td>")

                                'html += ("<tr>")
                                html += ("<tr>")

                                html += ("<td colspan='5'></td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("rack_no") & "</td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("subrack_no") & "</td>")
                                html += ("<td align='left'>" & ds_challan.Tables(0).Rows(i).Item("part_no") & "</td>")
                                html += ("<td align='right'>" & ds_challan.Tables(0).Rows(i).Item("qty") & "</td>")
                                html += ("<td align='right'>" & ds_challan.Tables(0).Rows(i).Item("landedcost") & "</td>")
                                html += ("<tr>")

                            End If

                        Next
                        html += ("</table>")
                        htmlchallan.Text = html

                    Else
                        Response.Write("<script>alert ('Record Not Found');window.location.href='delete_inv.aspx' </script>")
                        tblcontain.Visible = False
                    End If
                    ''''''''''''''''''''''

                    'BindGrid(dgresult, con, "view_invoice '" & txtvendor.Value & "','" & txtinvoice.Text & "','" & fromdate.ToString() & "','" & todate.ToString() & "'")

                End If

            Catch ex As Exception

            Finally
                ''clean()
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try

        End Sub

    End Class
End Namespace
