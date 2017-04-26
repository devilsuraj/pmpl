Imports System.Data.SqlClient
Namespace KDMT
    Partial Class tanker_master
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Public strDepot As String = ""
        Public strVendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Session("MenuId") = 5
                btnSubmit.Attributes.Add("onclick", "return validate();")
                BindGrid(dgresult, con, "view_indent_diesel")
                btnSubmit.Visible = False
                bdpchalandate.Text = Now.Date()
            End If

        End Sub

        Protected Sub dgresult_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgresult.ItemCommand
            If e.CommandName = "select" Then
                hdnid.Value = e.CommandArgument.ToString()
                'ViewState("Save") = 2
                txtindentno.Text = e.Item.Cells(1).Text

                clean()
                btnSubmit.Visible = True

            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click



            Call fnExecuteNonQuery("update indent_diesel   set  challan_date = '" & bdpchalandate.Text & "',shortage = '" & txtshort.Text & "',short_amt = '" & txtshortamt.Text & "',challan_no = '" & txtchalanno.Text & "',rec_qty = '" & txtrec_qty.Text & "',challan_amt = '" & txtchalan_amt.Text & "',receive_user = '" & Session("UserId") & "',flag = 1    where indent_id = '" & hdnid.Value & "'")
            BindGrid(dgresult, con, "view_indent_diesel")
            clean()
            Call Show_Msg(Page, "Updated Successfully", "tanker_master.aspx")

        End Sub

        Private Sub clean()
            txtshort.Text = ""
            txtshortamt.Text = ""
            txtchalanno.Text = ""
            txtrec_qty.Text = ""
            txtchalan_amt.Text = ""
        End Sub
    End Class
End Namespace