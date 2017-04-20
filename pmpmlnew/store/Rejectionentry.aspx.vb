Imports System.Data.SqlClient
Imports System.Data
Namespace KDMT
    Partial Class store_Rejectionentry
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
            'btnSubmit.Attributes.Add("onclick", "return validatedata();")
            btnSubmit.Attributes.Add("onclick", "return ValidateSave();")
            If Not IsPostBack Then
                Dim SQL As String
                Dim SQL1 As String
                'lbldepttype.Text = (Session("Dept_type").ToString)
                hdnrwcnt.Value = 0
                'dtPODate.SelectedDate = Now.Date
                'dtOurRefNo.SelectedDate = Now.Date
                'dtYourRefNo.SelectedDate = Now.Date
                'Date1.SelectedDate = Now.Date
                'Date2.SelectedDate = Now.Date

                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                SQL = "select distinct ref_Asrtu,po_master.ref_Asrtu  from po_master  where po_master.ref_Asrtu is not null order by po_master.ref_Asrtu"
                strref_asrtu = getAutoCompleteList(SQL, "ref_Asrtu")

                SQL1 = "select top 829 special_discount,po_master.special_discount  from po_master  where po_master.special_discount is not null order by po_master.special_discount"
                strspdisc = getAutoCompleteList(SQL1, "special_discount")

                If (Session("Deptid").ToString() = "1") Then
                    'Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "' and item_id = 1")
                Else
                    'Call edit_combo(ddlCategory, "item_id", "item_name", "Item_Master", "loc_id = '" & Session("LocID") & "' and item_id <> 1")
                End If

                'ddlCategory.SelectedValue = Session("Deptid").ToString()
            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Dim i As Integer

            Dim strIndentdetails As String = hdndetail.Value
            If strIndentdetails.ToString <> "" Then
                'Dim i As Integer

                Dim myarray As Array = Split(strIndentdetails.ToString, "|")
                Dim j As Integer
                j = myarray.Length - 1
                Dim strSql As String

                For i = 0 To myarray.Length - 1
                    If myarray(i) <> "" Then
                        Dim mainarray As Array = Split(myarray(i), "^")

                        Dim strq As String = "get_Rejitemcode'" & Trim(mainarray(2)) & "','" & mainarray(0) & "'"
                        Dim Itemcode As String = ExecuteQuery(strq)
                        Dim strvendorname As String = "select Vendor_id from stock_vendor where vendor_name = '" & mainarray(3) & "' "
                        Dim strvendorid As Integer = ExecuteQuery(strvendorname)
                        'strSql = "UPDATE Indent_Request_Details SET Indent_item_code = stritemcode,Indent_bus_no = mainarray(4),Indent_Req_qty = mainarray(6) WHERE Indent_Details_Id = " & mainarray(0)
                        'fnExecuteNonQuery(strSql)
                        cmd = New SqlCommand("Ins_Rejectiondetails", Con)
                        cmd.CommandType = CommandType.StoredProcedure
                        'cmd.Parameters.AddWithValue("@po_id", maxid)
                        cmd.Parameters.AddWithValue("@VendorId", strvendorid)
                        cmd.Parameters.AddWithValue("@Challanno", mainarray(4))
                        cmd.Parameters.AddWithValue("@item_code", Itemcode)
                        cmd.Parameters.AddWithValue("@Quantity", mainarray(5))
                        cmd.Parameters.AddWithValue("@Rejdate", System.DateTime.Now)
                        cmd.Parameters.AddWithValue("@IsActive", 0)
                        Con.Open()
                        cmd.ExecuteNonQuery()

                        Con.Close()
                    End If
                Next
            End If
        End Sub
    End Class
End Namespace
