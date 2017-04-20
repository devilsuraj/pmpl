Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.ReportSource
Imports System.Web.UI
Imports System.IO
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rptcontractorwisereceive
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Public strvendor As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
                Table1.Visible = False
            End If



        End Sub
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
            End Select

        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try

     
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")

                Label2.Text = "Vendor : " + (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                BindGrid(grdstock, con, "VIEW_cont_receive_report '" & fromdate & "','" & todate & "','" & vendor & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception
            Finally
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub
       


        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub


        Protected Sub Crystal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Crystal.Click
            Try


                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                Dim vendor As String = ExecuteQuery("select vendor_id  from stock_vendor  where vendor_name  ='" & txtvendor.Value & "' ")


                Dim dt As New DataTable
                dt = GetDatatTable("VIEW_cont_receive_report '" & fromdate & "','" & todate & "','" & vendor & "'")
                Dim cryRpt As New ReportDocument

                Dim cr As New ReportDocument
                cryRpt.Load(Server.MapPath("item_val.rpt"))

                ' cryRpt.SetParameterValue("itemtype", drpTypeOfItems.SelectedValue)

                cryRpt.SetDataSource(dt)


                item_view_contractwise.ReportSource = cryRpt
                item_view_contractwise.EnableViewState = True
                item_view_contractwise.EnableDatabaseLogonPrompt = False

                Table1.Visible = False
            Catch ex As Exception

            End Try




        End Sub
    End Class
End Namespace

