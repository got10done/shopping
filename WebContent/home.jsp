<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
	<meta charset="UTF-8">
	<title>All 쇼핑몰</title>
	<link rel="stylesheet" href="/style2.css"/>
</head>
<body>
	<div id="divPage">
		<div id="divTop">
			<h1 id="homeTop">All 쇼핑몰</h1>
			<a href="/home"><img src="/banner.jpg" width=970/></a>
		</div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="/menu.jsp"/></div>
			<div id="divContent">
				<jsp:include page="${pageName}"></jsp:include>
			</div>
		</div>
		<div id="divBottom">
			<h4 >Copyright © ICIA All Rights Reserved.</h4>
		</div>
	</div>
</body>	
</html>