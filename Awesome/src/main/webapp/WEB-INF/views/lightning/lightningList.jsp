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
#lightningList-content{width:500px; }
#lightning{width:400px;}
#search-container{
	width:300px;
	position: fixed;
	right: 0;
	top: 50px;
}
</style>
<script>
var cPage = 1;

$(function(){  //페이지가 로드되면 데이터를 가져오고 page를 증가시킨다.
    getLightningList(cPage);
    cPage++;
});

$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	if($(window).scrollTop() >= $(document).height() - $(window).height()){
		getLightningList(cPage);
		cPage++;   
	} 
});

function getLightningList(cPage){

	$.ajax({
		url : '${pageContext.request.contextPath}/lightning/lightningListPage/cPage/'+cPage,
		dataType: "json",
		type : 'get',
		success : function(data) {
			console.log(data);
			for(data.length)
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	}); 
}

</script>
<title>번개팅</title>
</head>
<body>
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
					${matching.interestingName} | ${matching.localName} | ${matching.placeName} | ${matching.matchEndDate}
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
	<div id="search-container" class="card shadow p-4 mb-4 bg-white">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
			<input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2">
			<div class="input-group-append">
				<button class="btn btn-outline-secondary" type="button">Button</button>
			</div>
			</li>
			<li class="list-group-item">Dapibus ac facilisis in</li>
			<li class="list-group-item">
				<button class="btn" onclick="location.href='${pageContext.request.contextPath}/lightning/lightningWrite.do'">신규작성</button>
			</li>
		</ul>
	</div>
	
</body>
</html>