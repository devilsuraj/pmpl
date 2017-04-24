Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic

Namespace KDMT
    Partial Class frmSickReasonUpdate
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
            'btnsubmit.Attributes.Add("Onclick", "return chkBrakedown()")
            Try
                Session("MenuId") = 2
                If Not IsPostBack Then
                    edit_combo(ddlReason, "reason_id", "reason", "tblSickReasonMst", "0=0  ")

                    txtjob.Text = ExecuteQuery("(SELECT RIGHT('0' + RTRIM(year(getdate())), 2)+ RIGHT('0' + RTRIM(month(getdate())), 2))")
                    'btnSubmit.Attributes.Add("onclick", "return chkBrakedown()")
                    tbldata.Visible = "False"
                End If
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
            Try
                Dim defect As String
                defect = ExecuteQuery("select deffectplace  from dbo.JobOrderCard_Master where locid = 0 and busno = '" + txtBusNo.Value + "' ")
                Dim jobid As String = ExecuteQuery("select JOC_id  from dbo.JobOrderCard_Master where locid = 0 and newjob = '" + txtjob.Text + "' and newjobno = '" + txtjobno.Text + "' ")
                If defect = "1" Then
                    BindGrid(grddeffectlist, con, "view_defects '" + txtBusNo.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'")
                    If (defect = "1" And grddeffectlist.Items.Count > 0) Then
                        tbldata.Visible = True

                        Dim oldSickReason As String
                        oldSickReason = ExecuteQuery("select note from tbl_Bus_SeekDetails where jobid='" + jobid + "'")
                        lbloldSickReason.Text = oldSickReason
                    Else
                        tbldata.Visible = False
                        Response.Write("<script>alert ('Please do Inpection') </script>")
                    End If

                ElseIf defect <> "1" Then
                    lblmsg.Text = "cannot declare as sick"

                    tbldata.Visible = False
                Else
                    lblmsg.Text = "Job Card closed"
                End If

            Catch ex As Exception

            End Try

        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
            Try


                cmd = New SqlCommand("ins_sickreasonUpdate", con)
                cmd.CommandType = CommandType.StoredProcedure

                 cmd.Parameters.AddWithValue("@newjob", txtjob.Text)
                cmd.Parameters.AddWithValue("@newjobno", txtjobno.Text)
                cmd.Parameters.AddWithValue("@oldSickReason", lbloldSickReason.Text)
                cmd.Parameters.AddWithValue("@newSickReason", txtDesc.Text)
                cmd.Parameters.AddWithValue("@userid", Session("userid"))
                cmd.Parameters.AddWithValue("@reasonid", ddlReason.SelectedValue)
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
                Response.Write("<script>alert ('Saved Successfully') </script>")
                tbldata.Visible = False
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            Response.Redirect("frmSickReasonUpdate.aspx")
        End Sub
    End Class
End Namespace


