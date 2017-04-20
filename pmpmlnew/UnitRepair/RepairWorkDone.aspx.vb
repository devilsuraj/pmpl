Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing

Namespace KDMT
    Partial Class RepairWorkDone
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim DA As SqlDataAdapter
        Dim ds As DataSet
        Dim i As Integer = 0
        Public sb As New StringBuilder()

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                btnSubmit.Attributes.Add("Onclick", "return validate ()")
                edit_combo(ddlvendor, "cont_id", "cont_name", "contractor_master", "loc_id = '" & Session("LocID") & "' and isRepair  = '1'")
                'btnSubmit.Attributes.Add("Onclick", "return validate ()")
                ' gridbind()
            End If
        End Sub
        Private Sub gridbind()
            BindGrid(dgresult, con, "view_repair_items '" & ddlvendor.SelectedValue & "'")
        End Sub
        Protected Sub dgresult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgresult.ItemDataBound
            If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then
                Dim bdpliteToDate As BasicFrame.WebControls.BDPLite
                bdpliteToDate = CType(e.Item.FindControl("bdpTodate"), BasicFrame.WebControls.BDPLite)
                bdpliteToDate.SelectedDate = Now.Date()

                If e.Item.Cells(16).Text = "3" Then
                    e.Item.BackColor = Color.BurlyWood
                End If

                Dim txtissueqty As TextBox = CType(e.Item.Cells(9).FindControl("txtqty"), TextBox)
                txtissueqty.Attributes.Add("Onblur", "checkqty('" + txtissueqty.ClientID + "','" + e.Item.Cells(7).Text + "','" + e.Item.Cells(8).Text + "')")

                If e.Item.Cells(5).Text = "0" Then
                    e.Item.Cells(5).Text = "NA"
                End If

                i += 1
                Dim fromdate As DateTime = e.Item.Cells(15).Text
                sb.AppendLine("function getindent" + i.ToString() + "() {  if((Date.parse('" + fromdate + "')) > (Date.parse(document.getElementById('" + bdpliteToDate.ClientID + "_TextBox').value))){ alert('Done Date Should be equal or greater than received date');var d1=new Date(); document.getElementById('" + bdpliteToDate.ClientID + "_TextBox').value = d1.toString('dd-MMM-yyyy');    ; return false ; }};  var b" + i.ToString() + "= document.getElementById('" + bdpliteToDate.ClientID + "_TextBox')  ; addEventHandler(b" + i.ToString() + ",getindent" + i.ToString() + ");")
            End If
        End Sub

        'Protected Sub grddetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grddetails.ItemDataBound
        '    If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
        '        Dim txtissueqty As TextBox = CType(e.Item.Cells(8).FindControl("txtissueqty"), TextBox)
        '        txtissueqty.Attributes.Add("Onblur", "checkqty('" + txtissueqty.ClientID + "','" + e.Item.Cells(6).Text + "','" + e.Item.Cells(7).Text + "')")

        '    End If
        'End Sub

        Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
            Try
                Dim check As Integer = 0
                For i = 0 To dgresult.Items.Count - 1


                    Dim txtqty As TextBox = CType(dgresult.Items(i).Cells(9).FindControl("txtqty"), TextBox)
                    Dim txtWrkDone As TextBox = CType(dgresult.Items(i).Cells(12).FindControl("txtWrkDone"), TextBox)
                    Dim ddlResult As DropDownList = CType(dgresult.Items(i).Cells(13).FindControl("ddlResult"), DropDownList)
                    Dim bdpfromdate As BasicFrame.WebControls.BDPLite
                    bdpfromdate = CType(dgresult.Items(i).Cells(10).FindControl("bdpfromdate"), BasicFrame.WebControls.BDPLite)
                    Dim bdpTodate As BasicFrame.WebControls.BDPLite
                    bdpTodate = CType(dgresult.Items(i).Cells(11).FindControl("bdpTodate"), BasicFrame.WebControls.BDPLite)
                    Dim chkselect As CheckBox = CType(dgresult.Items(i).Cells(14).FindControl("chkselect"), CheckBox)


                    If chkselect.Checked = True Then

                        cmd = New SqlCommand("ins_work_details", con)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@RepairRecDtlId", dgresult.Items(i).Cells(1).Text)
                        cmd.Parameters.AddWithValue("@itemcode", dgresult.Items(i).Cells(2).Text)
                        cmd.Parameters.AddWithValue("@qty", txtqty.Text)
                        cmd.Parameters.AddWithValue("@frmdate", dgresult.Items(i).Cells(15).Text)
                        cmd.Parameters.AddWithValue("@todate", bdpTodate.SelectedDate)
                        cmd.Parameters.AddWithValue("@workdone", txtWrkDone.Text)
                        cmd.Parameters.AddWithValue("@result", ddlResult.SelectedItem.Text)
                        cmd.Parameters.AddWithValue("@userid", Session("Userid"))
                        cmd.Parameters.AddWithValue("@sys_date", Now.Date)
                        cmd.Parameters.AddWithValue("@isReceive", 0)
                        cmd.Parameters.AddWithValue("@isDelete", 0)
                        cmd.Parameters.AddWithValue("@repairflag", dgresult.Items(i).Cells(16).Text)
                        Dim strmaxid As New SqlParameter("@RepairWorkId", SqlDbType.BigInt)
                        strmaxid.Direction = ParameterDirection.Output
                        cmd.Parameters.Add(strmaxid)

                        con.Open()
                        cmd.ExecuteNonQuery()
                        Dim maxrepairid As Integer = cmd.Parameters("@RepairWorkId").Value.ToString
                        con.Close()
                        check = 1

                    End If

                Next
                If check = 1 Then
                    Response.Write("<script>alert('Saved Successfuly');window.location.href='RepairWorkDone.aspx'</script>")
                    ' Response.Write("<script>alert('Saved Successfuly')</script>")

                Else
                    Response.Write("<script>alert('Please Tick the boxes ')</script>")
                End If


            Catch ex As Exception


            End Try


        End Sub


        Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click
            gridbind()
        End Sub
    End Class
End Namespace







