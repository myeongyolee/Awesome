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

function selectLocalList(){
	var param = {city: $("#cityName>option:selected").val()}
	var city = JSON.stringify(param);
	$.ajax({
		url : '${pageContext.request.contextPath}/lightning/localList.do',
		dataType: "json",
		type : 'POST',
		data : city,
		contentType: "application/json; charset=UTF-8",
		success : function(data){
			$("#localName").html("");
			var html = "";
			html += '<option id="defaultLocal" disabled selected>지역 선택</option>';
			for(var i=0; i<data.length; i++){
				html += '<option value='+data[i].localCode+'>'+data[i].localName+'</option>';					
			}
			$("#localName").append(html);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
};



$(document).ready(function(){
    $('#clubInfo').keyup(function(){
        if ($(this).val().length > $(this).attr('maxlength')) {
            alert('제한길이 초과');
            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
        }
    });
});



</script>




	${cityList }
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
					<input type="text" class="form-control" name="clubName" placeholder="club name입력" required="required">
					
					<!-- 작성자: 로그인된 아이디로 전달(로그인구현하면 주석풀기) -->
					<%-- <input type="hidden" name="memberCode" value="<%=memberLoggedIn!=null?memberLoggedIn.getMemberId():""%>" readonly> --%>
					
					<label for="interestingCode">카테고리선택</label>
					<select name="interestingCode" id="interestingCode" class="form-control">
						<option id="defaultInteresting" value="0" disabled selected>분류를 선택해주세요</option>
						<c:forEach items="${interestingList}" var="interesting">
						<option value=${interesting.interestingCode }>${interesting.interestingName }</option>						
						</c:forEach>
					</select>
					
					<label for="cityName" style="margin-right: 110px; display: inline-block;" >도시선택</label>
					<label for="localName" style=" display: inline-block;">State</label>
					
					
					
					<select name="cityName" id="cityName" class="form-control" style="width: 150px; display: inline-block; margin-right: 18px;" onchange="selectLocalList();" required>
						<option id="defaultCity" value="0" disabled selected>도시 선택</option>
						<c:forEach items="${cityList}" var="city">
						<option value=${city.cityCode }>${city.cityName }</option>						
						</c:forEach>
					</select>
					
					<select name="localCode" id="localName" class="form-control" style="width: 150px;  display: inline-block;" required>
						<option id="defaultLocal" value="0" disabled selected>지역 선택</option>
					</select>
						
					
					<label for="clubsimpleInfo">클럽한줄소개</label>
					<input type="text" class="form-control" name="clubsimpleInfo" placeholder="클럽한줄소개를 입력하세요.(20자 이내)" required="required" maxlength="25">
					
				</div>
			</div>
			
			<div class="form-group">
				<label for="clubInfo">클럽상세설명</label>
				<textarea class="form-control" name="clubInfo" id="clubInfo" placeholder="클럽을 소개해 주세요.(100자 이내)" style="min-height: 200px;" maxlength="120" ></textarea>
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

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>