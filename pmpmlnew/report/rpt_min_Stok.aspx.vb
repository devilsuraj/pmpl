Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rpt_min_Stok
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
            crydv.Visible = False
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

                    BindGrid(grdstock, con, "[view_item_summary_moving] '" & Format(Convert.ToDateTime(fromdate), "MM/dd/yy") & "' ,'" & Format(Convert.ToDateTime(todate), "MM/dd/yy") & "','" & drbType.SelectedValue & "','" & ddlresulttype.SelectedValue & "'")




                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
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
                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))



            End Select
        End Sub

        Protected Sub btncry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncry.Click
            crydv.Visible = True
            Table1.Visible = False
            Session("minstkdt") = ""
            Session("mincat") = ""
            Session("frommin") = ""
            Session("tomin") = ""
            Try
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate

                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text

                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")



                If BDPLite1.SelectedDate = Now.Date Then
                    Response.Write("<script>alert('Please Select Proper Date');</script>")
                    '                    Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                Else

                    Dim dt As New DataTable
                    dt = GetDatatTable("[view_item_summary_moving] '" & fromdate & "' ,'" & todate & "','" & drbType.SelectedValue & "','" & ddlresulttype.SelectedValue & "'")
                    Session("minstkdt") = dt
                    If dt.Rows.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        crydv.Visible = False
                        Table1.Visible = False
                    Else
                        Session("mincat") = drbType.SelectedItem.Text
                        Dim cryRpt As New ReportDocument
                        cryRpt.Load(Server.MapPath("item_min_stock.rpt"))
                        cryRpt.SetDataSource(dt)
                        cryRpt.SetParameterValue("category", Session("mincat"))
                        If BDPLite1.SelectedDate = "#12:00:00 AM#" Then
                            cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(Now.Date()), "dd/MM/yy"))
                            Session("frommin") = "#12:00:00 AM#"
                        Else
                            cryRpt.SetParameterValue("frm", Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy"))
                            Session("frommin") = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yy")
                        End If
                        If BDPLite2.SelectedDate = "#12:00:00 AM#" Then
                            cryRpt.SetParameterValue("to", Now.Date())
                            Session("tomin") = "#12:00:00 AM#"
                        Else
                            cryRpt.SetParameterValue("to", Format(Convert.ToDateTime(todate), "dd/MM/yy"))
                            Session("tomin") = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yy")
                        End If

                        crst_min_stock.ReportSource = cryRpt
                        crst_min_stock.EnableDatabaseLogonPrompt = False


                    End If
                End If
            Catch ex As Exception

            End Try
        End Sub

        Public Sub cryshow()
            Try

                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_min_stock.rpt"))
                cryRpt.SetDataSource(Session("minstkdt"))
                cryRpt.SetParameterValue("category", Session("mincat"))
                If Session("frommin") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("frm", Now.Date())
                Else
                    cryRpt.SetParameterValue("frm", Session("frommin"))

                End If
                If Session("tomin") = "#12:00:00 AM#" Then
                    cryRpt.SetParameterValue("to", Now.Date())
                Else
                    cryRpt.SetParameterValue("to", Session("tomin"))

                End If
                crst_min_stock.ReportSource = cryRpt
                crst_min_stock.EnableDatabaseLogonPrompt = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class

End Namespace
