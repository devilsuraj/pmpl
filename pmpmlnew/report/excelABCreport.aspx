<%@ Import Namespace = "system" %>
<%@ Import Namespace = "system.Data.sqlclient" %>
<%@ Import Namespace = "system.Data" %>
<%@ Import Namespace = "KDMT" %>
<%@ Page Language="VB" AutoEventWireup="false" CodeFile="excelABCreport.aspx.vb" Inherits="KDMT.excelissuereport" %>

<%  Dim con As New SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
    Dim fromdate As String = Request.QueryString("fromdate")
    Dim todate As String = Request.QueryString("todate")
    Response.Clear()
    Response.ContentType = "application/download"
    Response.AddHeader("content-disposition", "filename = excellists.xls")
    Dim i As Integer
    Dim da As New SqlClient.SqlDataAdapter("VIEW_ABC ", con)
    Dim ds As New DataSet()
    da.SelectCommand.CommandTimeout = 0
    da.Fill(ds, "temp")
    
    Dim rowcount As Integer = ds.Tables(0).Rows.Count
    Response.Write("")
    Response.Write("<table border = 1>")
    Response.Write("<tr><Td colspan=12 align=center style=font-size: 18pt><B>PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED</b></td></tr>")

    Response.Write("<tr><Td colspan=12 align=center style=font-size: 16pt><B>Item Issue Report  &nbsp " & Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy") & "&nbsp&nbsp;To&nbsp&nbsp;" & Format(Convert.ToDateTime(todate), "dd/MM/yyyy") & "</b></td></tr>")
    Response.Write("<tr>")
    'commented by shital
    'Response.Write("<td><b>veh_no</b></td>")
    'Response.Write("<td><b>itemname</b></td>")
    'Response.Write("<td><b>Quantity</b></td>")
    'Response.Write("<td><b>worker</b></td>")
    'Response.Write("<td><b>cont_name</b></td>")
    'Response.Write("<td><b>trans_date</b></td>")
    
    Response.Write("<td align=center><b>Class</b></td>")
    Response.Write("<td  align=center><b>IndentNo</b></td>")
    Response.Write("<td  align=center><b>Item</b></td>")
    Response.Write("<td  align=center><b>L/F_No</b></td>")
    Response.Write("<td  align=center><b>Bin_No</b></td>")
    Response.Write("<td  align=center><b>Part_No</b></td>")
    Response.Write("<td  align=center><b>Quatity</b></td>")
    Response.Write("<td  align=center><b>Rate</b></td>")
    Response.Write("<td  align=center><b>Amount</b></td>")
    'Response.Write("<td><b>Veh_No</b></td>")
    Response.Write("<td  align=center><b>Apoved_By</b></td>")
    Response.Write("<td  align=center><b>Depot</b></td>")
    Response.Write("<td  align=center><b>Remark</b></td>")
    Response.Write("</tr>")
        
    For i = 0 To rowcount - 1
        Response.Write("<tr>")
        'comente by shital
        'Dim str As String = ds.Tables("temp").Rows(i).Item("veh_no").ToString
        ' Response.Write("<td>" & str & "</td>")

        '' Dim str2 As String = " & ds.Tables(0).Rows(i).ItemArray(1).ToString() & "
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("itemname").ToString & "</td>")
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("Quantity").ToString & "</td>")
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("worker").ToString & "</td>")
        '    Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("cont_name").ToString & "</td>")
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("trans_date").ToString & "</td>")
        

        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("refno").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("itemname").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("rack_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("subrack_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("part_no").ToString & "</td>")
        Response.Write("<td align=right>" & ds.Tables("temp").Rows(i).Item("Quantity").ToString & "</td>")
        Response.Write("<td align=right>" & ds.Tables("temp").Rows(i).Item("total_amount").ToString & "</td>")
        Response.Write("<td align=right>" & ds.Tables("temp").Rows(i).Item("amount").ToString & "</td>")
        'Dim str As String = ds.Tables("temp").Rows(i).Item("veh_no").ToString
        'Response.Write("<td>" & str & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("approvedby").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("cont_name").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("remark").ToString & "</td>")
      
        Response.Write("</tr>")
    '     Response.Write("<tr>")
    'Response.Write("<td><b>Aeon Software</b></td>")
    '     Response.Write("<tr>")
        
    Next
  Response.Write("</table border=1>")
   Response.Write("<table border = 0>")
    Response.Write("<tr><Td width = 50px colspan=3 align=left><B><font size = 5></b></td><Td width = 50px colspan=3 align=Right><B><font size = 5>Workshop Dept</b></td> </tr>")
      'Respose.Write("<tr>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("</tr>")
    'Response.Write("</table>")
           %>
