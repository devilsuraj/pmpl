Imports System.Data.SqlClient
Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine

Namespace KDMT
    Partial Class rptcontractorwise
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

            If Page.IsPostBack = True Then
                cryshow()
            Else
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Call Fill_Combo("cont_id", "cont_name", "contractor_master", DropDownList1, con, "", "Select")
                Table1.Visible = False
            Else
                'cryshow()
            End If
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
            End Select
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            divcrt.Visible = False
            Table1.Visible = True
            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Dim CONT As Integer = DropDownList1.SelectedValue

            lblcontractor.Text = "Depot: " + DropDownList1.SelectedItem.Text
            lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
            lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
            'If Page.IsPostBack Then
            'BindGrid(grdstock, con, "VIEW_cont_report '" & fromdate & "' ,'" & todate & "','" & CONT & "','" & drpTypeOfItems.SelectedValue & "'")
            BindGrid(grdstock, con, "VIEW_cont_report '" & fromdate & "' ,'" & todate & "','" & CONT & "','" & drpTypeOfItems.SelectedValue & "','" & DropDownList2.SelectedValue & "'")
            If grdstock.Items.Count = 0 Then
                Response.Write("<script>alert ('Record Not Found') </script>")
                Table1.Visible = False
            Else
                Table1.Visible = True
            End If
            'End If
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub

        Protected Sub crystal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles crystal.Click
            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Dim CONT As Integer = DropDownList1.SelectedValue
            Session("itemcontractdt") = ""
            Session("depotval") = ""
            Session("fromcontract") = ""
            Session("tocontract") = ""
            Session("depotval") = DropDownList1.SelectedItem.Text
            Session("fromcontract") = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
            Session("tocontract") = Format(Convert.ToDateTime(todate), "dd/MM/yy")

            divcrt.Visible = True
            Table1.Visible = False
            Dim nm As String = DropDownList1.SelectedItem.Text

            Try
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                Dim dt As New DataTable
                dt = GetDatatTable("VIEW_cont_report '" & fromdate & "' ,'" & todate & "','" & CONT & "','" & drpTypeOfItems.SelectedValue & "'")
                Session("itemcontractdt") = dt
                If dt.Rows.Count <= 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    item_view_contract.Visible = False
                    item_view_contract.EnableDatabaseLogonPrompt = False
                    Table1.Visible = False
                    divcrt.Visible = True
                Else

                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_contract.rpt"))
                    cryRpt.SetDataSource(dt)
                    cryRpt.SetParameterValue("@cont", Session("depotval"))
                    cryRpt.SetParameterValue("@dt", Session("fromcontract"))
                    cryRpt.SetParameterValue("dtto", Session("tocontract"))
                    item_view_contract.EnableDatabaseLogonPrompt = False
                    item_view_contract.EnableParameterPrompt = False
                    item_view_contract.EnableViewState = True
                    item_view_contract.ReportSource = cryRpt
                    item_view_contract.RefreshReport()
                    item_view_contract.DataBind()
                    Table1.Visible = False
                    divcrt.Visible = True
                End If
            Catch ex As Exception
            End Try

        End Sub
        Private Sub cryshow()
            divcrt.Visible = True
            Table1.Visible = False
            Try
                Dim dt As New DataTable
                dt = Session("itemcontractdt")
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_contract.rpt"))
                cryRpt.SetDataSource(dt)
                item_view_contract.EnableDatabaseLogonPrompt = False

                item_view_contract.ReportSource = cryRpt
                item_view_contract.Visible = True
                item_view_contract.RefreshReport()
                item_view_contract.DataBind()
                Table1.Visible = False
                divcrt.Visible = True
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace


