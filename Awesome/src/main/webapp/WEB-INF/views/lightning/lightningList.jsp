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
#lightning{width:400px; margin-bottom: 10px;}
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
			for(var i=0; i<data.length; i++){
				var j = 0;
				var html = "";
				html +=	'<div id="lightning" class="card">';
				html +=	'<div id="lightningTest-head" class="card-header">';
				html +=	'<img class="card-img-top" src="" alt="Card image cap">';
				html +=	'<div class="card-body" data-toggle="collapse" data-target="#'+data[i].matchNo+'" aria-expanded="true" aria-controls="lightningTest-body">';
				html +=	'<h5 class="card-title"> '+data[i].matchTitle+' </h5></div></div>';
				html +=	'<ul class="list-group list-group-flush">';
				html +=	'<li class="list-group-item"> '+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+'</li>';
				html +=	'<li class="list-group-item"> 작성자:'+data[i].memberId+' | 참여회원수: '+(Number(data[i].memberCount)+1)+' </li></ul>';
				html +=	'<div id="'+data[i].matchNo+'" class="collapse container" aria-labelledby="lightningTest-head" data-parent="#lightning">';
				html +=	'<div id="carousel" class="carousel slide bg-secondary mb-3" data-ride="carousel">';
				html +=	'<ol id="indicators" class="carousel-indicators">';
				html +=	'<li data-target="#carousel" data-slide-to="'+j+'" class="active"></li></ol>';
				html +=	'<div class="carousel-inner">';
				html +=	'<div class="carousel-item active p-5">';
				html +=	'<div class="card">';
				html +=	'<div id="memberList" class="card-header">'+data[i].matchContent+'</div></div></div>';
				if(data[i].memberCount>=1){
					j++;
					html +=	'<div class="carousel-item p-5">';
					html +=	'<div class="card">';
					html +=	'<div id="memberList" class="card-header">'+memberList+'</div></div></div>';					
					$("#indicators").append('<li data-target="#carousel" data-slide-to="'+j+'"></li>');
				}
				if(data[i].placeId!=null){
					j++;
					html +=	'<div class="carousel-item p-5">';
					html +=	'<div class="card">';
					html +=	'<div id="memberList" class="card-header">'+data[i].placeName+'</div></div></div>';
					$("#indicators").append('<li data-target="#carousel" data-slide-to="'+j+'"></li>');
				}
				html +=	'<a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">';
				html +=	'<span class="carousel-control-prev-icon" aria-hidden="false"></span>';
				html +=	'<span class="sr-only">Previous</span></a>';
				html +=	'<a class="carousel-control-next" href="#carousel" role="button" data-slide="next">';
				html +=	'<span class="carousel-control-next-icon" aria-hidden="false"></span>';
				html +=	'<span class="sr-only">Next</span></a></div></div>';
				html +=	'<button type="button" class="btn btn-primary">Primary</button></div>';
				$("#lightningList-content").append(html);
			}
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
	<div id="lightningList-content"></div>
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