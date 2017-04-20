Imports System.Data
Imports System.Data.SqlClient
Imports System.String
Imports System.Drawing

Namespace KDMT
    Partial Class Workshop_Insp_docking_list
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim cmd1 As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Button3.Attributes.Add("Onclick", "return validate()")
            If Not IsPostBack Then

                bdpinspdate.SelectedDate = Now.Date
                Label1.Text = "Bus No" + " : " + Request.QueryString("busno")
                lblinspno.Text = Request.QueryString("Insp")
                'If Request.QueryString("insptype") = "1" Then
                '    'BindGrid(grddockinglist, con, "view_dockingdetails_type '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + Request.QueryString("insp") + "'")
                BindGrid(grddockinglist, con, "view_dockingdetails '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + lblinspno.Text + "','" + Request.QueryString("jobno") + "'")
                BindGrid(grddetails, con, "view_ItemIssueOnJobcard '" + Request.QueryString("busno") + "','" + Request.QueryString("newjob") + "','" + Request.QueryString("newjobno") + "',''")
                hdnextra.Value = 0
                '  SetInitialRow1()
                'Else
                '    BindGrid(grddockinglist, con, "view_dockingdetails '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + Request.QueryString("insp") + "','" + Request.QueryString("jobno") + "'")
                '    'BindGrid(grddockinglist, con, "view_dockingdetails_type '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + Request.QueryString("insp") + "','" + Request.QueryString("jobno") + "'")
                'End If
            End If
        End Sub
        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            Try

                'If txtjocno.Value = "" And .Value = "" Then
                'Response.Write("<script>alert('Enter Job Card No and Bus no..');window.location.href='Docking_inspection.aspx'</script>")
                'Else
                If hdnextra.Value = 1 Then
                    cmd = New SqlCommand
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.CommandText = "ins_extrainsp"
                    lblinspno.Text = Convert.ToInt32(Request.QueryString("Insp"))
                    cmd.Parameters.AddWithValue("@expectedinsp", lblinspno.Text)
                    cmd.Parameters.AddWithValue("@transdate", bdpinspdate.SelectedDate())
                    cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                    cmd.Parameters.AddWithValue("@joccode", Request.QueryString("jobno"))
                    cmd.Parameters.AddWithValue("@busno", Request.QueryString("busno"))
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                Else
                    cmd1 = New SqlCommand
                    cmd1.Connection = con
                    lblinspno.Text = Convert.ToInt32(lblinspno.Text)
                    cmd1.CommandType = CommandType.StoredProcedure
                    cmd1.CommandText = "ins_busdocking"
                    cmd1.Parameters.AddWithValue("@busno", Request.QueryString("busno"))
                    cmd1.Parameters.AddWithValue("@dockinsp", lblinspno.Text)
                    cmd1.Parameters.AddWithValue("@transdate", bdpinspdate.SelectedDate())
                    con.Open()
                    cmd1.ExecuteNonQuery()
                    con.Close()

                End If

                cmd = New SqlCommand("ins_Docking_mst", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@joccode", Request.QueryString("jobno"))
                cmd.Parameters.AddWithValue("@busno", Request.QueryString("busno"))
                cmd.Parameters.AddWithValue("@inspec_no", lblinspno.Text)
                'cmd.Parameters.AddWithValue("@inspmstid", subid1)
                cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                con.Open()
                Dim maxno As Integer
                cmd.ExecuteNonQuery()

                maxno = ExecuteQuery("select isnull(max(insp_id),1)  from tbl_Inspection_Docking_Mst")

                If ViewState("link") = "" Then
                    Dim txt1 As TextBox
                    For i = 0 To grddockinglist.Items.Count - 1
                        If grddockinglist.Items(i).Cells(4).Text <> "1" Then

                            cmd = New SqlCommand("ins_Docking_Details", con)
                            cmd.CommandType = CommandType.StoredProcedure
                            'ch1 = grddockinglist.Items(i).Cells(4).FindControl("ch1")
                            'If ch1.Checked = True Then
                            cmd.Parameters.AddWithValue("@insp_id", maxno)
                            cmd.Parameters.AddWithValue("@docking_id", grddockinglist.Items(i).Cells(2).Text)
                            cmd.Parameters.AddWithValue("@subdocking_id", grddockinglist.Items(i).Cells(5).Text)
                            txt1 = grddockinglist.Items(i).Cells(3).FindControl("txtnote")
                            cmd.Parameters.AddWithValue("@note", txt1.Text)
                            cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                            'cmd.Parameters.AddWithValue("@isnpdtl_id", grddockinglist.Items(i).Cells(5).Text)
                            'cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                            cmd.ExecuteNonQuery()
                            'End If

                        End If
                    Next

                End If
                con.Close()

                Response.Write("<script>alert('Saved Successfuly');</script>")
                Response.Write("<script>window.close();</script>")
                'Response.Write("<script>alert('Saved Successfuly');window.location.href='Insp_docking_list.aspx'</script>")
            Catch ex As Exception
            End Try
            ViewState("link") = ""
        End Sub

        'Protected Sub lnkid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkid.Click
        '    ViewState("link") = ""
        '    divother.Visible = True
        '    'BindGrid(grddockinglist, con, "view_dockingdetails '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + Request.QueryString("insp") + "','" + Request.QueryString("jobno") + "'")
        '    BindGrid(grdother, con, "notin_view_dockingdetails '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + Request.QueryString("insp") + "','" + Request.QueryString("jobno") + "'")
        '    ViewState("link") = "link"

        'End Sub

        Sub AddNewRowToGrid()

            Dim rowIndex As Integer = 0
            ' If ViewState("CurrentTable") <> " " Then
            Dim dtCurrentTable As DataTable
            dtCurrentTable = CType(ViewState("CurrentTable"), DataTable)
            Dim drCurrentRow As DataRow
            If (dtCurrentTable.Rows.Count > 0) Then
                Dim i As Integer
                For i = 1 To dtCurrentTable.Rows.Count
                    'extract the TextBox values
                    Dim box1 As Label = CType(grddockinglist.Items(rowIndex).Cells(0).FindControl("txtfo"), Label)
                    ' Dim box2 As TextBox = CType(grddockinglist.Items(rowIndex).Cells(0).FindControl("txtfo"), TextBox)
                    'Dim box3 As TextBox = CType(grddockinglist.Items(rowIndex).Cells(0).FindControl("txtpartsregu"), TextBox)
                    ' Dim box4 As CheckBox = CType(grddockinglist.Items(rowIndex).Cells(0).FindControl("ch1"), CheckBox)
                    ' Dim box5 As TextBox = CType(grddockinglist.Items(rowIndex).Cells(0).FindControl("txtnote"), TextBox)
                    drCurrentRow = dtCurrentTable.NewRow()
                    ' drCurrentRow = dtCurrentTable.NewRow()
                    ' drCurrentRow["RowNumber"] = i + 1;
                    drCurrentRow("cl1") = box1.Text
                    ' drCurrentRow("cl2") = box3.Text
                    ' drCurrentRow("cl3") = box4.Text
                    ' drCurrentRow("Column1") = box1.Text
                    ' drCurrentRow("Column2") = box2.Text
                    'drCurrentRow("Column3") = box3.Text

                    rowIndex = rowIndex + 1
                    'add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow)
                Next
                'Store the current data to ViewState
                ViewState("CurrentTable") = dtCurrentTable
                'Rebind the Grid with the current data
                ' grddockinglist.DataSource = dtCurrentTable
                'grddockinglist.DataBind()
            End If
            'Else
            Response.Write("ViewState is null")
            'End If
            'Set Previous Data on Postbacks
            'SetPreviousData();

        End Sub

        Protected Sub btnclick_Click(ByVal sender As Object, ByVal e As System.EventArgs)
            ' AddNewRowToGrid()
        End Sub

        Public Sub SetInitialRow()
            Dim RowNumber As Integer = 0
            Dim dt As New DataTable
            Dim dr As DataRow
            'dt.Columns.Add(New DataColumn("RowNumber", GetType(String)))
            dt.Columns.Add(New DataColumn("txtfo", GetType(String)))
            dt.Columns.Add(New DataColumn("lbldockingmain", GetType(String)))
            dt.Columns.Add(New DataColumn("txtpartsregu", GetType(String)))
            dt.Columns.Add(New DataColumn("ch1", GetType(String)))
            dt.Columns.Add(New DataColumn("txtnote", GetType(String)))
            dr = dt.NewRow()
            ' dr("RowNumber") = 1
            dr("txtfo") = String.Empty
            dr("lbldockingmain") = String.Empty
            dr("txtpartsregu") = String.Empty
            dr("ch1") = String.Empty
            dr("txtnote") = String.Empty
            dt.Rows.Add(dr)
            'Store the DataTable in ViewState
            ViewState("CurrentTable") = dt
            ' grddockinglist.DataSource = dt
            ' grddockinglist.DataBind()
        End Sub
        Protected Sub grddockinglist_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddockinglist.ItemDataBound
            Try

                If e.Item.Cells(4).Text = "1" Then
                    e.Item.Cells(1).ForeColor = Color.Blue
                    e.Item.Cells(3).Text = ""
                Else
                    e.Item.Cells(1).ForeColor = Color.Black
                End If




            Catch ex As Exception

            End Try
        End Sub

        Public Sub SetInitialRow1()
            Dim RowNumber As Integer = 0
            Dim dt As New DataTable
            Dim dr As DataRow
            'dt.Columns.Add(New DataColumn("RowNumber", GetType(String)))
            dt.Columns.Add(New DataColumn("cl1", GetType(String)))
            dt.Columns.Add(New DataColumn("cl2", GetType(String)))
            dt.Columns.Add(New DataColumn("cl3", GetType(String)))
            ' dt.Columns.Add(New DataColumn("ch1", GetType(String)))
            ' dt.Columns.Add(New DataColumn("txtnote", GetType(String)))
            dr = dt.NewRow()
            ' dr("RowNumber") = 1
            dr("cl1") = String.Empty
            dr("cl2") = String.Empty
            dr("cl3") = String.Empty
            '  dr("ch1") = String.Empty
            ' dr("txtnote") = String.Empty
            dt.Rows.Add(dr)
            'Store the DataTable in ViewState
            ViewState("CurrentTable") = dt
            'grddockinglist.DataSource = dt
            'grddockinglist.DataBind()
        End Sub

        Protected Sub btnskip_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnskip.Click
            If Convert.ToInt32(lblinspno.Text) + 1 < 13 Then

                lblinspno.Text = Convert.ToInt32(lblinspno.Text) + 1


            End If
            BindGrid(grddockinglist, con, "view_dockingdetails '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','" + lblinspno.Text + "','" + Request.QueryString("jobno") + "'")


        End Sub

        Protected Sub btnextra_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnextra.Click
            Try

                hdnextra.Value = 1
                Label1.Text = "Bus No" + " : " + Request.QueryString("busno")
                lblinspno.Text = "Extra Inspection"
                BindGrid(grddockinglist, con, "view_dockingdetails '" + Request.QueryString("insp1") + "','" + Request.QueryString("busno") + "','5','" + Request.QueryString("jobno") + "'")

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grddetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddetails.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    If e.Item.Cells(6).Text = "1" Then
                        e.Item.Cells(6).Text = "New"
                    End If
                    If e.Item.Cells(6).Text = "3" Then
                        e.Item.Cells(6).Text = "Repair"
                    End If
            End Select
        End Sub
    End Class
End Namespace
