
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class report_rptDepotWiseSummary
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim dr19 As SqlClient.SqlDataReader
        Dim sql19 As String

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Call Fill_Combo("cont_id", "cont_name", "contractor_master", DropDownList1, con, "", "Select")
                Table1.Visible = False
            End If

        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Dim CONT As Integer = DropDownList1.SelectedValue

            lblcontractor.Text = "Depot  : " + IIf(DropDownList1.SelectedItem.Text = "Select", "All", DropDownList1.SelectedItem.Text)
            lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yy")
            lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yy")
            'If Page.IsPostBack Then
            If (ddlitem.Text = "" And txtlfno.Text = "" And txtPartNo.Text = "") Then
                BindGrid(grdstock, con, "view_contractorwise_summarry '" & fromdate & "' ,'" & todate & "','" & CONT & "','0'")
            Else

                Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & ddlitem.Text & "','" & txtlfno.Text & "','" & txtPartNo.Text & "'")
                BindGrid(grdstock, con, "view_contractorwise_summarry '" & fromdate & "' ,'" & todate & "','" & CONT & "','" & itemcode & "'")

            End If


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
    End Class
End Namespace

