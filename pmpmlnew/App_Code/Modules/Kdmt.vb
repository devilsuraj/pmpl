Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Namespace KDMT
    Public Module Kdmt
        Function FilldropDown(ByVal depo_code As Integer, ByRef loc As DropDownList)
            Dim sqlcon As New SqlConnection(ConfigurationSettings.AppSettings("Con"))
            Dim cmd As New SqlCommand
            Dim dr As SqlDataReader
            cmd.Connection = sqlcon
            cmd.CommandText = "GetWindowLocation"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.Add(New SqlParameter("@depo_code", depo_code))
            loc.DataValueField = "win_counter"
            loc.DataTextField = "win_desc"
            Try
                sqlcon.Open()
                loc.DataSource = cmd.ExecuteReader()
                loc.DataBind()
                sqlcon.Close()
            Catch ex As Exception

            End Try
        End Function
        Public Function fnCheckDuplicate(ByVal QueryString As String) As Boolean
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Dim cmd As New SqlClient.SqlCommand
            Dim dr As SqlClient.SqlDataReader
            Dim errMsg As String

            Try
                Con.Open()
                cmd.Connection = Con
                cmd.CommandType = CommandType.Text
                cmd.CommandText = QueryString

                dr = cmd.ExecuteReader
                If dr.HasRows = True Then fnCheckDuplicate = True Else fnCheckDuplicate = False

                dr.Close()
                cmd.Dispose()
                Con.Close()
            Catch
                dr.Close()
                cmd.Dispose()
                Con.Close()
                errMsg = Err.Description
                Return errMsg
            Finally
                cmd.Dispose()
                Con.Close()
            End Try
            Return fnCheckDuplicate
        End Function
        Public Function Fill_Combo(ByRef PK_COL As String, ByRef DESC_COL As String, _
                              ByRef TableName As String, ByRef Combo_Name As DropDownList, _
                              ByRef con As SqlClient.SqlConnection, _
                              Optional ByRef CONDITION As String = "", _
                              Optional ByRef First_Cmb_Value As String = "")

            con.Open()
            Dim SQL As String
            Dim dr As SqlClient.SqlDataReader

            SQL = "SELECT DISTINCT " & PK_COL & ", " & DESC_COL & " FROM " & TableName
            If CONDITION <> "" Then SQL = SQL & " WHERE " & CONDITION
            SQL = SQL & " ORDER BY " & DESC_COL

            Dim Com As New SqlClient.SqlCommand(SQL, con)
            Combo_Name.DataTextField = DESC_COL
            Combo_Name.DataValueField = PK_COL
            dr = Com.ExecuteReader
            Combo_Name.DataSource = dr
            Combo_Name.DataBind()

            If First_Cmb_Value <> "" Then Combo_Name.Items.Insert(0, First_Cmb_Value) : Combo_Name.Items(0).Value = 0

            Com.Dispose()
            Com = Nothing
            dr.Close()
            dr = Nothing
            con.Close()
        End Function
        Public Function Fill_Combo_pk(ByRef PK_COL As String, ByRef DESC_COL As String, _
                      ByRef TableName As String, ByRef Combo_Name As DropDownList, _
                      ByRef con As SqlClient.SqlConnection, _
                      Optional ByRef CONDITION As String = "", _
                      Optional ByRef First_Cmb_Value As String = "")

            con.Open()
            Dim SQL As String
            Dim dr As SqlClient.SqlDataReader

            SQL = "SELECT DISTINCT " & PK_COL & ", " & DESC_COL & " FROM " & TableName
            If CONDITION <> "" Then SQL = SQL & " WHERE " & CONDITION
            SQL = SQL & " ORDER BY " & PK_COL

            Dim Com As New SqlClient.SqlCommand(SQL, con)
            Combo_Name.DataTextField = DESC_COL
            Combo_Name.DataValueField = PK_COL
            dr = Com.ExecuteReader
            Combo_Name.DataSource = dr
            Combo_Name.DataBind()

            If First_Cmb_Value <> "" Then Combo_Name.Items.Insert(0, First_Cmb_Value) : Combo_Name.Items(0).Value = 0

            Com.Dispose()
            Com = Nothing
            dr.Close()
            dr = Nothing
            con.Close()
        End Function
        Public Sub edit_combo(ByVal dropdownlist As DropDownList, ByVal PK_COL As String, ByVal DESC_COL As String, ByVal table_name As String, ByVal condition As String)

            Try

                'string sql = "select distinct(comp_id),comp_name from comp_detail  where  comp_id = ";
                Dim cmd As SqlCommand
                Dim sql As String = "select distinct(" & PK_COL & ") ," & DESC_COL & " from " & table_name & " where " & condition & "  order by " & DESC_COL & " "
                Dim dr As SqlDataReader
                Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
                cmd = New SqlCommand(sql, Con)
                Con.Open()
                dr = cmd.ExecuteReader()
                dropdownlist.DataTextField = DESC_COL
                dropdownlist.DataValueField = PK_COL
                dropdownlist.DataSource = dr
                dropdownlist.DataBind()
                Con.Close()
                'dropdownlist.Items.Insert(0, "select");

                dropdownlist.Items.Insert(0, New ListItem("Select", "0"))

            Catch ex As Exception
            Finally

            End Try
        End Sub
        Public Sub route_combo(ByVal dropdownlist As DropDownList, ByVal PK_COL As String, ByVal DESC_COL As String, ByVal table_name As String, ByVal condition As String)

            Try

                'string sql = "select distinct(comp_id),comp_name from comp_detail  where  comp_id = ";
                Dim cmd As SqlCommand
                Dim sql As String = "select (" & PK_COL & ") ," & DESC_COL & " from " & table_name & " where " & condition & "  order by cast(" & table_name & "." & DESC_COL & "  as int) "
                Dim dr As SqlDataReader
                Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
                cmd = New SqlCommand(sql, Con)
                Con.Open()
                dr = cmd.ExecuteReader()
                dropdownlist.DataTextField = DESC_COL
                dropdownlist.DataValueField = PK_COL
                dropdownlist.DataSource = dr
                dropdownlist.DataBind()
                Con.Close()
                'dropdownlist.Items.Insert(0, "select");

                dropdownlist.Items.Insert(0, New ListItem("Select", "0"))

            Catch ex As Exception
            Finally

            End Try
        End Sub

        Public Function Fill_Combofrom(ByRef PK_COL As String, ByRef DESC_COL As String, _
                              ByRef TableName As String, ByRef Combo_Name As DropDownList, _
                              ByRef con As SqlClient.SqlConnection, _
                              Optional ByRef CONDITION As String = "", _
                              Optional ByRef First_Cmb_Value As String = "")

            con.Open()
            Dim SQL As String
            Dim dr As SqlClient.SqlDataReader

            SQL = "select distinct start_loc_name as r from planning_sheet_master  union all select distinct end_loc_name as r from planning_sheet_master  union all select distinct via_loc_name as r from planning_sheet_master order by r "

            Dim Com As New SqlClient.SqlCommand(SQL, con)
            Combo_Name.DataTextField = dr(0)
            Combo_Name.DataValueField = dr(0)
            dr = Com.ExecuteReader
            Combo_Name.DataSource = dr
            Combo_Name.DataBind()

            If First_Cmb_Value <> "" Then Combo_Name.Items.Insert(1, First_Cmb_Value) : Combo_Name.Items(1).Value = 0

            Com.Dispose()
            Com = Nothing
            dr.Close()
            dr = Nothing
            con.Close()
        End Function
        Public Function fnExecuteNonQuery(ByVal QueryString As String) As String
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Dim cmd As New SqlClient.SqlCommand
            Dim errMsg As String

            Try
                Con.Open()
                cmd.Connection = Con
                cmd.CommandType = CommandType.Text
                cmd.CommandText = QueryString

                cmd.Transaction = Con.BeginTransaction
                cmd.ExecuteNonQuery()
                cmd.Transaction.Commit()

                cmd.Dispose()
                Con.Close()
            Catch
                cmd.Transaction.Rollback()
                cmd.Dispose()
                Con.Close()
                errMsg = Err.Description
                Return errMsg
            Finally
                cmd.Dispose()
                Con.Close()
            End Try

        End Function
        Public Function Show_Msg(ByRef Page_Name As Page, ByRef strMessage As String, ByVal strPage As String)
            Dim strScript As String
            strScript = "<script language=""VBSCRIPT"">"
            strScript = strScript & "Msgbox """ & strMessage & """, vbInformation, ""Server Message"" "
            strScript = strScript & "</script>"
            If (Not Page_Name.IsStartupScriptRegistered("clientScript")) Then
                Page_Name.RegisterStartupScript("clientScript", strScript)
            End If

        End Function
        Public Function GetMaxId(ByRef ColName As String, ByRef con As SqlClient.SqlConnection, ByRef TabName As String) As Long
            Dim SQL As String
            Dim dr As SqlClient.SqlDataReader

            SQL = "SELECT isNull(MAX(" & ColName & "),0) FROM " & TabName

            Dim cmd As New SqlClient.SqlCommand(SQL, con)
            dr = cmd.ExecuteReader
            dr.Read()
            If IsDBNull(dr.GetValue(0)) = True Then
                GetMaxId = 1
            Else
                GetMaxId = dr.GetValue(0) + 1
            End If
            cmd.Dispose()
            dr.Close()
            dr = Nothing
        End Function
        Public Function GetMaxId1(ByRef ColName As String, ByRef con As SqlClient.SqlConnection, ByRef TabName As String) As Long
            Dim SQL As String
            Dim dr As SqlClient.SqlDataReader

            SQL = "SELECT isNull(MAX(" & ColName & "),0) FROM " & TabName

            Dim cmd As New SqlClient.SqlCommand(SQL, con)
            dr = cmd.ExecuteReader
            dr.Read()
            If IsDBNull(dr.GetValue(0)) = True Then
                GetMaxId1 = 1
            Else
                GetMaxId1 = dr.GetValue(0)
            End If
            cmd.Dispose()
            dr.Close()
            dr = Nothing
        End Function
        Public Function GetMaxIdwithloc(ByRef ColName As String, ByRef locid As String, ByRef con As SqlClient.SqlConnection, ByRef TabName As String) As Long
            Dim SQL As String
            Dim dr As SqlClient.SqlDataReader

            SQL = "SELECT isNull(MAX(" & ColName & "),0) FROM  " & TabName & " where loc_id = " & locid & " "

            Dim cmd As New SqlClient.SqlCommand(SQL, con)
            dr = cmd.ExecuteReader
            dr.Read()
            If IsDBNull(dr.GetValue(0)) = True Then
                GetMaxIdwithloc = 1
            Else
                GetMaxIdwithloc = dr.GetValue(0)
            End If
            cmd.Dispose()
            dr.Close()
            dr = Nothing
        End Function
        Public Function BindGrid(ByRef grdMod As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet
            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                SQL = SQL.Replace("  ", "  ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdMod.DataSource = ds
                grdMod.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function
        Public Function fnCheckRights(ByVal strPageName As String, ByVal intUserID As Integer, ByVal intCheckFor As Integer) As String
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Dim dr As SqlClient.SqlDataReader
            Con.Open()
            Dim cmd As New SqlClient.SqlCommand("SELECT addto, Edit, [Delete] FROM User_Rights WHERE FormPath='" & strPageName & "' AND UserID=" & intUserID, Con)
            dr = cmd.ExecuteReader
            If dr.HasRows = True Then
                dr.Read()
                If dr("New") = 0 And dr("Edit") = 0 And dr("Delete") = 0 Then
                    Return "You do not have rights to view this page."
                ElseIf intCheckFor = 0 And dr("New") = 0 Then                           ' New
                    Return "You do not have rights to add records in this module."
                ElseIf intCheckFor = 1 And dr("Edit") = 0 Then                          ' Edit
                    Return "You do not have rights to edit records in this module."
                ElseIf intCheckFor = 2 And dr("Delete") = 0 Then                        ' Delete
                    Return "You do not have rights to delete records in this module."
                End If
            End If
            dr.Close()
            Con.Close()
        End Function

        Public Function GetDatatTable(ByVal strSql As String) As DataTable
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Con.Open()

            Dim cmd As New SqlCommand(strSql, Con)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable

            Try
                da.Fill(dt)
            Catch
                cmd.Dispose()
                da.Dispose()
                Con.Close()

            End Try

            Return dt
        End Function
        Public Function GetDataset(ByVal strSql As String) As DataSet
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Con.Open()

            Dim cmd As New SqlCommand(strSql, Con)
            Dim da As New SqlDataAdapter(cmd)
            Dim ds As New DataSet

            Try
                da.Fill(ds)
            Catch
                cmd.Dispose()
                da.Dispose()
                Con.Close()

            End Try

            Return ds
        End Function

        Public Function ExecuteQuery(ByVal strSql As String) As String
            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            Dim dr As SqlClient.SqlDataReader
            Dim strReturn As String = ""
            Con.Open()

            Dim cmd As New SqlClient.SqlCommand(strSql, Con)
            dr = cmd.ExecuteReader
            'dr.Read()
            If dr.Read Then
                strReturn = dr.GetValue(0)
            End If

            Return strReturn

            cmd.Dispose()
            dr.Close()
            dr = Nothing

        End Function

        Public Function ExportDataGrid(ByVal grid As DataGrid)
            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.Buffer = True

            Dim header1 As String = "content-disposition"
            Dim header2 As String = "attachment;filename=FileName.xls"
            Dim contentType As String = "application/vnd.xls"

            HttpContext.Current.Response.AddHeader(header1, header2)
            HttpContext.Current.Response.ContentType = contentType

            'HttpContext.Current.Response.ContentType = str
            HttpContext.Current.Response.Charset = ""
            'EnableViewState = False

            Dim oStringWriter As New System.IO.StringWriter()
            Dim oHtmlTextWriter As New System.Web.UI.HtmlTextWriter(oStringWriter)


            grid.AllowPaging = False
            'grid.DataSource = DirectCast(HttpContext.Current.Session("table1"), DataTable)
            'grid.DataBind()
            PrepareControlForExport(grid)
            ClearControls(grid)
            grid.RenderControl(oHtmlTextWriter)
            Dim sb As New StringBuilder
            'sb.Append("<TABLE border='1'><Center><thead style='font-size:16;font-family:Verdana;color:green'><font color='green' size='5'><b>bbbbbbbbbbbbbbbbb</font></thead></Center>")

            ' HttpContext.Current.Response.Write("<b> dddddddddddddddddzzzz</b><br />")
            HttpContext.Current.Response.Write(oStringWriter.ToString())
            'HttpContext.Current.Response.Write("pmpmlssssssssssss")
            'HttpContext.Current.Response.Write(oStringWriter.ToString())
            HttpContext.Current.Response.[End]()
        End Function

        Private Sub PrepareControlForExport(ByVal control As Control)
            Dim i As Integer = 0
            Do While (i < control.Controls.Count)
                Dim current As Control = control.Controls(i)
                If (TypeOf current Is LinkButton) Then
                    control.Controls.Remove(current)
                    control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
                ElseIf (TypeOf current Is ImageButton) Then
                    control.Controls.Remove(current)
                    control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
                ElseIf (TypeOf current Is HyperLink) Then
                    control.Controls.Remove(current)
                    control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
                ElseIf (TypeOf current Is DropDownList) Then
                    control.Controls.Remove(current)
                    control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
                ElseIf (TypeOf current Is CheckBox) Then
                    control.Controls.Remove(current)
                    control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
                    'TODO: Warning!!!, inline IF is not supported ?
                End If
                If current.HasControls Then
                    PrepareControlForExport(current)
                End If
                i = (i + 1)
            Loop
        End Sub
        Public Sub ClearControls(ByVal control As Control)
            For i As Integer = control.Controls.Count - 1 To 0 Step -1
                ClearControls(control.Controls(i))
            Next

            If Not (TypeOf control Is TableCell) Then
                If Not (control.[GetType]().GetProperty("SelectedItem")) Is Nothing Then
                    Dim literal As New LiteralControl
                    control.Parent.Controls.Add(literal)
                    Try
                        literal.Text = DirectCast(control.[GetType]().GetProperty("SelectedItem").GetValue(control, Nothing), String)
                    Catch
                    End Try
                    control.Parent.Controls.Remove(control)
                ElseIf Not (control.[GetType]().GetProperty("Text")) Is Nothing Then
                    Dim literal As New LiteralControl
                    control.Parent.Controls.Add(literal)
                    literal.Text = DirectCast(control.[GetType]().GetProperty("Text").GetValue(control, Nothing), String)
                    control.Parent.Controls.Remove(control)
                End If
            End If
            Return
        End Sub

        Public Function getAutoCompleteList(ByVal strSql As String, ByVal strColName As String) As String
            Dim str As New StringBuilder
            Dim dt As New DataTable
            Dim i As Integer = 0

            dt = GetDatatTable(strSql)

            For i = 0 To dt.Rows.Count - 1
                str = str.Append(",'" & dt.Rows(i).Item(strColName) & "'")
            Next

            If str.Length <> 0 Then str.Remove(0, 1)
            Return str.ToString

        End Function

Public Function Get_ItemwisePO_Details(ByRef PO_itemwise As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet
            'Dim cmd As SqlCommand
            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                'cmd.CommandText = "Item_Wise_PO_Report"
                'SqlCommand cmd = New SqlCommand "Item_Wise_PO_Report", con
                SQL = SQL.Replace(" ", "  ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                PO_itemwise.DataSource = ds
                PO_itemwise.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function

        Public Function Vendor_Details(ByRef grdVendorDetail As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet

            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                'cmd.CommandText = "Item_Wise_PO_Report"
                'SqlCommand cmd = New SqlCommand "Item_Wise_PO_Report", con
                SQL = SQL.Replace(" ", " ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdVendorDetail.DataSource = ds
                grdVendorDetail.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function

        Public Function Item_Details(ByRef grdItemDetail As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet

            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                'cmd.CommandText = "Item_Wise_PO_Report"
                'SqlCommand cmd = New SqlCommand "Item_Wise_PO_Report", con
                SQL = SQL.Replace(" ", " ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdItemDetail.DataSource = ds
                grdItemDetail.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function

        Public Function Receipt_Control_Details(ByRef grdReceiptcontrol As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet

            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                'cmd.CommandText = "Item_Wise_PO_Report"
                'SqlCommand cmd = New SqlCommand "Item_Wise_PO_Report", con
                SQL = SQL.Replace(" ", " ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdReceiptcontrol.DataSource = ds
                grdReceiptcontrol.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function
        Public Function BindGridview(ByRef grdMod As GridView, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet
            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                SQL = SQL.Replace("  ", "  ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdMod.DataSource = ds
                grdMod.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function
        Public Function BindGrid_Recevie(ByRef grdMod As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet
            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                SQL = SQL.Replace("  ", "  ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdMod.DataSource = ds.Tables(0)
                con.Close()
                grdMod.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function
        Public Function BindGrid_SubRecevie(ByRef grdMod As DataGrid, ByRef con As SqlClient.SqlConnection, ByRef SQL As String) As DataSet
            Try

                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                SQL = SQL.Replace("  ", "  ")
                Dim da As New SqlClient.SqlDataAdapter(SQL, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                grdMod.DataSource = ds.Tables(1)
                con.Close()
                grdMod.DataBind()
                Return ds
            Catch e As DataException
                e.Message.ToString()
            Finally
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End Try
        End Function
    End Module
End Namespace
