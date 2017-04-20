Namespace KDMT
    Partial Class report_rptItemrate
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            BindGrid(grdstock, con, "View_Itemrate '" & drpTypeOfItems.SelectedValue & "'")
        End Sub
    End Class
End Namespace
