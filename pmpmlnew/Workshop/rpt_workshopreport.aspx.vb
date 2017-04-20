Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_rpt_workshopreport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                cmd = New SqlClient.SqlCommand
                ds = New DataSet
                cmd.Connection = con
                Dim deffectpl As String
                con.Open()
                DA = New SqlClient.SqlDataAdapter("view_workJOC_rpt " & Request.QueryString("jobid") & "", con)
                DA.Fill(ds, "tblEmp")

                If (ds.Tables("tblEmp").Rows(0).Item("newjobno") = "0") Then
                    lbljocno.Text = ds.Tables("tblEmp").Rows(0).Item("joccode").ToString
                Else
                    lbljocno.Text = ds.Tables("tblEmp").Rows(0).Item("newjobno").ToString
                End If
                lblbusno.Text = ds.Tables("tblEmp").Rows(0).Item("busno").ToString
                lblmodel.Text = ds.Tables("tblEmp").Rows(0).Item("model").ToString
                lblchassis.Text = ds.Tables("tblEmp").Rows(0).Item("chassis").ToString
                lblkms.Text = ds.Tables("tblEmp").Rows(0).Item("kms").ToString
                lblengine.Text = ds.Tables("tblEmp").Rows(0).Item("engine").ToString
                lbljobdate.Text = ds.Tables("tblEmp").Rows(0).Item("jobdate").ToString
                lbljobtime.Text = ds.Tables("tblEmp").Rows(0).Item("jobtime").ToString
                'lbldeffect.Text = ds.Tables("tblEmp").Rows(0).Item("deffect_decr").ToString
                lbldrv.Text = ds.Tables("tblEmp").Rows(0).Item("drvname").ToString

                txtrt.Text = ds.Tables("tblEmp").Rows(0).Item("routeno").ToString
                txtplc.Text = ds.Tables("tblEmp").Rows(0).Item("place").ToString
                txtdt.Text = ds.Tables("tblEmp").Rows(0).Item("deffecttime").ToString
                txtwt.Text = ds.Tables("tblEmp").Rows(0).Item("workshoptime").ToString
                txtarreason.Text = ds.Tables("tblEmp").Rows(0).Item("reason").ToString
                txtname.Text = ds.Tables("tblEmp").Rows(0).Item("supervisor").ToString
                deffectpl = ds.Tables("tblEmp").Rows(0).Item("deffectplace").ToString
                lblclosedate.Text = ds.Tables("tblEmp").Rows(0).Item("jobclosedate").ToString
                lblclosebtime.Text = ds.Tables("tblEmp").Rows(0).Item("jobclosetime").ToString
                'If ds.Tables("tblEmp").Rows(0).Item("deffectplace").ToString = "2" Then
                '    tbl1.Visible = True
                'Else
                '    tbl1.Visible = False
                'End If

                con.Close()
                txtinspectionnote.Text = ExecuteQuery("select inspnote from tbl_JobInspection_Master where jobid=" & Request.QueryString("jobid") & "")

                BindGrid(grddeffectlist, con, "view_workJOCInsp_rpt " & Request.QueryString("jobid") & "")

                BindGrid(grddetails, con, "view_ItemIssueOnJobCard " & Request.QueryString("busno") & ",'','', " & Request.QueryString("jobid") & "")

                txtnote.Text = ExecuteQuery("select closejob_remark from JobOrderCard_Master where JOC_id=" & Request.QueryString("jobid") & " and locid=1")

                Dim days1, hrs1 As String
                days1 = ExecuteQuery("SELECT (case Bus_Open_Close.job_closedate when '1/1/1900 12:00:00 AM' then '0' else DATEDIFF(day, Bus_Open_Close.job_opendate,Bus_Open_Close.job_closedate) end) FROM JobOrderCard_Master LEFT OUTER JOIN Bus_Open_Close ON JobOrderCard_Master.JOC_id = Bus_Open_Close.JOC_id where Bus_Open_Close.JOC_id=" & Request.QueryString("jobid") & " and locid=1")
                hrs1 = ExecuteQuery("SELECT (case Bus_Open_Close.job_closedate when '1/1/1900 12:00:00 AM' then '0' else DATEDIFF(hh, Bus_Open_Close.job_opentime,Bus_Open_Close.job_closetime) end) FROM JobOrderCard_Master LEFT OUTER JOIN Bus_Open_Close ON JobOrderCard_Master.JOC_id = Bus_Open_Close.JOC_id where Bus_Open_Close.JOC_id=" & Request.QueryString("jobid") & " and locid=1")
                Label1.Text = "Total No of Days :  " & IIf(days1 = "", "0", days1) '& "<br />" & " Total Hours :  " & IIf(hrs1 = "", "", hrs1)


                If deffectpl = "2" Then
                    tbldeffect.Visible = True
                Else
                    tbldeffect.Visible = False
                End If
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
