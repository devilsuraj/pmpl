Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rptinvoice
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            If Not IsPostBack Then
                bdpfromdate.SelectedDate = Now.Date()
                bdptodate.SelectedDate = Now.Date()
                tblcontain.Visible = False
            End If
        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            Try
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
                Dim idcount As Integer = 0
                If bdpfromdate.SelectedDate <> "#12:00:00 AM#" Then
                    lbldate.Text = "From Date : " + bdpfromdate.SelectedDate.ToString("dd/MM/yy")
                    fromdate = bdpfromdate.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If bdptodate.SelectedDate <> "#12:00:00 AM#" Then
                    lbltodate.Text = "ToDate : " + bdptodate.SelectedDate.ToString("dd/MM/yy")
                    todate = bdptodate.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If (txtvendor.Value <> "") Then
                    lblvendor.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                End If
                If (txtinvoice.Text <> "") Then
                    lblinvoice.Text = "Invoice No : " + txtinvoice.Text
                End If


                If txtvendor.Value = "" And txtinvoice.Text = "" And fromdate.ToString = "" And todate.ToString = "" Then
                    Response.Write("<script>alert ('Please enter search value');window.location.href='rptinvoice.aspx' </script>")
                Else
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
                            ' hdnrowcount.Value = ds_challan.Tables(0).Rows.Count
                            If i = 0 Then

                                html += ("<tr style='font-weight :bold '>")
                                html += ("<td>Sr No</td>")
                                html += ("<td>Vendor Name</td>")
                                html += ("<td>Invoice No</td>")
                                html += ("<td>Invoice Date</td>")
                                html += ("<td>Total Amt </td>")
                                html += ("<td colspan='7'> Item Description</td>")

                                html += ("</tr>")
                            End If

                            Dim invid As Integer = ds_challan.Tables(0).Rows(i).Item("invid")

                            If (invid = strinvid) Then
                                count = count + 1
                                html += ("<tr >")

                                html += ("<td colspan='5'></td>")
                                html += ("<td>" & count + 1 & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("rack_no") & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("subrack_no") & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("part_no") & "</td>")
                                html += ("<td align='right'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("qty") & "")
                                html += ("<td align='right'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("landedcost") & "</td>")
                                html += ("<td align='right'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("total_qty_amt") & "</td>")

                                html += ("</td>")
                                html += ("<tr>")
                            Else
                                idcount = idcount + 1
                                count = 0
                                strinvid = invid
                                store_id_check = "chk_" + i.ToString
                                html += ("<tr >")
                                html += ("<td align='right'><font color='#000066'>" & idcount & "</td>")
                                html += ("<td align='left' id='rec_date_" & i & "'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("vendor_name") & "</td>")
                                html += ("<td align='right' id='rec_no_" & i & "'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("invoice_no") & "</td>")
                                html += ("<td align='left' id='challan_no_" & i & "'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("inv_date") & "</td>")
                                html += ("<td align='right' id='challan_no_" & i & "'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("grand_total") & "</td>")
                                html += ("<td>Sr No</td>")
                                html += ("<td  style='font-weight :bold '>Description</td>")
                                html += ("<td  style='font-weight :bold '>LF No</td>")
                                html += ("<td  style='font-weight :bold '>Bin No</td>")
                                html += ("<td  style='font-weight :bold '>Part No</td>")
                                html += ("<td  style='font-weight :bold '>Inv Qty</td>")
                                html += ("<td  style='font-weight :bold '>Landedcost Per Qty</td>")
                                html += ("<td  style='font-weight :bold '>Total Amount</td>")
                                'html += ("<td id='tdchk_" & i & "'><input id='chk_" & i & "' name='chk_" & i & "' type='checkbox' onclick='removestore_detailcheck(this.id," & k & ")' runat='server'  /><input id='hdnstore_id_" & i & "' name='hdnstore_id_" & i & "' runat='server'  type='hidden' value='" & ds_challan.Tables(0).Rows(i).Item("store_id") & "' /></td>")

                                'html += ("<tr>")
                                html += ("<tr>")

                                html += ("<td colspan='5'></td>")
                                html += ("<td>" & count + 1 & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("item_name") & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("rack_no") & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("subrack_no") & "</td>")
                                html += ("<td align='left'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("part_no") & "</td>")
                                html += ("<td align='right'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("qty") & "</td>")
                                html += ("<td align='right'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("landedcost") & "</td>")
                                html += ("<td align='right'><font color='#000066'>" & ds_challan.Tables(0).Rows(i).Item("total_qty_amt") & "</td>")
                                html += ("<tr>")

                            End If

                        Next
                        html += ("</table>")
                        htmlchallan.Text = html
                        clean()
                    Else
                        Response.Write("<script>alert ('Record Not Found');window.location.href='rptinvoice.aspx' </script>")
                        tblcontain.Visible = False
                    End If

                End If
                '''''''''''''''''''''       
                'BindGrid(dgresult, con, "view_invoice '" & txtvendor.Value & "','" & txtinvoice.Text & "','" & fromdate.ToString() & "','" & todate.ToString() & "'")
            Catch ex As Exception

            Finally
                ''clean()
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try

        End Sub

        Private Sub clean()
            bdpfromdate.SelectedDate = "#12:00:00 AM#"
            bdptodate.SelectedDate = "#12:00:00 AM#"
            txtvendor.Value = ""
            txtinvoice.Text = ""


        End Sub
    End Class
End Namespace

