Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT

    Partial Class report_rpt_minlavel_zero
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

                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                'lblimovingtype.Text = "Item Type  : " + ddlmoving.SelectedItem.Text
                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then

                If BDPLite1.SelectedDate = Now.Date Then
                    Response.Write("<script>alert('Please Select Proper Date');</script>")
                    '                    Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                Else

                    BindGrid(grdstock, con, "[view_item_summary_moving] '" & fromdate & "' ,'" & todate & "','" & drbType.SelectedValue & "' , '" & drblevel.SelectedValue & "' ")

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

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
            End Select
            'If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then
           
            Select Case CType(e.Item.Cells(8).Text, String)

                Case Is = 0
                    ' e.Item.Cells(8).BackColor = Drawing.Color.Yellow
                    '  e.Item.Cells(8).ForeColor = Drawing.Color.Black
                    ' If (e.Item.Cells(8).Text = 0) Then
                    e.Item.Cells(8).BackColor = Drawing.Color.Red
                    e.Item.Cells(8).ForeColor = Drawing.Color.White


            End Select
            Select Case CType(e.Item.Cells(9).Text, String)
                Case Is = 1
                    If e.Item.Cells(9).Text = 1 And e.Item.Cells(8).Text <> 0 Then
                        e.Item.Cells(8).BackColor = Drawing.Color.Yellow
                        e.Item.Cells(8).ForeColor = Drawing.Color.Black
                    End If
                    'e.Item.Cells(8).BackColor = Drawing.Color.Red
            End Select
            Select Case CType(e.Item.Cells(9).Text, String)
                Case Is = 0
                    If e.Item.Cells(9).Text <> 1 And e.Item.Cells(9).Text = 0 And e.Item.Cells(8).Text <> 0 Then

                        e.Item.Cells(8).BackColor = Drawing.Color.Green
                        e.Item.Cells(8).ForeColor = Drawing.Color.White


                    End If

            End Select
        End Sub

        Protected Sub btnCry0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry0.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace
