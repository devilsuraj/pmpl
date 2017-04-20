Namespace KDMT
    Partial Class rptitemrepair
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Table1.Visible = False

            End If
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            Dim fromdate As String = Request.QueryString("fromdate")
            Dim todate As String = Request.QueryString("todate")
            Dim flag As String = Request.QueryString("option")
            'Response.Redirect("excelrepair.aspx?fromdate=" & fromdate & " &Todate= " & todate & " & option= " & flag & " ")

            If flag = "1" Then
                Response.Redirect("excelrepair.aspx?fromdate=" & fromdate & "&Todate=" & todate & "&option=" & flag & "")
            End If
            If flag = "2" Then
                Response.Redirect("excelrepair.aspx?fromdate=" & fromdate & "&Todate=" & todate & "&option=" & flag & "")
            End If
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Dim flag As String = RadioButtonList1.SelectedValue

            lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy")
            lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yyyy")
            BindGrid(grdstock, con, "VIEW_ITEM_REPAIR '" & fromdate & "','" & todate & "','" & flag & "'")
            If grdstock.Items.Count = 0 Then
                Response.Write("<script>alert ('Record Not Found') </script>")
                Table1.Visible = False
            Else
                Table1.Visible = True
            End If

        End Sub
    End Class
End Namespace


