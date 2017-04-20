Imports System.Data
Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_IRR_Repair_Fit
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strmech As String = ""
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                If Not IsPostBack Then
                    strmech = getAutoCompleteList("select Name from tbl_Mechanic_master order by Name", "Name")
                    If Request.QueryString("id") = 1 Then
                        cmd = New SqlClient.SqlCommand
                        ds = New DataSet
                        cmd.Connection = con
                        con.Open()
                        DA = New SqlClient.SqlDataAdapter("view_IRR_fit_Details " & Request.QueryString("irrid") & "", con)
                        DA.Fill(ds, "tblEmp")
                        txtirrno.Text = ds.Tables("tblEmp").Rows(0).Item("IRR_No").ToString
                        txtjocNo.Text = ds.Tables("tblEmp").Rows(0).Item("joccode").ToString
                        txtdeffecttype.Text = ds.Tables("tblEmp").Rows(0).Item("deffect_decr").ToString
                        txtBusNo.Text = ds.Tables("tblEmp").Rows(0).Item("busno").ToString
                        txtmodel.Text = ds.Tables("tblEmp").Rows(0).Item("model").ToString
                        txtchassis.Text = ds.Tables("tblEmp").Rows(0).Item("chassis").ToString
                        txtkms.Text = ds.Tables("tblEmp").Rows(0).Item("kms").ToString
                        txtengine.Text = ds.Tables("tblEmp").Rows(0).Item("engine").ToString
                        txtmechanic.Text = ds.Tables("tblEmp").Rows(0).Item("Mechanicname").ToString
                        txtitemname.Text = ds.Tables("tblEmp").Rows(0).Item("Item_name").ToString
                        txtpartno.Text = ds.Tables("tblEmp").Rows(0).Item("part_NO").ToString
                        btnsave.Enabled = True
                    ElseIf Request.QueryString("id") = 2 Then
                        cmd = New SqlClient.SqlCommand
                        ds = New DataSet
                        cmd.Connection = con
                        con.Open()
                        DA = New SqlClient.SqlDataAdapter("view_IRR_fit_Details " & Request.QueryString("irrid") & "", con)
                        DA.Fill(ds, "tblEmp")
                        txtirrno.Text = ds.Tables(1).Rows(0).Item("IRR_No").ToString
                        txtjocNo.Text = ds.Tables(1).Rows(0).Item("joccode").ToString
                        txtdeffecttype.Text = ds.Tables(1).Rows(0).Item("deffect_decr").ToString
                        txtBusNo.Text = ds.Tables(1).Rows(0).Item("busno").ToString
                        txtmodel.Text = ds.Tables(1).Rows(0).Item("model").ToString
                        txtchassis.Text = ds.Tables(1).Rows(0).Item("chassis").ToString
                        txtkms.Text = ds.Tables(1).Rows(0).Item("kms").ToString
                        txtengine.Text = ds.Tables(1).Rows(0).Item("engine").ToString
                        txtmechanic.Text = ds.Tables(1).Rows(0).Item("Mechanicname").ToString
                        txtitemname.Text = ds.Tables(1).Rows(0).Item("Item_name").ToString
                        txtpartno.Text = ds.Tables(1).Rows(0).Item("part_NO").ToString
                        txtregno.Text = ds.Tables(1).Rows(0).Item("repair_regNo").ToString
                        txtrepairmechanic.Value = ds.Tables(1).Rows(0).Item("fit_Mechanicname").ToString
                        txtremark.Text = ds.Tables(1).Rows(0).Item("fit_Remark").ToString
                        btnsave.Enabled = False
                    End If
                End If


            Catch ex As Exception
                Response.Write(ex.Message)

            End Try

        End Sub

        Protected Sub btnsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsave.Click
            Try
                If txtregno.Text = "" Then
                    Call Show_Msg(Page, "Enter Repair Reg. No.", "IRR_Repair_Fit.aspx")
                    txtregno.Focus()
                Else
                    If txtrepairmechanic.Value = "" Then
                        Call Show_Msg(Page, "Enter Mechanic Name", "IRR_Repair_Fit.aspx")
                        txtregno.Focus()
                    Else
                        cmd = New SqlCommand
                        ds = New DataSet
                        DA = New SqlDataAdapter
                        cmd.Connection = con
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.CommandText = "ins_IRR_fit"
                        cmd.Parameters.AddWithValue("@IRR_ID", Request.QueryString("irrid"))
                        cmd.Parameters.AddWithValue("@Joc_ID", Request.QueryString("jocid"))
                        cmd.Parameters.AddWithValue("@repair_regNo", txtregno.Text)
                        cmd.Parameters.AddWithValue("@fitMechanicname", txtrepairmechanic.Value)
                        cmd.Parameters.AddWithValue("@fit_Remark", txtremark.Text)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                        reset()
                        Call Show_Msg(Page, "Save Successfully", "IRR_Repair_Fit.aspx")
                        Response.Write("<script>window.location.href='../Workshop/IRR_Register.aspx'</script>")

                    End If
                End If
            Catch ex As Exception

            End Try
        End Sub
        Sub reset()
            txtirrno.Text = ""
            txtjocNo.Text = ""
            txtdeffecttype.Text = ""
            txtBusNo.Text = ""
            txtmodel.Text = ""
            txtchassis.Text = ""
            txtkms.Text = ""
            txtengine.Text = ""
            txtmechanic.Text = ""
            txtitemname.Text = ""
            txtpartno.Text = ""
            txtregno.Text = ""
            txtrepairmechanic.Value = ""
            txtremark.Text = ""
        End Sub
    End Class
End Namespace
