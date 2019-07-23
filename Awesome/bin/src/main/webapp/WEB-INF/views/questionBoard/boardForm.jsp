<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 부트스트랩관련 라이브러리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
 
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
div#board-container label.custom-file-label{text-align:left;}
</style>
<script>
$(function(){
	$("[name=questionOriginalFilename]").on("change",function(){
		 var fileName = $(this).val(); 
		 //C:\\fakepath\fileName
		//사용자가 파일입력을 취소한 경우
		  if($(this).prop('files')[0] === undefined){
			 $(this).next(".custom-file-label").html("파일을 선택하세요.");
			 return;
		 }
		var fileName = $(this).prop('files')[0].name;
	
		$(this).next(".custom-file-label").html(fileName);
	});
});
function validate(){
	console.log($("[name=boardFrm]").serialize());
	var content = $("[name=questionContent]").val();
	if(content.trim().length==0){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
$(function(){
	$("p1").html("공개 질문입니다. ");		
	$("#openCheck").on("click", function(){
		$("p1").html("비공개 질문입니다. ");		
			/* $("#openCheck").on("click", function(){
				$("p1").toggle("공개 질문입니다. ");		
			}); */	
		});	
});
</script>
<div id="board-container">질문을 완성하여 주세요.
	<form name="boardFrm"
		action="${pageContext.request.contextPath}/questionBoard/boardFormEnd.do"
		method="post" onsubmit="return validate();"
		enctype="multipart/form-data">
		<input type="text" class="form-control" placeholder="제목"
			name="questionTitle" id="boardTitle"> 
			<input type="text"
			class="form-control" placeholder="로그인한 아이디" value="12345"
			name="memberCode">
		<%-- value="${memberLoggedIn.memberId}" --%>
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3" style="padding: 0px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text">첨부파일1</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input"
					name="upFile" id="upFile">
					 <label
					class="custom-file-label" for="upFile">파일을 선택하세요</label>
			</div>
		</div>
		<div class="form-group row">
		  &nbsp; 공개여부
	    <div class="col-sm-10">
	      <div class="form-check">
	        <input class="form-check-input" type="checkbox" value='Y'
	         id="openCheck"
	        name="questionOpen">
	        <label class="form-check-label" for="openCheck">
	          	<p1></p1>
	        </label>
	      </div>
	    </div>
	  </div>
		<textarea class="form-control" name="questionContent" placeholder="내용"
			required></textarea>
		<br /> <input type="submit" class="btn btn-outline-success"
			value="저장">
	</form>
</div>



