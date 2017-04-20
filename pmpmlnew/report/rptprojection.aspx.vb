﻿Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rptprojection
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim classa As Integer = 0
        Dim classb As Integer = 0
        Dim classc As Integer = 0

        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then

            Else
                ' cryshow()
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()

            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim fromdate As String = BDPLite1.SelectedDate

                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                lblimovingtype.Text = "Moving Type  : " + ddlmoving.SelectedItem.Text
                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")

                BindGrid(grdstock, con, "[sp_MIn_level] '" & fromdate & "' ,'" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "','" & ddlbelow.SelectedValue & "'")
                '                BindGrid(grdstock, con, "[sp_MIn_level] '" & fromdate & "'")
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
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
                    e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
                    If e.Item.Cells(1).Text = "A" Then
                        classa = classa + 1
                    ElseIf e.Item.Cells(1).Text = "B" Then
                        classb = classb + 1

                    Else
                        classc = classc + 1

                    End If
                    lbla.Text = classa
                    lblb.Text = classb
                    lblc.Text = classc
                    lbltotal.Text = classa + classb + classc




            End Select
        End Sub
        Protected Sub btncry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncry.Click
            Try
                Dim fromdate As String = BDPLite1.SelectedDate

                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                Session("lblcat") = ""
                Session("lblcat") = drbType.SelectedItem.Text
                Session("lblmvtp") = ""
                Session("lblmvtp") = ddlmoving.SelectedItem.Text
                lblimovingtype.Text = "Moving Type  : " + ddlmoving.SelectedItem.Text
                lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")

                'If BDPLite1.SelectedDate = Now.Date Then
                '    Response.Write("<script>alert('Please Select Proper Date');</script>")
                '    'Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                'Else
                Dim dt As New DataTable
                dt = GetDatatTable("[sp_MIn_level] '" & fromdate & "' ,'" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "','" & ddlbelow.SelectedValue & "'")
                Session("itemmov") = dt
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    divcry.Visible = False
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    ' If Not IsPostBack() Then
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("projectionreport.rpt"))
                    cryRpt.SetDataSource(dt)
                    ' cryRpt.SetParameterValue("ctgry", Session("lblcat"))
                    'cryRpt.SetParameterValue("type", Session("lblmvtp"))
                    crst_item_move.ReportSource = cryRpt
                    Session.Add("cryRpt", cryRpt)
                    crst_item_move.EnableDatabaseLogonPrompt = False
                    divcry.Visible = True
                    Table1.Visible = False
                    ' Else
                    crst_item_move.ReportSource = Session("cryRpt")
                    'crst_item_move.EnableDatabaseLogonPrompt = False
                    ' End If

                End If

                'End If
            Catch ex As Exception
            End Try
        End Sub
        Public Sub cryshow()
            Try
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("projectionreport.rpt"))
                cryRpt.SetDataSource(Session("itemmov"))
                ' cryRpt.SetParameterValue("itemid", Session("lblcat"))
                'cryRpt.SetParameterValue("type", Session("lblmvtp"))
                crst_item_move.ReportSource = cryRpt
                crst_item_move.EnableDatabaseLogonPrompt = False

                divcry.Visible = True
                Table1.Visible = False
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        End Sub
    End Class
End Namespace