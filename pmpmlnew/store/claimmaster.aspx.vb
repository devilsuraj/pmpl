Imports System.Data.SqlClient
Namespace KDMT
    Partial Class claimmaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlClient.SqlDataAdapter
        Public strSubRackNo As String = ""
        Public strVendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            txt_ClimNo.Text = ExecuteQuery("max_Claimno")
            btnsubmit.Attributes.Add("Onclick", "return validate()")
            Session("MenuId") = 10
            If Not IsPostBack Then
                strVendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                bdpclaimdate.Text = Now.Date()
                tblmain.Visible = False

            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                BindGrid(dgresult, con, "view_claimitem '" & txtvendor.Text & "','" & txtchallanno.Text & "'")
                tblmain.Visible = True
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound


            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
                Dim txtclaimrejqty As TextBox = CType(e.Item.Cells(8).FindControl("txtclaimrejqty"), TextBox)

                txtclaimrejqty.Attributes.Add("Onblur", "checkqty('" + txtclaimrejqty.ClientID + "')")

            End If
        End Sub
        Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
            Try
                Dim vendor As Integer = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  =  '" + txtvendor.Text + "'")
                For i = 0 To dgresult.Items.Count - 1

                    Dim txtxlaimqty As TextBox = dgresult.Items(i).Cells(8).FindControl("txtclaimrejqty")
                    Dim txtclaimreason As TextBox = dgresult.Items(i).Cells(9).FindControl("txtclaimreason")
                    Dim ddlclaimtype As DropDownList = dgresult.Items(i).Cells(9).FindControl("ddlclaim")

                    If txtxlaimqty.Text > 0 Then

                        cmd = New SqlCommand("UPDATE_claimdetail", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@CLAIMID", dgresult.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@Claimno", txt_ClimNo.Text)
                        cmd.Parameters.AddWithValue("@claimqty", txtxlaimqty.Text)
                        cmd.Parameters.AddWithValue("@Claimreason", txtclaimreason.Text)
                        cmd.Parameters.AddWithValue("@claimtype", ddlclaimtype.SelectedValue)
                        cmd.Parameters.AddWithValue("@claimdate", bdpclaimdate.Text)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        ' Call Show_Msg(Page, "Saved Successfuly", "storemaster.aspx")

                        con.Close()
                    End If
                Next
                Response.Write("<script>alert('Saved Successfuly');window.location.href='claimmaster.aspx'</script>")
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
