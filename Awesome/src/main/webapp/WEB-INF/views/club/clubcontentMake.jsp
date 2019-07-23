<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>


	
<style>
div#contentmake-container{width:600px; margin:0 auto; text-align:center;}
div#contentmake-container input{margin-bottom:15px;}

</style>	

<script>
function validate(){
	var content = $("[name=boardContent]").val();
	if(content.trim().length==0){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>
	
	
	<div style="text-align: center;">
			<c:if test="${empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 95%; height: 250px; "  />
			</c:if>
			<c:if test="${not empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 95%; height: 250px; " />
			</c:if>
	</div>
	
	<div id="contentmake-container">	
	<h2>게시물 작성</h2>
	${club }
	
	<form name="contentmakeFrm" 
		  action="${pageContext.request.contextPath}/club/clubcontentMakeend.do" 
		  method="post" 
		  onsubmit="return validate();"
		  enctype="multipart/form-data">
		
		<input type="hidden" name="clubCode" value="${club.clubCode}" readonly>  
		<%-- <input type="hidden" name="memberCode" value="${memberLoggedIn.memberCode} " readonly> --%>
		<input type="hidden" name="memberCode" value="1" readonly>
		<input type="text" class="form-control" placeholder="제목" name="contentTitle" id="contentTitle" required>
		<input type="text" class="form-control" name="contentWriter" value="memberLoggedIn.memberId" readonly required>
	    <textarea class="form-control" name="content" placeholder="내용" required></textarea>
		<input type="hidden" name="writeLevel" value="1" readonly>
		<br />
		<input type="submit" class="btn btn-outline-success" value="저장" >
	</form>
</div>
	
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>