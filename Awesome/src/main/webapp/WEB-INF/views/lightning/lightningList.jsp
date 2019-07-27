<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Awesome" name="번개모임"/>
</jsp:include>
<!-- bootstrap -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>
<style>
#lightningList-content{width:600px; }
#lightning{width:500px; margin-bottom: 10px;}
#search-container{
	width:300px;
	position: fixed;
	right: 0;
	top: 50px;
}
#ContentView{height:290px;}
#match{height:375px; position: relative;}
.myMap{width:334px; height:250px; position: relative;}

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
	
	if($("#city>option:selected").not("#default City")) param.city = $("#city>option:selected").val();
	if($("#local>option:selected").not("#defaultLocal")) param.local = $("#local>option:selected").val();
	if($("#interesting>option:selected").not("#defaultInteresting")) param.interesting = $("#interesting>option:selected").val();
	
	console.log(param);
	var str = JSON.stringify(param);
	console.log(str);
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
				html +=	'<div id="lightning" class="card border-success">';
				html +=	'<div id="'+data[i].matchNo+'-head" class="card-header">';
				if(data[i].matchRenamedImg!=null){
				html +=	'<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/match/'+data[i].matchRenamedImg+'" alt="Card image cap">';					
				}
				html +=	'<div class="card-body" data-toggle="collapse" data-target="#'+data[i].matchNo+'" aria-expanded="true" aria-controls="'+data[i].matchNo+'">';
				html +=	'<h5 class="card-title"> '+data[i].matchTitle+' </h5></div></div>';
				html +=	'<ul class="list-group list-group-flush">';
				html +=	'<li class="list-group-item"> '+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+'</li>';
				html +=	'<li class="list-group-item"> 작성자:'+data[i].nickName+' | 참여회원수: '+(Number(data[i].memberCount)+1)+' </li></ul>';
				html +=	'<div id="'+data[i].matchNo+'" class="collapse container" aria-labelledby="'+data[i].matchNo+'-head" data-parent="#lightning">';
				html +=	'<div id="carousel'+data[i].matchNo+'" class="carousel slide mb-3" data-ride="carousel">';
				html +=	'<ol id="indicators" class="carousel-indicators">';
				html +=	'<li data-target="#carousel'+data[i].matchNo+'" data-slide-to="'+j+'" class="active"></li>';
				if(data[i].memberCount>=1){
					j++;
					html += '<li data-target="#carousel'+data[i].matchNo+'" data-slide-to="'+j+'"></li>';
				}
				if(data[i].placeName!=null){
					j++;
					html += '<li data-target="#carousel'+data[i].matchNo+'" data-slide-to="'+j+'"></li>';					
				}
				html += '</ol>'
				html +=	'<div id="match" class="carousel-inner">';
				html +=	'<div class="carousel-item active p-5">';
				html +=	'<div class="card border-light">';
				html +=	'<div id="ContentView" class="card-body">'+data[i].matchContent+'</div></div></div>';
				if(data[i].memberCount>=1){
					html +=	'<div class="carousel-item p-5">';
					html +=	'<div class="card border-light">';
					html +=	'<div id="ContentView" class="card-body">'+data[i].joinMemberNickName+'</div></div></div>';
				}
				if(data[i].placeName!=null){
					html +=	'<div class="carousel-item p-5">';
					html +=	'<div class="card">';
					html +=	'<div id="ContentView" class="card-body border-light">'+data[i].placeName+'<div id="map_'+i+'" class="myMap"></div></div></div></div>';
				}
				html +=	'<a class="carousel-control-prev" href="#carousel'+data[i].matchNo+'" role="button" data-slide="prev">';
				html +=	'<span class="carousel-control-prev-icon bg-dark" aria-hidden="false"></span>';
				html +=	'<span class="sr-only">Previous</span></a>';
				html +=	'<a class="carousel-control-next" href="#carousel'+data[i].matchNo+'" role="button" data-slide="next">';
				html +=	'<span class="carousel-control-next-icon bg-dark" aria-hidden="false"></span>';
				html +=	'<span class="sr-only">Next</span></a></div></div>';
				html +=	'<button type="button" class="btn btn-primary float-right">참가신청</button></div>';
				$("#lightningList-content").append(html);
				if(data[i].placeName!=null) insertMap(i, data[i].placeLat, data[i].placeLng);
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

</script>

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

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
