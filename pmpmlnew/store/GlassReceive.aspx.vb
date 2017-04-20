Imports System.Data.SqlClient
Imports System.Data
Namespace KDMT
    Partial Class GlassReceive
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strSubRackNo As String = ""
        Public strref_asrtu As String = ""
        Public strspdisc As String = ""
        Public strVendor As String = ""
        Dim sqlrdr As SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Get_Glasspo()
            If Not IsPostBack Then

                Dim SQL As String
                Dim SQL1 As String
                lbldepttype.Text = (Session("Dept_type").ToString)
                txt_recno.Text = ExecuteQuery("max_receipt_no '" & Session("Dept_type").ToString() & "'")
                hdnrwcnt.Value = 0
                'dtPODate.SelectedDate = Now.Date
                'dtOurRefNo.SelectedDate = Now.Date
                'dtYourRefNo.SelectedDate = Now.Date
                'Date1.SelectedDate = Now.Date
                'Date2.SelectedDate = Now.Date
                'txtindent.Value = ExecuteQuery("select isnull(max(indent_no),0)+1 from Indent_Request_master")
                'Fill_Combo("Vendor_ID", "Vendor_Name", "Stock_Vendor", ddlvendor, Con, "Vendor_Name is not null", "Select")
                btnSubmit.Attributes.Add("onclick", "return validate();ValidateSave();")
                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                SQL = "select distinct ref_Asrtu,po_master.ref_Asrtu  from po_master  where po_master.ref_Asrtu is not null order by po_master.ref_Asrtu"
                strref_asrtu = getAutoCompleteList(SQL, "ref_Asrtu")

                SQL1 = "select top 829 special_discount,po_master.special_discount  from po_master  where po_master.special_discount is not null order by po_master.special_discount"
                strspdisc = getAutoCompleteList(SQL1, "special_discount")
                'Fill_Combo("Scrap_ID", "Scrap_Reason", "Scrap_Reason_Master", ddlScrapRsn, Con)
                'If (Session("Deptid").ToString() = "1") Then
                '    Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "' and item_id = 1")
                'Else
                '    Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "' and item_id <> 1")
                'End If

                'ddlCategory.SelectedValue = Session("Deptid").ToString()
            End If
        End Sub

        Protected Function Get_Glasspo()
            Dim ds As New DataSet

            Dim val As String
            'val = ExecuteQuery("SELECT Vendor_Id FROM Stock_vendor WHERE Vendor_name = '" & txtvendorname.Text & "'")

            Dim cmd As New SqlCommand("SELECT Code,Glassname FROM Glassmaster", Con)

            Dim ap As New SqlDataAdapter(cmd)
            ap.Fill(ds)
            drdglasstype.DataSource = ds
            drdglasstype.DataTextField = "Glassname"
            drdglasstype.DataValueField = "Code"
            drdglasstype.DataBind()
        End Function

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = Con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try
                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendorname.Text & "' ")
                Dim fin_year As String = GetFinYear(1)
                cmd = New SqlCommand("Ins_storemaster", Con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@part_type", lbldepttype.Text)
                cmd.Parameters.AddWithValue("@vendor_id", intvendor)
                cmd.Parameters.AddWithValue("@security_date", BDPLite4.SelectedDate)
                cmd.Parameters.AddWithValue("@challan_date", BDPLite2.SelectedDate)
                cmd.Parameters.AddWithValue("@challan_no ", txt_challanno.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@loc_id", Session("LocID"))
                cmd.Parameters.AddWithValue("@po_date", hdnPoDate.Value)
                cmd.Parameters.AddWithValue("@po_no", hdnPoNo.Value)
                cmd.Parameters.AddWithValue("@po_type", hdnPOtype.Value)
                cmd.Parameters.AddWithValue("@Inward_no", "")
                cmd.Parameters.AddWithValue("@getpassno ", "")
                cmd.Parameters.AddWithValue("@bill_no ", txt_Billno.Text)
                cmd.Parameters.AddWithValue("@bill_date", BDPLite3.SelectedDate)
                cmd.Parameters.AddWithValue("@Rec_No ", txt_recno.Text)
                cmd.Parameters.AddWithValue("@Rec_Date", BDPLite4.SelectedDate)
                cmd.Parameters.AddWithValue("@drb_no ", "")
                cmd.Parameters.AddWithValue("@fy ", fin_year)

                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                Con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                Con.Close()

                If hdnrwcnt.Value <> "" Then
                    'Dim i As Integer
                    Dim str As String = hdnrwcnt.Value
                    Dim myarray As Array = Split(hdndetail.Value, "|")
                    Dim j As Integer
                    j = myarray.Length - 1

                    For i = 0 To myarray.Length - 1
                        If myarray(i) <> "" Then
                            Dim mainarray As Array = Split(myarray(i), "^")
                            'Dim itemcode As Integer = ExecuteQuery("get_itemcode  '','','" & mainarray(1) & "'")
                            Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & mainarray(1) & "','',''")
                            cmd = New SqlCommand("Ins_GLASSstoredetail", Con)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@storeid ", maxid)
                            cmd.Parameters.AddWithValue("@item_code", itemcode)
                            cmd.Parameters.AddWithValue("@challanqty", mainarray(5))
                            cmd.Parameters.AddWithValue("@quantity", mainarray(5))
                            cmd.Parameters.AddWithValue("@totalsqrfit", mainarray(6))
                            'Dim glasscode = ExecuteQuery("SELECT code from Glassmaster where glassname = '" + ddlitem.Text + "'")
                            cmd.Parameters.AddWithValue("@Glasscode", mainarray(0))
                            cmd.Parameters.AddWithValue("@vendor_id", intvendor)
                            cmd.Parameters.AddWithValue("@po_date", hdnPoDate.Value)
                            cmd.Parameters.AddWithValue("@po_no", hdnPoNo.Value)
                            cmd.Parameters.AddWithValue("@po_type", hdnPOtype.Value)
                            Con.Open()
                            cmd.ExecuteNonQuery()
                            Con.Close()
                            Response.Write("<script>alert('Saved Successfuly');window.location.href='GlassReceive.aspx'</script>")

                            Con.Open()
                            Dim strpenqty As Integer = ExecuteQuery("SELECT po_details.pen_qty from po_details INNER JOIN po_master on po_master.po_id = po_details.po_id where po_master.po_no = '" + hdnPoNo.Value + "' and PO_Master.Gflag = '1'") ' inner join po_master PO_master ON PO_Master.po_id = po_details.po_id inner join store_master ON store_master.po_no = po_master.po_no inner join store_master_detail ON store_master_detail.store_id = store_master.store_id  where PO_Master.po_no = '" + hdnPoNo.Value + "'  and PO_Master.Gflag = '1'")

                            'Dim strpenqty As String = ExecuteQuery("SELECT cast(po_details.pen_qty as numeric) - SUM(cast(store_master_detail.total_qty as numeric)) as Pen from po_details inner join po_master PO_master ON PO_Master.po_id = po_details.po_id inner join store_master ON store_master.po_no = po_master.po_no inner join store_master_detail ON store_master_detail.store_id = store_master.store_id  where PO_Master.po_no = '" + hdnPoNo.Value + "'  and PO_Master.Gflag = '1' group by po_details.pen_qty")
                            'SqlCommand(cmd = New SqlCommand("UPDATE "))
                            Con.Close()
                            Hid_Rec.Value = ""
                        End If
                    Next
                End If

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
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

        'Protected Sub txtlfno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtlfno.TextChanged

        'End Sub      
    End Class
End Namespace
