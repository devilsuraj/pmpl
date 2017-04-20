Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Close_Assign_Job
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Public strjobno As String = ""
        Public strmech As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                If Not IsPostBack Then
                    BindGrid(grdjobdetails, con, "JOC_closingjob '" + txtjocno.Value + "','" + txtBusNo.Value + "'")

                    strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=0 and inspection_no<>0 order by joccode", "joccode")

                    strBusno = getAutoCompleteList("SELECT vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0  and inspection_no<>0  ORDER BY vech_master.vech_no", "vech_no")

                    'strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")

                    'grdjobdetails.DataSource = ""
                    'grdjobdetails.DataBind()
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdjobdetails_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdjobdetails.ItemCommand
            Try
                If e.CommandName = "save" Then
                    'Response.Write("../report/rptJOC.aspx?id=2& jobid='" & e.Item.Cells(0).Text & "'")
                    con.Open()
                    cmd = New SqlCommand("ins_JOC_assignjobclose " + e.Item.Cells(1).Text + "," + e.Item.Cells(10).Text + ",'" + e.Item.Cells(5).Text + "','" + e.Item.Cells(9).Text + "'", con)
                    cmd.ExecuteNonQuery()
                    Call Show_Msg(Page, "Save Successfully", "Close_Assign_Job.aspx")
                    con.Close()

                    BindGrid(grdjobdetails, con, "JOC_closingjob '" + txtjocno.Value + "','" + txtBusNo.Value + "'")

                    'Response.Write("<script>window.location.href='../report/rpt_Closing_Job.aspx?id=2&jobno=" + e.Item.Cells(2).Text + "&deffectid=" + e.Item.Cells(5).Text + "'</script>")
                End If
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub grdjobdetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjobdetails.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    'Dim grd As DataGrid
                    'grd = e.Item.FindControl("grddeffect")

                    'Dim adp As New SqlDataAdapter("JOC_closingjob_details '" + txtjocno.Value + "','" + e.Item.Cells(4).Text + "'," + e.Item.Cells(1).Text + "", con)
                    'Dim ds As New DataSet
                    'adp.Fill(ds)
                    'grd.DataSource = ds.Tables(1)
                    'grd.DataBind()
                    'Dim txt1 As TextBox
                    'txt1 = e.Item.FindControl("txtmech")
                    'strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
                    'e.Item.Cells(10).Text = Format(Now.Date, "dd/MM/yyyy") & "-" & Now.Hour & Now.Minute & Now.Second
                    'Dim btn As Button
                    'btn=
            End Select
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            BindGrid(grdjobdetails, con, "JOC_closingjob '" + txtjocno.Value + "','" + txtBusNo.Value + "'")

            strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=1 order by joccode", "joccode")

            strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            strBusno = getAutoCompleteList("SELECT vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=1  ORDER BY vech_master.vech_no", "vech_no")

        End Sub

        Protected Sub grdjobdetails_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdjobdetails.SelectedIndexChanged

        End Sub
    End Class
End Namespace
