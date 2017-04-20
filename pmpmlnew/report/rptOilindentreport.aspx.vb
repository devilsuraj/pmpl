Namespace KDMT


    Partial Class report_rptOilindentreport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Page.IsPostBack = False Then

                Table1.Visible = False

            End If
        End Sub


        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))

            End Select

        End Sub

        Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
            Try

                Dim fromdate As String = ""
                Dim todate As String = ""

                If txtindent.Text = "" Then
                    Response.Write("<script>alert ('Please Enter Indent No') </script>")

                Else

                    Dim dt As DataTable = GetDatatTable("view_oil_indent_master '" & txtindent.Text & "'")
                    lbldepotname.Text = "Date :" + dt.Rows(0)("cont_name").ToString()
                    lbldate.Text = "Depot Name :" + dt.Rows(0)("trans_date").ToString()

                    lblindent.Text = "Indent No :" + " " + txtindent.Text
                    BindGrid(grdstock, con, "VIEW_Oil_ITEMISSUE '" & txtindent.Text & "','" & fromdate & "','" & todate & "'")

                    If grdstock.Items.Count = 0 Then
                        Response.Write("<script>alert ('Record Not Found') </script>")
                        Table1.Visible = False
                    Else
                        Table1.Visible = True
                    End If
                End If




            Catch ex As Exception

            End Try
        End Sub

    End Class
End Namespace
