<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>

<style>
.img-thumbnail{
	width: 284px;
	height: 194px;
}

</style>

<script>
$(function(){
	$("#img-viewer1").click(function(){
		$("#uploadProfile1").click();
	});	
});
function loadProfile1(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer1").attr("src", reader.result);
		}
	}
};

$(function(){
	$("#img-viewer2").click(function(){
		$("#uploadProfile2").click();
	});	
});
function loadProfile2(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer2").attr("src", reader.result);
		}
	}
};

$(function(){
	$("#img-viewer3").click(function(){
		$("#uploadProfile3").click();
	});	
});
function loadProfile3(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer3").attr("src", reader.result);
		}
	}
};

</script>

${club }

	<table id="clubcontentImg">
		<div style="text-align: center;">
			<c:if test="${empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 95%; height: 250px; "  />
			</c:if>
			<c:if test="${not empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 95%; height: 250px; " />
			</c:if>
		</div>
	
		<button class="btn btn-outline-secondary" onclick="imgcountAdd();">사진더올리기</button>
		<span>사진은 최대 3장까지 올릴수 있습니다.</span>
		<br>
		
		<form action="${pageContext.request.contextPath}/club/clubcontentImgend.do" method="post" enctype="multipart/form-data">
			
			<div class="form-group col-md-6" style="display: inline; margin-left: 20px; ">
				<img src="${pageContext.request.contextPath}/resources/images/sampleimage.png" id="img-viewer1" class="img-thumbnail">
				<input type="file" name="upFile" id="uploadProfile1" style="display:none;" onchange="loadProfile1(this);"/>				
			</div>
		
		
			<div class="form-group col-md-6" style="display: inline;">
				<img src="${pageContext.request.contextPath}/resources/images/sampleimage.png" id="img-viewer2" class="img-thumbnail">
				<input type="file" name="upFile" id="uploadProfile2" style="display:none;" onchange="loadProfile2(this);"/>
			</div>
		
			<div class="form-group col-md-6" style="display: inline;">
				<img src="${pageContext.request.contextPath}/resources/images/sampleimage.png" id="img-viewer3" class="img-thumbnail">
				<input type="file" name="upFile" id="uploadProfile3" style="display:none;" onchange="loadProfile3(this);"/>
			</div>
			<br><br>
	
	
			<input type="text" name="content1" id="content1" style="margin-left: 80px; margin-right: 80px;"/>
			<input type="text" name="content2" id="content2" style="margin-left: 90px; margin-right: 90px;"/>
			<input type="text" name="content3" id="content3" style="margin-left: 80px; margin-right: 70px;"/>
			<br><br><br>
			
			<button  type="submit" class="btn btn-primary" style="position: absolute; left: 38%;">등록하기</button>
			<button  type="button" class="btn btn-primary" value="BACK" onclick="history.go(-1)" style="position: absolute; left: 53%;">취소</button>
			
			<div id="hidden-container">
				<input type="hidden" name="clubCode" value="${club.clubCode }"/>
				<input type="hidden" name="memberCode" value="1"/>
				<input type="hidden" name="writeLevel" value="2" readonly>
			</div>
		
		</form>
		
	</table>

	<br>
	<br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>