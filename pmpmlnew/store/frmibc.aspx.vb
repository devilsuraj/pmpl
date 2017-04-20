Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT

    Partial Class frmibc
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Public strVendor As String = ""
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            btnSubmit.Attributes.Add("onclick", "return validate();")
            Session("MenuId") = 10
            If Not IsPostBack Then
                Fill_Combo("bank_id", "bank_name", "bank_master", ddlbank, Con, "", "select")
                dtinfodate.Text = Now.Date
                dtintimateDate.Text = Now.Date
                dtinvoicedate.Text = Now.Date
                dtlastdate.Text = Now.Date
                dtibc.Text = Now.Date
                DTLrdate.Text = Now.Date


                ' bdpPoDate.Text = Now.Date.ToString("dd-MM-yyyy")



            End If


        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = Con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try


                Dim poarray As Array = Split(txtpono.Text, " | ")

                Dim intvendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Text & "' ")



                cmd = New SqlCommand("Ins_ibc", Con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ibc_date", dtibc.Text)
                cmd.Parameters.AddWithValue("@bankid", ddlbank.SelectedValue)
                cmd.Parameters.AddWithValue("@intimateno", txtintimateno.Text)
                cmd.Parameters.AddWithValue("@intimate_date", dtintimateDate.Text)
                cmd.Parameters.AddWithValue("@intimate_rec_date", dtinfodate.Text)
                cmd.Parameters.AddWithValue("@amt_involved ", txtamtinvolved.Text)
                cmd.Parameters.AddWithValue("@last_payment_date", dtlastdate.Text)
                cmd.Parameters.AddWithValue("@materail_detail", hdnmaterial_detail.Value)
                cmd.Parameters.AddWithValue("@vendor_id", intvendor)
                cmd.Parameters.AddWithValue("@po_type", poarray(0))
                cmd.Parameters.AddWithValue("@po_no", poarray(1))
                cmd.Parameters.AddWithValue("@po_date", hdnPoDate.Value)
                cmd.Parameters.AddWithValue("@invoice_no ", txtinvoiceno.Text)
                cmd.Parameters.AddWithValue("@invoice_date ", dtinvoicedate.Text)
                cmd.Parameters.AddWithValue("@invoice_amt", txtinvoiceamt.Text)
                cmd.Parameters.AddWithValue("@release_amt ", txtreleaseamount.Text)
                cmd.Parameters.AddWithValue("@terms_payment ", txtpaymentterms.Text)
                cmd.Parameters.AddWithValue("@bc_charges ", txtbccharge.Text)
                cmd.Parameters.AddWithValue("@other ", txtothers.Text)

                'cmd.Parameters.AddWithValue("@rate_po ", txtratespurchase.Text)
                'cmd.Parameters.AddWithValue("@chng_rate ", txtchnginrate.Text)
                'cmd.Parameters.AddWithValue("@qty_dmnd ", txtqtydmnd.Text)
                'cmd.Parameters.AddWithValue("@qty_rec ", txttotqtyrec.Text)


                cmd.Parameters.AddWithValue("@lr_no", txtLrno.Text)
                cmd.Parameters.AddWithValue("@lr_date", DTLrdate.Text)



                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                Con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                Con.Close()


                Response.Redirect("../report/printibc.aspx?ibcid=" & maxid & "")


            Catch ex As Exception

            End Try
        End Sub

        
        Protected Sub txtintimateno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtintimateno.TextChanged

        End Sub
    End Class

End Namespace

