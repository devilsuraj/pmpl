Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Workshop_IndentFittingDetails
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strcompno As String = ""
        Public strwsno As String = ""
        Public strVech As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                If Not IsPostBack Then
                    Fill_Combo("itemid", "item_name", "tbl_Repair_Item", drpindentitem, con, "", "")
                    'Fill_Combo("Part_Type_ID", "Part_Type", "Part_Type_Master", drpindentitem, con, "", "")
                    bdpfittingDate.SelectedDate = Now.Date
                    bdpremovedate.SelectedDate = Now.Date
                    BindGrid(grddeffectlist, con, "view_Indentitemdetails '" & Format(bdpfittingDate.SelectedDate, "MM/dd/yyyy") & "','" & Format(bdpremovedate.SelectedDate, "MM/dd/yyyy") & "','" & drpindentitem.SelectedItem.Text & "'")
                End If
                'strcompno = getAutoCompleteList("select Part_Company_No from Part_Master where Part_Type=" & drpindentitem.SelectedValue & " order by Part_Company_No", "Part_Company_No")
                'strwsno = getAutoCompleteList("select Part_WS_No from Part_Master where Part_Type=" & drpindentitem.SelectedValue & " order by Part_WS_No", "Part_WS_No")
                strVech = getAutoCompleteList("select (VECH_NO + '/' + vech_desc) as VECH_NO from VECH_MASTER  order by VECH_NO", "VECH_NO")
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub drpindentitem_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpindentitem.SelectedIndexChanged
            Try
                'strcompno = getAutoCompleteList("select Part_Company_No from Part_Master where Part_Type=" & drpindentitem.SelectedValue & " order by Part_Company_No", "Part_Company_No")
                'strwsno = getAutoCompleteList("select Part_WS_No from Part_Master where Part_Type=" & drpindentitem.SelectedValue & " order by Part_WS_No", "Part_WS_No")
                BindGrid(grddeffectlist, con, "view_Indentitemdetails '" & Format(bdpfittingDate.SelectedDate, "MM/dd/yyyy") & "','" & Format(bdpremovedate.SelectedDate, "MM/dd/yyyy") & "','" & drpindentitem.SelectedItem.Text & "'")
            Catch ex As Exception
            End Try
        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            Try
                cmd = New SqlCommand
                ds = New DataSet
                DA = New SqlDataAdapter
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure

                cmd.CommandText = "ins_indentfittingitem"
                cmd.Parameters.AddWithValue("@indentitem", drpindentitem.SelectedItem.Text)
                cmd.Parameters.AddWithValue("@comno", txtcompno.Value)
                cmd.Parameters.AddWithValue("@wsno", txtworkshopno.Value)
                cmd.Parameters.AddWithValue("@fittingdate", bdpfittingDate.SelectedDate)
                cmd.Parameters.AddWithValue("@removedate", bdpremovedate.SelectedDate)
                cmd.Parameters.AddWithValue("@busno", txtbusno.Value)
                cmd.Parameters.AddWithValue("@fuelused", txtfuel.Text)
                cmd.Parameters.AddWithValue("@kms", txtkms.Text)
                cmd.Parameters.AddWithValue("@userid", Session("UserId"))
                'cmd.Parameters.AddWithValue("@sys_date", Now.Date)

                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()

                BindGrid(grddeffectlist, con, "view_Indentitemdetails '" & Format(bdpfittingDate.SelectedDate, "MM/dd/yyyy") & "','" & Format(bdpremovedate.SelectedDate, "MM/dd/yyyy") & "','" & drpindentitem.SelectedItem.Text & "'")

                txtcompno.Value = ""
                txtworkshopno.Value = ""
                bdpfittingDate.SelectedDate = Now.Date
                bdpremovedate.SelectedDate = Now.Date
                txtbusno.Value = ""
                txtfuel.Text = ""
                txtkms.Text = ""
            Catch ex As Exception
            End Try
        End Sub
    End Class
End Namespace
