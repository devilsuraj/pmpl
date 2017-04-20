Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class store_KITDRB
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim qry As String
        Dim total As Double
        Public currenedate


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                btnSubmit.Attributes.Add("Onclick", "return validate ()")
                If Not IsPostBack Then
                    fillgrid()
                    bdpdrbdate.SelectedDate = Now.Date()
                    fydrbyear.Value = GetFinYear(1)
                End If

            Catch ex As Exception

            End Try
        End Sub

        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then
                'Dim bdplite As BasicFrame.WebControls.BDPLite
                'bdplite = CType(e.Item.FindControl("bdpreceive_date"), BasicFrame.WebControls.BDPLite)
                'bdplite.SelectedDate = Now.Date()

                Dim radauthenticate As RadioButton
                radauthenticate = e.Item.FindControl("authenticate")
                radauthenticate.Attributes.Add("onclick", "radvaidate(this);Details('" & e.Item.Cells(0).Text & "')")

            End If
        End Sub

        Protected Sub dgresult_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgresult.ItemCommand
            Try

                If e.CommandName = "select" Then
                    Hid_Rec.Value = e.CommandArgument.ToString()
                    ' BindGrid(DataGrid1, con, " view_receive_detail_storeid '" & Hid_Rec.Value & "'")
                    'ViewState("Save") = 2

                End If
            Catch ex As Exception

            End Try
        End Sub

        Private Sub fillgrid()
            Try
                Dim Part_Type As String = ""

                If Session("Dept_code") = 1 Then
                    Part_Type = "sp"
                ElseIf Session("Dept_code") = 2 Then
                    Part_Type = "hw"
                End If

                BindGrid(dgresult, con, "view_receive_authenticate 'KIT' ")
            Catch ex As Exception

            End Try
        End Sub

        Public Function GetFinYear(ByVal yearinc As Integer)
            Dim finyear As String = ""
            Dim s As DateTime = bdpdrbdate.SelectedDate
            Dim m As Integer = s.Month
            Dim y As Integer = s.Year
            If (m > 3) Then
                finyear = Convert.ToString((y - yearinc + 1)) + "-" + Convert.ToString((y - yearinc + 2))
            Else
                finyear = Convert.ToString((y - yearinc)) + "-" + Convert.ToString((y - yearinc + 1))
            End If
            Return finyear
        End Function

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click

        End Sub
    End Class
End Namespace

