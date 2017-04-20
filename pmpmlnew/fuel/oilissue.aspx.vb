Imports System.Data.SqlClient
Namespace KDMT
    Partial Class oilissue
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                btnsubmit.Attributes.Add("onclick", "return validate();ValidateSave();")
                edit_combo(ddldepot, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "'")
                BDPissuedate.SelectedDate = Now.Date()
            End If
        End Sub

        Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
            cmd = New SqlCommand
            ds = New DataSet
            DA = New SqlDataAdapter
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            Dim i As Integer
            Try


                cmd = New SqlCommand("ins_oilissuemaster", con)
                cmd.CommandType = CommandType.StoredProcedure


                cmd.Parameters.AddWithValue("@oilissuedate", BDPissuedate.SelectedDate)
                cmd.Parameters.AddWithValue("@oilrefno", txtref.Text)
                cmd.Parameters.AddWithValue("@workername", txtwname.Text)
                cmd.Parameters.AddWithValue("@oiligatepass", txtgate.Text)
                cmd.Parameters.AddWithValue("@oilapprovedby", txtapproved.Text)
                cmd.Parameters.AddWithValue("@oilissuedepot", ddldepot.SelectedValue)
                cmd.Parameters.AddWithValue("@remark", txtremark.Text)
                cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                cmd.Parameters.AddWithValue("@locid", Session("LocID"))


                Dim strmaxid As New SqlParameter("@maxid", SqlDbType.BigInt)
                strmaxid.Direction = ParameterDirection.Output
                cmd.Parameters.Add(strmaxid)

                con.Open()
                cmd.ExecuteNonQuery()
                Dim maxid As String = cmd.Parameters("@maxid").Value.ToString()
                con.Close()

                If hdnrwcnt.Value <> "" Then
                    'Dim i As Integer
                    Dim str As String = hdnrwcnt.Value
                    Dim myarray As Array = Split(hdndetail.Value, "|")
                    Dim j As Integer
                    j = myarray.Length - 1

                    For i = 0 To myarray.Length - 2
                        If myarray(i) <> "" Then
                            Dim mainarray As Array = Split(myarray(i), "^")
                            ' Dim itemcode As Integer = ExecuteQuery("get_itemcode  '" & mainarray(4) & "','" & mainarray(2) & "','" & mainarray(1) & "'")
                            cmd = New SqlCommand("ins_issuedetail", con)
                            cmd.CommandType = CommandType.StoredProcedure

                            cmd.Parameters.AddWithValue("@oilissueid", maxid)
                            cmd.Parameters.AddWithValue("@oilitemname", mainarray(0))
                            cmd.Parameters.AddWithValue("@issueltrperbarrel", mainarray(1))
                            cmd.Parameters.AddWithValue("@issuebarrel", mainarray(2))
                            cmd.Parameters.AddWithValue("@issuetotal", mainarray(3))


                            con.Open()
                            cmd.ExecuteNonQuery()
                            Response.Write("<script>alert('Saved Successfuly');window.location.href='oilissue.aspx'</script>")
                            con.Close()

                            hdndetail.Value = ""
                        End If

                    Next
                End If


            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
       
    End Class
End Namespace
