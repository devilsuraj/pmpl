<%@ Control Language="VB" AutoEventWireup="false" CodeFile="header.ascx.vb" Inherits="includes_controls_header" %>
<link rel="stylesheet"  href="<% =session("host") %>css/website.css" type="text/css">

<script src="<% =session("host") %>SpryAssets/SpryMenuBar.js" type="text/javascript"></script>

<link href="<% =session("host") %>SpryAssets/SpryMenuBarVertical.css" rel="stylesheet"
    type="text/css">

<script src="<% =Session("host") %>includes/scripts/jquery-1.6.2.js" type="text/javascript"></script>

<script language="javascript" src="<% =Session("host") %>includes/scripts/jquery.autocomplete.js"></script>

<link rel="stylesheet" href="<% =Session("host") %>css/jquery.autocomplete2.css" />

<script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function findValue(li) {
	if( li == null ) return alert("No match!");

	// if coming from an AJAX call, let's use the CityId as the value
	if( !!li.extra ) var sValue = li.extra[0];

	// otherwise, let's just display the value in the text box
	else var sValue = li.selectValue;

	//alert("The value you selected was: " + sValue);
}

function selectItem(li) {
	findValue(li);
}

//-->
</script>

<div id="header">
    <div class="logo">
        <img src="../images/logo.jpg"></div>
    <div class="logotxt">
        <br>
        Pune Mahanagar Parivahan Mahamandal Limited</div>
    <div style="color: White">
        Powered by <a style="color: White" target="_blank" href="http://www.cirtindia.com">CIRT</a></div>
    <div class="signlink">
        <br>
        <br>
        <br>
        <ul>
            <li><a href="javascript:void(0);">
                <% =Session("UserName")%></a></li>
            <li>|</li>
            <li><a href="<% =Session("host") %>Login.aspx">Sign Out</a></li>
        </ul>
    </div>
</div>
<br />
