Imports System.Data.SqlClient
Imports System.Data
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic
Imports System.Configuration
Imports InfoSoftGlobal
Namespace KDMT
    Partial Class Workshop_Workshop_Docking
        Inherits System.Web.UI.Page
        Dim con As New SqlClient.SqlConnection(System.Configuration.ConfigurationSettings.AppSettings("con"))
        Dim cmd As SqlClient.SqlCommand
        Dim ds As DataSet
        Dim DA As SqlClient.SqlDataAdapter
        Dim dr As SqlClient.SqlDataReader
        Public strBusno As String = ""
        Public strjobno As String = ""
        ' --------------
        Dim dtt1 As New DataTable("Chart")
        Dim x, y As String

        Dim GraphWidth As String = "750"
        Dim GraphHeight As String = "620"
        Dim color(12) As String
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Session("MenuId") = 2
            Try
                If Not IsPostBack Then
                    strBusno = getAutoCompleteList("select distinct busno from JobOrderCard_Master order by busno", "busno")

                    strjobno = getAutoCompleteList("select joccode from JobOrderCard_Master order by joccode", "joccode")
                End If
                'color = New String("12")
                'ConfigureColors()
                'LoadGraphData()
                'CreateBarGraph()
            Catch ex As Exception
            End Try
        End Sub
        Private Shared Function GetData(ByVal query As String) As DataTable
            Dim dt As New DataTable()
            Dim constr As String = ConfigurationManager.ConnectionStrings("con").ConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(query)
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        sda.Fill(dt)
                    End Using
                End Using
                Return dt
            End Using
        End Function
        Private Sub ConfigureColors()
            color(0) = "AFD8F8"
            'color(0) = "A186BE"
            color(1) = "F6BD0F"
            color(2) = "8BBA00"
            color(3) = "FF8E46"
            color(4) = "008E8E"
            color(5) = "D64646"
            color(6) = "8E468E"
            color(7) = "588526"
            color(8) = "B3AA00"
            color(9) = "008ED6"
            color(10) = "9D080D"
            color(11) = "A186BE"
        End Sub
        Private Sub CreateBarGraph()
            Dim strCaption As String = "Inspection wise Kms"
            Dim strSubCaption As String = ""
            Dim xAxis As String = "Inspection"
            Dim yAxis As String = "Kms"
            '//strXML will be used to store the entire XML document generated
            Dim strXML As String = ""
            '//Generate the graph element
            strXML = "<graph caption='" + strCaption + "' subCaption='" + strSubCaption + "' decimalPrecision='0'  pieSliceDepth='60' baseFontSize='11' formatNumberScale='0' xAxisName='" + xAxis + "' numDivLines='3' yAxisMinValue='3750' yAxisMaxValue='15000' yAxisName='" + yAxis + "' showValues='1' rotateNames='2' >"
            Dim i As Integer = 0
            Dim dr2 As DataRow
            For Each dr2 In dtt1.Rows
                If dr2(4).ToString() = "1" Then
                    strXML += "<set name='" + dr2(0).ToString() + "' value='" + dr2(1).ToString() + "' color='" + color(4) + "'  link=&quot;JavaScript:myJS('" + dr2("insp").ToString() + "','" + txtBusNo.Value + "','" + dr2("inspstatus").ToString() + "','" + dr2("insp1").ToString() + "','1','" + txtjoc.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'); &quot;/>"
                Else
                    strXML += "<set name='" + dr2(0).ToString() + "' value='" + dr2(1).ToString() + "' color='" + color(i) + "'  link=&quot;JavaScript:myJS('" + dr2("insp").ToString() + "','" + txtBusNo.Value + "','" + dr2("inspstatus").ToString() + "','" + dr2("insp1").ToString() + "','0','" + txtjoc.Value + "','" + txtjob.Text + "','" + txtjobno.Text + "'); &quot;/>"
                End If
                'strXML += "<set name='" + dr2(0).ToString() + "' value='" + dr2(1).ToString() + "' color='" + color(i) + "'  link=&quot;JavaScript:myJS('" + dr2("insp").ToString() + ", " + dr2("km").ToString() + "'); &quot;/>"
            Next
            '//Finally, close <graph> element
            strXML += "<trendlines> <line startvalue='3750' displayvalue='Inspection Km.             ' color='FF0000' thickness='1' isTrendZone='0'/> </trendlines>"
            strXML += "</graph>"
            FCLiteral2.Text = FusionCharts.RenderChartHTML("../FusionCharts/FCF_Column3D.swf", "", strXML, "mygraph1", GraphWidth, GraphHeight, False)
            'FCLiteral2.Text = FusionCharts.RenderChart("../FusionCharts/FCF_Column3D.swf", "", strXML, "mygraph1", GraphWidth, GraphHeight, False, False)
            '// Path to chart's SWF
            '// Leave blank when using Data String method   '// xmlStr contains the chart data      '// Unique chart ID         
            '         // Width & Height of chart
        End Sub
        Private Sub LoadGraphData()
            Dim sql1 As String = ""
            If txtjoc.Value = "" Then
                Call Show_Msg(Page, "That Bus not Create Job Card.......", "Workshop_Docking.aspx")
            Else
                sql1 = "view_jobbusdocking '" & txtBusNo.Value & "'"
                Dim da As New SqlClient.SqlDataAdapter(sql1, con)
                Dim ds As New DataSet
                da.SelectCommand.CommandTimeout = 0
                da.Fill(ds)
                Dim dc As New DataColumn("insp", GetType(String))
                '("Month", String)
                Dim dc3 As New DataColumn("insp1", GetType(String))
                Dim dc1 As New DataColumn("km", GetType(Double))
                Dim dc2 As New DataColumn("inspstatus", GetType(String))
                Dim dc4 As New DataColumn("newinsp", GetType(String))
                Dim dc5 As New DataColumn("inspdate", GetType(String))
                dtt1.Columns.Add(dc)
                dtt1.Columns.Add(dc1)
                dtt1.Columns.Add(dc2)
                dtt1.Columns.Add(dc3)
                dtt1.Columns.Add(dc4)
                dtt1.Columns.Add(dc5)

                'DataRow dr1 = dt.NewRow();
                Dim dr1 As DataRow
                'dr1 = dt.NewRow()
                For i = 0 To ds.Tables(0).Rows.Count - 1
                    'aProfits.Add(ds.Tables(0).Rows(i).Item(4).ToString)
                    dr1 = dtt1.NewRow
                    dr1(0) = ds.Tables(0).Rows(i).Item(1).ToString
                    dr1(1) = ds.Tables(0).Rows(i).Item(4).ToString
                    dr1(2) = "Insp" & ds.Tables(0).Rows(i).Item(1).ToString
                    dr1(3) = ds.Tables(0).Rows(i).Item(0).ToString
                    dr1(4) = ds.Tables(0).Rows(i).Item(5).ToString
                    dr1(5) = ds.Tables(0).Rows(i).Item(2).ToString
                    dtt1.Rows.Add(dr1)
                Next
                con.Close()
            End If
        End Sub
        'Sub DrawBarGraph(ByVal strTitle As String, ByVal strTitle1 As String, ByVal aX As ArrayList, ByVal aY As ArrayList)
        '    Const iColWidth As Integer = 20, iColSpace As Integer = 25, _
        '    iMaxHeight As Integer = 500, iHeightSpace As Integer = 100, _
        '     iXLegendSpace As Integer = 30, iTitleSpace As Integer = 50

        '    ' Const iColWidth As Integer = 20, iColSpace As Integer = 25, _
        '    'iMaxHeight As Integer = 500, iHeightSpace As Integer = 100, _s
        '    ' iXLegendSpace As Integer = 30, iTitleSpace As Integer = 50

        '    Dim iMaxWidth As Integer = (iColWidth + iColSpace) * aX.Count + iColSpace, iMaxColHeight As Integer = 0, _
        '    iTotalHeight As Integer = iMaxHeight + iXLegendSpace + iTitleSpace

        '    Dim objBitmap As Bitmap = New Bitmap(iMaxWidth + 300, iTotalHeight)
        '    Dim objGraphics As Graphics = Graphics.FromImage(objBitmap)
        '    Dim fontTitle1 As Font = New Font("Arial", 12)
        '    Dim objBrush1 As SolidBrush = New SolidBrush(Color.FromArgb(70, 70, 20))

        '    objGraphics.FillRectangle(New SolidBrush(Color.White), 0, 0, iMaxWidth + 300, iTotalHeight)
        '    objGraphics.FillRectangle(New SolidBrush(Color.White), 0, 0, iMaxWidth + 300, iMaxHeight)
        '    objGraphics.DrawString(strTitle1, fontTitle1, objBrush1, (iMaxWidth / 2) - strTitle.Length * 8, iMaxHeight + iXLegendSpace + 30)

        '    ' find the maximum value
        '    Dim iValue As Integer
        '    For Each iValue In aY
        '        If iValue > iMaxColHeight Then iMaxColHeight = iValue
        '    Next

        '    Dim iBarX As Integer = iColSpace, iCurrentHeight As Integer
        '    Dim objBrush As SolidBrush = New SolidBrush(Color.FromArgb(50, 70, 90))
        '    Dim fontLegend As Font = New Font("Arial", 11), fontValues As Font = New Font("Arial", 8), fontTitle As Font = New Font("Arial", 15)

        '    Dim fromdate As String = Request.QueryString("fromdate")
        '    Dim Todate As String = Request.QueryString("Todate")
        '    Dim avg As Decimal
        '    'Dim ObjDataAdapter As New SqlClient.SqlDataAdapter("view_graph_avg '" & fromdate & "','" & Todate & "','1'", con)
        '    'Dim ObjDataSet As New DataSet
        '    'ObjDataAdapter.SelectCommand.CommandTimeout = 0
        '    'ObjDataAdapter.Fill(ObjDataSet, "tblEmp")
        '    'avg = ObjDataSet.Tables("tblEmp").Rows(0).Item("avg").ToString
        '    avg = 500 - 2000 'avg

        '    Dim avgcash As Integer
        '    'Dim ObjDataAdapter1 As New SqlClient.SqlDataAdapter("view_graph_avg '" & fromdate & "','" & Todate & "','2'", con)
        '    'Dim ObjDataSet1 As New DataSet 
        '    'ObjDataAdapter1.SelectCommand.CommandTimeout = 0
        '    'ObjDataAdapter1.Fill(ObjDataSet1, "tblEmp")
        '    avgcash = 2000 'ObjDataSet1.Tables("tblEmp").Rows(0).Item("avgcash").ToString

        '    ' loop through and draw each bar
        '    Dim iLoop As Double
        '    For iLoop = 0 To aX.Count - 1
        '        iCurrentHeight = ((Convert.ToDouble(aY(iLoop)) / Convert.ToDouble(iMaxColHeight)) * Convert.ToDouble(iMaxHeight - iHeightSpace))
        '        objGraphics.FillRectangle(objBrush, iBarX, _
        '        iMaxHeight - iCurrentHeight, iColWidth, iCurrentHeight)
        '        objGraphics.DrawString(aX(iLoop), fontLegend, objBrush, iBarX, iMaxHeight)
        '        'objGraphics.DrawString(15056898, fontLegend, objBrush, iBarX, 50)

        '        'objGraphics.DrawString(Format(aY(iLoop), "#,###"), fontValues, objBrush, iBarX, iMaxHeight - iCurrentHeight - 15)
        '        objGraphics.DrawString("", fontValues, objBrush, iBarX, iMaxHeight - iCurrentHeight - 15)
        '        iBarX += (iColSpace + iColWidth)
        '    Next
        '    objGraphics.DrawString(strTitle, fontTitle, objBrush, (iMaxWidth / 2) - strTitle.Length * 6, iMaxHeight + iXLegendSpace)
        '    objGraphics.DrawString("Avg  =  " & avgcash, fontTitle, objBrush, iMaxWidth, avg)
        '    objGraphics.DrawLine(Pens.Blue, 1500, avg, 0, avg)
        '    objGraphics.DrawLine(Pens.Blue, 0, 500, 0, 0)
        '    'objBitmap.Save("C:\inetpub\wwwroot\graph.gif", ImageFormat.GIF)
        '    objBitmap.Save(Response.OutputStream, ImageFormat.Gif)
        '    objGraphics.Dispose()
        '    objBitmap.Dispose()
        'End Sub
        Sub DrawBarGraph(ByVal strTitle As String, ByVal strTitle1 As String, ByVal aX As ArrayList, ByVal aY As ArrayList)
            'Const iColWidth As Integer = 20, iColSpace As Integer = 25, _
            'iMaxHeight As Integer = 500, iHeightSpace As Integer = 100, _
            ' iXLegendSpace As Integer = 30, iTitleSpace As Integer = 50

            '' Const iColWidth As Integer = 20, iColSpace As Integer = 25, _
            ''iMaxHeight As Integer = 500, iHeightSpace As Integer = 100, _
            '' iXLegendSpace As Integer = 30, iTitleSpace As Integer = 50

            'Dim iMaxWidth As Integer = (iColWidth + iColSpace) * aX.Count + iColSpace, iMaxColHeight As Integer = 0, _
            'iTotalHeight As Integer = iMaxHeight + iXLegendSpace + iTitleSpace

            'Dim objBitmap As Bitmap = New Bitmap(iMaxWidth - 100, iTotalHeight)
            'Dim objGraphics As Graphics = Graphics.FromImage(objBitmap)
            'Dim fontTitle1 As Font = New Font("Arial", 12)
            'Dim objBrush1 As SolidBrush = New SolidBrush(Color.FromArgb(70, 70, 20))

            'objGraphics.FillRectangle(New SolidBrush(Color.White), 0, 0, iMaxWidth + 300, iTotalHeight)
            'objGraphics.FillRectangle(New SolidBrush(Color.White), 0, 0, iMaxWidth + 300, iMaxHeight)
            'objGraphics.DrawString(strTitle1, fontTitle1, objBrush1, (iMaxWidth / 2) - strTitle.Length * 8, iMaxHeight + iXLegendSpace + 30)

            '' find the maximum value
            'Dim iValue As Integer = 1
            'For Each iValue In aY
            '    If iValue > iMaxColHeight Then iMaxColHeight = iValue
            'Next

            'Dim iBarX As Integer = iColSpace, iCurrentHeight As Integer
            'Dim objBrush As SolidBrush = New SolidBrush(Color.FromArgb(50, 70, 90))
            'Dim fontLegend As Font = New Font("Arial", 11), fontValues As Font = New Font("Arial", 8), fontTitle As Font = New Font("Arial", 15)

            'Dim fromdate As String = Request.QueryString("fromdate")
            'Dim Todate As String = Request.QueryString("Todate")
            'Dim avg As Decimal
            ''Dim ObjDataAdapter As New SqlClient.SqlDataAdapter("view_graph_avg '" & fromdate & "','" & Todate & "','1'", con)
            ''Dim ObjDataSet As New DataSet
            ''ObjDataAdapter.SelectCommand.CommandTimeout = 0
            ''ObjDataAdapter.Fill(ObjDataSet, "tblEmp")
            ''avg = ObjDataSet.Tables("tblEmp").Rows(0).Item("avg").ToString
            'avg = 500 - 2000 'avg

            'Dim avgcash As Integer
            ''Dim ObjDataAdapter1 As New SqlClient.SqlDataAdapter("view_graph_avg '" & fromdate & "','" & Todate & "','2'", con)
            ''Dim ObjDataSet1 As New DataSet 
            ''ObjDataAdapter1.SelectCommand.CommandTimeout = 0
            ''ObjDataAdapter1.Fill(ObjDataSet1, "tblEmp")
            'avgcash = 2000 'ObjDataSet1.Tables("tblEmp").Rows(0).Item("avgcash").ToString

            '' loop through and draw each bar
            'Dim iLoop As Double
            'For iLoop = 0 To aX.Count - 1
            '    iCurrentHeight = ((Convert.ToDouble(aY(iLoop)) / Convert.ToDouble(iMaxColHeight)) * Convert.ToDouble(iMaxHeight - iHeightSpace))
            '    objGraphics.FillRectangle(objBrush, iBarX, _
            '    iMaxHeight - iCurrentHeight, iColWidth, iCurrentHeight)
            '    objGraphics.DrawString(aX(iLoop), fontLegend, objBrush, iBarX, iMaxHeight)
            '    'objGraphics.DrawString(15056898, fontLegend, objBrush, iBarX, 50)

            '    'objGraphics.DrawString(Format(aY(iLoop), "#,###"), fontValues, objBrush, iBarX, iMaxHeight - iCurrentHeight - 15)
            '    objGraphics.DrawString("", fontValues, objBrush, iBarX, iMaxHeight - iCurrentHeight - 15)
            '    iBarX += (iColSpace + iColWidth)
            'Next
            'objGraphics.DrawString(strTitle, fontTitle, objBrush, (iMaxWidth / 2) - strTitle.Length * 6, iMaxHeight + iXLegendSpace)
            'objGraphics.DrawString("Avg  =  " & avgcash, fontTitle, objBrush, iMaxWidth, avg)
            'objGraphics.DrawLine(Pens.Blue, 1500, avg, 0, avg)
            'objGraphics.DrawLine(Pens.Blue, 0, 500, 0, 0)
            ''objBitmap.Save("C:\inetpub\wwwroot\graph.gif", ImageFormat.GIF)
            ''objBitmap.Save(Response.OutputStream, ImageFormat.Gif)
            'objGraphics.Dispose()
            'objBitmap.Dispose()
        End Sub
        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            Try

          
            lbltotalkm.Text = ExecuteQuery("calculate_dockingtotalkm   " + txtBusNo.Value + "")
            Dim aMonths As ArrayList = New ArrayList(), aProfits As ArrayList = New ArrayList()

            '' insp
            'aMonths.Add("0")
            aMonths.Add("1")
            aMonths.Add("2")
            aMonths.Add("3")
            aMonths.Add("4")
            aMonths.Add("5")
            aMonths.Add("H/D")
            aMonths.Add("7")
            aMonths.Add("8")
            aMonths.Add("9")
            aMonths.Add("10")
            aMonths.Add("11")
            aMonths.Add("F/D")

                ConfigureColors()
                LoadGraphData()
                CreateBarGraph()
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End Sub
    End Class
End Namespace

