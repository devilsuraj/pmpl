Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Part_Master
        Inherits System.Web.UI.Page

        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtCompDate.SelectedDate = Now.Date
                dtWSDate.SelectedDate = Now.Date
                'txtBusNo.Focus()
                Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", ddlPartType, Con)
                'ddlPartType.SelectedValue = "1"
                txtPartCompNo.Focus()

            End If
        End Sub

        'Protected Sub ddlPartType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPartType.SelectedIndexChanged
        '    Response.Write("<script>window.location.href='../Workshop/Part_Master.aspx?PartType='" + ddlPartType.SelectedItem.Text + "'</script>")
        'End Sub

        Protected Sub ddlPartType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPartType.SelectedIndexChanged

        End Sub

        'Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        '    Try
        '        'Response.Write("<script>window.location.href='../tmtAjax/Master_ajax.aspx?action=PartMaster&Id=' + ID + '&PartType=' + ddlPartType.SelectedValue + '&PartCompanyNo=' + txtPartCompNo.Value + '&PartCompany=' + txtPartComp.Value + '&PartWSNo=' + txtPartWSNo.Value + '&PartSize=' + txtPartSize.Value + '&CompDate=' + dtCompDate.SelectedDate + '&WSDate=' + dtWSDate.SelectedDate + '&Optype=' + 1'</script>")


        '        cmd = New SqlCommand
        '        ds = New DataSet
        '        DA = New SqlDataAdapter
        '        cmd.Connection = Con
        '        cmd.CommandType = CommandType.StoredProcedure
        '        Dim i As Integer

        '        cmd = New SqlCommand("Ins_Part_Master", Con)
        '        cmd.CommandType = CommandType.StoredProcedure

        '        cmd.Parameters.AddWithValue("@Part_ID", 0)
        '        cmd.Parameters.AddWithValue("@Part_Type", ddlPartType.SelectedValue)
        '        cmd.Parameters.AddWithValue("@Part_Company_No", txtPartCompNo.Value)
        '        cmd.Parameters.AddWithValue("@Part_Company", txtPartComp.Value)
        '        cmd.Parameters.AddWithValue("@Part_WS_No", txtPartWSNo.Value)
        '        cmd.Parameters.AddWithValue("@Part_Size", txtPartSize.Value)
        '        cmd.Parameters.AddWithValue("@Part_Comp_Date", dtCompDate.SelectedDate)
        '        cmd.Parameters.AddWithValue("@Part_WS_Date", dtWSDate.SelectedDate)
        '        cmd.Parameters.AddWithValue("@User_ID", Session("Userid"))
        '        cmd.Parameters.AddWithValue("@type", 0)

        '        Con.Open()
        '        cmd.ExecuteNonQuery()
        '        Con.Close()

        '        txtPartCompNo.Value = ""
        '        txtPartComp.Value = ""
        '        txtPartWSNo.Value = ""
        '        txtPartSize.Value = ""
        '    Catch ex As Exception

        '    End Try
        'End Sub
    End Class
End Namespace
