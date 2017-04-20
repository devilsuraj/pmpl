Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rpt_ClaimRejection
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        '
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End If

        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim dt As New DataTable
                'Dim fromdate As String = BDPLite1.SelectedDate
                'Dim todate As String = BDPLite2.SelectedDate
                'Label3.Text = "( " + IIf(ddldepttype.SelectedValue = "SP", "Spare Parts", "Hardware") + " )"
                Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                Label2.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                dt = GetDatatTable("View_CliamRejMaster '" & vendor & "','" & txtchallanno.Text & "'")
                For i = 0 To dt.Rows.Count - 1
                    lblSupName.Text = dt.Rows(i).Item("vendor_name")
                    lblBlNo.Text = dt.Rows(i).Item("claimno")

                    lblBlDT.Text = dt.Rows(i).Item("claimdate")
                    lblChNo.Text = dt.Rows(i).Item("Challan_No")
                    lblChDT.Text = dt.Rows(i).Item("Challan_Date")

                    'lbldrbdate.Text = "DRB Date :" + dt.Rows(0).Item("drb_date")
                    lblOrdNo.Text = dt.Rows(i).Item("PO_type") + " " + dt.Rows(i).Item("PO_No")
                    lblOrdDT.Text = dt.Rows(i).Item("PO_Date")
                    lblRecNo.Text = dt.Rows(0).Item("Rec_No")
                    lblRecDate.Text = dt.Rows(0).Item("Rec_Date")
                    'lblPMPLNo.Text = dt.Rows(i).Item("vendor_name")
                    ' lblSerNo.Text = dt.Rows(i).Item("Store_Id")
                Next
                BindGrid(grdstock, con, "View_CliamRejMasterDetails '" & vendor & "','" & txtchallanno.Text & "'")
                'BindGrid(grdstock, con, "VIEW_cont_receive_report_Print '" & ddldrbtype.SelectedValue & "','" & txtdrbno.Text & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception
            Finally
                ' strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub
    End Class
End Namespace
