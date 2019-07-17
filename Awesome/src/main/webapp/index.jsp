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
section.main-section{
	border: 6px solid black;
	border-radius: 80px;
	width: 700px;
	min-height: 500px;
	
	display: inline-flex;
}
div.profile-photo{
	border: 1px solid red;
	width: 49%;
	height: 500px;
	
	display: flex;
	overflow: hidden;
    align-items: center;
    justify-content: center;
}
div.profile-text{
	border: 1px solid blue;
	width: 49%;
	height: 500px;
	
}
ul.profile-list{
	padding: 60px;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="awesome 인덱스" name="pageTitle"/>
</jsp:include>
<script>
function city_local_info(){
	/* var param = {};
	param.key = '82C91404-6AF0-3A92-8D77-CB8CCEE31F42';
	param.domain = 'http://localhost/awesome/';
	
	var jsonParam = JSON.stringify(param); */
	
	$.ajax({
		url : 'http://api.vworld.kr/req/data?service=data&request=GetFeature&data=LT_C_ADSIGG_INFO&key=C5041472-87EC-3778-B5A6-95598389672F&domain=',
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(data){
			console.log(data);
		},error: function(){
			
		}
	});
};
</script>

<button onclick="city_local_info();">도시정보</button>

<button onclick="location.href='${pageContext.request.contextPath}/lightning/lightningList.do'">lightning.do</button>

<<<<<<< HEAD
<input type="button" value="동네친구 지도 확인" onclick="searchMap();" />
<input type="button" value="동네친구찾기" onclick="modaltest();"/>
<input type="button" value="동네친구찾기MODAL" class="modal" name="modal" data-toggle="modal" data-target="#searchfriend" /> 
<input type="text" name="modalmember" value="124"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->

<button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/questionBoard/boardForm.do'">질문 작성</button>
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/questionBoard/questionBoard.do'">질문 게시판 보기</button>
			 
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/admin/adminMain.do'">관리자 메인 페이지</button>


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
	<button onclick="location.href='${pageContext.request.contextPath}/websocket/chatting'">채팅기능</button>
	</section>
	--%>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
