<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
#form-container{width:700px;}
#matchContent{min-height: 200px; resize: none;}
#btn{margin-right:20px;}
#selectPlace{width:150px;}
#img-viewer{width:344px; height: 300px;}
#map{width:465px; height:350px;}
.modal-content div{z-index: 1050;}
</style>
<script>
$(function(){
	$("#img-viewer").click(function(){
		$("#uploadProfile").click();
	});	
});

function writeCheck(){
	//title채크
	if($("[name=matchTitle]").val().trim()==""){
		alert("제목을 입력하세요.");
		$("[name=matchTitle]").focus();
		return false;
	}
	//지역선택 채크
	if($("#localCode").val()==null){
		alert("지역을 선택해주세요.");
		return false;
	}
	
	//분류선택 채크
	if($("#interestingCode").val()==null){
		alert("분류를 선택해주세요.");
		return false;
	}
	
	//일자 채크
	if($("[name=lightningEndDate]").val()==""){
		alert("마감일자를 입력해주세요.");
		return false;
	}
	//시간 채크
	if($("[name=lightningEndTime]").val()==""){
		alert("마감시간을 입력해주세요.");
		return false;
	}
	
	//내용 채크
	if($("[name=matchContent]").val().trim()==""){
		alert("내용을 입력하세요.");
		$("[name=matchContent]").focus();
		return false;
	}
}

