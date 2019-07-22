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
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.js"></script>
<style>
#lightningList-content{width:600px; }
#lightning{width:500px; margin-bottom: 10px;}
#search-container{
	width:300px;
	position: fixed;
	right: 0;
	top: 50px;
}
#swiperContainer{height:350px; position: relative;}
.myMap{width:334px; height:250px; position: relative;}
#swiper-container {
      width: 100%;
      height: 100%;
      margin-left: auto;
      margin-right: auto;
}
#swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
}
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
	
});

$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	if($(window).scrollTop() >= $(document).height() - $(window).height()){
		getLightningList();
	}
});

function selectLocalList(){
	var param = {city: $("#city>option:selected").val()}
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
			$("#local").append(html);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
};

function serchAjax(){
	$("#lightningList-content").html("");
	$("#cPage").val(1);
	getLightningList();
};

function getLightningList(){
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
	
	$.ajax({
		url : '${pageContext.request.contextPath}/lightning/lightningListPage.do',
		dataType: "json",
		type : 'POST',
		data : str,
		contentType: "application/json; charset=UTF-8",
		success : function(data) {
			for(var i=0; i<data.length; i++){
				var j = 0;
				var html = "";
				html +=	'<div id="lightning" class="card">';
				html +=	'<div id="lightningTest-head" class="card-header">';
				html +=	'<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/match/'+data[i].matchRenamedImg+'" alt="Card image cap">';
				html +=	'<div class="card-body" data-toggle="collapse" data-target="#'+data[i].matchNo+'" aria-expanded="true" aria-controls="lightningTest-body">';
				html +=	'<h5 class="card-title"> '+data[i].matchTitle+' </h5></div></div>';
				html +=	'<ul class="list-group list-group-flush">';
				html +=	'<li class="list-group-item"> '+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+'</li>';
				html +=	'<li class="list-group-item"> 작성자:'+data[i].nickName+' | 참여회원수: '+(Number(data[i].memberCount)+1)+' </li></ul>';
				html +=	'<div id="'+data[i].matchNo+'" class="collapse container" aria-labelledby="lightningTest-head" data-parent="#lightning">';
				html += '<div id="swiperContainer"  class="card-body">';
				html +=	'<div id="swiper-container" class="swiper-container'+data[i].matchNo+'">';
				html +=	'<div class="swiper-wrapper">';
				html +=	'<div id="swiper-slide" class="swiper-slide card-body">'+data[i].matchContent+'</div>';
				if(data[i].memberCount>=1){
					html +=	'<div id="swiper-slide" class="swiper-slide card-body">'+data[i].joinMemberNickName+'</div>';
				}
				if(data[i].placeName!=null){
					html +=	'<div id="swiper-slide" class="swiper-slide card-body">'+data[i].placeName+'<div id="map_'+i+'" class="myMap"></div></div>';
				}
				html += '</div><div class="swiper-pagination'+data[i].matchNo+'"></div></div></div>';
				/* html += '<div class="swiper-button-prev'+data[i].matchNo+'"></div>';
				html += '<div class="swiper-button-next'+data[i].matchNo+'"></div></div></div>'; */
				html +=	'<button type="button" class="btn btn-primary float-right">참가신청</button></div>';
				$("#lightningList-content").append(html);
				if(data[i].placeName!=null){
					insertMap(i, data[i].placeLat, data[i].placeLng);
				}
				insertSlide(data[i].matchNo);
			}
			
			$("#cPage").val(Number($("#cPage").val())+1);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	}); 
}
function insertMap(i, mapx, mapy){
	var id = $("#map_"+i).attr('id');
	console.log(mapx,mapy);
	var map = new naver.maps.Map(id, {
        center: new naver.maps.Point(mapx, mapy),
        zoom: 12,
        mapTypes: new naver.maps.MapTypeRegistry({
            'normal': naver.maps.NaverMapTypeOption.getNormalMap({
                projection: naver.maps.TM128Coord
            }),
            'terrain': naver.maps.NaverMapTypeOption.getTerrainMap({
                projection: naver.maps.TM128Coord
            }),
            'satellite': naver.maps.NaverMapTypeOption.getSatelliteMap({
                projection: naver.maps.TM128Coord
            }),
            'hybrid': naver.maps.NaverMapTypeOption.getHybridMap({
                projection: naver.maps.TM128Coord
            })
        }),
        mapTypeControl: true
    });
	var marker = new naver.maps.Marker({
       position: new naver.maps.Point(mapx, mapy),
       map: map
  	});

};

function insertSlide(no){
	var swiper = new Swiper('.swiper-container'+no, {
	      effect: 'cube',
	      grabCursor: true,
	      cubeEffect: {
	        shadow: true,
	        slideShadows: true,
	        shadowOffset: 20,
	        shadowScale: 0.94,
	      },
	      pagination: {
	        el: '.swiper-pagination'+no,
	      },
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
				<label for="title">제목검색</label>
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
				<label for="city">도시검색</label>
				<select class="form-control" id="city" onchange="selectLocalList();">
					<option id="defaultCity" value="0" disabled selected>도시를 선택해주세요</option>
					<c:forEach items="${cityList}" var="city">
					<option value=${city.cityCode }>${city.cityName }</option>						
					</c:forEach>
				</select>
			</li>
			<li class="list-group-item">
				<label for="local">지역검색</label>
				<select class="form-control" id="local">
					<option id="defaultLocal" value="0" disabled selected>지역을 선택해주세요</option>
				</select>
			</li>
			<li class="list-group-item">
				<label for="nickName">작성자검색</label>
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