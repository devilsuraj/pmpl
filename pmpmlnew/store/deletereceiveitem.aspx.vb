Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class deletereceiveitem
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 10S
            If Page.IsPostBack = False Then
                btnSubmit.Attributes.Add("Onclick", "return validate ()")
                trgrid.Visible = False
                trbtn.Visible = False
                'Me.BDPLite1.SelectedDate = Now.Date

            End If
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click

            Try


                Dim i As Integer

                Dim delete As CheckBox

                For i = 0 To dgresult.Items.Count - 1

                    delete = dgresult.Items(i).Cells(10).FindControl("delete")
                    Dim reject As String = dgresult.Items(i).Cells(9).Text
                    Dim is_reject As Integer
                    If reject = "Yes" Then
                        is_reject = 1
                    Else
                        is_reject = 0
                    End If

                    If delete.Checked Then

                        Call fnExecuteNonQuery("delete_receive_item " & dgresult.Items(i).Cells(0).Text & ",'" & is_reject & "' ")
                    End If



                Next
                fillgrid()
            Catch ex As Exception

            End Try
        End Sub

        Private Sub fillgrid()
            Try
                BindGrid(dgresult, con, "select store_master_detail.store_id,store_detail_id,store_master_detail.item_code,convert(varchar(10),challan_date,103)challan_date,convert(varchar(10),store_master.trans_date,103)trans_date,vendor_name,challan_no,item_name,total_qty,part_no,inward_no,po_no,case reject when 1 then 'Yes' else '' end as reject,drb_no from   store_master  left outer join stock_vendor on store_master.vendor_id = stock_vendor.vendor_id join store_master_detail on store_master_detail.store_id = store_master.store_id left outer join item_detail on store_master_detail.item_code = item_detail.item_code where  challan_no ='" & txtchallan_no.Text & "'")
                If dgresult.Items.Count > 0 Then
                    trgrid.Visible = True
                    trbtn.Visible = True
                Else
                    trgrid.Visible = False
                    trbtn.Visible = False
                    Response.Write("<script>alert ('Record Not Found') </script>")
                End If
            Catch ex As Exception

            End Try

        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            Try

                fillgrid()
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
