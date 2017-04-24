Imports System.Data.SqlClient
Namespace KDMT
    Partial Class updatestock
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Session("MenuId") = 10
                btnSubmit.Attributes.Add("onclick", "return validate ()")
                BDPLite1.SelectedDate = "04/01/2012"
                txtlfno.Focus()

            End If
        End Sub

        Protected Sub txtcode_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtcode.TextChanged
            Try


                txtitem.Text = ""
                Dim sql As String
                sql = "select item_detail.item_name,part_no,isnull(unit,'0'),room_no,rack_no,subrack_no,item_master.item_name as item from item_detail inner join item_master on item_master.item_id = item_detail.item_id where item_code ='" & txtcode.Text & "'"
                Dim dr As SqlClient.SqlDataReader
                cmd = New SqlClient.SqlCommand(sql, con)
                con.Open()
                dr = cmd.ExecuteReader()

                If dr.Read() Then

                    txtitem.Text = dr(0)
                    Txtpartno.Text = dr(1)
                    txtroomno.Text = dr(3)
                    txtlfno.Text = dr(4)
                    txtcat.Text = dr(6)
                    HiddenField1.Value = txtcode.Text

                Else
                    txtitem.Text = ""
                    Txtpartno.Text = ""
                    txtroomno.Text = ""
                    txtlfno.Text = ""
                    txtcat.Text = ""

                End If
                dr.Close()
                con.Close()
            Catch ex As Exception

            End Try
        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                Dim stritemname As String = ExecuteQuery("select item_name  from item_detail  where item_code = '" & HiddenField1.Value & "'  and is_update = 1")

                If stritemname.ToString = "" Then
                    Call fnExecuteNonQuery("UPDATE_INITIAL_STOCK '" & HiddenField1.Value & "','" & BDPLite1.SelectedDate & "','" & txtstock.Text & "'")
                    Response.Write("<script>alert('Update Stock Successfully');window.location.href='updatestock.aspx'</script>")

                Else

                    Response.Write("<script>alert('Stock already Updates');window.location.href='updatestock.aspx'</script>")
                End If


            Catch ex As Exception

            End Try
        End Sub

        Protected Sub Txtpartno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Txtpartno.TextChanged
            Try


                txtitem.Text = ""
                Dim sql As String
                If Txtpartno.Text <> "" Then
                    sql = "select item_detail.item_name,part_no,isnull(unit,'0'),room_no,rack_no,subrack_no,item_master.item_name as item,item_detail.item_code  as code from item_detail inner join item_master on item_master.item_id = item_detail.item_id where part_no ='" & Txtpartno.Text & "'"
                    Dim dr As SqlClient.SqlDataReader
                    cmd = New SqlClient.SqlCommand(sql, con)
                    con.Open()
                    dr = cmd.ExecuteReader()

                    If dr.Read() Then

                        txtitem.Text = dr(0)
                        ' Txtpartno.Text = dr(1)
                        txtroomno.Text = dr(3)
                        txtlfno.Text = dr(4)
                        txtcat.Text = dr(6)
                        txtcode.Text = dr(7)
                        HiddenField1.Value = dr(7)
                    Else
                        txtitem.Text = ""
                        ' Txtpartno.Text = dr(1)
                        txtroomno.Text = ""
                        txtlfno.Text = ""
                        txtcat.Text = ""
                        txtcode.Text = ""
                    End If
                    dr.Close()
                    con.Close()
                End If

            Catch ex As Exception

            End Try
        End Sub

    End Class
End Namespace

