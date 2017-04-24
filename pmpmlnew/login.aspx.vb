Imports System.Data

Partial Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("UserId") = ""
            Session("UserName") = ""
            Session("LocID") = ""
            Session("Host") = ConfigurationManager.AppSettings("Host")
        End If

    End Sub

    Protected Sub btnLogin_ServerClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.ServerClick
        Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))

        If Con.State = ConnectionState.Closed Then
            Con.Open()
        End If

        Dim cmd As New SqlClient.SqlCommand("SELECT USERID, USERNAME, USERPASS,Dept_code,Loc_ID,RoleId,Windowid FROM USER_MASTER WHERE USERNAME = '" & txtusername.Value & "' AND USERPASS ='" & txtpass.Value & "' AND dbo.User_Master.isDeleted=0 and dept_code='" & DropDownList1.SelectedValue & "'", Con)
        Dim dr As SqlClient.SqlDataReader

        dr = cmd.ExecuteReader

        If dr.HasRows = True Then
            dr.Read()
            If txtusername.Value.ToUpper <> UCase(dr("USERNAME")) Then
                lblinfo.Text = "Invalid User Name!"
                cmd.Dispose()
                dr.Close()
                Con.Close()
                Con.Dispose()
            ElseIf txtpass.Value <> (dr("USERPASS")) Then
                lblinfo.Text = "Invalid Password!"
                cmd.Dispose()
                dr.Close()
                Con.Close()
                Con.Dispose()
            ElseIf DropDownList1.SelectedValue <> Trim((dr("Dept_code"))) Then
                lblinfo.Text = "Invalid Department!"
                cmd.Dispose()
                dr.Close()
                Con.Close()
                Con.Dispose()
            Else
                Dim ds As New DataSet
                Session("UserName") = dr("USERNAME")
                Session("UserId") = dr("USERID").ToString
                Session("LocID") = dr("Loc_ID")
                Session("RoleId") = dr("RoleId")
                Session("Dept_code") = Trim(dr("Dept_code"))
                If DropDownList1.SelectedValue = "1" Then
                    Session("Dept_type") = "SP"
                ElseIf DropDownList1.SelectedValue = "2" Then
                    Session("Dept_type") = "HW"

                Else : DropDownList1.SelectedValue = "4"
                    Session("Dept_type") = "FUEL"
                End If
                Session("Deptid") = DropDownList1.SelectedValue


                If Session("Dept_code") = "4" Then

                    Response.Redirect("default.aspx")
                ElseIf Session("Dept_code") = "5" Then
                    Session("UserName") = dr("USERNAME")
                    Session("UserId") = dr("USERID").ToString
                    Session("LocID") = dr("Loc_ID")
                    Session("RoleId") = dr("RoleId")
                    Session("Dept_code") = dr("dept_code")
                    Session("engineer") = ddlengineer.SelectedItem.ToString
                    dr.Close()
                    Con.Close()
                    Con.Dispose()
                    Response.Redirect("default.aspx")
                ElseIf Session("Dept_code") <> "4" And Session("RoleId") = 1 Then
                    Response.Redirect("default.aspx")
                Else
                    Response.Redirect("default.aspx")
                End If
                dr.Close()
                Con.Close()
                Con.Dispose()
            End If
        Else
            lblinfo.Text = "Invalid User Name or Password, try again."
        End If
    End Sub
End Class

