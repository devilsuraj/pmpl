Imports System.Data.SqlClient
Namespace KDMT
    Partial Class FastCardexReport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Dim classa As Integer = 0
        Dim classb As Integer = 0
        Dim classc As Integer = 0
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then
            Else
                'cryshow()
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                'BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                'Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                'lblimovingtype.Text = "Moving Type  : " + ddlmoving.SelectedItem.Text
                'lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then
                'If BDPLite1.SelectedDate = Now.Date Then
                '    Response.Write("<script>alert('Please Select Proper Date');</script>")
                '    'Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                'Else
                BindGrid(grdstock, con, "Item_Consumption_and_Requirement '" & todate & "','" & drbType.SelectedValue & "'") ','" & ddlmoving.SelectedValue & "'
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    divcry.Visible = False
                End If
                'End If
            Catch ex As Exception

            End Try
        End Sub
        'Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
        '    Select Case e.Item.ItemType
        '        Case ListItemType.AlternatingItem, ListItemType.Item
        '            e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
        '            e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
        '            If e.Item.Cells(1).Text = "A" Then
        '                classa = classa + 1
        '            ElseIf e.Item.Cells(1).Text = "B" Then
        '                classb = classb + 1
        '            ElseIf e.Item.Cells(1).Text = "C" Then
        '                classc = classc + 1
        '            Else
        '            End If
        '            lbla.Text = classa
        '            lblb.Text = classb
        '            lblc.Text = classc
        '            lbltotal.Text = classa + classb + classc
        '    End Select
        'End Sub


        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class

End Namespace