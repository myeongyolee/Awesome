<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<style>
#lightningList-content{width:500px;}
#lightning{width:400px;}
</style>
<title>번개팅</title>
</head>
<body>
	<div id="search-container">
		
	</div>
	<div id="lightningList-content">
		<div id="lightning" class="card">
			<div id="lightningTest-head" class="card-header">
				<img class="card-img-top" src="" alt="Card image cap">
				<div class="card-body" data-toggle="collapse" data-target="#lightningTest-body" aria-expanded="true" aria-controls="lightningTest-body">
					<h5 class="card-title"> 매칭타이틀 </h5>
				</div>
			</div>
			<ul class="list-group list-group-flush">
				<li class="list-group-item"> 분류 | 지역 | 장소이름 | 마감시간 </li>
				<li class="list-group-item"> 작성회원 | 참여회원수 </li>
			</ul>
			<div id="lightningTest-body" class="collapse" aria-labelledby="lightningTest-head" data-parent="#lightning">
				<div class="card-body">
					<p class="card-text">매칭내용</p>
				</div>		
			</div>
		</div>
		
		<c:forEach items="${lightningList}" var="matching">
		<div id="lightning" class="card">
			<div id="${matching.matchNo}-head" class="card-header">
				<img class="card-img-top" src="" alt="Card image cap">
				<div class="card-body" data-toggle="collapse" data-target="#${matching.matchNo}-body" aria-expanded="true" aria-controls="${matching.matchNo}-body">
					<h5 class="card-title"> ${matching.matchTitle} </h5>
				</div>
			</div>
			<ul class="list-group list-group-flush">
				<li class="list-group-item"> 
					${matching.interestingName} | ${matching.localName} | ${matching.placeName} |  
					<fmt:formatDate value="${matching.matchEndDate}" type="date" pattern="yyyy/MM/dd(E) hh:mm"/>
				</li>
				<li class="list-group-item"> ${matching.memberId} | ${matching.memberCount}</li>
			</ul>
			<div id="${matching.matchNo}-body" class="collapse" aria-labelledby="${matching.matchNo}-head" data-parent="#lightning">
				<div class="card-body">
					<p class="card-text">매칭내용</p>
				</div>		
			</div>
		</div>
		</c:forEach>
	</div>
	
</body>
</html>