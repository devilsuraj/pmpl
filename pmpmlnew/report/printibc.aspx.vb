Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class printibc
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Public strVendor As String = ""
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dt As DataTable

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Dim ibcid As Integer = Request.QueryString("ibcid")
                Dim ibcform As String = ""
                ibcform = Request.QueryString("ibcform")
                If ibcform = "" Then
                    htmlchallan.Text = "<a href='../store/frmibc.aspx' class='ctrl'>Back</a>"

                End If


                cmd = New SqlCommand("view_ibc_details '" & ibcid & "'", Con)
                'cmd.CommandType = CommandType.StoredProcedure
                'cmd.Parameters.AddWithValue("@type", "'1'")
                'cmd.Parameters.AddWithValue("@poid", "'113'")
                '   cmd.Parameters.AddWithValue("@vendorid", CONT)
                DA = New SqlDataAdapter(cmd)
                dt = New DataTable
                DA.Fill(dt)

                If dt.Rows.Count <> 0 Then
                    lblbank.Text = dt.Rows(0)("bank_name").ToString()
                    lblintimationno.Text = dt.Rows(0)("intimateno").ToString() + " , " + dt.Rows(0)("intimate_date").ToString()
                    lblintrecon.Text = dt.Rows(0)("intimate_rec_date").ToString()

                    lblamtinvolved.Text = dt.Rows(0)("amt_involved").ToString()
                    lbllastdate.Text = dt.Rows(0)("last_payment_date").ToString()
                    lblmaterial_detail.Text = dt.Rows(0)("material_detail").ToString()

                    lblsender.Text = dt.Rows(0)("vendor_name").ToString()
                    lblinvoice.Text = dt.Rows(0)("invoice_no").ToString() + " / " + dt.Rows(0)("invoice_date").ToString() + " , " + dt.Rows(0)("invoice_amt").ToString()

                    lblLrnoLrdate.Text = dt.Rows(0)("lr_no").ToString() + " / " + dt.Rows(0)("lr_date").ToString()

                    lblreleaseamt.Text = dt.Rows(0)("release_amt").ToString()
                    lblpaymentterms.Text = dt.Rows(0)("terms_payment").ToString()
                    lblbccharges.Text = dt.Rows(0)("bc_charges").ToString()
                    lblothers.Text = dt.Rows(0)("other").ToString()

                    'lblratespurordr.Text = dt.Rows(0)("rate_po").ToString()
                    'lblchngrate.Text = dt.Rows(0)("chng_rate").ToString()
                    'lblqtydmnd.Text = dt.Rows(0)("qty_dmnd").ToString()
                    'lbltotreceived.Text = dt.Rows(0)("qty_rec").ToString()
                End If
            End If
        End Sub
    End Class
End Namespace
