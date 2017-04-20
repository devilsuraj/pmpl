<%@ Page Language="VB" AutoEventWireup="false" CodeFile="excelrepair.aspx.vb" Inherits="KDMT.excelrepair" %>


<%@ Import Namespace = "system" %>
<%@ Import Namespace = "system.Data.sqlclient" %>
<%@ Import Namespace = "system.Data" %>
<%@ Import Namespace = "KDMT" %>


<%  Dim con As New SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
    Dim fromdate As String = Request.QueryString("fromdate")
    Dim todate As String = Request.QueryString("todate")
    Dim flag As String = Request.QueryString("option")
    Response.Clear()
    Response.ContentType = "application/download"
    Response.AddHeader("content-disposition", "filename = excellists.xls")
    Dim i As Integer
    Dim da As New SqlClient.SqlDataAdapter("VIEW_ITEM_REPAIR '" & fromdate & "','" & todate & "','" & flag & "'", con)
    Dim ds As New DataSet()
    da.SelectCommand.CommandTimeout = 0
    da.Fill(ds, "temp")
    
    Dim rowcount As Integer = ds.Tables(0).Rows.Count
    Response.Write("")
    Response.Write("<table border = 1>")
    Response.Write("<tr><Td colspan=6 align=center><B>Item Receive Report  &nbsp " & Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy") & "&nbsp&nbsp;To&nbsp&nbsp;" & Format(Convert.ToDateTime(todate), "dd/MM/yyyy") & "</b></td></tr>")
    Response.Write("<tr>")
 
    Response.Write("<td><b>item_name</b></td>")
    Response.Write("<td><b>qty</b></td>")
    Response.Write("<td><b>gate_pass_no</b></td>")
    Response.Write("<td><b>available_qty</b></td>")
    Response.Write("<td><b>total_qty</b></td>")
    Response.Write("<td><b>trans_date</b></td>")
    Response.Write("</tr>")
        
    For i = 0 To rowcount - 1
        Response.Write("<tr>")
        Dim str As String = ds.Tables("temp").Rows(i).Item("item_name").ToString
        Response.Write("<td>" & str & "</td>")
        'Dim str1 As String = " & ObjDataSet.Tables(0).Rows(i).ItemArray(1).ToString() & "
        'Dim str2 As String = " & ds.Tables(0).Rows(i).ItemArray(1).ToString() & "
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("qty").ToString & "</td>")
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("gate_pass_no").ToString & "</td>")
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("available_qty").ToString & "</td>")
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("total_qty").ToString & "</td>")
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("trans_date").ToString & "</td>")
        Response.Write("</tr>")
    Next
    Response.Write("<table border = 0>")
    Response.Write("<tr><Td width = 50px colspan=3 align=left><B><font size = 5></b></td><Td width = 50px colspan=3 align=Right><B><font size = 5>Workshop Dept</b></td> </tr>")
    ' Response.Write("</table border=1>")
    'Response.Write("<tr>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("<td></td>")
    'Response.Write("</tr>")
    'Response.Write("</table>")
           %>
