Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rpt_act_nonact
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then

            Else
                cryshow()
            End If
        End Sub
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
                lblimovingtype.Text = "Item Type  : " + ddlmoving.SelectedItem.Text
                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then

                If BDPLite1.SelectedDate = Now.Date Then
                    Response.Write("<script>alert('Please Select Proper Date');</script>")
                    '                    Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                Else

                    BindGrid(grdstock, con, "[view_item_summary_moving] '" & Format(Convert.ToDateTime(fromdate), "MM/dd/yy") & "' ,'" & Format(Convert.ToDateTime(todate), "MM/dd/yy") & "','" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "'")

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
                    If e.Item.Cells(1).Text = "TOTAL" Then
                        e.Item.Cells(0).Text = ""
                        e.Item.Cells(1).Font.Bold = True
                        e.Item.Cells(11).Font.Bold = True

                    End If

                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))


            End Select
        End Sub

        Protected Sub btnCry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry.Click
            crydv.Visible = True
            Table1.Visible = False
            Session("itemmact") = ""
            Session("actc") = ""
            Session("actt") = ""
            Session("fromct") = ""
            Session("toct") = ""
            Try


                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                lblimovingtype.Text = "Item Type  : " + ddlmoving.SelectedItem.Text
                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")

                'If Page.IsPostBack Then

                If BDPLite1.SelectedDate = Now.Date Then
                    Response.Write("<script>alert('Please Select Proper Date');</script>")
                    '                    Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                Else

                    Dim dt As New DataTable
                    dt = GetDatatTable("[view_item_summary_moving] '" & Format(Convert.ToDateTime(fromdate), "MM/dd/yy") & "' ,'" & Format(Convert.ToDateTime(todate), "MM/dd/yy") & "','" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "'")
                    Session("itemmact") = dt
                    If dt.Rows.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        crydv.Visible = False
                        Table1.Visible = False
                    Else
                        Session("actc") = drbType.SelectedItem.Text
                        Session("actt") = ddlmoving.SelectedItem.Text
                        Dim cryRpt As New ReportDocument
                        cryRpt.Load(Server.MapPath("item_act.rpt"))
                        cryRpt.SetDataSource(dt)
                        cryRpt.SetParameterValue("category", Session("actc"))
                        cryRpt.SetParameterValue("type", Session("actt"))
                        If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                            cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(Now.Date()), "dd/MM/yy"))
                            Session("fromct") = "#12:00:00 AM#"
                        Else
                            cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy"))
                            Session("fromct") = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy")
                        End If
                        If BDPLite2.SelectedDate = "#12:00:00 AM#" Then
                            cryRpt.SetParameterValue("to", Now.Date())
                            Session("toct") = "#12:00:00 AM#"
                        Else
                            cryRpt.SetParameterValue("to", Format(Convert.ToDateTime(todate), "dd/MM/yy"))
                            Session("toct") = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yy")
                        End If
                        crst_item_act.ReportSource = cryRpt
                        crst_item_act.EnableDatabaseLogonPrompt = False


                    End If
                End If
            Catch ex As Exception

            End Try
        End Sub

        Public Sub cryshow()
            Try
                crydv.Visible = True
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_act.rpt"))
                cryRpt.SetDataSource(Session("itemmact"))
                cryRpt.SetParameterValue("category", Session("actc"))
                cryRpt.SetParameterValue("type", Session("actt"))
                If Session("fromct") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(Now.Date()), "dd/MM/yy"))
                Else
                    cryRpt.SetParameterValue("frm", Session("fromct"))

                End If
                If Session("toct") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("to", Format(Convert.ToDateTime(Now.Date()), "dd/MM/yy"))
                Else
                    cryRpt.SetParameterValue("to", Session("toct"))

                End If
                crst_item_act.ReportSource = cryRpt
                crst_item_act.EnableDatabaseLogonPrompt = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub btnCry0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCry0.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace