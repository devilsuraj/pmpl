Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Namespace KDMT
    Partial Class rptreceivereport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Public strvendor As String = ""

        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            If Page.IsPostBack = False Then
            Else
                cryshow()

            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            If Not IsPostBack Then
                'Fill_Combo("vendor_id", "vendor_name", "stock_vendor", ddlvendor, con, "", "select")
                Table1.Visible = False
            End If
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click

            Response.Redirect("excelreceivereport.aspx?fromdate=" & BDPLite1.SelectedDate & "&Todate=" & BDPLite2.SelectedDate & "")
        End Sub

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
                    e.Item.Cells(6).Text = (StrConv(e.Item.Cells(6).Text, VbStrConv.ProperCase))
            End Select
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
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


                If txtchallan.Text <> "" Then
                    lblchallan.Text = "Challan No " + " " + txtchallan.Text
                Else
                    lblchallan.Text = ""

                End If
                If txtvendor.Value <> "" Then
                    lblvendor.Text = "Vendor Name " + " " + txtvendor.Value
                Else
                    lblvendor.Text = ""
                End If


                BindGrid(grdstock, con, "VIEW_ITEMRECIEVE '" & txtvendor.Value & "','" & txtchallan.Text & "','" & fromdate & "','" & todate & "'")

                'If challan <> "" And vendor = "" Then
                '    lblfrom.Text = challan
                '    lbltodate.Text = ""
                '    Label1.Text = " Challan No :- "
                '    Label2.Text = ""
                '    Label3.Text = "ChallanWise :"

                '    BindGrid(grdstock, con, "select inward_no,subrack_no,part_no,vendor_name,challan_no,convert(varchar(10),challan_date,3)as challan_date,item_detail.item_name,store_master_detail.total_qty as quantity,unit as count_in,convert(varchar(10),store_master.rec_date,3)as rec_date,case reject    when '1' then 'Yes' Else '' end as reject,rack_no ,po_no,convert(varchar(10),po_date,3) po_date, bill_no ,convert(varchar(10),bill_date,3) bill_date,drb_no  from store_master inner join store_master_detail on store_master.store_id = store_master_detail.store_id inner join stock_vendor on stock_vendor.vendor_id = store_master.vendor_id left outer join item_detail on item_detail.item_code = store_master_detail.item_code where   challan_no = '" & challan & "'  order by store_master.rec_date")
                'ElseIf txtvendor.Value <> "" And challan <> "" Then
                '    lblfrom.Text = challan
                '    lbltodate.Text = (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                '    Label1.Text = "Challan No :"
                '    Label2.Text = "Vendor Name :"
                '    Label3.Text = ""

                '    BindGrid(grdstock, con, "select inward_no,subrack_no,part_no,vendor_name,challan_no,convert(varchar(10),challan_date,3)as challan_date,item_detail.item_name,store_master_detail.total_qty as quantity,unit as count_in,convert(varchar(10),store_master.rec_date,3)as rec_date,case reject    when '1' then 'Yes' Else '' end as reject,rack_no ,po_no,convert(varchar(10),po_date,3) po_date, bill_no ,convert(varchar(10),bill_date,3) bill_date,drb_no  from store_master inner join store_master_detail on store_master.store_id = store_master_detail.store_id inner join stock_vendor on stock_vendor.vendor_id = store_master.vendor_id left outer join item_detail on item_detail.item_code = store_master_detail.item_code where challan_no = '" & challan & "' and store_master.vendor_id = '" & vendor & "' order by store_master.rec_date ")

                'ElseIf txtvendor.Value <> "" And challan = "" Then
                '    lblfrom.Text = (StrConv(txtvendor.Value, VbStrConv.ProperCase))
                '    lbltodate.Text = ""
                '    Label1.Text = "Vendor Name :"
                '    Label2.Text = ""
                '    Label3.Text = ""

                '    BindGrid(grdstock, con, "select inward_no,subrack_no,part_no,vendor_name,challan_no,convert(varchar(10),challan_date,3)as challan_date,item_detail.item_name,store_master_detail.total_qty as quantity,unit as count_in,convert(varchar(10),store_master.rec_date,3)as rec_date,case reject    when '1' then 'Yes' Else '' end as reject,rack_no ,po_no,convert(varchar(10),po_date,3) po_date, bill_no ,convert(varchar(10),bill_date,3) bill_date,drb_no  from store_master inner join store_master_detail on store_master.store_id = store_master_detail.store_id inner join stock_vendor on stock_vendor.vendor_id = store_master.vendor_id left outer join item_detail on item_detail.item_code = store_master_detail.item_code where store_master.vendor_id = '" & vendor & "'  order by store_master.rec_date  ")
                'Else
                'BindGrid(Datagrid1, con, "VIEW_PASS_REPORT '" & fromdate & "','" & todate & "','3'")
                'BindGrid(Datagrid2, con, "VIEW_PASS_REPORT '" & fromdate & "','" & todate & "','4'")
                'End If
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False
                    divcrt.Visible = False
                Else
                    Table1.Visible = True
                    divcrt.Visible = False
                    clear()
                End If
            Catch ex As Exception

            Finally
                strvendor = getAutoCompleteList("select vendor_name  from stock_vendor order by vendor_name", "vendor_name")
            End Try
        End Sub
        Private Sub clear()
            BDPLite1.SelectedDate = ""
            BDPLite2.SelectedDate = ""
            txtchallan.Text = ""
            txtvendor.Value = ""
        End Sub

        Protected Sub crystal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles crystal.Click
            Try
                divcrt.Visible = True
                Session("itemrecievdt") = ""
                Session("vendorname") = ""
                Dim fromdate As String = ""
                Dim todate As String = ""
                Dim dt As DataTable

                If BDPLite1.SelectedDate <> "#12:00:00 AM#" Then
                    lblfrom.Text = "From Date : " + BDPLite1.SelectedDate.ToString("dd/MM/yy")
                    fromdate = BDPLite1.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If BDPLite2.SelectedDate <> "#12:00:00 AM#" Then
                    lbltodate.Text = "ToDate : " + BDPLite2.SelectedDate.ToString("dd/MM/yy")
                    todate = BDPLite2.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If txtchallan.Text <> "" Then
                    lblchallan.Text = "Challan No " + " " + txtchallan.Text
                Else
                    lblchallan.Text = ""
                End If
                If txtvendor.Value <> "" Then
                    Session("vendorname") = txtvendor.Value
                Else
                    lblvendor.Text = ""
                End If

                dt = GetDatatTable("VIEW_ITEMRECIEVE '" & Session("vendorname") & "','" & txtchallan.Text & "','" & fromdate & "','" & todate & "'")
                Session("itemrecievdt") = dt
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    Table1.Visible = False

                Else
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("item_recieve.rpt"))
                    cryRpt.SetDataSource(dt)
                    cryRpt.SetParameterValue("vendor", Session("vendorname"))
                    viewer_item_recieve.ReportSource = cryRpt
                    viewer_item_recieve.EnableDatabaseLogonPrompt = False
                    Table1.Visible = False

                End If
            Catch ex As Exception

            Finally

            End Try
         
        End Sub
        Public Sub cryshow()
            Try

                Dim dt2 As New DataTable
                dt2 = Session("itemrecievdt")
                Dim cryRpt As New ReportDocument
                cryRpt.Load(Server.MapPath("item_recieve.rpt"))
                cryRpt.SetDataSource(dt2)
                cryRpt.SetParameterValue("vendor", Session("vendorname"))
                viewer_item_recieve.ReportSource = cryRpt
                viewer_item_recieve.EnableDatabaseLogonPrompt = False
                Table1.Visible = False
                divcrt.Visible = True
            Catch ex As Exception
                'Response.Write(ex.Message)

            End Try

        End Sub
    End Class
End Namespace

