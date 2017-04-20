Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI
Imports System.Web.Services
Imports System.Collections.Generic

Namespace KDMT
    Partial Class sickBus
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

                If Not IsPostBack Then
                    edit_combo(ddlReason, "reason_id", "reason", "tblSickReasonMst", "0=0  ")
                    BDPLite1.SelectedDate = Format(Now.Date, "dd/MMM/yyyy")
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
                Dim jobid As String = ExecuteQuery("select JOC_id  from dbo.JobOrderCard_Master where locid = 0 and busno = '" + txtBusNo.Value + "' ")
                If defect = "1" Then
                    BindGrid(grddeffectlist, con, "view_defects '" + txtBusNo.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'")
                    If (defect = "1" And grddeffectlist.Items.Count > 0) Then
                        tbldata.Visible = True
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

               
                cmd = New SqlCommand("ins_SickBus", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@busno", txtBusNo.Value)
                cmd.Parameters.AddWithValue("@jobno", txtjob.Text)
                cmd.Parameters.AddWithValue("@newjobno", txtjobno.Text)
                cmd.Parameters.AddWithValue("@note", txtDesc.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@sickdate", BDPLite1.SelectedDate)
                cmd.Parameters.AddWithValue("@sickshift", ddlshift.SelectedValue)
                cmd.Parameters.AddWithValue("@reason", ddlreason.SelectedValue)
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
                Response.Write("<script>alert ('Saved Successfully') </script>")
                tbldata.Visible = False
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnreset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnreset.Click
            Response.Redirect("sickBus.aspx")
        End Sub
    End Class
End Namespace

