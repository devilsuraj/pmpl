Imports System.Data.SqlClient
Namespace kdmt
    Partial Class diesel_indent
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strDepot As String = ""
        Public strVendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            strVendor = getAutoCompleteList("select fuel_vendor_desc from Fuel_vendor order by fuel_vendor_desc", "fuel_vendor_desc")
            strDepot = getAutoCompleteList("select cont_name from contractor_master order by cont_name", "cont_name")
            If Page.IsPostBack = False Then
                Try
                    btnSubmit.Attributes.Add("onclick", "return validate();")

                    'strVendor = getAutoCompleteList("select fuel_vendor_desc  from  fuel_vendor order by fuel_vendor_desc", "fuel_vendor_desc")

                    'ExecuteQuery ("select * from "
                    bdpchqdate.SelectedDate = Now.Date
                    bdptankerdate.SelectedDate = Now.Date

                Catch ex As Exception

                End Try
                maxid()
            End If

        End Sub
        Sub maxid()
            Dim indentId As Integer = ExecuteQuery("SELECT isnull(max(adv_no),0)  FROM Indent_diesel  ")
            If indentId = 0 Then
                txtindentno.Text = 1
            Else
                txtindentno.Text = indentId + 1
            End If
        End Sub
        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                If txtvendor.Text = "" Or txtdepot.Text = "" Or txtamount.Text = "" Or txtchqno.Text = "" Then
                    Response.Write("<script>alert('Please Enter All Field ');</script>")
                Else
                    cmd = New SqlCommand("Ins_indent_Master", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    Dim vendorid As Integer = ExecuteQuery("select fuel_ven_id from Fuel_vendor where fuel_vendor_desc='" & txtvendor.Text & "'")
                    Dim depoid As Integer = ExecuteQuery("select cont_id from contractor_master where cont_name='" & txtdepot.Text & "'")
                    cmd.Parameters.AddWithValue("@adv_no", txtindentno.Text)

                    cmd.Parameters.AddWithValue("@adv_chq_date", bdpchqdate.SelectedDate)
                    cmd.Parameters.AddWithValue("@vendor_id", vendorid)
                    cmd.Parameters.AddWithValue("@depo_id", depoid)
                    cmd.Parameters.AddWithValue("@amount", txtamount.Text)
                    cmd.Parameters.AddWithValue("@chq_no", txtchqno.Text)
                    cmd.Parameters.AddWithValue("@tanker_date", bdptankerdate.SelectedDate)
                    cmd.Parameters.AddWithValue("@indent_user", Session("UserId"))

                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()

                    maxid()
                    bdpchqdate.SelectedDate = Now.Date
                    txtvendor.Text = ""
                    txtdepot.Text = ""
                    txtamount.Text = ""
                    txtchqno.Text = ""
                    bdptankerdate.SelectedDate = Now.Date
                    Response.Write("<script>alert('Saved Successfuly');</script>")

                End If
            Catch ex As Exception

            End Try
        End Sub
    End Class

End Namespace
