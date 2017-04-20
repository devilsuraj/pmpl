Imports System.Data.SqlClient
Imports System.Drawing


Namespace KDMT


    Partial Class UserMaster
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlCommand
#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub


        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try
                If Session("UserName").ToString = "aeon" Then
                    'ExecuteQuery("sleect *  from user_master  where userid ")
                    ImageButton3.Attributes.Add("Onclick", "return validate()")
                    If Page.IsPostBack = False Then


                    End If
                Else
                    Response.Redirect("storeitemmaster.aspx")


                End If

            Catch ex As Exception

            End Try
        End Sub

        Private Sub ImageButton3_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton3.Click
            Try

                Dim username As String = ExecuteQuery("select username  from user_master where username = '" & txtname.Text & "' ")
                If username <> "" Then
                    Response.Write("<script>alert('User Name Allready Exist')</script>")
                    txtname.ForeColor = Color.Red
                    txtname.Focus()

                Else

                    cmd = New SqlClient.SqlCommand("Ins_usermaster", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@fname", txtfname.Text)
                    cmd.Parameters.AddWithValue("@lname", txtlast.Text)
                    cmd.Parameters.AddWithValue("@name", txtname.Text)
                    cmd.Parameters.AddWithValue("@pass", txtpass.Text)
                    cmd.Parameters.AddWithValue("@locid", Session("locid"))
                    cmd.Parameters.AddWithValue("@role", "1")
                    cmd.Parameters.AddWithValue("@dept_code", ddldept.SelectedValue)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    Response.Write("<script>alert('Save Successfully');window.location.href='usermaster.aspx'</script>")
                    con.Close()
                End If
            Catch ex As Exception

            End Try
        End Sub
    End Class

End Namespace
