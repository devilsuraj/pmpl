Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Workshop_Deffect_Details
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strmain As String = ""
        Public strsub As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                If Not IsPostBack Then
                    strmain = getAutoCompleteList("select deffect_decr from tbl_deffect_Master where subid=0 order by deffect_decr", "deffect_decr")
                    strsub = getAutoCompleteList("select deffect_decr from tbl_deffect_Master where subid=(select deffect_id from tbl_deffect_Master where deffect_decr='" + txtmaindeffect.Value + "') order by deffect_decr", "deffect_decr")

                    BindGrid(grddeffectlist, con, "view_Deffect_master")
                End If
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
            Try
                If txtmaindeffect.Value = "" Or txtsubdeffect.Value = "" Or ddltype.SelectedValue = 0 Then
                    Call Show_Msg(Page, "Select All Fields", "Workshop_Deffect_Details.aspx")
                Else
                    cmd = New SqlCommand
                    ds = New DataSet
                    DA = New SqlDataAdapter
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.CommandText = "ins_Deffect_master"
                    cmd.Parameters.AddWithValue("@deffect_decr", txtmaindeffect.Value)
                    cmd.Parameters.AddWithValue("@subdeffect", txtsubdeffect.Value)
                    cmd.Parameters.AddWithValue("@deffectype", ddltype.SelectedItem.Text)
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                    con.Open()
                    cmd.ExecuteNonQuery()

                    con.Close()

                    txtmaindeffect.Value = ""
                    txtsubdeffect.Value = ""
                    ddltype.SelectedValue = 0

                    strmain = getAutoCompleteList("select deffect_decr from tbl_deffect_Master where subid=0 order by deffect_decr", "deffect_decr")

                    Call Show_Msg(Page, "Save Successfully", "Workshop_Deffect_Details.aspx")
                End If

            Catch ex As Exception

            End Try
        End Sub
        Protected Sub Reset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Reset.Click
            Try
                txtmaindeffect.Value = ""
                txtsubdeffect.Value = ""
                ddltype.SelectedValue = 0

                strmain = getAutoCompleteList("select deffect_decr from tbl_deffect_Master where subid=0 order by deffect_decr", "deffect_decr")
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace