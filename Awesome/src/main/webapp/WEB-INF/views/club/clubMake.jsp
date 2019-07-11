<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
	
<style>
#form-container{width:700px;}
#matchContent{min-height: 200px; resize: none;}
#btn{margin-right:20px;}
#selectPlace{width:150px;}
#img-viewer{width:344px; height: 300px;}


</style>

<script>
$(function(){
	$("#img-viewer").click(function(){
		$("#uploadProfile").click();
	});	
});
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
</script>



<section>

	<h2>클럽개설</h2>
		<div id="form-container" class="card mx-auto">
		<form action="${pageContext.request.contextPath}/club/clubMakeEnd.do" method="post" enctype="multipart/form-data">
			<div class="form-row">
				<div class="form-group col-md-6">
					<img src="${pageContext.request.contextPath}/resources/images/log.jpg" id="img-viewer" class="img-thumbnail" style="cursor:pointer">
					<input type="file" name="uploadProfile" id="uploadProfile" style="display:none;" onchange="loadProfile(this);"/>
					
				</div>
				<div class="form-group col-md-6">
					<label for="clubName">Club Name</label>
					<input type="text" class="form-control" name="clubName" placeholder="club name입력">
					
					<!-- 작성자: 로그인된 아이디로 전달(로그인구현하면 주석풀기) -->
					<%-- <input type="hidden" name="memberCode" value="<%=memberLoggedIn!=null?memberLoggedIn.getMemberId():""%>" readonly> --%>
					
					<label for="interestingCode">카테고리선택</label>
					<select name="interestingCode" id="interestingCode" class="form-control">
						<option selected disabled="disabled">카테고리 선택</option>
						<option value="1">분류1</option>
						<option value="2">분류2</option>
						<option value="3">분류3</option>
						<option value="4">분류4</option>
					</select>
					
					
					<label for="cityName" style="margin-right: 110px; display: inline-block;" >도시선택</label>
					<label for="localName" style=" display: inline-block;">State</label>
					<select name="cityName" id="cityName" class="form-control" style="width: 150px; display: inline-block; margin-right: 18px;">
						<option selected disabled="disabled">도시 선택</option>
						<option value="city1">도시1</option>
						<option value="city2">도시2</option>
						<option value="city3">도시3</option>
						<option value="city4">도시4</option>
					</select>
					
					<select name="localCode" id="localName" class="form-control" style="width: 150px;  display: inline-block;">
						<option selected disabled="disabled">구 선택</option>
						<option value="1">지역1</option>
						<option value="2">지역2</option>
						<option value="3">지역3</option>
						<option value="4">지역4</option>
					</select>
					
					<label for="clubsimpleInfo">클럽한줄소개</label>
					<input type="text" class="form-control" name="clubsimpleInfo" placeholder="클럽한줄소개를 입력하세요.(50자 이내)">
					
				</div>
			</div>
			
			<div class="form-group">
				<label for="clubInfo">클럽상세설명</label>
				<textarea class="form-control" name="clubInfo" id="clubInfo" placeholder="클럽을 소개해 주세요.(2000자 이내)" style="min-height: 200px;"></textarea>
			</div>
			
			<div style="display: none;">
				<label for="club-invite-friend">초대할 친구 목록</label>
				<tabel>
					<tr>
						<td>친구사진</td>
						<td>친구아이디</td>
						<td>친구이름</td>
					</tr>
				</tabel>
			</div>
			
	
			<!-- modal 구동 버튼 (trigger) -->
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
 			 친구추가
			</button>


			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  				<div class="modal-dialog" role="document">
    				<div class="modal-content">
      					<div class="modal-header">
   
        					<h4 class="modal-title" id="myModalLabel">친구목록</h4>
      					</div>
      				<div class="modal-body">
       					 친구목록 ajax
      				</div>
      				<div class="modal-footer">
      					<button type="button" class="btn btn-default" data-dismiss="modal">초대</button>
        			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      			</div>
    		</div>
  			</div></div>

			
			<button  type="button" class="btn btn-primary float-right" value="BACK" onclick="history.go(-1)">이전</button>
			<button  type="submit" class="btn btn-primary float-right">등록</button>
			
			<div id="hidden-container">
				<input type="hidden" name="placeId"/>
				<input type="hidden" name="placeLat" value="0"/>
				<input type="hidden" name="placeLng" value="0"/>
				<input type="hidden" name="matchingType" value="C"/>
			</div>
		</form>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>