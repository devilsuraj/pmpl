
<%@ Import Namespace = "system" %>
<%@ Import Namespace = "system.Data.sqlclient" %>
<%@ Import Namespace = "system.Data" %>
<%@ Import Namespace = "KDMT" %>

<%@ Page Language="VB" AutoEventWireup="false" CodeFile="excelitembalance.aspx.vb"  Inherits="KDMT.excelitembalance" %>

<%  Dim con As New SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
    Dim fromdate As String = Request.QueryString("fromdate")
    Dim todate As String = Request.QueryString("todate")
    Response.Clear()
    Response.ContentType = "application/download"
    Response.AddHeader("content-disposition", "filename = excellists.xls")
    Dim i As Integer
    Dim da As New SqlClient.SqlDataAdapter("view_available_itemstock'" & fromdate & "'", con)
   
    Dim ds As New DataSet()
    da.SelectCommand.CommandTimeout = 0
    da.Fill(ds, "temp")
    
    Dim rowcount As Integer = ds.Tables(0).Rows.Count
    Response.Write("")
    Response.Write("<table border = 1>")
    Response.Write("<tr><Td colspan=3 align=center><B>Item Balance Report  </b></td></tr>")
    Response.Write("<tr>")
  
    Response.Write("<td><b>ITEM NAME</b></td>")
    Response.Write("<td><b>ITEM CODE</b></td>")
    Response.Write("<td><b>BALANCE</b></td>")
 
    Response.Write("</tr>")
        
    For i = 0 To rowcount - 1
        Response.Write("<tr>")
        Dim str As String = ds.Tables("temp").Rows(i).Item("ITEM_NAME").ToString
        Response.Write("<td>" & str & "</td>")
     
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("ITEM_CODE").ToString & "</td>")
        Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("q").ToString & "</td>")

        Response.Write("</tr>")
    Next
    Response.Write("<table border = 0>")
    Response.Write("<tr><Td width = 50px colspan=3 align=left><B><font size = 5></b></td><Td width = 50px colspan=3 align=Right><B><font size = 5>Workshop Dept</b></td> </tr>")

           %>
