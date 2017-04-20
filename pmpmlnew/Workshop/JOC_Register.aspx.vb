Imports System.Data.SqlClient
Namespace KDMT
    Partial Class JOC_Register
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Public strjobno As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")

                strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master order by joccode", "joccode")

                Dim cmd As SqlCommand
                Dim sql As String = "select distinct 0 as id,Supervisorname from JobOrderCard_Master where Supervisorname<>'' order by Supervisorname"
                Dim dr As SqlDataReader
                'Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
                cmd = New SqlCommand(sql, con)
                con.Open()
                dr = cmd.ExecuteReader()
                ddlsuperv.DataTextField = "Supervisorname"
                ddlsuperv.DataValueField = "id"
                ddlsuperv.DataSource = dr
                ddlsuperv.DataBind()
                con.Close()
                'dropdownlist.Items.Insert(0, "select");

                ddlsuperv.Items.Insert(0, New ListItem("Select", "0"))


                BindGrid(grdjoclist, con, "view_jobcarddetails '" + dtformDate.SelectedDate + "','" + dttoDate.SelectedDate + "','" & IIf(ddlsuperv.SelectedItem.Text = "Select", "", ddlsuperv.SelectedItem.Text) & "','','" + txtBusNo.Value + "'")
            End If
            'grdjoclist.DataSource = ""
            'grdjoclist.DataBind()
        End Sub

        Protected Sub grdjoclist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjoclist.ItemDataBound
            Try
                Dim i As Integer
                Dim j As Integer
                j = 1
                Dim btn As New Button
                Dim link1, link2 As New HyperLink
                For i = 0 To grdjoclist.Items.Count - 1
                    If grdjoclist.Items(0).ItemType = ListItemType.AlternatingItem Or grdjoclist.Items(0).ItemType = ListItemType.Item Then
                        link1 = grdjoclist.Items(i).Cells(0).FindControl("hpfit")
                        link1.NavigateUrl = "../report/rptJOC.aspx?id=1&jobid=" & grdjoclist.Items(i).Cells(2).Text & "&deffectid=0"
                    End If
                Next
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click
            Try
                BindGrid(grdjoclist, con, "view_jobcarddetails '" + dtformDate.SelectedDate + "','" + dttoDate.SelectedDate + "','" & IIf(ddlsuperv.SelectedItem.Text = "Select", "", ddlsuperv.SelectedItem.Text) & "','','" + txtBusNo.Value + "'")

                strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")

                strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master order by joccode", "joccode")

            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace