Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Login
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As New SqlClient.SqlCommand
#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub
        Protected WithEvents ImageButton4 As System.Web.UI.WebControls.ImageButton


        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            'Put user code to initialize the page here
            'ImageButton1.Attributes.Add("Onclick", "return check()")
            'ImageButton1.Attributes.Add("Onclick", "return check1()")
            If Page.IsPostBack = False Then

                'DropDownList1.DataBind()
                ' DropDownList1.Items.Insert(0, " -- Select -- ")



            End If
        End Sub

        Private Sub ImageButton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
            Dim strUserName As String
            Dim strPassword As String

            Dim Con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("Con"))
            If Con.State = ConnectionState.Closed Then
                Con.Open()
            End If

            Dim cmd As New SqlClient.SqlCommand("SELECT USERID, USERNAME, USERPASS,Dept_code,Loc_ID,RoleId,Windowid FROM USER_MASTER WHERE USERNAME = '" & txtusername.Value & "' AND USERPASS ='" & txtpass.Text & "' AND dbo.User_Master.isDeleted=0 and dept_code = '" & DropDownList1.SelectedValue & "'", Con)
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
                    'Response.End()
                ElseIf txtpass.Text <> (dr("USERPASS")) Then
                    lblinfo.Text = "Invalid Password!"
                    cmd.Dispose()
                    dr.Close()
                    Con.Close()
                    Con.Dispose()
                    'Response.End()


                ElseIf Trim((dr("Dept_code"))) = "1" And Me.DropDownList1.SelectedValue = "1" Then
                    Dim ds As New DataSet
                    Session("UserName") = dr("USERNAME")
                    Session("UserId") = dr("USERID")
                    Session("LocID") = dr("Loc_ID")
                    loc_name()
                    'Session("RoleId") = dr("RoleId")
                    'Session("WindowId") = dr("WindowId")
                    'Session("cashid") = ddlcashier.SelectedValue
                    dr.Close()
                    Con.Close()
                    Con.Dispose()
                    Response.Redirect("../store/Storeitemmaster.aspx")
               
                Else
                    lblinfo.Text = "Invalid Department"
                End If
            Else
                lblinfo.Text = "Invalid User Name or Password, try again."
            End If
        End Sub



        Sub loc_name()
            Dim sql1 As String = "select *  from depo_master where depo_code = " & Session("LocID").ToString() & " "
            Dim dr1 As SqlClient.SqlDataReader
            Dim cmd1 As New SqlCommand(sql1, con)
            con.Open()
            dr1 = cmd1.ExecuteReader()
            If dr1.Read() Then
                Session("depo_name") = dr1(1)
            End If
            dr1.Close()
            con.Close()
        End Sub
    End Class
End Namespace

