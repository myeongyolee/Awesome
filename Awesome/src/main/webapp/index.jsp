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
div.primary-div{
	border:1px solid black;
	min-height:30px;
}
button.modal{
	display: none;
}
textarea{
	border: 5px solid red;
	border-radius: 10px;
}
input#agree{
	position: relative;
	left: 400px;
}
label[for="agree"]{
	position: relative;
	left: 400px;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="awesome 인덱스" name="pageTitle"/>
</jsp:include>
<button onclick="location.href='${pageContext.request.contextPath}/lightning/lightningList.do'">lightning.do</button>

<input type="button" value="동네친구 지도 확인" onclick="searchMap();" />
<input type="button" value="동네친구찾기" onclick="modaltest();"/>
<input type="button" value="동네친구찾기MODAL" class="modal" name="modal" data-toggle="modal" data-target="#searchfriend" /> 
<input type="text" name="modalmember" value="124"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->

	<!-- 동네친구찾기버튼 눌렀을 때, 나타나는 MODAL -->
    <div class="modal fade" id="searchfriend" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
        
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">동네친구찾기 추가정보 확인</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          
          <form action="${pageContext.request.contextPath}/map/enrollFriend" name="friend-frm">
          <input type="text" name="memberLoggedIn" value="124"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->
          <div class="modal-body"> 
			
			<div class="">
				<textarea name="" id="" cols="60" rows="3" readonly>해당 서비스를 이용하기 위해서는 사용자정보 공개를 허용해야 합니다. 사용 하시겠습니까?</textarea>
				<br />
				<input type="checkbox" name="infocheck" id="agree" value="Y" style="display:inline-block" />
				<label for="agree">수락</label>
			</div>
			
			<div class="">
				<p>회원님의 관심분야를 선택하여 주세요!</p>
				<input type="checkbox" name="interesting" id="1" value="음식"/>
				<label for="1">음식</label>
				<input type="checkbox" name="interesting" id="2" value="여행"/>
				<label for="2">여행</label>
				<input type="checkbox" name="interesting" id="3" value="술"/>
				<label for="3">술</label>
				<input type="checkbox" name="interesting" id="4" value="영화"/>
				<label for="4">영화</label>
				<input type="checkbox" name="interesting" id="5" value="기타"/>
				<label for="5">기타</label>
			</div>
			 
          </div>
          
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-success" onclick="summitFrm2();">확인</button>
            <button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
          </div>
          </form>
         
        </div>
      </div>
    </div>
    <!-- 동네친구찾기 MODAL End -->

<br />


<input type="text" name="position" placeholder="검색하려는 장소를 입력하세요"/>
<input type="button" value="위치정보 확인" onclick="findPosition();" />
<div id="map" style="width:700px;height:700px;"></div>
<div id="infotest"></div>

<br />

<input type="button" value="동창찾기" data-toggle="modal" data-target="#searchModal"/>

	<!-- 로그인된 회원이 없을 경우 -->
	<%-- <c:if test="">
	
	</c:if> --%>
	
	<!-- 로그인된 회원이 있을 경우 -->
	<c:if test="true">
	
	<!-- 동창모임버튼 눌렀을 때, 나타나는 MODAL -->
    <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
        
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">나의 출신 학교</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          
          <form action="${pageContext.request.contextPath}/school/enrollSchool" name="school-frm">
          <input type="text" name="memberLoggedIn" value="123"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->
          <div class="modal-body"> <!-- 내가 회원가입할 때 등록한 학교정보 가지고 와서 보여주기 -->
                <input type="text" class="form-control" name="primary" placeholder="출신 초등학교" >
                <input type="hidden" name="primary_id" />
                <input type="hidden" name="primary_address" />
                <button type="button" onclick="test();">확인</button>
               
                <div class="primary-div">
                </div>
                
                <br /> 
                <input type="text" class="form-control" name="middle" placeholder="출신 중학교" >
                <input type="hidden" name="middle_id" />
                <input type="hidden" name="middle_address" />
                <button type="button" onclick="test2();">확인</button>
                
                <div class="middle-div">
                </div>
                
                <br />
                <input type="text" class="form-control" name="high" placeholder="출신 고등학교" >
                <input type="hidden" name="high_id" />
                <input type="hidden" name="high_address" />
                <button type="button" onclick="test3();">확인</button>
                
                <div class="high-div">
                </div>
               
          </div>
          
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-success" onclick="summitFrm();">확인</button>
            <button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
          </div>
          </form>
         
        </div>
      </div>
    </div>
    <!-- 동창찾기MODAL End -->
    
	</c:if>
	
	
<script>

$(function(){
	$("div.primary-div").hide();
	$("div.middle-div").hide();
	$("div.high-div").hide();
});

function searchMap(){
	location.href = "${pageContext.request.contextPath}/map/searchMap";	
}

function modaltest(){
	var memberCode = $("input[name=modalmember]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/map/checkInfo",
		data:{memberCode:memberCode},
		success:function(data){
			console.log(data);
			
			if(data == 'Y'){
				console.log("공개");
				location.href = "${pageContext.request.contextPath}/map/searchMap";	
			}
			else{
				console.log("비공개");
				$("input[name=modal]").trigger("click");
				
			}

		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
}

function summitFrm(){
	console.log("summitFrm들어옴");
	$("form[name=school-frm]").submit();
}

function summitFrm2(){
	console.log("summitFrm2들어옴");
	
	if($("input[name=infocheck]").is(":checked")){
		$("form[name=friend-frm]").submit();
	}
	else{
		alert("수락버튼은 확인해주세요.");
	}
}

function findPosition(){
	
	var param = $("input[name=position]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/map/findPosition",
		data:{param:param},
		success:function(data){
			console.log(data);
	
			var map = new naver.maps.Map("map", {
		        center: new naver.maps.Point(data.items[0].mapx, data.items[0].mapy),
		        zoom: 8,
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
			var HTMLS = [];
			
			for(var i=0; i<data.items.length; i++){
					 
				 var HTML = "";
				 HTML += "<input type='text' name='test"+i+"' value='"+data.items[i].title+"'>";
				 HTML += "<input type='text' name='test_"+i+"' value='"+data.items[i].roadAddress+"'>";
				 $("div#infotest").append(HTML);
				 console.log(HTML);
				 
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
	    	    HTMLS.push(HTML);
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


function test(){
	
	console.log("test함수 들어옴");
	
	var ch1 = $("input[name=primary]").val();
	
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				
				console.log(data.response.body.items.length);
				var HTML = "";
				
				if(data.response.body.items.length > 1) {
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.primary-div").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectPrimary("+i+");' class='p"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='pid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='padd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.primary-div").append(HTML);
				}
				else if(data.response.body.items.length == 1){
					
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=primary]").val(result);
					$("input[name=primary_id]").val(result2);
					$("input[name=primary_address]").val(result3);
					
				}
				
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=primary]").val("해당 학교가 존재하지 않습니다.");
			}
		}
	});
}

function test2(){
	
	console.log("test2함수 들어옴");
	
	var ch1 = $("input[name=middle]").val();
	
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				var HTML = "";
				
				if(data.response.body.items.length > 1) {
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.middle-div").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectMiddle("+i+");' class='m"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='mid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='madd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.middle-div").append(HTML);
				}
				else if(data.response.body.items.length == 1){
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=middle]").val(result);
					$("input[name=middle_id]").val(result2);
					$("input[name=middle_address]").val(result3);
				}
				
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=middle]").val("해당 학교가 존재하지 않습니다.");
			}
		}
	});
}

