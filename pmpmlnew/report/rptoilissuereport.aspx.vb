Namespace KDMT
    Partial Class report_rptoilissuereport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

            If Page.IsPostBack = False Then
            Else

                'crysto()

            End If
        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Page.IsPostBack = False Then
                Table1.Visible = False
            End If
        End Sub

       

        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(3).Text = (StrConv(e.Item.Cells(3).Text, VbStrConv.ProperCase))
                    e.Item.Cells(7).Text = (StrConv(e.Item.Cells(7).Text, VbStrConv.ProperCase))
            End Select
        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try
                Dim fromdate As String = ""
                Dim todate As String = ""
                If BDPLite1.SelectedDate <> "#12:00:00 AM#" Then
                    lblfrom.Text = "From Date : " + BDPLite1.SelectedDate.ToString("dd/MM/yy")

                    fromdate = BDPLite1.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If BDPLite2.SelectedDate <> "#12:00:00 AM#" Then
                    lbltodate.Text = "ToDate : " + BDPLite2.SelectedDate.ToString("dd/MM/yy")
                    todate = BDPLite2.SelectedDate.ToString("MM/dd/yyyy")
                End If
                If txtindent.Text <> "" Then
                    lblindent.Text = "Indent No " + " " + txtindent.Text
                Else
                    lblindent.Text = ""
                End If
                BindGrid(grdstock, con, "VIEW_Oil_ITEMISSUE '" & txtindent.Text & "','" & fromdate & "','" & todate & "'")
                If grdstock.Items.Count = 0 Then
                    Response.Write("<script>alert ('Record Not Found') </script>")
                    dicsryst.Visible = False
                    Table1.Visible = False
                Else
                    Table1.Visible = True
                    dicsryst.Visible = False
                End If
            Catch ex As Exception
            End Try
        End Sub

    End Class
End Namespace

