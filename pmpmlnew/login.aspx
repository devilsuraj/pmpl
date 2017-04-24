﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>

<!DOCTYPE html>
<!-- 
Template Name: Metronic - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.7
Version: 4.7.5
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Dribbble: www.dribbble.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
Renew Support: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <meta charset="utf-8" />
    <title>PMPML | Dashboard</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta content="Preview page of Metronic Admin Theme #5 for " name="description" />
    <meta content="" name="author" />
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
    <link href="<% =Session("host") %>assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="<% =Session("host") %>assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="<% =Session("host") %>assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<% =Session("host") %>assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <link href="<% =Session("host") %>assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="<% =Session("host") %>assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="<% =Session("host") %>assets/global/css/components-md.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="<% =Session("host") %>assets/global/css/plugins-md.min.css" rel="stylesheet" type="text/css" />
    <!-- END THEME GLOBAL STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="<% =Session("host") %>assets/pages/css/login-5.min.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL STYLES -->
    <!-- BEGIN THEME LAYOUT STYLES -->
    <!-- END THEME LAYOUT STYLES -->
    <link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->
    <script language="javascript">

        function showengg() {
            //debugger
            var dvchk = document.getElementById('engg');
            var dvchk2 = document.getElementById('Span1');
            var deptype = document.getElementById('ddldeptname').value;
            if (deptype == '2') {
                dvchk.style.display = '';
                dvchk2.style.display = '';
            }

            else {
                dvchk.style.display = 'none';
                dvchk2.style.display = 'none';
            }

        }

    </script>
<body class=" login">
    <form runat="server">
        <!-- BEGIN : LOGIN PAGE 5-1 -->
        <div class="user-login-5">
            <div class="row bs-reset">
                <div class="col-md-6 bs-reset mt-login-5-bsfix">
                    <div class="login-bg" style="background-image: url(<% =Session("host") %>assets/pages/img/login/bg1.jpg)">
                        <img class="login-logo" src="<% =Session("host") %>assets/global/img/logo-main.png" />
                    </div>
                </div>
                <div class="col-md-6 login-container bs-reset mt-login-5-bsfix">
                    <div class="login-content">

                        <div>
                            <div class="form-body">
                                <div class="row">
                                    <div class="form-group">
                                        <asp:DropDownList ID="DropDownList1" ClientIDMode="Static" onchange="showengg();" runat="server" class="form-control">
                                            <asp:ListItem Text="SparePart Section" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Hardware Section" Value="2"></asp:ListItem>

                                            <asp:ListItem Text="Fuel Section" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Workshop Section" Value="5"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="content">
                            <div class="portlet light bordered form-horizontal">
                                <!-- BEGIN LOGIN div -->
                                <div class="login-div" action="index.html" method="post" novalidate>
                                    <h3 class="form-title font-blue text-center">Pune Mahanagar Parivahan Mahamandal Limited
                                    </h3>
                                    <div class="alert alert-danger display-hide">
                                        <button class="close" data-close="alert"></button>
                                        <span>Enter any username and password. </span>
                                    </div>
                                    <div class="form-group">
                                        <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                                        <label class="control-label visible-ie8 visible-ie9">Username</label>
                                        <input name="txtusername" type="text" class="form-control " placeholder="Username" id="txtusername" runat="server">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label visible-ie8 visible-ie9">Password</label>
                                        <input name="txtpass" type="password" class="form-control " placeholder="Password" id="txtpass" runat="server">
                                    </div>
                                    <div>
                                        <div class="form-group" id="eng">
                                            <label class="">Engineer's Name</label>
                                            <asp:DropDownList ID="ddlengineer" Class="form-control" runat="server" DataSourceID="SqlDataSource1"
                                                DataTextField="EngName" DataValueField="EngId">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                                ConnectionString="<%$ ConnectionStrings:Con %>"
                                                SelectCommand="SELECT [EngId], [EngName] FROM [EngineerMaster]"></asp:SqlDataSource>
                                     </div>


                                    </div>
                                    <div class="form-actions">

                                        <input name="btnLogin" type="button" class="btn blue uppercase" value="Login" id="btnLogin" runat="server">

                                        <asp:Label runat="server" ID="lblinfo" CssClass="forget-password pull-right" ForeColor="Red"></asp:Label>
                                    </div>

                                </div>
                                <!-- END LOGIN div -->
                            </div>
                            <!-- BEGIN FORGOT PASSWORD div -->



                            <!-- END FORGOT PASSWORD div -->
                            <!-- BEGIN REGISTRATION div -->

                            <!-- END REGISTRATION div -->
                        </div>
                    </div>
                    <div class="login-footer">
                        <div class="row bs-reset">
                            <div class="col-xs-5 bs-reset">
                                <ul class="login-social">
                                    <li>
                                        <a href="javascript:;">
                                            <i class="icon-social-facebook"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <i class="icon-social-twitter"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <i class="icon-social-dribbble"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-xs-7 bs-reset">
                                <div class="login-copyright text-right">
                                    <p>Copyright &copy; Aeonsoftware Pvt Ltd</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END : LOGIN PAGE 5-1 -->
        <!--[if lt IE 9]>
<script src="<% =Session("host") %>assets/global/plugins/respond.min.js"></script>
<script src="<% =Session("host") %>assets/global/plugins/excanvas.min.js"></script> 
<script src="<% =Session("host") %>assets/global/plugins/ie8.fix.min.js"></script> 
<![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="<% =Session("host") %>assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="<% =Session("host") %>assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
        <script src="<% =Session("host") %>assets/global/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="<% =Session("host") %>assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="<% =Session("host") %>assets/pages/scripts/login-5.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <!-- END THEME LAYOUT SCRIPTS -->

    </form>
        <script src="../scripts/jquery-1.11.0.min.js"></script>
    <script src="../scripts/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            $('#clickmewow').click(function () {
                $('#radio1003').attr('checked', 'checked');
            });
            $('#eng').hide();
        
        })
        function showengg() {
            if ($('#DropDownList1').val() == "5")
            {
                $('#eng').fadeIn(100);
            }
        }
    </script>
    
</body>

</html>
