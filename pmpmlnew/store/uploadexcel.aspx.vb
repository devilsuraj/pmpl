Imports System.Data

Imports System.Data.SqlClient
imports system.io
Namespace Kdmt
    Partial Class uploadexcel
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                Session("MenuId") = 10

                tblmain.Visible = False
            End If
        End Sub
        Protected Sub btnfilesave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnfilesave.Click
            Try

                If MyFile.PostedFile.ContentLength = 0 Then
                    Response.Write("<script> alert('Cannot upload zero length file');</script>")
                    Return
                Else
                    'string FileName = Path.GetFileName(MyFile.PostedFile.FileName);

                    'string Extension = Path.GetExtension(MyFile.PostedFile.FileName)
                    'string FolderPath = ConfigurationManager.AppSettings["FolderPath"]

                    Dim File As String = (MyFile.PostedFile.FileName)
                    Dim FileInfo As New FileInfo(File)
                    Dim str As String = FileInfo.Name
                    Dim filename As Array = str.ToString().Split(".")
                    Dim exist As String = ""
                    exist = ExecuteQuery("select *  from dbo.Indent_Request_Master  where depoindent = '" + filename(0).ToString() + "' ")

                    Dim locid As Integer
                    Dim locname As String
                    Dim inddate As String
                    If exist = "" Then
                        Dim strpath As String = Server.MapPath("uploadfile")
                        Dim path As String = (strpath + "\" + str)
                        ' MyFile.PostedFile.SaveAs("c:\\UploadFile\\" + str + "");
                        MyFile.PostedFile.SaveAs(path)

                        Dim strConn As String
                        strConn = "Provider=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" & path & ";" & "Extended Properties=Excel 8.0;"
                        'You must use the $ after the object you reference in the spreadsheet
                        Dim myCommand As New OleDb.OleDbDataAdapter("SELECT * FROM [indent$]", strConn)
                        '  Dim myCommand As New OleDbDataAdapter("SELECT * FROM [Sheet1$]", strConn)
                        Dim myDataSet As New DataSet()
                        myCommand.Fill(myDataSet, "temp")
                        Dim maxid As Integer

                        If myDataSet.Tables(0).Rows.Count > 0 Then
                            Dim row As Integer

                            For row = 0 To myDataSet.Tables(0).Rows.Count - 1
                                If row = 2 Then
                                    locname = myDataSet.Tables(0).Rows(2)(3).ToString()
                                    inddate = myDataSet.Tables(0).Rows(2)(7).ToString()
                                    locid = ExecuteQuery("select cont_id  from contractor_master where cont_name = '" + myDataSet.Tables(0).Rows(2)(3).ToString() + "'")
                                    cmd = New SqlCommand("ins_Indent_Request_Master", con)
                                    cmd.CommandType = CommandType.StoredProcedure
                                    cmd.Parameters.AddWithValue("@Indent_No", filename(0))
                                    cmd.Parameters.AddWithValue("@Indent_Date", myDataSet.Tables(0).Rows(2)(7).ToString())
                                    cmd.Parameters.AddWithValue("@User_ID", Session("userid"))
                                    cmd.Parameters.AddWithValue("@ind_locid", locid)
                                    Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                                    strmaxid.Direction = ParameterDirection.Output
                                    cmd.Parameters.Add(strmaxid)
                                    con.Open()
                                    cmd.ExecuteNonQuery()
                                    maxid = cmd.Parameters("@maxid").Value.ToString
                                    con.Close()
                                End If
                                'string insert123 = "INSERT INTO [Tahira].[dbo].[consignee_master]([company_name],[add1],[city],[pincode],[telephone],[email],[fax]) VALUES ('" + Session["uid"].ToString() + "','" + count + "','" + dt + "')";
                                'string insert = "insert into exceldata (name,week_from,week_to,frequency,verified_by,doc_code,date,time_from,time_to,project_name,module_name,activity,description,hrs,remarks) values ('" + myDataSet.Tables[0].Rows[0][0].ToString() + "','" + myDataSet.Tables[0].Rows[0][1].ToString() + "','" + myDataSet.Tables[0].Rows[0][2].ToString() + "','" + myDataSet.Tables[0].Rows[0][3].ToString() + "','" + myDataSet.Tables[0].Rows[0][4].ToString() + "','" + myDataSet.Tables[0].Rows[0][5].ToString() + "','" + myDataSet.Tables[0].Rows[row][6].ToString() + "','" + myDataSet.Tables[0].Rows[row][7].ToString() + "','" + myDataSet.Tables[0].Rows[row][8].ToString() + "','" + myDataSet.Tables[0].Rows[row][9].ToString() + "','" + myDataSet.Tables[0].Rows[row][10].ToString() + "','" + myDataSet.Tables[0].Rows[row][11].ToString() + "','" + myDataSet.Tables[0].Rows[row][12].ToString() + "','" + myDataSet.Tables[0].Rows[row][13].ToString() + "','" + myDataSet.Tables[0].Rows[row][14].ToString() + "')";
                                If row > 3 Then
                                    If myDataSet.Tables(0).Rows(row)(1).ToString() = "" And myDataSet.Tables(0).Rows(row)(2).ToString() = "" And myDataSet.Tables(0).Rows(row)(3).ToString() = "" Then

                                    Else
                                        cmd = New SqlCommand("ins_Indent_Request_Details", con)
                                        cmd.CommandType = CommandType.StoredProcedure

                                        cmd.Parameters.AddWithValue("@Indent_ID", maxid)
                                        cmd.Parameters.AddWithValue("@lfno", myDataSet.Tables(0).Rows(row)(1).ToString())
                                        cmd.Parameters.AddWithValue("@item_name", myDataSet.Tables(0).Rows(row)(3).ToString())
                                        cmd.Parameters.AddWithValue("@part_no", myDataSet.Tables(0).Rows(row)(2).ToString())
                                        cmd.Parameters.AddWithValue("@itemcode", 0)
                                        cmd.Parameters.AddWithValue("@reqqty", myDataSet.Tables(0).Rows(row)(5).ToString())
                                        cmd.Parameters.AddWithValue("@avbqty", 0)
                                        cmd.Parameters.AddWithValue("@issueqty", 0)
                                        cmd.Parameters.AddWithValue("@remark", myDataSet.Tables(0).Rows(row)(6).ToString())

                                        con.Open()
                                        cmd.ExecuteNonQuery()
                                        con.Close()
                                    End If
                                    
                                End If

                            Next
                        Else
                            Response.Write("<script> alert('Ecxcel Sheet Does Not Contain Any data');</script> ")
                        End If
                        tblmain.Visible = True
                        lblindno.Text = filename(0)
                        lblinddate.Text = Format(Date.Parse(inddate), "dd-MMM-yyyy")
                        lblloc.Text = locname.ToString()
                        BindGrid(dgresult, con, "select *  from Indent_Request_Details  where indent_id = '" & maxid & "'")
                    Else
                        Response.Write("<script> alert('This Sheet is already exist');window.location.href='uploadexcel.aspx';</script> ")
                    End If

                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            Finally
                con.Close()
                con.Dispose()
            End Try

        End Sub
    End Class
End Namespace

