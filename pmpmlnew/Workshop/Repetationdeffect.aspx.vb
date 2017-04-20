Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class Workshop_Repetationdeffect
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Dim busno As String = ""
        Dim sr As Integer = 0
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                dtformDate.SelectedDate = Now.Date
                dttoDate.SelectedDate = Now.Date
                Dim fromdate As String = Format(Convert.ToDateTime(dtformDate.SelectedDate), "MM/dd/yyyy")
                Dim todate As String = Format(Convert.ToDateTime(dttoDate.SelectedDate), "MM/dd/yyyy")
                strBusno = getAutoCompleteList("select vech_no from vech_Master order by vech_no", "vech_no")
                edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")

                'grdjoclist.DataSource = ""
                'grdjoclist.DataBind()
            End If
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                hdnshowtype.Value = "All"
                Dim fromdate As String = Format(Convert.ToDateTime(dtformDate.SelectedDate), "MM/dd/yyyy")
                Dim todate As String = Format(Convert.ToDateTime(dttoDate.SelectedDate), "MM/dd/yyyy")
                BindGrid(grdjoclist, con, "view_repetationwork_bus '" & DateAdd(DateInterval.Day, -(txtday.Text), Now.Date) & "','" & Now.Date & "','" & ddlsubdefect.Text & "','" & txtBusNo.Value & "','" & ddldeffectplace.SelectedItem.Text & "','" & ddlbustype.SelectedValue & "'")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                If hdnshowtype.Value = "All" Then
                    Response.Redirect("../report/Workshop_rptRepetationdeffect.aspx?fromdate=" & dtformDate.SelectedDate & "&Todate=" & dttoDate.SelectedDate & "&deffect=&busno=&type=&Defecttype=" & ddldeffectplace.SelectedItem.Text & "")
                Else
                    Response.Redirect("../report/Workshop_rptRepetationdeffect.aspx?fromdate=" & dtformDate.SelectedDate & "&Todate=" & dttoDate.SelectedDate & "&deffect=" & ddlsubdefect.Text & "&busno=" & txtBusNo.Value & "&type=" & ddlbustype.Selectedvalue & "")
                End If

                ' Response.Write("<script>window.location.href='../Workshop/Job_Assign.aspx?id=1&jobno=" + txtjocno.Value + "&busno=" + txtBusNo.Value + "'</script>")
            Catch ex As Exception

            End Try
        End Sub
        <WebMethod()> _
Public Shared Function GetAutoCompleteData(ByVal SubId As String, ByVal SearchText As String) As List(Of String)
            Dim result As New List(Of String)()



            'Using con As New SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB")
            Try
                Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master where subid='" + SubId + "'  and subid <> 0 and deffect_decr like '%" & SearchText & "%' ", con)
                    'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                    con.Open()
                    'cmd.Parameters.AddWithValue("@SearchText", username)
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("deffect_decr").ToString())
                    End While
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function

        Protected Sub btnshowall_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshowall.Click
            Try
                hdnshowtype.Value = "Defect"
                BindGrid(grdjoclist, con, "view_repetationwork_bus '" & dtformDate.SelectedDate & "','" & dttoDate.SelectedDate & "','','','Select'")
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grdjoclist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjoclist.ItemDataBound

            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then

                If busno.ToString <> e.Item.Cells(1).Text Then
                    sr = sr + 1
                    e.Item.Cells(0).Text = sr
                    busno = e.Item.Cells(1).Text
                Else
                    e.Item.Cells(0).Text = ""
                End If
            End If
        End Sub

        Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
            ExportDataGrid(grdjoclist)
        End Sub

    End Class
End Namespace
