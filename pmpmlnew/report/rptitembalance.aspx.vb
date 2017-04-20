Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Namespace KDMT
    Partial Class rptitembalance
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

            If Page.IsPostBack = False Then
            Else
                cryshow()
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date
                Table1.Visible = False

            End If
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
            End Select
            'If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then

            Select Case CType(e.Item.Cells(7).Text, String)
                Case Is = 0
                    e.Item.Cells(7).BackColor = Drawing.Color.Red
                    e.Item.Cells(7).ForeColor = Drawing.Color.White                     'Case Is = 10
                    '    e.Item.Cells(7).BackColor = Drawing.Color.Orange
                    'e.Item.BackColor = Drawing.Color.Red
            End Select
            ' End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                divcryrpt.Visible = False
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite1.SelectedDate
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                BindGrid(grdstock, con, "view_available_itemstock '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "'")
                If grdstock.Items.Count = 0 Then
                    'Session("df") = grdstock.DataSource
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btncrt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncrt.Click
            Table1.Visible = False
            divcryrpt.Visible = True
            Session("itemalance") = ""
            Session("val") = ""
            Session("val") = drpTypeOfItems.SelectedItem.Text
            Try
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim val As String
                'val = getval("val")
                val = Session("val")
                Dim dt As New DataTable
                dt = GetDatatTable("view_available_itemstock '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "'")
                Session("itemalance") = dt
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_bal.rpt"))
                cryRpt.SetDataSource(dt)
                cryRpt.SetParameterValue("item", val)
                crst_item_bal.ReportSource = cryRpt

                crst_item_bal.EnableDatabaseLogonPrompt = False

                divcryrpt.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                Response.Write(ex.Message)

            End Try

        End Sub
        Public Sub cryshow()
            Try
                Dim fromdate As String = BDPLite1.SelectedDate

                Dim val As String
                ' val = getval("val")
                val = Session("val")


                Dim dt2 As New DataTable
                dt2 = Session("itemalance")
                'dt = GetDatatTable("view_available_itemstock '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "'")
                'dt = ViewState("myTable")
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_bal.rpt"))
                cryRpt.SetDataSource(dt2)
                cryRpt.SetParameterValue("item", val)
                crst_item_bal.ReportSource = cryRpt

                crst_item_bal.EnableDatabaseLogonPrompt = False

                divcryrpt.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                'Response.Write(ex.Message)

            End Try
          
        End Sub


        'Public Function getval(ByVal val As String) As String
        '    Try

        '        ' val = Session("val")
        '    Catch ex As Exception
        '        Response.Write(ex.Message)
        '    End Try

        '    Return val
        'End Function
    End Class
End Namespace

