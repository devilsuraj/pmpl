Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class purchase_request_report
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As New DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim itemname As String = ""
        Dim sr As Integer = 0
        Dim file_no As Integer
        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            Try
                If Not IsPostBack Then
                    If Not String.IsNullOrEmpty(Request.QueryString("fileno")) Then
                        filldata(Request.QueryString("fileno"))
                    End If
                End If
            Catch ex As Exception

            End Try

        End Sub
        Private Sub filldata(ByVal file_no As String)
            Try
                Dim curyear As String = Date.Today.Year
                Dim file_name As String
                file_name = ExecuteQuery("select file_name from file_master where file_no = '" + file_no.ToString() + "' ")
                txtfilename.Text = file_name.ToString()

                cmd = New SqlCommand("purchase_request_report", con)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@fileno", file_no.ToString())

                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
                DA = New SqlDataAdapter(cmd)
                DA.Fill(ds)
                grdpurchase.DataSource = ds

                If (DateTime.Today.ToString("MM") > "03") Then
                    grdpurchase.Columns(9).HeaderText = Date.Today.Year & " - " & Date.Today.Year + 1
                    grdpurchase.Columns(10).HeaderText = Date.Today.Year - 1 & " - " & Date.Today.Year
                    grdpurchase.Columns(11).HeaderText = Date.Today.Year - 2 & " - " & Date.Today.Year - 1
                Else
                    grdpurchase.Columns(9).HeaderText = Date.Today.Year - 1 & " - " & Date.Today.Year
                    grdpurchase.Columns(10).HeaderText = Date.Today.Year - 2 & " - " & Date.Today.Year - 1
                    grdpurchase.Columns(11).HeaderText = Date.Today.Year - 3 & " - " & Date.Today.Year - 2
                End If


                grdpurchase.DataBind()
                'GenerateUniqueData(2)



                Dim name As String = grdpurchase.Rows(0).Cells(1).Text
                Dim lf As String = grdpurchase.Rows(0).Cells(2).Text
                Dim subrack As String = grdpurchase.Rows(0).Cells(3).Text
                Dim part As String = grdpurchase.Rows(0).Cells(4).Text
                Dim balance As String = grdpurchase.Rows(0).Cells(5).Text
                Dim mlevel As String = grdpurchase.Rows(0).Cells(6).Text
                Dim threemon As String = grdpurchase.Rows(0).Cells(7).Text
                Dim sixmon As String = grdpurchase.Rows(0).Cells(8).Text
                Dim year As String = grdpurchase.Rows(0).Cells(9).Text
                Dim year1 As String = grdpurchase.Rows(0).Cells(10).Text
                Dim year2 As String = grdpurchase.Rows(0).Cells(11).Text

                Dim i As Integer

                For i = 1 To grdpurchase.Rows.Count

                    If (grdpurchase.Rows(i).Cells(1).Text = name) Then

                        grdpurchase.Rows(i).Cells(1).Text = String.Empty
                        grdpurchase.Rows(i).Cells(2).Text = String.Empty
                        grdpurchase.Rows(i).Cells(3).Text = String.Empty
                        grdpurchase.Rows(i).Cells(4).Text = String.Empty
                        grdpurchase.Rows(i).Cells(5).Text = String.Empty
                        grdpurchase.Rows(i).Cells(6).Text = String.Empty
                        grdpurchase.Rows(i).Cells(7).Text = String.Empty
                        grdpurchase.Rows(i).Cells(8).Text = String.Empty
                        grdpurchase.Rows(i).Cells(9).Text = String.Empty
                        grdpurchase.Rows(i).Cells(10).Text = String.Empty
                        grdpurchase.Rows(i).Cells(11).Text = String.Empty

                    Else

                        name = grdpurchase.Rows(i).Cells(1).Text
                        lf = grdpurchase.Rows(i).Cells(2).Text
                        subrack = grdpurchase.Rows(i).Cells(3).Text
                        part = grdpurchase.Rows(i).Cells(4).Text
                        balance = grdpurchase.Rows(i).Cells(5).Text
                        mlevel = grdpurchase.Rows(i).Cells(6).Text
                        threemon = grdpurchase.Rows(i).Cells(7).Text
                        sixmon = grdpurchase.Rows(i).Cells(8).Text
                        year = grdpurchase.Rows(i).Cells(9).Text
                        year1 = grdpurchase.Rows(i).Cells(10).Text
                        year2 = grdpurchase.Rows(i).Cells(11).Text
                    End If
                Next



            Catch ex As Exception

            Finally
                lblfilename.Text = txtfilename.Text.ToString()
                lblfileno.Text = file_no.ToString()
                lblDate.Text = Date.Today.ToString("dd-MMM-yyyy")
            End Try
        End Sub

        Protected Sub btnshow_Click(sender As Object, e As EventArgs) Handles btnshow.Click
            Try

                If (txtfilename.Text.ToString() = "") Then
                    Response.Write("<script>alert('Please Enter File Name');</script>")
                Else
                    file_no = ExecuteQuery("select file_no from file_master where file_name = '" + txtfilename.Text.ToString() + "' ")
                End If
                filldata(file_no)
            Catch ex As Exception

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

        Protected Sub GenerateUniqueData(cellno As Integer)

            Dim initialnamevalue As String = grdpurchase.Rows(0).Cells(cellno).Text

            Dim i As Integer

            For i = 1 To grdpurchase.Rows.Count

                If (grdpurchase.Rows(i).Cells(cellno).Text = initialnamevalue) Then
                    grdpurchase.Rows(i).Cells(cellno).Text = String.Empty
                Else
                    initialnamevalue = grdpurchase.Rows(i).Cells(cellno).Text
                End If
            Next

        End Sub



        Protected Sub grdpurchase_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdpurchase.RowDataBound
            If e.Row.RowType = DataControlRowType.DataRow Then
                If e.Row.Cells(1).Text <> itemname.ToString() Then

                    sr = sr + 1
                    e.Row.Cells(0).Text = sr
                    itemname = e.Row.Cells(1).Text
                End If
            End If
        End Sub
    End Class
End Namespace