function selectLocalList(){
	var param = {city: $("#cityCode>option:selected").val()}
	var city = JSON.stringify(param);
	$.ajax({
		url : '${pageContext.request.contextPath}/lightning/localList.do',
		dataType: "json",
		type : 'POST',
		data : city,
		contentType: "application/json; charset=UTF-8",
		success : function(data){
			$("#localCode").html("");
			var html = "";
			html += '<option id="defaultLocal" disabled selected>지역을 선택해주세요</option>';
			for(var i=0; i<data.length; i++){
				html += '<option value='+data[i].localCode+'>'+data[i].localName+'</option>';					
			}
			$("#localCode").append(html);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
};

function loadProfile(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer").attr("src", reader.result);
		}
	}
};

function findPosition(){
	
	var param = $("input[name=position]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/lightning/map/findPosition",
		data:{param:param},
		success:function(data){
			console.log(data);
	
			var map = new naver.maps.Map("map", {
		        center: new naver.maps.Point(data.items[0].mapx, data.items[0].mapy),
		        zoom: 10,
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
			
			var markers = [];
			var infowindows = [];
			
			$("#mapInfo").html("");
			for(var i=0; i<data.items.length; i++){
				var title = data.items[i].title;
				title = title.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
				
				var HTML = "";
				HTML += "<button type='button' id='locationBtn"+i+"' class='list-group-item list-group-item-action' data-dismiss='modal' onclick='insertData(this);'>";
				HTML += "<p>"+data.items[i].title+"</p>";
				HTML += "<small>"+data.items[i].roadAddress+"</small>";
				HTML += "<input type='hidden' id='mapTitle' value='"+title+"'/>";
				HTML += "<input type='hidden' id='mapx' value='"+data.items[i].mapx+"'/>";
				HTML += "<input type='hidden' id='mapy' value='"+data.items[i].mapy+"'/>";
				HTML += "</button>";
				$("#mapInfo").append(HTML);
				var marker = new naver.maps.Marker({
				    position: new naver.maps.Point(data.items[i].mapx, data.items[i].mapy),
				    map: map
				});
	     
				var contentString = [
	    	          '<div class="iw_inner">',
					  '<p>'+data.items[i].title+'</p>',
					  '<p>'+data.items[i].roadAddress+'</p>',
					  '<button type="button" onclick="test10('+i+');">확인</button>',
	    	          '</div>'
	    	      ].join('');
	    	        
	    	    var infowindow = new naver.maps.InfoWindow({
	    	         content: contentString,
	    	         maxWidth: 1000,
	    	         backgroundColor: "#eee",
	    	         borderColor: "#dc50dc",
	    	         borderWidth: 5,
	    	         anchorSize: new naver.maps.Size(20, 20),
	    	         anchorSkew: true,
	    	         anchorColor: "#eee",
	    	         pixelOffset: new naver.maps.Point(20, -20)
	    	    });
	    	        
	    	    markers.push(marker);
	    	    infowindows.push(infowindow);    
			}
			
			function getClickHandler(seq){
	        	return function(e){
	        		var marker = markers[seq];
	        		var infowindow = infowindows[seq];
	        		
	        		if(infowindow.getMap()){
	        			infowindow.close();
	        		}
	        		else{
	        			infowindow.open(map,marker);
	        		}
	        		
	        	}
	        }
	        
			for(var i=0; i<markers.length; i++){
    	        naver.maps.Event.addListener(markers[i], "click", getClickHandler(i));
			}
			
		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
}

function insertData(btn){
	$("[name=placeName]").val("");
	$("[name=placeLat]").val("");
	$("[name=placeLng]").val("");
	
	var title = $(btn).find("#mapTitle").val();
	
	$("[name=placeName]").val(title);
	$("[name=placeLat]").val($(btn).find("#mapx").val());
	$("[name=placeLng]").val($(btn).find("#mapy").val());
	
}
</script>

	<div id="form-container" class="card mx-auto">
		<form action="${pageContext.request.contextPath}/lightning/lightningWriteEnd.do" method="post" enctype="multipart/form-data" onsubmit="return writeCheck();">
			<div class="form-row">
				<div class="form-group col-md-6">
					<img src="${pageContext.request.contextPath}/resources/images/sampleimage.png" id="img-viewer" class="img-thumbnail">
					<input type="file" name="uploadProfile" id="uploadProfile" style="display:none;" onchange="loadProfile(this);"/>
					<label for="placeName">지도에서 장소 선택하기</label>
					<input type="text" class="form-control" name="placeName" placeholder="장소 선택하기" data-toggle="modal" data-target="#searchMap" readonly>
				</div>
				<div class="form-group col-md-6">
					<label for="matchTitle">Title</label>
					<input type="text" class="form-control" name="matchTitle" placeholder="title입력">
					<label for="city">도시검색</label>
					<select class="form-control" id="cityCode" onchange="selectLocalList();">
						<option id="defaultCity" value="0" disabled selected>도시를 선택해주세요</option>
						<c:forEach items="${cityList}" var="city">
						<option value=${city.cityCode }>${city.cityName }</option>						
						</c:forEach>
					</select>
					<label for="local">지역검색</label>
					<select class="form-control" name="localCode" id="localCode">
						<option id="defaultLocal" value="0" disabled selected>지역을 선택해주세요</option>
					</select>
					<label for="interesting-search">분류검색</label>
					<select class="form-control" name="interestingCode" id="interestingCode">
						<option id="defaultInteresting" value="0" disabled selected>분류를 선택해주세요</option>
						<c:forEach items="${interestingList}" var="interesting">
						<option value=${interesting.interestingCode }>${interesting.interestingName }</option>						
						</c:forEach>
					</select>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="lightningEndDate">모집마감일자</label>
							<input type="date" class="form-control" name="lightningEndDate">
						</div>
						<div class="form-group col-md-6">
							<label for="lightningEndTime">모집마감시각</label>
							<input type="time" class="form-control" name="lightningEndTime"/>					
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<textarea class="form-control" name="matchContent" id="matchContent" placeholder="내용을 입력해주세요."></textarea>
			</div>
			<button id="btn" type="submit" class="btn btn-primary float-right">등록</button>
			<button id="btn" type="button" class="btn btn-primary float-right">이전</button>
			<div id="hidden-container">
				<input type="hidden" name="placeLat" value="0"/>
				<input type="hidden" name="placeLng" value="0"/>
				<input type="hidden" name="matchingType" value="L"/>
			</div>
		</form>
	</div>
</div>
</main>
</div>
	<div class="modal fade" id="searchMap" tabindex="-1" role="dialog" aria-labelledby="searchMap" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="searchMapTitle">지도 검색</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="searchMapBody">
					<div id="search-container" class="mb-2">
						<input type="text" name="position" class="col-md-9" placeholder="검색하려는 장소를 입력하세요"/>
						<input type="button" value="검색" onclick="findPosition();" />
					</div>
					<div id="map" class="mb-2"></div>
					<div id="mapInfo" class="mapInfo"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary">완료</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

