Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Namespace KDMT
    Partial Class rptissuereport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

            If Page.IsPostBack = False Then
            Else

                crysto()

            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Table1.Visible = False
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            Dim fromdate As String = Request.QueryString("fromdate")
            Dim todate As String = Request.QueryString("todate")
            Response.Redirect("excelissuereport.aspx?fromdate=" & BDPLite1.SelectedDate & "&Todate=" & BDPLite2.SelectedDate & "")
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
                    e.Item.Cells(7).Text = (StrConv(e.Item.Cells(7).Text, VbStrConv.ProperCase))
            End Select
        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try
                Dim fromdate As String = ""
                Dim todate As String = ""
                If BDPLite1.SelectedDate <> "#12:00:00 AM#" Then
                    lblfrom.Text = "From Date : " + BDPLite1.SelectedDate.ToString("dd/MM/yy")

                    fromdate = BDPLite1.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If BDPLite2.SelectedDate <> "#12:00:00 AM#" Then
                    lbltodate.Text = "ToDate : " + BDPLite2.SelectedDate.ToString("dd/MM/yy")
                    todate = BDPLite2.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If txtindent.Text <> "" Then
                    lblindent.Text = "Indent No " + " " + txtindent.Text
                Else
                    lblindent.Text = ""
                End If
                BindGrid(grdstock, con, "VIEW_ITEMISSUE '" & txtindent.Text & "','" & fromdate & "','" & todate & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    dicsryst.Visible = False
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    dicsryst.Visible = False
                End If
            Catch ex As Exception
            End Try
        End Sub

        Protected Sub Crystal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Crystal.Click
            Try
                Dim dt As DataTable
                Session("itemissuedt") = ""
                Session("issuefrom") = ""
                Session("issueto") = ""
                Session("indent") = ""

                If BDPLite1.SelectedDate <> "#12:00:00 AM#" Then
                    Session("issuefrom") = BDPLite1.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If BDPLite2.SelectedDate <> "#12:00:00 AM#" Then
                    Session("issueto") = BDPLite2.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If txtindent.Text <> "" Then
                    Session("indent") = txtindent.Text
                Else
                    lblindent.Text = ""
                End If
                dt = GetDatatTable("VIEW_ITEMISSUE '" & Session("indent") & "','" & Session("issuefrom") & "','" & Session("issueto") & "'")
                Session("itemissuedt") = dt
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    dicsryst.Visible = False
                    Table1.Visible = False
                Else
                    Table1.Visible = False
                    dicsryst.Visible = True
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_issue.rpt"))
                    cryRpt.SetDataSource(dt)
                    viewer_item_issue.ReportSource = cryRpt
                    cryRpt.SetParameterValue("item", Session("indent"))
                    If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("frm", "")
                        Session("issuefrom") = "#12:00:00 AM#"
                    Else
                        cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy"))
                        Session("issuefrom") = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy")
                    End If
                    If BDPLite2.SelectedDate = "#12:00:00 AM#" Then
                        cryRpt.SetParameterValue("to", "")
                        Session("issueto") = "#12:00:00 AM#"
                    Else
                        cryRpt.SetParameterValue("to", Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yy"))
                        Session("issueto") = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yy")
                    End If
                    'cryRpt.SetParameterValue("from",(Format(Convert.ToDateTime(((Session("issuefrom"))), "dd/MM/yyyy")
                    'cryRpt.SetParameterValue("to", Convert.ToDateTime(Session("issueto"))) ', "dd/MM/yyyy")

                    viewer_item_issue.EnableDatabaseLogonPrompt = False
                End If
            Catch ex As Exception
            End Try
        End Sub

        Public Sub crysto()
            Try
                Table1.Visible = False
                Dim dt As DataTable
                dt = Session("itemissuedt")
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_issue.rpt"))
                cryRpt.SetDataSource(dt)
                viewer_item_issue.ReportSource = cryRpt
                cryRpt.SetParameterValue("item", Session("indent"))
                If Session("issuefrom") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(Now.Date()), "dd/MM/yy"))
                Else
                    cryRpt.SetParameterValue("frm", Session("issuefrom"))

                End If
                If Session("issueto") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("to", Format(Convert.ToDateTime(Now.Date()), "dd/MM/yy"))
                Else
                    cryRpt.SetParameterValue("to", Session("issueto"))

                End If
                'cryRpt.SetParameterValue("from", Format(Convert.ToDateTime((Session("issuefrom"))), "dd/MM/yyyy"))
                'cryRpt.SetParameterValue("to", Format(Convert.ToDateTime((Session("issueto"))), "dd/MM/yyyy"))

                viewer_item_issue.EnableDatabaseLogonPrompt = False
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace