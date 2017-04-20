Namespace KDMT
    Partial Class rptissuereport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim TotalCon As Integer = 0
        Dim TotalItem As Integer = 0
        Dim TotalItemPer As Double = 0
        Dim TotalConPer As Double = 0
        Dim itemcount As Integer = 0

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Table1.Visible = False
                Try
                    Dim Clas As String = Request.QueryString("Cls")
                    Dim fromdate As String = Request.QueryString("FDate")
                    Dim todate As String = Request.QueryString("TDate")
                    Dim drpType As String = Request.QueryString("drpType")
                    Dim drbtext As String = Request.QueryString("drbtext")

                    Lbldrbtype.Text = drbtext

                    lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                    lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                    lblClass.Text = Clas
                    'If Clas = "A" Or Clas = "a" Then
                    '    lblACRange.Text = "RS.30000/- & above"
                    'ElseIf Clas = "B" Or Clas = "b" Then
                    '    lblACRange.Text = "Between Rs.4001/- & Rs.29999"
                    'ElseIf Clas = "C" Or Clas = "c" Then
                    '    lblACRange.Text = "Upto Rs.4000/-"
                    'End If
                    'BindGrid(grdstock, con, "VIEW_ABC '" & fromdate & "','" & todate & "','" & Clas & "'")
                    BindGrid(grdstock, con, "VIEW_ABC '" & drpType & "','" & Clas & "','04/01/2013','08/01/2013'")

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If

                Catch ex As Exception

                End Try
            End If
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            Dim fromdate As String = Request.QueryString("fromdate")
            Dim todate As String = Request.QueryString("todate")
            Response.Redirect("excelABCreport.aspx?fromdate=" & BDPLite1.SelectedDate & "&Todate=" & BDPLite2.SelectedDate & "")
        End Sub

        Protected Sub grdstock_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdstock.ItemCommand
            Dim Total As Integer = 0
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound

            Select e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))

                    TotalCon = TotalCon + CDbl(e.Item.Cells(6).Text)

                    TotalConPer = TotalConPer + CDbl(e.Item.Cells(7).Text)
                    itemcount = itemcount + 1
                Case ListItemType.Footer
                    '        'Use the footer to display the summary row.


                    e.Item.Cells(6).Text = Format("##,###", TotalCon)
                    e.Item.Cells(7).Text = TotalConPer.ToString("0.00") 'Format("##,###", TotalConPer)
                    lblACRange.Text = TotalCon
                    lbltotalitems.Text = itemcount
            End Select
        End Sub
         

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                BindGrid(grdstock, con, "VIEW_ABC '" & fromdate & "','" & todate & "'")

                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdstock_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdstock.PreRender
           
        End Sub
    End Class
End Namespace