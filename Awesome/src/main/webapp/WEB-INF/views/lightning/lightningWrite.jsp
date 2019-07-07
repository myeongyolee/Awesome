<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>번개팅작성</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
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
</head>
<body>
	<div id="form-container" class="card mx-auto">
		<form action="${pageContext.request.contextPath}/lightning/lightningWriteEnd.do" method="post" enctype="multipart/form-data">
			<div class="form-row">
				<div class="form-group col-md-6">
					<img src="${pageContext.request.contextPath}/resources/images/sampleimage.png" id="img-viewer" class="img-thumbnail">
					<input type="file" name="uploadProfile" id="uploadProfile" style="display:none;" onchange="loadProfile(this);"/>
					<label for="placeName">지도에서 장소 선택하기</label>
					<input type="text" class="form-control" name="placeName" placeholder="장소 선택하기" readonly>
				</div>
				<div class="form-group col-md-6">
					<label for="matchTitle">Title</label>
					<input type="text" class="form-control" name="matchTitle" placeholder="title입력">
					<label for="cityName">도시선택</label>
					<select id="cityName" class="form-control">
						<option selected>도시 선택</option>
						<option value="city1">도시1</option>
						<option value="city2">도시2</option>
						<option value="city3">도시3</option>
						<option value="city4">도시4</option>
					</select>
					<label for="localName">State</label>
					<select name="localCode" id="localName" class="form-control">
						<option selected>구 선택</option>
						<option value="1">지역1</option>
						<option value="2">지역2</option>
						<option value="3">지역3</option>
						<option value="4">지역4</option>
					</select>
					<label for="interestingCode">모집분류</label>
					<select name="interestingCode" id="interestingName" class="form-control">
						<option selected>모집분류 선택</option>
						<option value="1">분류1</option>
						<option value="2">분류2</option>
						<option value="3">분류3</option>
						<option value="4">분류4</option>
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
				<input type="hidden" name="placeId"/>
				<input type="hidden" name="placeLat" value="0"/>
				<input type="hidden" name="placeLng" value="0"/>
				<input type="hidden" name="matchingType" value="L"/>
			</div>
		</form>
	</div>
</body>
</html>