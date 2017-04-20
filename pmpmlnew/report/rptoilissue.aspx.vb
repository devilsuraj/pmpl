Namespace KDMT
    Partial Class rptoilissue
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()

                Table1.Visible = False

            End If

        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                lblfrom.Text = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yyyy")
                lbltodate.Text = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yyyy")
                BindGrid(grdstock, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','1'")
                BindGrid(Datagrid1, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','2'")
                BindGrid(Datagrid2, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','3'")
                BindGrid(Datagrid3, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','4'")
                BindGrid(Datagrid4, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','5'")
                BindGrid(Datagrid5, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','6'")
                BindGrid(Datagrid6, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','7'")
                BindGrid(Datagrid7, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','8'")
                BindGrid(Datagrid8, con, " oilissue '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','9'")
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