function test3(){
	
	console.log("test3함수 들어옴");
	
	var ch1 = $("input[name=high]").val();
	
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				var HTML = "";
				
				if(data.response.body.items.length > 1) {
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.high-div").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectHigh("+i+");' class='h"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='hid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='hadd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.high-div").append(HTML);
				}
				else if(data.response.body.items.length == 1){
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=high]").val(result);
					$("input[name=high_id]").val(result2);
					$("input[name=high_address]").val(result3);
				}
				
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=high]").val("해당 학교가 존재하지 않습니다.");
			}
		}
	});
}

function selectPrimary(num){
	console.log("selectPrimary 들어옴");
	console.log(num);
	
	var result = $("a.p"+num)[0].innerHTML;
	var result2 = $("input[name=pid"+num+"]").val();
	var result3 = $("input[name=padd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=primary]").val(result);
	$("input[name=primary_id]").val(result2);
	$("input[name=primary_address]").val(result3);
	
	$("div.primary-div").hide();
	
}

function selectMiddle(num){
	console.log("selectMiddle 들어옴");
	console.log(num);
	
	var result = $("a.m"+num)[0].innerHTML;
	var result2 = $("input[name=mid"+num+"]").val();
	var result3 = $("input[name=madd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=middle]").val(result);
	$("input[name=middle_id]").val(result2);
	$("input[name=middle_address]").val(result3);
	
	$("div.middle-div").hide();
	
}

function selectHigh(num){
	console.log("selectHigh 들어옴");
	console.log(num);
	
	var result = $("a.h"+num)[0].innerHTML;
	var result2 = $("input[name=hid"+num+"]").val();
	var result3 = $("input[name=hadd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=high]").val(result);
	$("input[name=high_id]").val(result2);
	$("input[name=high_address]").val(result3);
	
	$("div.high-div").hide();
	
}

function test10(num){
	console.log("체크");
	console.log(num);
	
	console.log($("input[name=test"+num+"]").val());
	console.log($("input[name=test_"+num+"]").val());
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
