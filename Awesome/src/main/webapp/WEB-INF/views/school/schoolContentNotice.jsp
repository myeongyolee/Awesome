<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member member = (Member)session.getAttribute("memberLoggedIn"); %>

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

<div style="text-align: center;">
		<c:if test="${empty schoolInfo[0].MAIN_RENAMED_FILENAME }">
			<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt=""  style="width: 95%; height: 250px; "  />
		</c:if>
		<c:if test="${not empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
			<img src="${pageContext.request.contextPath }/resources/upload/school/${schoolInfo[0].MAIN_RENAMED_FILENAME}"  alt=""  style="width: 95%; height: 250px; " />
		</c:if>
</div>
	
<div id="contentmake-container" style="padding:20px;">
	<h2>게시물 작성</h2>
	<form name="contentmakeFrm" 
		  action="${pageContext.request.contextPath}/school/schoolNoticeEnd" onsubmit="return validate();">
		<input type="hidden" name="clubCode" value="${schoolInfo[0].CLUB_CODE}" readonly>  
		<input type="hidden" name="memberCode" value="<%=member.getMemberCode() %>" readonly> <!-- 멤버코드 찍어주는 곳 -->
		<input type="text" name="contentTitle" placeholder="제목" required>
		<br />
		<hr />
	    <textarea name="content" cols="40" rows="3" placeholder="내용" required></textarea>
		<input type="hidden" name="writeLevel" value="0" readonly>
		<br />
		<input type="submit" class="btn btn-outline-success" value="저장" >
	</form>
</div>