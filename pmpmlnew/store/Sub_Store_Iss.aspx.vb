Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Threading

Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class Sub_Store_Iss
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim sql1 As String
        Dim dr2 As SqlClient.SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                If Request.QueryString("Opt") = "GetFill" Then
                    Dim intType As Integer = Request.QueryString("Type")
                    Dim strbinno As String = Request.QueryString("binno")
                    Dim stritemname As String = Request.QueryString("itemname")
                    Dim strPartno As String = Request.QueryString("Partno")
                    Dim strmrvno As String = Request.QueryString("mrvno")
                    GetPartItem(intType, strbinno, stritemname, strPartno, strmrvno)
                End If

                If Request.QueryString("Action") = "chkitem" Then
                    Dim binno As String = Request.QueryString("binno")
                    Dim name As String = Request.QueryString("name")
                    checkitem(binno, name)

                End If


                If Not IsPostBack Then

                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    txtWMR.Text = ExecuteQuery("SELECT (MAX(CAST(gatepassno AS int)) +1) FROM  store_issue_master where loc_id = " + Session("locid").ToString() + " ")

                    edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "'")

                    txtissuedate.Text = Now.Date().ToString("dd-MMM-yyyy")
                    con.Open()
                    Dim SQL As String
                    Dim dr As SqlClient.SqlDataReader
                    SQL = "select item_name,item_name from item_master where  loc_id = '" & Session("LocID") & "' "

                    Dim Com As New SqlClient.SqlCommand(SQL, con)
                    'ddlcat.DataTextField = "item_name"
                    'ddlcat.DataValueField = "item_name"
                    dr = Com.ExecuteReader
                    'ddlcat.DataSource = dr
                    'ddlcat.DataBind()

                    Com.Dispose()
                    Com = Nothing
                    dr.Close()
                    dr = Nothing
                    con.Close()
                    'Call Fill_Combo("item_name", "item_name", "item_master", ddlcat, con, "", "Select")

                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try

                Dim mtvexist As String
                mtvexist = ExecuteQuery("select gatepassno from store_issue_master  where gatepassno  = '" + txtWMR.Text + "'")

                If mtvexist <> "" Then
                    Response.Write("<script>alert('WMR NO is already exist')</script>")
                    'Response.Write("<script>alert('MTV NO is already exist');window.location.href='storeissue.aspx'</script>")
                Else

                    Thread.CurrentThread.CurrentCulture = New CultureInfo("en-US")

                    cmd = New SqlCommand("Ins_storeissuemaster_Workshop", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@worker_name ", "")
                    cmd.Parameters.AddWithValue("@trans_date", txtissuedate.Text)
                    cmd.Parameters.AddWithValue("@veh_no", 0)
                    cmd.Parameters.AddWithValue("@getpassno", txtWMR.Text)
                    cmd.Parameters.AddWithValue("@cont_id", ddlvendor.SelectedValue)
                    cmd.Parameters.AddWithValue("@userid", Session("Userid").ToString())
                    cmd.Parameters.AddWithValue("@loc_id", Session("locid").ToString())
                    con.Open()
                    cmd.ExecuteNonQuery()
                    cmd.CommandTimeout = 0

                    con.Close()
                    Dim maxid As Integer


                    maxid = GetMaxIdwithloc("issue_id", Session("locid").ToString(), con, "store_issue_master")

                    If Hid_Rec.Value <> "" Then
                        'Dim i As Integer
                        Dim str As String = Hid_Rec.Value
                        Dim myarray As Array = Split(Hid_Rec.Value, "^")
                        Dim j As Integer


                        For i = 0 To myarray.Length - 2
                            Dim mainarray As Array = Split(myarray(i), "|")
                            Dim sql As String
                            Dim dr As SqlClient.SqlDataReader
                            sql = "select item_id from item_master where item_name = '" & mainarray(2) & "'"
                            Dim cmd1 As New SqlClient.SqlCommand(sql, con)
                            con.Open()
                            dr = cmd1.ExecuteReader()
                            Dim str1 As String
                            If dr.Read() Then
                                str1 = dr(0)
                            End If
                            dr.Close()
                            con.Close()

                            Dim sql1 As String
                            Dim dr1 As SqlClient.SqlDataReader
                            'sql1 = "select item_code from item_detail where SubRack_No = '" & mainarray(0) & "' AND Part_No = '" & mainarray(1) & "' AND Item_Name = '" & mainarray(2) & "'"
                            sql1 = "select item_code from item_detail where  is_delete  <> 1 and  SubRack_No = '" & mainarray(0) & "' "
                            Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                            con.Open()
                            dr1 = cmd2.ExecuteReader()
                            Dim str2 As String
                            If dr1.Read() Then
                                str2 = dr1(0)
                            Else
                                str2 = 0
                            End If
                            dr1.Close()
                            con.Close()


                            cmd = New SqlCommand("Ins_storeissuedetail", con)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@issue_id ", maxid)
                            cmd.Parameters.AddWithValue("@available_qty ", mainarray(3))
                            cmd.Parameters.AddWithValue("@item_code", str2)
                            cmd.Parameters.AddWithValue("@quantity", mainarray(4))
                            cmd.Parameters.AddWithValue("@refno", 0)
                            cmd.Parameters.AddWithValue("@returnable", 0)
                            cmd.Parameters.AddWithValue("@loc_id", Session("LocID").ToString())
                            cmd.Parameters.AddWithValue("@veh_no", txtvehicle.Text)

                            con.Open()
                            cmd.ExecuteNonQuery()
                            cmd.CommandTimeout = 0
                            con.Close()
                        Next
                        Hid_Rec.Value = ""
                        Response.Write("<script>alert('Saved Successfuly');window.location.href='Sub_store_iss.aspx'</script>")
                    End If
                End If
            Catch ex As Exception
                Hid_Rec.Value = ""
                Response.Write("<script>alert('Error Occured While saving')</script>")
            End Try
        End Sub

        <WebMethod()> _
        Public Function GetAutoCompleteDataPartNo(ByVal PartNo As String, ByVal ItemName As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strcnt As String = ExecuteQuery("SELECT COUNT(Item_Name) FROM Item_Detail  WHERE  is_delete  <> 1 and Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "'")
            Dim strCondition As String = ""
            If CInt(strcnt) = 0 Then
                strCondition = "Part_No LIKE '%" & PartNo & "%'"
            ElseIf CInt(strcnt) <> 0 Then
                strCondition = "Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "' AND Part_No LIKE '%" & PartNo & "%'"
            End If

            Try
                Using cmd As New SqlCommand("SELECT Part_No FROM Item_Detail  WHERE  is_delete  <> 1 and  " & strCondition, con)
                    con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("Part_No").ToString())
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

        <WebMethod()> _
        Public Shared Function GetAutoCompleteDataItemName(ByVal prefixText As String) As List(Of String)
            Dim result As New List(Of String)()

            Using con As New SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
                Try
                    Using cmd As New SqlCommand("SELECT Item_Name FROM Item_Detail  WHERE  is_delete  <> 1 and  Item_Name LIKE '%" & prefixText & "%'", con)
                        'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                        con.Open()
                        'cmd.Parameters.AddWithValue("@SearchText", username)
                        Dim dr As SqlDataReader = cmd.ExecuteReader()
                        While dr.Read()
                            result.Add(dr("Item_Name").ToString())
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
            End Using

        End Function

        <WebMethod()> _
        Public Function GetAutoCompleteDataBinNo(ByVal prefixText As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strCondition As String = ""
           
            strCondition = "SubRack_No LIKE '%" & prefixText & "%'"
              

            Try
                Using cmd As New SqlCommand("SELECT SubRack_No FROM Item_Detail  WHERE  is_delete  <> 1 and " & strCondition, con)
                    con.Open()
                    Dim dr As SqlDataReader = cmd.ExecuteReader()
                    While dr.Read()
                        result.Add(dr("SubRack_No").ToString())
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

        Private Sub checkitem(ByVal binno As String, ByVal itemname As String)
            Dim StrItemName As String
            StrItemName = ExecuteQuery("select item_name from item_detail where  is_delete  <> 1 and rack_no = '" & binno & "' and item_name = '" & itemname & "'")

            If StrItemName <> "" Then
                Response.Write("Exist")
            Else
                Response.Write("NotExist")
            End If

        End Sub

        Private Sub GetPartItem(ByVal Type As Integer, ByVal binno As String, ByVal itemname As String, ByVal Partno As String, ByVal mrvno As String)
            Dim locid As String = Session("locid")
            If CInt(Type) <> 4 Then
                Dim stritemdetail As String = ""
                'Dim ItemCode As String = ExecuteQuery("SELECT Item_Code FROM Item_Detail  WHERE Part_No = '" & PartItem & "' AND Item_Name = '" & arrstrcnt(0) & "' AND Subrack_No = '" & arrstrcnt(1) & "'")
                sql1 = "item_stock_bal '" & itemname & "','" & binno & "','" & Partno & "','" & locid & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    stritemdetail += "~" & dr2(0).ToString() + "~" & dr2(1).ToString() + "~" & dr2(2).ToString() + "~" & dr2(3).ToString() + "~" & dr2(4).ToString() + "~" & dr2(5).ToString()
                    Response.Write("got~" & Type & "~" & stritemdetail & "~")
                Else
                    stritemdetail += "~" & "0"
                    Response.Write("Not~" & Type & "~" & stritemdetail & "~")
                End If
                dr2.Close()
                con.Close()

                'Response.Write("got~" & Type & "~" & stritemdetail & "~")

            ElseIf CInt(Type) = 4 Then
                Dim strcnt As String = ExecuteQuery("SELECT Count(MRV_No) FROM Indent_Request_Master  WHERE Is_Delete = 0 AND MRV_No = '" & mrvno & "'")
                If (strcnt <> 0) Then
                    Response.Write("Exist")
                ElseIf (strcnt = 0) Then
                    Response.Write("NotExist")
                End If
            End If
        End Sub

        Protected Sub btnclear_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnclear.Click
            Response.Redirect("Sub_Store_Issue.aspx")
        End Sub

        <WebMethod()> _
        Public Shared Function GetAutoCompleteVech(ByVal prefixText As String) As List(Of String)
            Dim result As New List(Of String)()

            Using con As New SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
                Try
                    Using cmd As New SqlCommand("select   vech_desc  from VECH_MASTER  where is_delete <> 1 and vech_desc  like  '%" & prefixText & "%' ", con)
                        'Using cmd As New SqlCommand("select deffect_decr from tbl_deffect_Master ", con)
                        con.Open()
                        'cmd.Parameters.AddWithValue("@SearchText", username)
                        Dim dr As SqlDataReader = cmd.ExecuteReader()
                        While dr.Read()
                            result.Add(dr("vech_desc").ToString())
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
            End Using

        End Function

    End Class
End Namespace
