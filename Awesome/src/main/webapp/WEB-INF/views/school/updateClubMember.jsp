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
</head>
<body>
<input type="text" name="clubCode" value="${clubCode }" />
<input type="text" name="memberCode" value="${memberCode }" />

<div class="clubMember-container">
<p>이름:${memberName }</p>
<p>현재 회원등급:${memberGrade }</p>
<c:if test="${memberGrade eq '일반회원' }">
<select name="grade">
	<option value="1">매니저</option>
	<option value="2">클럽장</option>
</select>
</c:if>

<c:if test="${memberGrade eq '매니저' }">
<select name="grade">
	<option value="0">일반회원</option>
	<option value="2">클럽장</option>
</select>
</c:if>

<c:if test="${memberGrade eq '클럽장' }">
<select name="grade">
	<option value="0">일반회원</option>
	<option value="1">매니저</option>
</select>
</c:if>
</div>
<button onclick="send();">확인</button>

<script>
function send(){
	var clubCode = $("input[name=clubCode]").val();
	var memberCode = $("input[name=memberCode]").val();
	var memberGrade = $("[name=grade]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/updateGrade",
		data:{clubCode:clubCode, memberCode:memberCode, memberGrade:memberGrade},
		success:function(data){
			console.log(data);
			
			self.close(); 
		}		
	});
}
</script>
</body>
</html>