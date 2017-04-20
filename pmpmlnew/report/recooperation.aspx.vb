Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine

Namespace KDMT
    Partial Class recooperation
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Dim TotalItem As Double = 0
        Dim TotalItem1 As Double = 0
        Dim TotalItem2 As Double = 0
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then
            Else
                cryshow()
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        End Sub


        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Table1.Visible = True
            divcry.Visible = False
            Try

                Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & ddlitem.Text & "','" & txtlfno.Text & "','" & txtPartNo.Text & "'")
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate
                ' Dim CONT As Integer = DropDownList1.SelectedValue
                Dim item As String = ""
                Dim rack_no As String = ""
                Dim subrack_no As String = ""
                Dim part_no As String = ""
                Dim category As String = ""
                Dim stock As String = ""

                Dim dr As SqlClient.SqlDataReader
                Dim strSql As String = "view_item_detail '" & itemcode & "'"
                'If (ConnectionState.Closed) Then

                'End If
                con.Open()
                Dim cmd As New SqlClient.SqlCommand(strSql, con)
                dr = cmd.ExecuteReader
                'dr.Read()
                If dr.Read Then
                    item = dr(0)
                    rack_no = dr(1)
                    subrack_no = dr(2)
                    part_no = dr(3)
                    category = dr(4)
                    stock = dr(5)
                End If



                cmd.Dispose()
                dr.Close()

                lblname.Text = "Nomenclature  : " + item + ""
                lbllf.Text = "Lf No : " + rack_no + ""
                lblbin.Text = "Bin No : " + subrack_no + ""
                lblpart.Text = "Part No : " + part_no + ""
                lblcat.Text = "Category : " + category + ""
                lblcurrent.Text = "Current Stock : " + stock + ""
                ' lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then
                If (ddlitem.Text = "" And txtlfno.Text = "" And txtPartNo.Text = "") Then
                    Response.Write("<script>alert ('Please Select Item')</script>")
                Else

                    lbllast_consunp.Text = "Last Year Consumption : " + ExecuteQuery("select isnull(consumation,0)  from item_detail  where item_code = '" & itemcode & "' ")
                    BindGrid(grdstock, con, "VIEW_RECOPERATION_REPORT '" & itemcode & "'")

                End If


                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If
                'End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    TotalItem = TotalItem + CDbl(e.Item.Cells(3).Text)
                    TotalItem1 = TotalItem1 + CDbl(e.Item.Cells(4).Text)
                    TotalItem2 = TotalItem2 + CDbl(e.Item.Cells(5).Text)
                Case ListItemType.Footer
                    e.Item.Cells(1).Text = "Grand Total : "
                    e.Item.Cells(3).Text = TotalItem.ToString()
                    e.Item.Cells(4).Text = TotalItem1.ToString()
                    e.Item.Cells(5).Text = TotalItem2.ToString()
            End Select
        End Sub

        Protected Sub btncry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncry.Click
            divcry.Visible = True
            Table1.Visible = False
            Session("lastdt") = ""
            Session("copitem") = ""
            Session("lblcon") = ""
            Try

                Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & ddlitem.Text & "','" & txtlfno.Text & "','" & txtPartNo.Text & "'")
                Session("copitem") = itemcode
                Dim fromdate As String = BDPLite1.SelectedDate
                Dim todate As String = BDPLite2.SelectedDate


                If (ddlitem.Text = "" And txtlfno.Text = "" And txtPartNo.Text = "") Then
                    Response.Write("<script>alert ('Please Select Item')</script>")
                Else

                    lbllast_consunp.Text = ExecuteQuery("select isnull(consumation,0)  from item_detail  where item_code = '" & itemcode & "' ")
                    Session("lblcon") = lbllast_consunp.Text

                End If

                Dim dt0 As DataTable
                Dim dt2 As DataTable

                dt0 = GetDatatTable("view_item_detail '" & itemcode & "'")
                dt2 = GetDatatTable("VIEW_RECOPERATION_REPORT '" & itemcode & "'")
                Session("lastdt") = dt2
                If dt2.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else

                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_recooperation.rpt"))


                    cryRpt.SetDataSource(dt2)
                    Dim dr As SqlClient.SqlDataReader
                    Dim strSql As String = "view_item_detail '" & itemcode & "'"
                   
                    con.Open()
                    Dim item As String = ""
                    Dim rack_no As String = ""
                    Dim subrack_no As String = ""
                    Dim part_no As String = ""
                    Dim category As String = ""
                    Dim stock As String = ""
                    Dim cmd As New SqlClient.SqlCommand(strSql, con)
                    dr = cmd.ExecuteReader

                    If dr.Read Then
                        cryRpt.SetParameterValue("category", dr(0))
                        cryRpt.SetParameterValue("lf", dr(1))
                        cryRpt.SetParameterValue("part", dr(3))
                        cryRpt.SetParameterValue("stock", dr(5))
                        cryRpt.SetParameterValue("nm", dr(4))
                        cryRpt.SetParameterValue("bin", dr(2))
                    End If
                    cmd.Dispose()
                    dr.Close()
                    con.Close()
                    cryRpt.SetParameterValue("con", lbllast_consunp.Text)
                    crst_min_coop.ReportSource = cryRpt
                    crst_min_coop.EnableDatabaseLogonPrompt = False
                    Table1.Visible = False
                End If
            Catch ex As Exception

            End Try
        End Sub
        Public Sub cryshow()
            Try

                divcry.Visible = True
                Table1.Visible = False
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_recooperation.rpt"))
                cryRpt.SetDataSource(Session("lastdt"))
                Dim dr As SqlClient.SqlDataReader
                Dim strSql As String = "view_item_detail '" & Session("copitem") & "'"
                con.Open()
                Dim cmd As New SqlClient.SqlCommand(strSql, con)
                dr = cmd.ExecuteReader
                If dr.Read Then
                    cryRpt.SetParameterValue("category", dr(0))
                    cryRpt.SetParameterValue("lf", dr(1))
                    cryRpt.SetParameterValue("part", dr(3))
                    cryRpt.SetParameterValue("stock", dr(5))
                    cryRpt.SetParameterValue("nm", dr(4))
                    cryRpt.SetParameterValue("bin", dr(2))
                End If
                cmd.Dispose()
                dr.Close()
                con.Close()
                cryRpt.SetParameterValue("con", Session("lblcon"))
                crst_min_coop.ReportSource = cryRpt
                crst_min_coop.EnableDatabaseLogonPrompt = False
                Table1.Visible = False

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
        End Sub
    End Class
End Namespace
