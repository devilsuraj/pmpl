Namespace KDMT
    Partial Class rptshortage
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strvendor As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strvendor = getAutoCompleteList("select fuel_vendor_desc  from Fuel_vendor order by fuel_vendor_desc", "fuel_vendor_desc")
            Try
                If Not IsPostBack Then
                    Fill_Combo("cont_id", "cont_name", "contractor_master", ddldepo, con, "", "select")
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim chq_fromdate As String = ""
                Dim chq_todate As String = ""
                Dim challan_fromdate As String = ""
                Dim challan_todate As String = ""

                If txtfuel.Text <> "" Then
                    lblvendor.Text = "Vendor Name :  " + "" + (StrConv(txtfuel.Text, VbStrConv.ProperCase))
                End If

                If ddldepo.SelectedValue <> 0 Then
                    lbldepotname.Text = "Depot : " + ddldepo.SelectedItem.Text
                End If

                If bdpadv_chqdate_from.SelectedDate <> "#12:00:00 AM#" Then
                    advcheque_fromdate.Text = "Cheque Date : " + bdpadv_chqdate_from.SelectedDate.ToString("dd/MM/yy")
                    chq_fromdate = bdpadv_chqdate_from.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If bdpadv_chqdate_to.SelectedDate <> "#12:00:00 AM#" Then
                    advcheque_todate.Text = "Cheque ToDate : " + bdpadv_chqdate_to.SelectedDate.ToString("dd/MM/yy")
                    chq_todate = bdpadv_chqdate_to.SelectedDate.ToString("MM/dd/yyyy")
                End If


                BindGrid(grdstock, con, "view_fuel_shortage_report '" & chq_fromdate.ToString() & "','" & chq_todate.ToString() & "', '" & challan_fromdate.ToString() & "','" & challan_todate.ToString() & "','" & txtfuel.Text & "','" & ddldepo.SelectedValue & "'")
                ' End If

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else

                    Table1.Visible = True
                End If
            Catch ex As Exception

            Finally
                clean()
                strvendor = getAutoCompleteList("select fuel_vendor_desc  from Fuel_vendor order by fuel_vendor_desc", "fuel_vendor_desc")
            End Try
        End Sub

        Private Sub clean()

        End Sub
    End Class
End Namespace

