Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports System.Collections.Generic
Namespace KDMT
    Partial Class WMR
        Inherits System.Web.UI.Page
        Shared con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim sql1 As String
        Dim dr2 As SqlClient.SqlDataReader

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                Session("MenuId") = 2
                If Request.QueryString("Opt") = "GetFill" Then
                    Dim intType As Integer = Request.QueryString("Type")
                    Dim strbinno As String = Request.QueryString("binno")
                    Dim stritemname As String = Request.QueryString("itemname")
                    Dim strPartno As String = Request.QueryString("Partno")
                    Dim strmrvno As String = Request.QueryString("mrvno")


                    GetPartItem(intType, strbinno, stritemname, strPartno, strmrvno)


                End If

                If Not IsPostBack Then

                    btnSubmit.Attributes.Add("onclick", "return validate();")
                    txtWMR.Text = ExecuteQuery("getwmrno '" & Now.Date().ToString("MM-dd-yyyy") & "','" & Session("LocID") & "'")

                    edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "0=0")

                    txtissuedate.Text = Now.Date().ToString("dd-MMM-yyyy")
                    con.Open()
                    Dim SQL As String
                    Dim dr As SqlClient.SqlDataReader
                    SQL = "select item_name,item_name from item_master where loc_id = '" & Session("LocID") & "' "

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
            Dim dtitemdetail As DataTable
            Try

                Dim mtvexist As String
                mtvexist = ExecuteQuery("select wmr_no from Workshop_Material_Request  where wmr_no  = '" + txtWMR.Text + "'")

                If mtvexist <> "" Then
                    Response.Write("<script>alert('WMR NO is already exist')</script>")
                    'Response.Write("<script>alert('MTV NO is already exist');window.location.href='storeissue.aspx'</script>")
                Else

                    Thread.CurrentThread.CurrentCulture = New CultureInfo("en-US")

                    cmd = New SqlCommand("Ins_Workshop_Material_Request", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@wmr_no ", txtWMR.Text)
                    cmd.Parameters.AddWithValue("@wmr_transdate", txtissuedate.Text)
                    cmd.Parameters.AddWithValue("@wmr_contid", ddlvendor.SelectedValue)
                    cmd.Parameters.AddWithValue("@wmr_approvedby", txtapprovedby.Text)
                    cmd.Parameters.AddWithValue("@wmr_remark", txtremark.Text)
                    cmd.Parameters.AddWithValue("@wmr_jobyymm", txtjobyymm.Text)
                    cmd.Parameters.AddWithValue("@wmr_jobno", txtjobno.Text)
                    cmd.Parameters.AddWithValue("@wmr_userid", Session("Userid").ToString())
                    cmd.Parameters.AddWithValue("@wmr_locid", Session("locid").ToString())
                    Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                    strmaxid.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(strmaxid)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                    cmd.CommandTimeout = 0
                    con.Close()
                    If Hid_Rec.Value <> "" Then
                        'Dim i As Integer
                        Dim str As String = Hid_Rec.Value
                        Dim myarray As Array = Split(Hid_Rec.Value, "^")
                        Dim j As Integer
                        For i = 0 To myarray.Length - 2
                            Dim mainarray As Array = Split(myarray(i), "|")


                            dtitemdetail = GetDatatTable("item_stock_bal '" & mainarray(2) & "','" & mainarray(0) & "','" & mainarray(1) & "','" & Session("LocID").ToString() & "'")


                            cmd = New SqlCommand("Ins_Workshop_Material_Request_Details", con)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@wmrdet_masterid ", maxid)
                            cmd.Parameters.AddWithValue("@wmrdet_itemcode ", dtitemdetail.Rows(0).Item("itemcode").ToString())
                            cmd.Parameters.AddWithValue("@wmrdet_Reqqty", mainarray(3))
                            cmd.Parameters.AddWithValue("@wmrdet_locid", Session("LocID").ToString())
                            con.Open()
                            cmd.ExecuteNonQuery()
                            cmd.CommandTimeout = 0
                            con.Close()
                        Next
                        Hid_Rec.Value = ""
                        Response.Write("<script>alert('Saved Successfuly');window.location.href='WMR.aspx'</script>")
                    End If
                End If
            Catch ex As Exception
                Hid_Rec.Value = ""
                Response.Write("<script>alert('Error Occured While saving')</script>")
            Finally
                con.Close()
            End Try
        End Sub

        <WebMethod()> _
        Public Function GetAutoCompleteDataPartNo(ByVal PartNo As String, ByVal ItemName As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strcnt As String = ExecuteQuery("SELECT COUNT(Item_Name) FROM Item_Detail  WHERE Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "'")
            Dim strCondition As String = ""
            If CInt(strcnt) = 0 Then
                strCondition = "Part_No LIKE '%" & PartNo & "%'"
            ElseIf CInt(strcnt) <> 0 Then
                strCondition = "Item_Name = '" & ItemName & "' AND SubRack_No = '" & BinNo & "' AND Part_No LIKE '%" & PartNo & "%'"
            End If

            Try
                Using cmd As New SqlCommand("SELECT Part_No FROM Item_Detail  WHERE " & strCondition, con)
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
        Public Function GetAutoCompleteDataItemName(ByVal ItemName As String, ByVal PartNo As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strcnt As String = ExecuteQuery("SELECT COUNT(Part_No) FROM Item_Detail  WHERE Part_No = '" & PartNo & "' AND SubRack_No = '" & BinNo & "'")
            Dim strCondition As String = ""
            If CInt(strcnt) = 0 Then
                strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
            ElseIf CInt(strcnt) <> 0 Then
                strCondition = "Part_No = '" & PartNo & "' AND SubRack_No = '" & BinNo & "' AND Item_Name  LIKE '%" & ItemName & "%'"
            End If
            Try
                Using cmd As New SqlCommand("SELECT Item_Name FROM Item_Detail  WHERE " & strCondition, con)
                    con.Open()
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
        End Function

        <WebMethod()> _
        Public Function GetAutoCompleteDataBinNo(ByVal ItemName As String, ByVal PartNo As String, ByVal BinNo As String) As List(Of String)
            Dim result As New List(Of String)()
            Dim strCondition As String = ""
            If ItemName = "" And PartNo = "" Then
                strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
            Else
                Dim strcnt As String = ExecuteQuery("SELECT COUNT(SubRack_No) FROM Item_Detail  WHERE Part_No = '" & PartNo & "' AND Item_Name = '" & ItemName & "'")

                If CInt(strcnt) = 0 Then
                    strCondition = "SubRack_No LIKE '%" & BinNo & "%'"
                ElseIf CInt(strcnt) <> 0 Then
                    strCondition = "Part_No = '" & PartNo & "' Item_Name = '" & ItemName & "' AND SubRack_No LIKE '%" & BinNo & "%'"
                End If
            End If

            Try
                Using cmd As New SqlCommand("SELECT SubRack_No FROM Item_Detail  WHERE " & strCondition, con)
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

        Private Sub GetPartItem(ByVal Type As Integer, ByVal binno As String, ByVal itemname As String, ByVal Partno As String, ByVal mrvno As String)
            Dim locid As String = Session("locid")
            If CInt(Type) <> 4 Then
                Dim stritemdetail As String = ""
                'Dim ItemCode As String = ExecuteQuery("SELECT Item_Code FROM Item_Detail  WHERE Part_No = '" & PartItem & "' AND Item_Name = '" & arrstrcnt(0) & "' AND Subrack_No = '" & arrstrcnt(1) & "'")
                sql1 = "item_stock_bal '" & itemname & "','" & locid & "','" & binno & "','" & Partno & "'"
                Dim cmd2 As New SqlClient.SqlCommand(sql1, con)
                con.Open()

                dr2 = cmd2.ExecuteReader
                If dr2.Read Then
                    stritemdetail += "~" & dr2(0).ToString() + "~" & dr2(1).ToString() + "~" & dr2(2).ToString() + "~" & dr2(3).ToString()
                Else
                    stritemdetail += "~" & "0"
                End If
                dr2.Close()
                con.Close()
                Response.Write("got~" & Type & "~" & stritemdetail & "~")

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
        <System.Web.Script.Services.ScriptMethod(), _
System.Web.Services.WebMethod()> _
        Public Shared Function SearchVehicle(ByVal prefixText As String, ByVal count As Integer) As List(Of String)

            Dim cmd As SqlCommand = New SqlCommand
            cmd.CommandText = "select vech_desc from vech_master where " & _
                " vech_desc like '%' + @SearchText + '%'"
            cmd.Parameters.AddWithValue("@SearchText", prefixText)
            cmd.Connection = con
            con.Open()
            Dim customers As List(Of String) = New List(Of String)
            Dim sdr As SqlDataReader = cmd.ExecuteReader
            While sdr.Read
                customers.Add(sdr("vech_desc").ToString)
            End While
            con.Close()
            Return customers
        End Function
    End Class
End Namespace
