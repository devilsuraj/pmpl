Imports CrystalDecisions.Enterprise
Imports CrystalDecisions.Reporting
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Namespace kdmt
    Partial Class rptprojectforselecteditem
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
                cryshow()
            End If
        End Sub
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            btnshow.Attributes.Add("Onclick", "return save()")
            btncry.Attributes.Add("Onclick", "return save()")
            If Not IsPostBack Then
                lbldate.Text = Date.Now.Date().ToString("dd/MM/yyyy")

            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            If hdnitemcodelist.Value <> "" Then
                BindGrid(grdstock, con, "[sp_MIn_level] '" & Date.Now.Date() & "' ,'0','(" & hdnitemcodelist.Value & ")','3'")
                hdnitemcodelist.Value = ""
                '                BindGrid(grdstock, con, "[sp_MIn_level] '" & fromdate & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                     Table1.Visible = False
                Else
                    Table1.Visible = True
                    divcry.Visible = False
                End If
            Else
                Response.Redirect("rptprojectforselecteditem.aspx")
            End If
        End Sub
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
                    e.Item.Cells(2).Text = (StrConv(e.Item.Cells(2).Text, VbStrConv.ProperCase))
                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
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
               
                'If BDPLite1.SelectedDate = Now.Date Then
                '    Response.Write("<script>alert('Please Select Proper Date');</script>")
                '    'Response.Write("<script>alert('You Are Logout;Please Login again');window.location.href='login.aspx'</script>")
                'Else
                Dim dt As New DataTable
                dt = GetDatatTable("[sp_MIn_level] '" & Date.Now.Date() & "' ,'0','(" & hdnitemcodelist.Value & ")','3'")
                Session("itemmov") = dt
                If dt.Rows.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    divcry.Visible = False
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    ' If Not IsPostBack() Then
                    Dim cryRpt As New ReportDocument
                    cryRpt.Load(Server.MapPath("selectedprojectionreport.rpt"))
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
                cryRpt.Load(Server.MapPath("selectedprojectionreport.rpt"))
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

