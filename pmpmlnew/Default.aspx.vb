
Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("MenuId") = 1
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))

        If Con.State = ConnectionState.Closed Then
            Con.Open()
        End If
        Dim cmd As New SqlClient.SqlCommand("select " &
        "(select count(*) from JobOrderCard_Master where locid=0) as total_defect," &
        "(select count(*) from JobOrderCard_Master where locid=0 and deffectplace = 1) as depo_defect," &
        "(select count(*) from JobOrderCard_Master where locid=0 And deffectplace = 0) as docking," &
        "(select count(*) from JobOrderCard_Master where locid=0 and deffectplace = 2) as road_defect", Con)
        Dim dr As SqlClient.SqlDataReader

        dr = cmd.ExecuteReader

        If dr.HasRows = True Then
            dr.Read()
            Session("total_defect") = dr("total_defect")
            Session("depo_defect") = dr("depo_defect").ToString
            Session("docking") = dr("docking")
            Session("road_defect") = dr("road_defect")
        Else
        End If

    End Sub
End Class
