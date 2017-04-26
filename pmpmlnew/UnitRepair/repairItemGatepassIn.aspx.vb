Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class repairItemGatepassIn
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            btnSubmit.Attributes.Add("Onclick", "return validate()")
            Session("MenuId") = 3
            If Not IsPostBack Then
                BDPrecdate.Text = Now.Date()
                trgrid.Visible = False
                trbtn.Visible = False
            End If
        End Sub

        Protected Sub btn_show_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_show.Click
            gridbind()

        End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click


            Try
                Dim check As Integer = 0
                For i = 0 To dgresult.Items.Count - 1


                    Dim txtqty As TextBox = CType(dgresult.Items(i).Cells(7).FindControl("txtqty"), TextBox)
                    Dim txtRemark As TextBox = CType(dgresult.Items(i).Cells(9).FindControl("txtremark"), TextBox)
                    Dim ddlResult As DropDownList = CType(dgresult.Items(i).Cells(8).FindControl("ddlResult"), DropDownList)
                    Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(10).FindControl("chkselect"), CheckBox)


                    If chkselect.Checked = True Then

                        cmd = New SqlCommand("ins_Repairgatepassreturn", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@inchallanno", txtinchallannno.Text)
                        cmd.Parameters.AddWithValue("@gatepassdetid", dgresult.Items(i).Cells(0).Text)
                        cmd.Parameters.AddWithValue("@recqty", txtqty.Text)
                        cmd.Parameters.AddWithValue("@recremark", txtRemark.Text)
                        cmd.Parameters.AddWithValue("@recdate", BDPrecdate.Text)
                        cmd.Parameters.AddWithValue("@result", ddlResult.SelectedValue)
                        cmd.Parameters.AddWithValue("@RepairWorkId", dgresult.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@itemid", dgresult.Items(i).Cells(2).Text)
                        'cmd.Parameters.AddWithValue("@RepairRecId", dgresult.Items(i).Cells(11).Text)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                        check = 1

                    End If

                Next
                If check = 1 Then
                    Response.Write("<script>alert('Saved Successfuly')</script>")
                Else
                    Response.Write("<script>alert('Please Tick the boxes ')</script>")
                End If


            Catch ex As Exception
            End Try


            gridbind()
            trgrid.Visible = "False"
        End Sub
        Private Sub gridbind()
            Dim dt As DataTable = GetDatatTable("view_repair_gatepassitem  '" & txtoutchallanno.Text & "','Yes'")

            If dt.Rows.Count > 0 Then
                dgresult.DataSource = dt
                dgresult.DataBind()

                trgrid.Visible = True
                trbtn.Visible = True
            Else
                Response.Write("<script>alert('No Record Found')</script>")

                trgrid.Visible = False
                trbtn.Visible = False
            End If



        End Sub


        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then

                Dim txtissueqty As TextBox = CType(e.Item.Cells(7).FindControl("txtqty"), TextBox)
                txtissueqty.Attributes.Add("Onblur", "checkqty('" + txtissueqty.ClientID + "','" + e.Item.Cells(6).Text + "','" + e.Item.Cells(5).Text + "')")


            End If
        End Sub
    End Class
End Namespace

