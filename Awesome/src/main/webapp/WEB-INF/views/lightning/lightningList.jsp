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
#ContentView{height: 200px;}

</style>
<script>

$(function(){  //페이지가 로드되면 데이터를 가져오고 page를 증가시킨다.
	getLightningList();
	
	$(":text").focus(function(){
		$("[name="+$(this).attr('id')+"]").prop("checked",true);
	});
	
	$(":text").blur(function(){
		if($(this).val().trim() == ''){
			console.log("입력값 없음");
			$("[name="+$(this).attr('id')+"]").prop("checked",false);		
		}
	});
	
	$("#city>option:selected").not("#defaultCity").change(function(){
		var param = {local: $("#city>option:selected").val()}
		var city = JSON.stringify(param);
		$.ajax({
			url : '${pageContext.request.contextPath}/lightning/localList.do',
			dataType: "json",
			type : 'POST',
			data : city,
			contentType: "application/json; charset=UTF-8",
			success : function(data){
				$("#local").html("");
				var html = "";
				html += '<option id="defaultLocal" disabled selected>지역을 선택해주세요</option>';
				for(var i=0; i<data.length; i++){
					html += '<option value='+data[i].localCode+'>'+data[i].localName+'</option>';					
				}
			},
			error:function(jqxhr, textStatus, errorThrown){
				console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
			}
		});
	});
	
});

$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	if($(window).scrollTop() >= $(document).height() - $(window).height()){
		getLightningList();
	}
});
function serchAjax(){
	$("#lightningList-content").html("");
	$("#cPage").val(1);
	getLightningList();
};

function getLightningList(){
	console.log($("#cPage").val());
	var param = {cPage: $("#cPage").val()};
	
	var check = $(":checkbox:checked");
	if(check!=null){
		for(var i=0; i<check.length; i++){
			var id = $(check[i]).attr('name');
			console.log($("#"+id).val());
			switch(id){
				case "title" : 
					param.title = $(":text#"+id).val(); 
					break;
				case "nickName" : 
					param.nickName = $(":text#"+id).val(); 
					break;
			}
		}
	}
	
	if($("#city>option:selected").not("#defaultCity")) param.city = $("#city>option:selected").val();
	if($("#local>option:selected").not("#defaultLocal")) param.local = $("#local>option:selected").val();
	if($("#interesting>option:selected").not("#defaultInteresting")) param.interesting = $("#interesting>option:selected").val();
	
	var str = JSON.stringify(param);
	console.log(str);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/lightning/lightningListPage.do',
		dataType: "json",
		type : 'POST',
		data : str,
		contentType: "application/json; charset=UTF-8",
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
				html +=	'<li class="list-group-item"> 작성자:'+data[i].nickName+' | 참여회원수: '+(Number(data[i].memberCount)+1)+' </li></ul>';
				html +=	'<div id="'+data[i].matchNo+'" class="collapse container" aria-labelledby="lightningTest-head" data-parent="#lightning">';
				html +=	'<div id="carousel" class="carousel slide bg-secondary mb-3" data-ride="carousel">';
				html +=	'<ol id="indicators" class="carousel-indicators">';
				html +=	'<li data-target="#carousel" data-slide-to="'+j+'" class="active"></li>';
				if(data[i].memberCount>=1){
					j++;
					html += '<li data-target="#carousel" data-slide-to="'+j+'"></li>';
				}
				if(data[i].placeId!=null){
					j++;
					html += '<li data-target="#carousel" data-slide-to="'+j+'"></li>';					
				}
				html += '</ol>'
				html +=	'<div class="carousel-inner">';
				html +=	'<div class="carousel-item active p-5">';
				html +=	'<div class="card">';
				html +=	'<div id="ContentView" class="card-header">'+data[i].matchContent+'</div></div></div>';
				if(data[i].memberCount>=1){
					html +=	'<div class="carousel-item p-5">';
					html +=	'<div class="card">';
					html +=	'<div id="ContentView" class="card-header">'+data[i].joinMemberNickName+'</div></div></div>';
				}
				if(data[i].placeId!=null){
					html +=	'<div class="carousel-item p-5">';
					html +=	'<div class="card">';
					html +=	'<div id="ContentView" class="card-header">'+data[i].placeName+'</div></div></div>';
				}
				html +=	'<a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">';
				html +=	'<span class="carousel-control-prev-icon" aria-hidden="false"></span>';
				html +=	'<span class="sr-only">Previous</span></a>';
				html +=	'<a class="carousel-control-next" href="#carousel" role="button" data-slide="next">';
				html +=	'<span class="carousel-control-next-icon" aria-hidden="false"></span>';
				html +=	'<span class="sr-only">Next</span></a></div></div>';
				html +=	'<button type="button" class="btn btn-primary float-right">참가신청</button></div>';
				$("#lightningList-content").append(html);
			}
			$("#cPage").val(Number($("#cPage").val())+1);
			console.log(cPage);
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
	<input type="hidden" id="cPage" value="1"/>
	<div id="lightningList-content" class="mx-auto"></div>
	<div id="search-container" class="card p-4 mb-4 bg-white">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				<label for="title-search">제목검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="title">
						</div>
					</div>
					<input type="text" class="form-control" id="title">
				</div>
			</li>
			<li class="list-group-item">
				<label for="local-search">도시검색</label>
				<select class="form-control" id="city">
					<option id="defaultCity" value="0" disabled selected>도시를 선택해주세요</option>
					<c:forEach items="${cityList}" var="city">
					<option value=${city.cityCode }>${city.cityName }</option>						
					</c:forEach>
				</select>
			</li>
			<li class="list-group-item">
				<label for="local-search">지역검색</label>
				<select class="form-control" id="local">
					<option id="defaultLocal" value="0" disabled selected>지역을 선택해주세요</option>
				</select>
			</li>
			<li class="list-group-item">
				<label for="memberId-search">작성자검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="nickName">
						</div>
					</div>
					<input type="text" class="form-control" id="nickName">
				</div>
			</li>
			<li class="list-group-item">
				<label for="interesting-search">분류검색</label>
				<select class="form-control" id="interesting">
					<option id="defaultInteresting" value="0" disabled selected>분류를 선택해주세요</option>
					<c:forEach items="${interestingList}" var="interesting">
					<option value=${interesting.interestingCode }>${interesting.interestingName }</option>						
					</c:forEach>
				</select>
			</li>
			
			<li class="list-group-item">
				<button class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/lightning/lightningWrite.do'">신규작성</button>
				<button class="btn btn-outline-secondary" type="button" onclick="serchAjax();">검색하기</button>
			</li>
		</ul>
	</div>

</body>
</html>