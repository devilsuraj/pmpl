Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Job_Assign
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
            txtBusNo.Focus()
            strBusno = getAutoCompleteList("SELECT distinct busno FROM tbl_JobInspection_Master where assignflag=0 ORDER BY busno asc", "busno")

            If Not IsPostBack Then
                'strjobno = getAutoCompleteList("SELECT JobOrderCard_Master.joccode FROM tbl_JobInspection_Master INNER JOIN JobOrderCard_Master ON tbl_JobInspection_Master.jobid = JobOrderCard_Master.JOC_id where inspection_no<>0 order by joccode asc", "joccode")

                strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
                strBusno = getAutoCompleteList("SELECT distinct busno FROM tbl_JobInspection_Master where assignflag=0 ORDER BY busno asc", "busno")


                'strBusno = getAutoCompleteList("SELECT distinct vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0 ORDER BY vech_master.vech_no asc", "vech_no")
                If Request.QueryString("jobno") <> "" Then
                    txtBusNo.Value = Request.QueryString("busno")
                    txtjocno.Value = Request.QueryString("jobno")
                    td1.Visible = True
                    td2.Visible = True
                    Dim jobid As Integer
                    jobid = ExecuteQuery("select JOC_id from JobOrderCard_Master where joccode='" + txtjocno.Value + "'")
                    lblinspmech.Text = ExecuteQuery("select name from tbl_Mechanic_master where Mech_id=(select mechid from tbl_JobInspection_Master where jobid=" & jobid & " and busno= " & txtBusNo.Value & " )")

                    BindGrid(grdjobdetails, con, "Assign_JOC_Detalis '" + Request.QueryString("jobno") + "','" + Request.QueryString("busno") + "',0")
                Else
                    td1.Visible = False
                    td2.Visible = False
                End If
            End If
        End Sub
        Protected Sub grdjobdetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdjobdetails.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    Dim grd As DataGrid
                    grd = e.Item.FindControl("grddeffect")

                    Dim adp As New SqlDataAdapter("Assign_JOC_Detalis '" + txtjocno.Value + "','" + e.Item.Cells(3).Text + "'," + e.Item.Cells(1).Text + "", con)
                    Dim ds As New DataSet
                    adp.Fill(ds)
                    grd.DataSource = ds.Tables(1)
                    grd.DataBind()

                    Dim txt1 As TextBox
                    txt1 = e.Item.FindControl("txtmech")

                    strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")

                    '("<script>$("grddeffect_#txtmech").autocompleteArray(" +"</script>"

            End Select
        End Sub
        Protected Sub grddeffect_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs)
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item
                    'Dim grd As DataGrid
                    'grd = e.Item.FindControl("grddeffect")

                    Dim adp As New SqlDataAdapter("select Mech_id,Name from tbl_Mechanic_master order by Name", con)
                    Dim ds As New DataSet
                    adp.Fill(ds)
                    'Dim drp1 As DropDownList
                    'drp1 = e.Item.FindControl("drpmech")
                    Dim txt1 As TextBox
                    txt1 = e.Item.FindControl("txtmech")

                    txt1.AutoCompleteType = AutoCompleteType.FirstName

                    'drp1.DataSource = ds
                    'drp1.DataTextField = "Name"
                    'drp1.DataValueField = "Mech_id"
                    'drp1.DataBind()

                    'grd.DataSource = ds.Tables(1)
                    'grd.DataBind()

                    'Dim txt1 As TextBox
                    'txt1 = e.Item.FindControl("txtmech")

                    strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            End Select
        End Sub
        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            td1.Visible = True
            td2.Visible = True
            Dim jobid As String
            jobid = ExecuteQuery("select JOC_id from JobOrderCard_Master where joccode='" & txtjocno.Value & "'")
            If jobid = "" Then
                lbl.Text = "No Job_id found"
            Else
                Dim mechid1 As String
                mechid1 = ExecuteQuery("select mechid from tbl_JobInspection_Master where jobid=" & jobid & " and busno=" + txtBusNo.Value + "")
                If mechid1 = "" Then
                    lbl.Text = "No Mech_id found"
                    ' Response.Write("<script language=javascript>alert('No Mech_id found ')</script>")
                    'Call Show_Msg(Page, "Save Successfully", "Job_Assign.aspx")
                    ' Response.Redirect("job_assign.aspx")
                Else

                    lblinspmech.Text = ExecuteQuery("select name from tbl_Mechanic_master where Mech_id=" + mechid1 + "")
                    ' If lblinspmech.Text = "" Then
                    ' Response.Write("<script language=javascript>alert('No Mech_id found ')</script>")
                    'End If
                End If
            End If
            BindGrid(grdjobdetails, con, "Assign_JOC_Detalis '" + txtjocno.Value + "','" + txtBusNo.Value + "',0")

            'strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master where locid=0 order by joccode", "joccode")

            strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
            strBusno = getAutoCompleteList("SELECT vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0  ORDER BY vech_master.vech_no", "vech_no")
        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            Try
                Dim i As Integer = 0
                Dim r As Integer = 0
                Dim j As Integer = 0
                Dim rd2 As Integer = 0
                con.Open()
                For i = 0 To grdjobdetails.Items.Count - 1
                    'cmd = New SqlCommand("ins_Assign_JOC", con)
                    'cmd.CommandType = CommandType.StoredProcedure
                    Dim txt1 As HtmlInputText
                    Dim txt2 As TextBox
                    Dim grd As DataGrid
                    Dim ch1 As CheckBox
                    Dim rd1 As RadioButton
                    grd = grdjobdetails.Items(i).FindControl("grddeffect")
                    rd1 = grdjobdetails.Items(i).FindControl("rd1")
                    If rd1.Checked = True Then
                        rd2 = 1
                    End If
                    For j = 0 To grd.Items.Count - 1
                        ch1 = grd.Items(j).FindControl("ch1")
                        If rd2 = 1 Then
                            ch1.Checked = True

                            'cmd.Parameters.AddWithValue("@jobno", grdjobdetails.Items(i).Cells(1).Text)
                            'cmd.Parameters.AddWithValue("@busno", grdjobdetails.Items(i).Cells(3).Text)
                            'cmd.Parameters.AddWithValue("@mechid", txt1.Value)
                            'cmd.Parameters.AddWithValue("@deptid", txt2.Value)
                            'cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                            'cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                            'cmd.Parameters.AddWithValue("@jobdtlid", grd.Items(i).Cells(2).Text)
                        End If
                        txt1 = grd.Items(j).FindControl("txtmech")
                        txt2 = grd.Items(j).FindControl("txtNote")
                        If ch1.Checked = True Then
                            If txt1.Value = "" Then
                                Call Show_Msg(Page, "Enter Mechnic Name", "Job_Assign.aspx")
                            Else
                                cmd = New SqlCommand("ins_Assign_JOC " + grdjobdetails.Items(i).Cells(1).Text + "," + grdjobdetails.Items(i).Cells(3).Text + ",'" + txt1.Value + "','" + txt2.Text + "'," + grd.Items(j).Cells(3).Text + "," + grd.Items(j).Cells(2).Text + "," + Session("UserId") + ",'" + Now.Date + "'", con)
                                cmd.ExecuteNonQuery()
                            End If
                            'If r > 0 Then
                            '    Response.Write("<script language=javascript>alert('data not inseretd')</script>")
                            'End If

                        End If

                    Next
                    Call Show_Msg(Page, "Save Successfully", "Job_Assign.aspx")
                    'Else
                    'Call Show_Msg(Page, "Save Successfully", "Job_Assign.aspx")
                    'End If

                    'Response.Write("<script>alert('Saved Successfuly');window.location.href='Job_Order_Card.aspx'</script>")
                Next
                'Call Show_Msg(Page, "Save Successfully", "Job_Assign.aspx")

                txtjocno.Value = ""
                txtBusNo.Value = ""
                grdjobdetails.DataSource = ""
                grdjobdetails.DataBind()
                td1.Visible = False
                td2.Visible = False
                con.Close()
                strBusno = getAutoCompleteList("SELECT vech_master.vech_no FROM  vech_master RIGHT OUTER JOIN JobOrderCard_Master ON vech_master.vech_no = JobOrderCard_Master.busno where locid=0  ORDER BY vech_master.vech_no", "vech_no")

            Catch ex As Exception
                Response.Write(ex.Message)

            End Try
        End Sub
        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            txtjocno.Value = ""
            txtBusNo.Value = ""
            grdjobdetails.DataSource = ""
            grdjobdetails.DataBind()
            td1.Visible = False
            td2.Visible = False
        End Sub
    End Class
End Namespace
