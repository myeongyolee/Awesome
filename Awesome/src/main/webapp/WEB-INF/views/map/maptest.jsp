<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네친구 보여주기" name="pageTitle"/>
</jsp:include>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&callback=initMap"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>

<style>
#tablet{width:800px; height: 600px; background: black; margin:0 auto; border-radius: 40px; padding:10px 37px;}
#vicinage-friend{background:aliceblue; padding-top:50px ;}
#naver-map{width: 700px; height: 575px; background: white;}

</style>

<input type="hidden" name="memberLoggedIn" value="${memberCode }" />
<div id="vicinage-friend" class="section">
     <div id="tablet">
         <div id="naver-map">
            		     
         </div>
     </div>
</div>


<script type="text/javascript">
function initMap() {
	
	//로그인된 회원의 동네찾기
	var param = $("input[name=memberLoggedIn]").val();
	console.log(param);
	
	if(param != ""){
	//Member테이블의 회원정보 중 로그인된 사용자와 같은 도로명 주소 가지고 오기 및 회원정보 가지고 오기 (JOIN사용해서 MAP형식으로 전부 받을 것)
 	$.ajax({
		url:"${pageContext.request.contextPath}/map/selectAddress",
		data:{param:param},
		success:function(data){
			console.log(data);	
			//지도 중앙에 표시할 자기좌표 가지고 오기
			$.ajax({
				url:"${pageContext.request.contextPath}/map/selectMyAddress",
				data:{param:param},
				success:function(result){
					console.log(result);
				//Map의 중심지역설정 (로그인한 사용자를 기준으로 설정할 것)
			    var map = new naver.maps.Map('naver-map', {
			        center: new naver.maps.LatLng(result[0].PLACE_LNG, result[0].PLACE_LAT),
			        zoom: 10
			    });		
				var markers = [];
				var infowindows = [];
				//중심지역 주변으로 선택될 Marker
				for(var i=0; i<data.length; i++){     
		    	     var marker = new naver.maps.Marker({
		    	         position: new naver.maps.LatLng(data[i].PLACE_LNG, data[i].PLACE_LAT),
		    	         map: map
		    	     });  
		      	    var contentString = [
		    	          '<div class="iw_inner">',
		    	          '<img src="${pageContext.request.contextPath}/resources/upload/member/'+data[i].RENAMED_PROFILE+'" width="100" height="100" alt="" class="thumb" />',
		    	          '<p>이름:'+data[i].MEMBER_NAME+'</p>',
		    	          '<p>성별:'+data[i].GENDER+'</p>',
		    	          '<p>자기소개 ↓↓↓</p>'+data[i].INTRODUCE,
		    	          '<p>관심분야:'+data[i].INTERESTING_CODE+'</p>',
		    	          '<button type="button" onclick="sendFriend('+data[i].MEMBER_CODE+','+param+');">친구요청</button>',
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
				//해당 Marker마다 정보창 보여주기
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
				}
			});
		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
	}
	else{
		var HTML = "<p>등록된 동네친구가 없습니다</p>";
		$("#naver-map").append(HTML);
	}
	
};
</script>

<script>
function sendFriend(friend, user){
	//테이블에 친구요청한 사실이 있는지 없는지 먼저 확인
	$.ajax({
		url:"${pageContext.request.contextPath}/map/checkFriend?memberCode="+user+"&friendCode="+friend,
		success:function(data){
			console.log(data);
			
			if(data == 0){
				console.log("친구등록사실없음. 등록진행 가능");
				location.href="${pageContext.request.contextPath}/map/sendFriend?memberCode="+user+"&friendCode="+friend;
			}
			else{
				console.log("친구등록사실있음. 중복진행 불가능");
				alert("이미 친구요청을 보낸 사람입니다.");
			}
			
			
		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});	
}
</script>


</body>
</html>