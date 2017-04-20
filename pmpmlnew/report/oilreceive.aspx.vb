Namespace KDMT
    Partial Class oilreceive
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
            End If
        End Sub


        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Response.Redirect("rptoilreceive.aspx?fromdate= " & BDPLite1.SelectedDate & " &todate= " & BDPLite2.SelectedDate & "")
        End Sub
    End Class
End Namespace

