<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>동네친구</title>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fullpage.js"></script>
    <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
    
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    <!-- 구글 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<style>
		 #tablet{width:800px; height: 600px; background: black; margin:0 auto; border-radius: 40px; padding:10px 37px;}
        #vicinage-friend{background:aliceblue; padding-top:50px ;}
        #naver-map{width: 700px; height: 575px; background: white;}
	</style>
</head>
<body>
	<div id="vicinage-friend" class="section">
         <div id="tablet">
                <div id="naver-map">
                        
                </div>
          </div>
    </div>
</body>
</html>