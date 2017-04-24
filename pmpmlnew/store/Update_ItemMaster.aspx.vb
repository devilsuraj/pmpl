Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.Services
Imports System.Collections.Generic

Namespace KDMT
    Partial Class Update_ItemMaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As New DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                fillgrid()
                Session("MenuId") = 10
                If rdbupdate.Checked = True Then
                    grdview.Visible = False
                    grditem.Visible = True
                ElseIf rdbview.Checked = True Then

                    grdview.Visible = True
                    grditem.Visible = False
                End If


            End If
        End Sub

        Protected Sub fillgrid()
            Try
                cmd = New SqlCommand("update_item_master", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@itemcode", "")
                cmd.Parameters.AddWithValue("@fileno", "")
                cmd.Parameters.AddWithValue("@type", "1")

                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
                DA = New SqlDataAdapter(cmd)
                DA.Fill(ds)
                grditem.DataSource = ds
                grditem.DataBind()
                grditem.Columns(1).Visible = False
            Catch
            End Try
        End Sub

        Protected Sub viewgrid()
            Try
                cmd = New SqlCommand("update_item_master", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@itemcode", "")
                cmd.Parameters.AddWithValue("@fileno", "")
                cmd.Parameters.AddWithValue("@type", "3")

                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
                DA = New SqlDataAdapter(cmd)
                DA.Fill(ds)
                grdview.DataSource = ds
                grdview.DataBind()
                grdview.Columns(1).Visible = False
            Catch
            End Try
        End Sub

        <WebMethod()> _
        Public Shared Function GetAutoCompletefilename(ByVal prefixText As String) As List(Of String)
            Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
            Dim result As New List(Of String)()
            Dim strSQL As String = ""

            Try

                'Department and designation
                strSQL = "select file_no, file_name  from file_master where is_del = 0 and file_name LIKE '%" & prefixText & "%'"
                'strSQL = "SELECT em.EMP_NAME,em.EMP_CODE,dm.KDMT_DEPT_DESC,et.emp_sub_desc,em.GPFNO FROM EMP_MASTER em INNER JOIN KDMT_DEPT_MASTER dm ON em.KDMT_DEPT_CODE = dm.KDMT_DEPT_CODE INNER JOIN emp_sub_type et ON em.EMP_SUB_CODE = et.emp_sub_code INNER JOIN Location_Master lm ON lm.Loc_ID = em.loc_id WHERE(em.is_delete = 0 And et.is_delete = 0 And dm.IS_DELETED = 0 And lm.isdeleted = 0) and em.EMP_CODE  IN (Select EMP_CODE from Emp_SalarySlip_Total_Temp) " & strCondition & " and em.EMP_CODE not in (select emp_code from trans_ret_exp where type_code in (2,3,4) and is_delete = 0 and  from_date < (select ('01-'+ month + '-' + convert(varchar,year)) from Emp_Completed_Payment where Is_del = 0 and is_Generate = 1)) ORDER BY em.EMP_NAME"
                'strSQL = "select emp_code from trans_ret_exp where type_code in (2,3,4) and is_delete = 0 and from_date < (select top 1 '01-'+month+'-'+convert(varchar,year) as process_date from Emp_SalarySlip_Total_Temp where is_delete = 0 order by convert(smalldatetime,'01-'+month+'-'+convert(varchar,year)) desc)"

                Using cmd As New SqlCommand(strSQL, con)
                    con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("file_name").ToString()) 'dr("Loc_Name").ToString()
                    End While
                    If dr.HasRows = False Then
                        result.Add("NotExist")
                    End If
                    con.Close()

                End Using
            Catch ex As Exception
                con.Close()
            Finally
                con.Close()
            End Try
            Return result
        End Function      

        Protected Sub grditem_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grditem.RowCommand
            Try
                If e.CommandName = "update" Then

                    Dim index As Integer = Convert.ToInt32(e.CommandArgument)
                    If grditem.PageIndex > 1 Then
                        index = index - (grditem.PageIndex * 100)
                    End If

                    Dim gvRow As GridViewRow = grditem.Rows(index)
                    Dim item_code As Label = gvRow.FindControl("item_code")
                    Dim item_name As Label = gvRow.FindControl("item_name")
                    Dim txtfilename As TextBox = gvRow.FindControl("txtfilename")
                    con.Open()
                    Dim file_no As Integer = ExecuteQuery("select file_no from file_master where file_name = '" + txtfilename.Text.ToString() + "' ")
                    Dim cmd1 As New SqlCommand
                    cmd1 = New SqlCommand("update_item_master", con)
                    cmd1.CommandType = CommandType.StoredProcedure

                    cmd1.Parameters.AddWithValue("@itemcode", item_code.Text)
                    cmd1.Parameters.AddWithValue("@fileno", file_no.ToString())
                    cmd1.Parameters.AddWithValue("@type", "2")


                    cmd1.ExecuteNonQuery()
                    con.Close()
                    fillgrid()
                End If
            Catch
            Finally
                con.Close()
            End Try
        End Sub

        Protected Sub grditem_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grditem.PageIndexChanging
            fillgrid()
            grditem.PageIndex = e.NewPageIndex
            grditem.DataBind()
        End Sub
        Protected Sub grdview_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grdview.PageIndexChanging
            viewgrid()
            grdview.PageIndex = e.NewPageIndex
            grdview.DataBind()
        End Sub

        Protected Sub OnRowUpdating(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
          
        End Sub

        Protected Sub rdbupdate_CheckedChanged(sender As Object, e As EventArgs) Handles rdbupdate.CheckedChanged
            fillgrid()
            grdview.Visible = False
            grditem.Visible = True
        End Sub

        Protected Sub rdbview_CheckedChanged(sender As Object, e As EventArgs) Handles rdbview.CheckedChanged
            viewgrid()
            grdview.Visible = True
            grditem.Visible = False
        End Sub
    End Class

End Namespace
