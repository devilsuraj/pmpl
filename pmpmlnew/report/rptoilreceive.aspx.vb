Namespace KDMT
    Partial Class rptoilreceive
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
                If Page.IsPostBack = False Then
                    lblfrom.Text = Format(Convert.ToDateTime(BDPLite1.SelectedDate), "dd/MM/yyyy")
                    lbltodate.Text = Format(Convert.ToDateTime(BDPLite2.SelectedDate), "dd/MM/yyyy")
                    BindGrid(grdstock, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','1'")
                    BindGrid(Datagrid1, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','2'")
                    BindGrid(Datagrid2, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','3'")
                    BindGrid(Datagrid3, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','4'")
                    BindGrid(Datagrid4, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','5'")
                    BindGrid(Datagrid5, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','6'")
                    BindGrid(Datagrid6, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','7'")
                    BindGrid(Datagrid7, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','8'")
                    BindGrid(Datagrid8, con, " oilreceive '" & BDPLite1.SelectedDate & "','" & BDPLite2.SelectedDate & "','9'")
                    Table1.Visible = True

                End If

            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace