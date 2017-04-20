Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Imports System.Data
Namespace KDMT
    Partial Class rptmakewisereport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then
                divCry.Visible = False
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
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
            End Select
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click

            Try

                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite1.SelectedDate
                lblmake.Text = "(" + drpTypeOfItems.SelectedItem.Text + ")"
                'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                'lbltodate.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")

                BindGrid(grdstock, con, "[view_makewise_balance_report_sss] '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "','" & drpTypeOfItemsNa.SelectedValue & "' ")
                'BindGrid(grdstock, con, "[view_makewise_balance_report] '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "'")
                If grdstock.Items.Count = 0 Then
                    'Session("df") = grdstock.DataSource
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    divCry.Visible = False

                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnCry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry.Click
            Session("dt") = ""
            ViewState("frm") = ""
            Session("itemwise") = ""
            ViewState("valwise") = ""
            ViewState("valwise1") = ""
            ViewState("frm") = BDPLite1.SelectedDate
            ViewState("val") = drpTypeOfItems.SelectedValue
            Session("valwise") = drpTypeOfItems.SelectedItem.Text
            ViewState("val1") = drpTypeOfItemsNa.SelectedValue
            Try
                Dim dt As New DataTable
                ' dt = GetDatatTable("[view_makewise_balance_report] '" & fromdate & "','" & drpTypeOfItems.SelectedValue & "'")
                dt = GetDatatTable("[view_makewise_balance_report_sss] '" & ViewState("frm") & "','" & ViewState("val") & "' ,'" & ViewState("val1") & "' ")
                Session("itemwise") = dt
                If dt.Rows.Count = 0 Then

                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else

                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("Item_makewise.rpt"))
                    cryRpt.SetDataSource(dt)
                    cryRpt.SetParameterValue("itemname", Session("valwise"))
                    If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("dt", "")
                    Else
                        cryRpt.SetParameterValue("dt", Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy"))
                    End If
                    Session("dt") = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy")


                    crst_item_wise.ReportSource = cryRpt
                    crst_item_wise.EnableDatabaseLogonPrompt = False
                    divCry.Visible = True
                    Table1.Visible = False

                End If

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub

        Public Sub cryshow()
            Try
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("Item_makewise.rpt"))
                cryRpt.SetDataSource(Session("itemwise"))
                cryRpt.SetParameterValue("itemname", Session("valwise"))
                If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("dt", Session("dt"))
                Else
                    cryRpt.SetParameterValue("dt", "")
                End If
                crst_item_wise.ReportSource = cryRpt
                crst_item_wise.EnableDatabaseLogonPrompt = False

                divCry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace