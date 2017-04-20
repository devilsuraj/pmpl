Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Part_Repair_Details
        Inherits System.Web.UI.Page
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
        Public strparttypedetails As String = ""
        Public strcompanyno As String = ""
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                btnsave.Attributes.Add("OnClick", "ValidateSave();")
                dtDate.SelectedDate = Now.Date
                fillgrid()
                strparttypedetails = getAutoCompleteList("SELECT Part_Master.Part_WS_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_WS_No")
                strcompanyno = getAutoCompleteList("SELECT Part_Master.Part_company_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_company_No")

                Fill_Combo("Repair_ID", "Repair_Type", "Repair_Type_Master", ddlReason, Con)
                Fill_Combo("Position_ID", "Position_Name", "Position_Master", ddlPartPosition, Con, , "Other")
                
            End If
        End Sub
        Protected Sub btnsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsave.Click
            Try
                strparttypedetails = getAutoCompleteList("SELECT Part_Master.Part_WS_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_WS_No")
                strcompanyno = getAutoCompleteList("SELECT Part_Master.Part_company_No FROM Part_Master INNER JOIN Part_Type_Master ON Part_Master.Part_Type = Part_Type_Master.Part_Type_ID where Part_Master.Part_Type='1'", "Part_company_No")


                If txtBusNo.Text = "" Then
                    Response.Write("<script>alert ('Please Enter the Bus no.') </script>")
                    Exit Sub

                End If



                Dim intresult As Integer = ExecuteQuery("view_state_exist '" & ddlPartStatus.SelectedValue & "','" & txtcompanyno.Text & "','" & txtPartNo.Text & "'")
                If intresult = "0" Then
                    cmd = New SqlCommand("Ins_Part_History", Con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@PH_ID", 0)
                    cmd.Parameters.AddWithValue("@Bus_No ", txtBusNo.Text)
                    cmd.Parameters.AddWithValue("@Part_type", 1)
                    cmd.Parameters.AddWithValue("@Part_No", txtPartNo.Text)
                    cmd.Parameters.AddWithValue("@Part_company_No", txtcompanyno.Text)
                    cmd.Parameters.AddWithValue("@Part_Position", ddlPartPosition.SelectedValue)
                    cmd.Parameters.AddWithValue("@Part_Status", ddlPartStatus.SelectedValue)
                    cmd.Parameters.AddWithValue("@Part_OI_Reason", ddlReason.SelectedValue)
                    cmd.Parameters.AddWithValue("@PH_Date", dtDate.SelectedDate)
                    cmd.Parameters.AddWithValue("@Part_KM", txtPartKm.Text)
                    cmd.Parameters.AddWithValue("@User_ID", Session("UserId"))
                    cmd.Parameters.AddWithValue("@part_size", ddlPartType.SelectedValue)
                    cmd.Parameters.AddWithValue("@remark ", txtremark.Text)
                    cmd.Parameters.AddWithValue("@place ", ddlplace.SelectedValue)
                    cmd.Parameters.AddWithValue("@type", 0)

                    Con.Open()
                    cmd.ExecuteNonQuery()
                    Con.Close()
                    Response.Write("<script>alert ('Saved Successfully') </script>")
                Else

                    Response.Write("<script>alert ('Already Exists') </script>")
                End If
                fillgrid()

                ddlPartType.SelectedIndex = 0
                ddlplace.SelectedIndex = 0
                ddlReason.SelectedIndex = 0
                ddlPartStatus.SelectedIndex = 0
                txtPartNo.Text = ""
                txtcompanyno.Text = ""
                txtBusNo.Text = ""
                txtPartKm.Text = ""
                ddlPartPosition.SelectedIndex = 0
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub grddetails_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grddetails.ItemCommand
            Try
                'If e.CommandName = "Edit" Then
                '    hdnphid.Value = e.CommandArgument.ToString()
                '    'ViewState("Save") = 2


                '    txtBusNo.Text = e.Item.Cells(2).Text
                '    txtPartNo.Text = e.Item.Cells(4).Text
                '    txtcompanyno.Text = e.Item.Cells(5).Text.Replace("&nbsp;", "")
                '    ddlPartPosition.SelectedValue = e.Item.Cells(14).Text
                '    ddlPartStatus.SelectedValue = e.Item.Cells(7).Text
                '    ddlReason.SelectedValue = e.Item.Cells(13).Text
                '    dtDate.SelectedDate = e.Item.Cells(9).Text
                '    txtPartKm.Text = e.Item.Cells(10).Text
                '    ddlPartType.SelectedValue = e.Item.Cells(3).Text

                'Else

                If e.CommandName = "Delete" Then

                    hdnphid.Value = e.CommandArgument.ToString()
                    cmd = New SqlCommand("delete_tyre_history", Con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@Part_No ", e.Item.Cells(4).Text)
                    cmd.Parameters.AddWithValue("@Part_company_No", e.Item.Cells(5).Text)
                    cmd.Parameters.AddWithValue("@part_size", e.Item.Cells(3).Text)
                    cmd.Parameters.AddWithValue("@PH_ID", hdnphid.Value)


                    Con.Open()
                    cmd.ExecuteNonQuery()
                    Con.Close()

                    fillgrid()
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
        Private Sub fillgrid()
            BindGrid(grddetails, Con, "View_tyre_Part_History")
            If grddetails.Items.Count > 0 Then
                grddetails.Visible = True
            Else
                grddetails.Visible = False
            End If
        End Sub


        'Protected Sub btnedit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnedit.Click
        '    Try



        '        cmd = New SqlCommand("Ins_Part_History", Con)
        '        cmd.CommandType = CommandType.StoredProcedure

        '        cmd.Parameters.AddWithValue("@PH_ID", 0)
        '        cmd.Parameters.AddWithValue("@Bus_No ", txtBusNo.Text)
        '        cmd.Parameters.AddWithValue("@Part_type", 1)
        '        cmd.Parameters.AddWithValue("@Part_No", txtPartNo.Text)
        '        cmd.Parameters.AddWithValue("@Part_company_No", txtcompanyno.Text)
        '        cmd.Parameters.AddWithValue("@Part_Position", ddlPartPosition.SelectedValue)
        '        cmd.Parameters.AddWithValue("@Part_Status", ddlPartStatus.SelectedValue)
        '        cmd.Parameters.AddWithValue("@Part_OI_Reason", ddlReason.SelectedValue)
        '        cmd.Parameters.AddWithValue("@PH_Date", dtDate.SelectedDate)
        '        cmd.Parameters.AddWithValue("@Part_KM", txtPartKm.Text)
        '        cmd.Parameters.AddWithValue("@User_ID", Session("UserId"))
        '        cmd.Parameters.AddWithValue("@part_size", ddlPartType.SelectedValue)
        '        cmd.Parameters.AddWithValue("@remark ", txtremark.Text)
        '        cmd.Parameters.AddWithValue("@type", 1)

        '        Con.Open()
        '        cmd.ExecuteNonQuery()
        '        Con.Close()
        '        Response.Write("<script>alert ('Updated Successfully') </script>")
        '    Catch ex As Exception

        '    End Try

        'End Sub

       
    End Class
End Namespace
