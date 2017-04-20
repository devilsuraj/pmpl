Namespace KDMT
    Partial Class rptvehiclewise
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not IsPostBack Then
                btnshow.Attributes.Add("onclick", "return validate();")
                BDPLite1.SelectedDate = Now.Date()
                BDPLite2.SelectedDate = Now.Date()
                Table1.Visible = False
            End If


 
        End Sub

        Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
            ExportDataGrid(grdstock)
            'Response.Redirect("excelvehiclewise.aspx?fromdate=" & BDPLite1.SelectedDate & " &todate= " & BDPLite2.SelectedDate & " &veh_no= " & txtbusno.Text & " ")
        End Sub
        Protected Sub grdstock_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdstock.ItemDataBound
            Select Case e.Item.ItemType
                Case ListItemType.AlternatingItem, ListItemType.Item

                    e.Item.Cells(1).Text = (StrConv(e.Item.Cells(1).Text, VbStrConv.ProperCase))
            End Select
        End Sub

        Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click

            Dim fromdate As String = BDPLite1.SelectedDate
            Dim todate As String = BDPLite2.SelectedDate
            Dim veh_no As String = txtbusno.Text

            lblfrom.Text = Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy")
            lbltodate.Text = Format(Convert.ToDateTime(todate), "dd/MM/yyyy")
            lblvechno.Text = veh_no
            BindGrid(grdstock, con, "view_veh_wise '" & fromdate & "','" & todate & "','" & veh_no & "'")
            If grdstock.Items.Count = 0 Then
                Response.Write("<script>alert ('Record Not Found') </script>")
                Table1.Visible = False
            Else
                Table1.Visible = True
            End If
            'BindGrid(Datagrid1, con, "VIEW_PASS_REPORT '" & fromdate & "','" & todate & "','3'")
            'BindGrid(Datagrid2, con, "VIEW_PASS_REPORT '" & fromdate & "','" & todate & "','4'")

        End Sub
    End Class
End Namespace

