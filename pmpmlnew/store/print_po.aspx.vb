Imports System.Data.SqlClient
Namespace kdmt
    Partial Class print_po
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim dt As DataTable
        Dim da As SqlDataAdapter
        Dim sql19 As String
        Public strvendor As String = ""


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Session("MenuId") = 10
                Try
                    Dim poid As Integer = Request.QueryString("po_id")


                    'BindGrid(grdstock, con, "View_PO_Details '" & poid & "'")
                    BindGrid(grdstock, con, "view_po_details_po '2','1'")

                    dt = GetDatatTable("view_po_details_po '1','1'")
                   
                    'lblpayment.Text = dt.Columns("payment_Mode").ToString()
                    lblpayment.Text = dt.Rows(0)("payment_Mode").ToString()
                    lblDMA.Text = dt.Rows(0)("Discount_Material_Amout").ToString()
                    lblFright.Text = dt.Rows(0)("Fright").ToString()
                    lblBCBB.Text = dt.Rows(0)("Bank_Charges_Borne_by").ToString()
                    lblGSB.Text = dt.Rows(0)("Good_Sent_By").ToString()

                    lblDSC.Text = dt.Rows(0)("Delivery_completed_By").ToString()
                    lblRNO.Text = dt.Rows(0)("Res_No").ToString()
                    lblDTTM.Text = dt.Rows(0)("DT_Trans_Manager").ToString()
                    lblVP.Text = dt.Rows(0)("Validity_Period").ToString()
                    lblPAB.Text = dt.Rows(0)("Purchas_Authorised_By").ToString()
                    lbltotal.Text = dt.Rows(0)("total").ToString()
                    lblYear.Text = dt.Rows(0)("Year1").ToString()
                    lblBAH.Text = dt.Rows(0)("Budget_Account_HD").ToString()
                    lblBCR.Text = dt.Rows(0)("B_C_Reg").ToString()
                    lblSN.Text = dt.Rows(0)("SrNo").ToString()
                    lblPB.Text = dt.Rows(0)("Prepared_By").ToString()
                    lblCB.Text = dt.Rows(0)("Checked_By").ToString()
                    lblAuditedBy.Text = dt.Rows(0)("Audited_By").ToString()
                    lblauditoff.Text = dt.Rows(0)("Audit_officer").ToString()

                    lblCL.Text = dt.Rows(0)("CL").ToString()
                    lblDT.Text = dt.Rows(0)("DT").ToString()
                    lblInReNo.Text = dt.Rows(0)("Indent_Ref_No").ToString()
                    lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                    lblAdd1.Text = dt.Rows(0)("add1").ToString()
                    lblAdd2.Text = dt.Rows(0)("add1").ToString()
                    lblPONoStr.Text = dt.Rows(0)("po_str").ToString()
                    lblPONo.Text = dt.Rows(0)("po_no").ToString()
                    lblPoDate.Text = dt.Rows(0)("po_date").ToString()
                    lblORN.Text = dt.Rows(0)("po_our_ref_no").ToString()
                    lblYRN.Text = dt.Rows(0)("po_your_ref_no").ToString()
                    lblYRD.Text = dt.Rows(0)("po_your_ref_date").ToString()
                    lblORD.Text = dt.Rows(0)("po_our_ref_date").ToString()
                    'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()
                    'lblVendorName.Text = dt.Rows(0)("vendor_name").ToString()

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                Catch ex As Exception

                End Try

            End If
        End Sub
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
            End Select
        End Sub
    End Class
End Namespace

