Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class Workshop_workshopreport
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Dim jobno As String = ""
        Dim sr As Integer = 0
        Public strBusno As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                If Not IsPostBack Then
                    dtformDate.SelectedDate = Now.Date
                    dttoDate.SelectedDate = Now.Date
                    Label1.Visible = "False"
                    LastInsp.Visible = "False"
                    'edit_combo(ddlsuperv, "0", "Supervisorname", "JobOrderCard_Master", "")
                    strBusno = getAutoCompleteList("select vech_no from vech_Master where is_delete<>'1' order by vech_no", "vech_no")
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
                    DropDownList1.Items.Insert(0, New ListItem("Select", "0"))
                    DropDownList2.Items.Insert(0, New ListItem("Select", "0"))
                    edit_combo(ddldeffect, "deffect_id", "deffect_decr", "tbl_deffect_Master", " subid=0")
                    edit_combo(DropDownList1, "EngId", "EngName", "EngineerMaster", "engid<>0")
                    edit_combo(DropDownList2, "Mech_id", "Name", "tbl_Mechanic_master", "Mech_id>7")


                    BindGrid(grdjoclist, con, "view_jobshowdetails '" & txtjoc.Text & "','" & txtBusNo.Text & "','" & IIf(dtformDate.SelectedDate = "12:00:00 AM", "", dtformDate.SelectedDate) & "','" & IIf(dttoDate.SelectedDate = "12:00:00 AM", "", dttoDate.SelectedDate) & "','" & ddlstatus.SelectedValue & "','" & ddldeffectplace.SelectedValue & "','" & IIf(ddlsuperv.SelectedItem.Text = "Select", "", ddlsuperv.SelectedItem.Text) & "','" & IIf(ddlshift.SelectedItem.Text = "Select", "", ddlshift.SelectedItem.Text) & "','" & ddlsubdefect.Text & "','" & ddldeffect.SelectedValue & "','" & ddlbustype.SelectedValue & "','" & txtDriver.Text & "','" & DropDownList1.SelectedItem.ToString & "','" & DropDownList2.SelectedValue & "'")

                    'BindGrid(grdirrlist, con, "view_jobshowdetails '" & txtjoc.Text & "','" & txtBusNo.Text & "','" & IIf(dtformDate.SelectedDate = "12:00:00 AM", "", dtformDate.SelectedDate) & "','" & IIf(dttoDate.SelectedDate = "12:00:00 AM", "", dttoDate.SelectedDate) & "'")
                End If
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                BindGrid(grdjoclist, con, "view_jobshowdetails '" & txtjoc.Text & "','" & txtBusNo.Text & "','" & IIf(dtformDate.SelectedDate = "12:00:00 AM", "", dtformDate.SelectedDate) & "','" & IIf(dttoDate.SelectedDate = "12:00:00 AM", "", dttoDate.SelectedDate) & "','" & ddlstatus.SelectedValue & "','" & ddldeffectplace.SelectedValue & "','" & IIf(ddlsuperv.SelectedItem.Text = "Select", "", ddlsuperv.SelectedItem.Text) & "','" & IIf(ddlshift.SelectedItem.Text = "Select", "", ddlshift.SelectedItem.Text) & "','" & ddlsubdefect.Text & "','" & ddldeffect.SelectedValue & "','" & ddlbustype.SelectedValue & "','" & txtDriver.Text & "','" & DropDownList1.SelectedItem.ToString & "','" & DropDownList2.SelectedValue & "'")

                If txtBusNo.Text <> "" Then
                    Label1.Visible = "True"
                    LastInsp.Visible = "True"
                    LastInsp.Text = ExecuteQuery("select inspno from last_inspect_status where busno ='" + txtBusNo.Text + "'")
                    If LastInsp.Text = "6" Then
                        LastInsp.Text = "HD"
                    ElseIf LastInsp.Text = "12" Then

                        LastInsp.Text = "FD"
                    Else
                        LastInsp.Text = LastInsp.Text
                    End If
                End If

                If txtBusNo.Text = "" Then
                    Label1.Visible = "False"
                    LastInsp.Visible = "False"

                End If
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub grdjoclist_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdjoclist.ItemCommand
            'Try
            '    If e.CommandName = "print" Then
            '        Response.Write("<script>window.location.href='../report/rpt_workshopreport.aspx?id=1&jobid=" + e.Item.Cells(1).Text + "</script>")
            '    End If
            'Catch ex As Exception
            'End Try
        End Sub
        'Protected Sub grdjoclist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjoclist.ItemDataBound
        '    Try
        '         Select e.Item.ItemType
        '            Case ListItemType.AlternatingItem, ListItemType.Item
        '                Dim btn As New Button
        '                Dim link1, link2 As New HyperLink
        '                btn = e.Item.Cells(6).FindControl("btnprn")
        '                btnprn_Click(sender, e)
        '                link2 = e.Item.Cells(6).FindControl("hpprint")

        '                link1.NavigateUrl = "../Workshop/rpt_workshopreport.aspx?id=1&jobid=" & e.Item.Cells(0).Text & ""

        '                e.Item.Cells(7).ResolveUrl("../Workshop/rpt_workshopreport.aspx?id=1&jobid=" & e.Item.Cells(0).Text & "")
        '        End Select

        'Dim i As Integer
        'Dim j As Integer
        'j = 1
        'Dim btn As New Button

        'Dim link1, link2 As New HyperLink
        'For i = 0 To grdjoclist.Items.Count - 1
        '    If grdjoclist.Items(0).ItemType = ListItemType.AlternatingItem Or grdjoclist.Items(0).ItemType = ListItemType.Item Then

        '        btn = e.Item.Cells(0).FindControl("btnprn")
        '        btnprn_Click(sender, e)
        '        link2 = e.Item.Cells(0).FindControl("hpprint")

        '        link1.NavigateUrl = "../Workshop/rpt_workshopreport.aspx?id=1&jobid=" & grdjoclist.Items(i).Cells(0).Text & ""

        '    End If
        'Next
        '    Catch ex As Exception

        '    End Try
        'End Sub
        Protected Sub btnprn_Click(ByVal sender As Object, ByVal e As System.EventArgs)
            Try
                Response.Write("<script>window.location.href='../Workshop/rpt_workshopreport.aspx?id=1&jobid=1&busno=1</script>")
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub grdjoclist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjoclist.ItemDataBound
            Try
                If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
                    If e.Item.Cells(2).Text = "0" Then
                        e.Item.Cells(2).Text = e.Item.Cells(14).Text
                    End If

                    If e.Item.Cells(14).Text = jobno.ToString Then
                        e.Item.Cells(2).Text = ""
                        e.Item.Cells(3).Text = ""
                        e.Item.Cells(4).Text = ""
                        e.Item.Cells(5).Text = ""
                        e.Item.Cells(7).Text = ""
                        e.Item.Cells(8).Text = ""
                        e.Item.Cells(11).Text = ""
                        e.Item.Cells(12).Text = ""
                        e.Item.Cells(13).Text = ""
                        e.Item.Cells(1).Text = ""
                        e.Item.Cells(9).Text = ""
                        e.Item.Cells(10).Text = ""
                    Else
                        jobno = e.Item.Cells(14).Text

                        If e.Item.Cells(14).Text <> "Job No" Then
                            sr = sr + 1
                            e.Item.Cells(1).Text = sr
                        End If

                    End If

                    Dim link1, link2 As New HyperLink
                    Dim i As Integer
                    Dim j As Integer
                    j = 1
                    Dim btn As New Button
                    If e.Item.Cells(5).Text = "Docking" And e.Item.Cells(7).Text = "Close" Then

                    Else
                        If j <> 1 Then
                            e.Item.Cells(14).Text = ""
                        Else
                            e.Item.Cells(14).Text = ""
                        End If

                    End If
                End If

                If (e.Item.Cells(15).Text = "1" Or e.Item.Cells(15).Text = "2" Or e.Item.Cells(15).Text = "3" Or e.Item.Cells(15).Text = "4" Or e.Item.Cells(15).Text = "5" Or e.Item.Cells(15).Text = "7" Or e.Item.Cells(15).Text = "8" Or e.Item.Cells(15).Text = "9" Or e.Item.Cells(15).Text = "10" Or e.Item.Cells(15).Text = "11") And e.Item.Cells(5).Text = "Docking" Then
                    e.Item.Cells(5).Text = "Inspection"
                End If

                If (e.Item.Cells(15).Text = "12") And e.Item.Cells(5).Text = "Docking" Then
                    e.Item.Cells(5).Text = "F.D"
                End If

                If (e.Item.Cells(15).Text = "6") And e.Item.Cells(5).Text = "Docking" Then
                    e.Item.Cells(5).Text = "H.D"
                End If

                If (e.Item.Cells(15).Text = "Extra Insp") And e.Item.Cells(5).Text = "Docking" Then
                    e.Item.Cells(5).Text = "Extra Insp"
                End If


                'For i = 0 To grdjoclist.Items.Count - 1
                '    If grdjoclist.Items(0).ItemType = ListItemType.AlternatingItem Or grdjoclist.Items(0).ItemType = ListItemType.Item Then
                '        link1 = grdjoclist.Items(i).Cells(0).FindControl("hpfit")

                '        link1.NavigateUrl = "../Workshop/rpt_workshopreport.aspx?id=1&jobid=" & grdjoclist.Items(i).Cells(0).Text & ""

                '        link2 = grdjoclist.Items(i).Cells(0).FindControl("docking")
                '        link2.NavigateUrl = "../report/rpt_dockingdtl.aspx?id=1&jobid=" & grdjoclist.Items(i).Cells(0).Text & ""

                '    End If
                'Next
            Catch ex As Exception

            End Try
        End Sub
        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try
                Response.Redirect("../report/Workshop_workshopreport.aspx?jobno=" & txtjoc.Text & "&busno=" & txtBusNo.Text & "&fromdate=" & dtformDate.SelectedDate & "&Todate=" & dttoDate.SelectedDate & "&status=" & ddlstatus.SelectedValue & "&deffectplace=" & ddldeffectplace.SelectedValue & "&superv=" & IIf(ddlsuperv.SelectedItem.Text = "Select", "", ddlsuperv.SelectedItem.Text) & "&shift=" & IIf(ddlshift.SelectedItem.Text = "Select", "", ddlshift.SelectedItem.Text) & "&deffect=" & ddldeffect.SelectedValue & "&subdeffect=" & ddlsubdefect.Text & "&bustype=" & ddlbustype.SelectedValue & "&driver=" & txtDriver.Text & "&engineer=" & DropDownList1.SelectedItem.ToString & "&mechanic=" & DropDownList2.SelectedValue & "")
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

        Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
            ExportDataGrid(grdjoclist)
        End Sub
    End Class
End Namespace
