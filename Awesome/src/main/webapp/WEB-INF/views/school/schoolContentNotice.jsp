<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>

<script>
function validate(){
	var content = $("[name=content]").val();
	if(content.trim().length==0){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>

</head>
<body>
공지사항쓰는곳
<p>${schoolInfo }</p>
<div style="text-align: center;">
		<c:if test="${empty schoolInfo[0].MAIN_RENAMED_FILENAME }">
			<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt=""  style="width: 95%; height: 250px; "  />
		</c:if>
		<c:if test="${not empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
			<img src="${pageContext.request.contextPath }/resources/upload/school/${schoolInfo[0].MAIN_RENAMED_FILENAME}"  alt=""  style="width: 95%; height: 250px; " />
		</c:if>
</div>
	
<div id="contentmake-container">
	<h2>게시물 작성</h2>
	<form name="contentmakeFrm" 
		  action="${pageContext.request.contextPath}/school/schoolNoticeEnd" onsubmit="return validate();">
		<input type="text" name="clubCode" value="${schoolInfo[0].CLUB_CODE}" readonly>  
		<input type="text" name="memberCode" value="124" readonly> <!-- 멤버코드 찍어주는 곳 -->
		<input type="text" name="contentTitle" placeholder="제목" required>
	    <textarea name="content" placeholder="내용" required></textarea>
		<input type="text" name="writeLevel" value="0" readonly>
		<br />
		<input type="submit" class="btn btn-outline-success" value="저장" >
	</form>
</div>
</body>
</html>