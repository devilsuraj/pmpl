Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT

    Partial Class report_R_Y_G_summery
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            crydv.Visible = False
            Table1.Visible = True
            Try


                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

              
                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then

                If BDPLite1.SelectedDate = Now.Date Then
                    Response.Write("<script>alert('Please Select Proper Date');</script>")
                    '                    Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                Else

                    BindGrid(grdstock, con, "[view_red_level_summ] '" & fromdate & "' ,'" & todate & "','" & drbType.SelectedValue & "','" & 16 & "'")

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        crydv.Visible = False
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnCry0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry0.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace
