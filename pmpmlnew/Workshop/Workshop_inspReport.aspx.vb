﻿Imports System.Data.SqlClient
Namespace KDMT
    Partial Class Workshop_Workshop_inspReport
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                Label1.Text = Format(Now.Date, "dd/MMM/yyyyy")
                BindGrid(grdinsp, con, "DockingInsp_10000")
                BindGrid(grdinsp1, con, "DockingInsp_7500")
                BindGrid(grdinsp2, con, "DockingInsp_3750")
            Catch ex As Exception

            End Try
        End Sub
    End Class
End Namespace
