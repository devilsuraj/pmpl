﻿Imports System.Data.SqlClient
Namespace KDMT
    Partial Class store_GlassPO
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As New SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strref_asrtu As String = ""
        Public strspdisc As String = ""
        Public strVendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10
            Button1.Attributes.Add("onclick", "return validatedata();")
            If Not IsPostBack Then
                Dim SQL As String
                Dim SQL1 As String
                lbldepttype.Text = (Session("Dept_type").ToString)
                hdnrwcnt.Value = 0
                dtPODate.SelectedDate = Now.Date
                dtOurRefNo.SelectedDate = Now.Date
                dtYourRefNo.SelectedDate = Now.Date
                Date1.SelectedDate = Now.Date
                Date2.SelectedDate = Now.Date
                'txtindent.Value = ExecuteQuery("select isnull(max(indent_no),0)+1 from Indent_Request_master")
                'Fill_Combo("Vendor_ID", "Vendor_Name", "Stock_Vendor", ddlvendor, Con, "Vendor_Name is not null", "Select")

                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                SQL = "select distinct ref_Asrtu,po_master.ref_Asrtu  from po_master  where po_master.ref_Asrtu is not null order by po_master.ref_Asrtu"
                strref_asrtu = getAutoCompleteList(SQL, "ref_Asrtu")

                SQL1 = "select top 829 special_discount,po_master.special_discount  from po_master  where po_master.special_discount is not null order by po_master.special_discount"
                strspdisc = getAutoCompleteList(SQL1, "special_discount")
                'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
                If (Session("Deptid").ToString() = "1") Then
                    Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "' and item_id = 1")
                Else
                    Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "' and item_id <> 1")
                End If

                ddlCategory.SelectedValue = Session("Deptid").ToString()
            End If
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            If hdnrwcnt.Value <> 0 Then

                Dim cmd As SqlClient.SqlCommand

                Dim vendorId As String = ExecuteQuery("SELECT VENDOR_ID FROM STOCK_VENDOR WHERE VENDOR_NAME = '" & ddlvendor.Text & "'")
                Dim PONoId As String = Request.Form("ddlPONo")

                Dim OurRefNo As String = Request.Form("txtOurRefNo")

                Dim YourRefNo As String = Request.Form("txtYourRefNo")

                Dim intOptype As Integer = 0

                Dim txtPayment As String = Request.Form("txtPayment")
                Dim txtDescount As String = Request.Form("txtDescount")
                Dim txtFright As String = Request.Form("txtFright")
                Dim txtBankCharges As String = Request.Form("txtBankCharges")
                Dim txtGoodsent As String = Request.Form("txtGoodsent")
                Dim txtDelivery As String = Request.Form("txtDelivery")
                Dim txtValidityPeriod As String = Request.Form("txtValidityPeriod")
                Dim txtYear As String = Request.Form("txtYear")
                Dim txtBCReg As String = Request.Form("txtBCReg")
                Dim txtSrNo As String = Request.Form("txtSrNo")
                Dim txtAudited As String = Request.Form("txtAudited")
                Dim txtAudit_officer As String = Request.Form("txtAudit_officer")
                Dim txtCl As String = Request.Form("txtCl")
                Dim Date1_TextBox As String = Request.Form("Date1_TextBox")
                Dim Date2_TextBox As String = Request.Form("Date2_TextBox")
                Dim txtResNo As String = Request.Form("txtResNo")
                Dim txtPurchase As String = Request.Form("txtPurchase")
                Dim txtBudgetAccount As String = Request.Form("txtBudgetAccount")
                Dim txtPreparedby As String = Request.Form("txtPreparedby")
                Dim txtCheckedBy As String = Request.Form("txtCheckedBy")
                Dim txtIndentRefNo As String = Request.Form("txtIndentRefNo")

                Dim txtspdiscount As String = Request.Form("txtspdisc")
                Dim txtvat As Double = Request.Form("txtvat")
                Dim txted As Double = Request.Form("txted")
                Dim ddlCategory As String = Request.Form("ddlCategory")

                Dim txtrefasrtu As String = Request.Form("txtref_asrtu")

                Dim dr As SqlClient.SqlDataReader
                If intOptype <> 0 Then

                Else
                    Dim fin_year As String = GetFinYear(1)

                    cmd = New SqlCommand("Ins_glassPO_Master", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@vendor_id", vendorId)
                    cmd.Parameters.AddWithValue("@po_str", PONoId)
                    cmd.Parameters.AddWithValue("@po_no ", txtPONo.Text)
                    cmd.Parameters.AddWithValue("@po_date", dtPODate.SelectedDate)
                    cmd.Parameters.AddWithValue("@po_our_ref_no", OurRefNo)
                    cmd.Parameters.AddWithValue("@po_our_ref_date ", dtOurRefNo.SelectedDate)
                    cmd.Parameters.AddWithValue("@po_your_ref_no ", YourRefNo)
                    cmd.Parameters.AddWithValue("@po_your_ref_date", dtYourRefNo.SelectedDate)

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
                    cmd.Parameters.AddWithValue("@DT", Date1.SelectedDate)
                    cmd.Parameters.AddWithValue("@Audited_By", txtAudited)
                    cmd.Parameters.AddWithValue("@Audit_officer ", txtAudit_officer)
                    cmd.Parameters.AddWithValue("@Res_No", txtResNo)
                    cmd.Parameters.AddWithValue("@DT_Trans_Manager ", Date2.SelectedDate)

                    cmd.Parameters.AddWithValue("@Purchas_Authorised_By", txtPurchase)

                    cmd.Parameters.AddWithValue("@Budget_Account_HD", txtBudgetAccount)
                    cmd.Parameters.AddWithValue("@Prepared_By", txtPreparedby)
                    cmd.Parameters.AddWithValue("@Checked_By", txtCheckedBy)
                    cmd.Parameters.AddWithValue("@Indent_Ref_No", txtIndentRefNo)

                    cmd.Parameters.AddWithValue("@special_discount", txtspdiscount)
                    cmd.Parameters.AddWithValue("@vat", txtvat)
                    cmd.Parameters.AddWithValue("@ed", txted)
                    cmd.Parameters.AddWithValue("@item_id", ddlCategory)
                    cmd.Parameters.AddWithValue("@ref_asrtu", txtrefasrtu)
                    cmd.Parameters.AddWithValue("@PO_fin_year", fin_year.ToString())
                    Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                    cmd.Parameters.AddWithValue("@Gflag", 1)
                    strmaxid.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(strmaxid)

                    con.Open()
                    cmd.ExecuteNonQuery()
                    Dim maxid As String = cmd.Parameters("@maxid").Value.ToString
                    con.Close()
                    
                    Dim i As Integer

                    Dim strIndentdetails As String = hdndetail.Value
                    If strIndentdetails.ToString <> "" Then

                        Dim myarray As Array = Split(strIndentdetails.ToString, "|")
                        Dim j As Integer
                        j = myarray.Length - 1
                        Dim strSql As String

                        For i = 0 To myarray.Length - 1
                            If myarray(i) <> "" Then
                                Dim mainarray As Array = Split(myarray(i), "^")

                                'Dim strq As String = "get_itemcodeglass '" & Trim(mainarray(2)) & "','" & mainarray(0) & "' , '" & Trim(mainarray(1)) & "'"
                                Dim strq As String = "get_itemcodeglass '" & mainarray(0) & "'"
                                Dim Itemcode As String = ExecuteQuery(strq)

                                cmd = New SqlCommand("Ins_PO_Details", con)
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@po_id", maxid)
                                cmd.Parameters.AddWithValue("@item_id", Itemcode)

                                cmd.Parameters.AddWithValue("@base_rate", mainarray(1))
                                cmd.Parameters.AddWithValue("@base_qty", mainarray(2))

                                cmd.Parameters.AddWithValue("@item_rate", mainarray(3))
                                cmd.Parameters.AddWithValue("@item_qty", mainarray(4))

                                cmd.Parameters.AddWithValue("@item_amt", mainarray(5))

                                con.Open()
                                cmd.ExecuteNonQuery()

                                con.Close()
                            End If
                        Next
                        Response.Write("<script>alert('Saved Successfuly');if(confirm('Do You Want To Print PO')){window.location.href = '../report/rptPO.aspx?potype=" + PONoId + "&PoNo=" + txtPONo.Text + "&poyear=" + fin_year + "&category=" + ddlCategory + "&vendor=" + ddlvendor.Text + "' }</script>")
                    End If
                End If
            Else

                Response.Write("<script>alert('Please Enter Item ');</script>")
            End If
        End Sub

        Private Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = dtPODate.SelectedDate
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function
        Protected Sub btn_print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_print.Click

        End Sub
    End Class
End Namespace

