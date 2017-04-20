<%@ Page Language="VB" AutoEventWireup="false" CodeFile="excelreceivereport.aspx.vb" Inherits="KDMT.excelreceivereport" %>

<%@ Import Namespace = "system" %>
<%@ Import Namespace = "system.Data.sqlclient" %>
<%@ Import Namespace = "system.Data" %>
<%@ Import Namespace = "KDMT" %>


<%  Dim con As New SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
    Dim fromdate As String = Request.QueryString("fromdate")
    Dim todate As String = Request.QueryString("todate")
    Response.Clear()
    Response.ContentType = "application/download"
    Response.AddHeader("content-disposition", "filename = excellists.xls")
    Dim i As Integer
    Dim da As New SqlClient.SqlDataAdapter("VIEW_ITEMRECIEVE '" & fromdate & "','" & todate & "'", con)
    Dim ds As New DataSet()
    da.SelectCommand.CommandTimeout = 0
    da.Fill(ds, "temp")
    
    Dim rowcount As Integer = ds.Tables(0).Rows.Count
    Response.Write("")
    Response.Write("<table border = 1>")
    Response.Write("<tr><Td colspan=17 align=center style=font-size: 18pt><B>PUNE MAHANAGAR PARIVAHAN MAHAMANDAL LIMITED</b></td></tr>")

    Response.Write("<tr><Td colspan=17 align=center style=font-size: 18pt><B>Item Receive Report  &nbsp " & Format(Convert.ToDateTime(fromdate), "dd/MM/yyyy") & "&nbsp&nbsp;To&nbsp&nbsp;" & Format(Convert.ToDateTime(todate), "dd/MM/yyyy") & "</b></td></tr>")
    Response.Write("<tr>")
    'comment by shital
    'Response.Write("<td><b>vendor_name</b></td>")
    'Response.Write("<td><b>challan_no</b></td>")
    'Response.Write("<td><b>item_name</b></td>")
    'Response.Write("<td><b>available</b></td>")
    'Response.Write("<td><b>quantity</b></td>")
    'Response.Write("<td><b>trans_date</b></td>")
    
    
    Response.Write("<td align=center><b>Inward_No</b></td>")
    Response.Write("<td align=center><b>Date_Of_Receipt</b></td>")
    Response.Write("<td align=center><b>Vendors</b></td>")
    Response.Write("<td align=center><b>Challan_No</b></td>")
    Response.Write("<td align=center><b>Challan_Date</b></td>")
    Response.Write("<td align=center><b>Item</b></td>")
    Response.Write("<td align=center><b>Part_No</b></td>")
    Response.Write("<td align=center><b>Bin_No</b></td>")
    Response.Write("<td align=center><b>Quantity</b></td>")
    Response.Write("<td align=center><b>Unit</b></td>")
    Response.Write("<td align=center><b>Rejected</b></td>")
    Response.Write("<td align=center><b>L/F_No</b></td>")
    Response.Write("<td align=center><b>Po_No</b></td>")
    Response.Write("<td align=center><b>Po_Date</b></td>")
    Response.Write("<td align=center><b>Bill_No</b></td>")
    Response.Write("<td align=center><b>Bill_Date</b></td>")
    Response.Write("<td align=center><b>DRB_No</b></td>")
    
    Response.Write("</tr>")
        
    For i = 0 To rowcount - 1
        Response.Write("<tr>")
        'commented by shital
        'Dim str As String = ds.Tables("temp").Rows(i).Item("vendor_name").ToString
        'Response.Write("<td>" & str & "</td>")
        ''Dim str1 As String = " & ObjDataSet.Tables(0).Rows(i).ItemArray(1).ToString() & "
        ''Dim str2 As String = " & ds.Tables(0).Rows(i).ItemArray(1).ToString() & "
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("challan_no").ToString & "</td>")
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("item_name").ToString & "</td>"comment)
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("available").ToString & "</td>")
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("quantity").ToString & "</td>")
        'Response.Write("<td>" & ds.Tables("temp").Rows(i).Item("trans_date").ToString & "</td>")
        
        
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("inward_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("trans_date").ToString & "</td>")
        Dim str As String = ds.Tables("temp").Rows(i).Item("vendor_name").ToString
        Response.Write("<td align=left>" & str & "</td>")
        
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("challan_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("challan_date").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("item_name").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("part_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("subrack_no").ToString & "</td>")
        Response.Write("<td align=right>" & ds.Tables("temp").Rows(i).Item("quantity").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("count_in").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("reject").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("rack_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("po_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("po_date").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("bill_no").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("bill_date").ToString & "</td>")
        Response.Write("<td align=left>" & ds.Tables("temp").Rows(i).Item("drb_no").ToString & "</td>")


        
        
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
