<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TEST</title>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>

<style>
section.main-section{
	border: 6px solid black;
	border-radius: 80px;
	width: 700px;
	min-height: 500px;
	
	display: inline-flex;
}
div.profile-photo{
	border: 1px solid red;
	width: 49%;
	height: 500px;
	
	display: flex;
	overflow: hidden;
    align-items: center;
    justify-content: center;
}
div.profile-text{
	border: 1px solid blue;
	width: 49%;
	height: 500px;
	
}
ul.profile-list{
	padding: 60px;
}
</style>

</head>
<body>

<section class="main-section">
	<div class="profile-photo">
		<img src="${pageContext.request.contextPath}/resources/images/너굴맨.jpg" alt="" />
	</div>
	<div class="profile-text">
		<ul class="profile-list">
			<li>이름 : </li>
			<br />
			<li>아이디 : </li>
			<br />
			<li>나이 : </li>
			<br />
			<li>성별 : </li>
			<br />
			<li>자기소개 : </li>
		</ul>
	</div>
	
	<button onclick="location.href='${pageContext.request.contextPath}/websocket/chatting'">채팅기능</button>
</section>

</body>
</html>

