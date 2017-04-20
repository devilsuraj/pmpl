Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class rpt_fsm_pendingpo
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String
        Dim item As String = ""
        Dim itemname As String = ""
        Dim rackno As String = ""
        Dim binno As String = ""
        Dim partno As String = ""
        Dim stockqty As String = ""
        Dim serial_no As Integer = 0


        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

            If Page.IsPostBack = False Then
            Else

                cryshow()

            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try


                If Not IsPostBack Then

                    drbType.SelectedValue = Request.QueryString("drbType")
                    ddlmoving.SelectedValue = Request.QueryString("movingtype")

                    lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                    lblimovingtype.Text = "Item Type  : " + ddlmoving.SelectedItem.Text
                    ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                    'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                    'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                    'If Page.IsPostBack Then
                    BindGrid(grdstock, con, "[view_item_summary_moving] '04/01/2013' ,'" & Now.Date & "','" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "'")

                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Table1.Visible = True
            divcry.Visible = False
            Try


                'Dim fromdate As String = BDPLite1.SelectedDate
                'Dim todate As String = BDPLite2.SelectedDate

                lblcategory.Text = "Category  : " + drbType.SelectedItem.Text
                lblimovingtype.Text = "Item Type  : " + ddlmoving.SelectedItem.Text
                ' lblcons_stock.Text = "Consumption and Stock Type  : " + ddl_cons_stock.SelectedItem.Text
                'lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
                'lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
                'If Page.IsPostBack Then
                BindGrid(grdstock, con, "[view_item_summary_moving] '04/01/2013' ,'" & Now.Date & "','" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
            End Select

            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then

                If e.Item.Cells(12).Text <> item Then
                    item = e.Item.Cells(12).Text
                    serial_no = serial_no + 1
                    e.Item.Cells(0).Text = serial_no



                Else
                    e.Item.Cells(0).Text = ""
                    e.Item.Cells(1).Text = ""
                    e.Item.Cells(2).Text = ""
                    e.Item.Cells(3).Text = ""
                    e.Item.Cells(4).Text = ""
                    e.Item.Cells(5).Text = ""
                End If


            End If
        End Sub

        Protected Sub btncry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btncry.Click

            Table1.Visible = False
            divcry.Visible = True
            Try
                Dim dt As DataTable
                dt = GetDatatTable("[view_item_summary_moving] '04/01/2013' ,'" & Now.Date & "','" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "'")
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Dim crt As New ReportDocument
                    crt.Load(Server.MapPath("item_fsm.rpt"))
                    crt.SetDataSource(dt)
                    crt.SetParameterValue("dr", drbType.SelectedItem.Text)
                    crt.SetParameterValue("dd", ddlmoving.SelectedItem.Text)
                    crt_fsm.ReportSource = crt
                End If
            Catch ex As Exception
            End Try
        End Sub
        Public Sub cryshow()
            Table1.Visible = False
            divcry.Visible = True
            Try
                Dim dt As DataTable
                dt = GetDatatTable("[view_item_summary_moving] '04/01/2013' ,'" & Now.Date & "','" & drbType.SelectedValue & "','" & ddlmoving.SelectedValue & "'")
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                Else
                    Dim crt As New ReportDocument
                    crt.Load(Server.MapPath("item_fsm.rpt"))
                    crt.SetDataSource(dt)
                    crt.SetParameterValue("dr", drbType.SelectedItem.Text)
                    crt.SetParameterValue("dd", ddlmoving.SelectedItem.Text)
                    crt_fsm.ReportSource = crt
                End If
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace

