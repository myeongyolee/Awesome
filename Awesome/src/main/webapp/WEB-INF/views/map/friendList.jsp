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

<style>
div.friend-view{
	border: 1px solid black;
}
img#profileimg{
	border: 1px solid black;
}
</style>

</head>
<body>
<input type="hidden" name="list" value="${list }" />
<input type="hidden" name="memberLoggedIn" value="${memberCode }" />

<c:if test="${empty list }">
	<p>등록된 친구가 없습니다.</p>
</c:if>

<c:if test="${not empty list }">
<div class="friend-view-container"></div>
</c:if>

<script>
$(function(){
	var param = $("input[name=list]").val().replace("[","").replace("]","");
	
	if(param != ""){
	$.ajax({
		url:"${pageContext.request.contextPath}/map/showMyFriend",
		data:{param:param},
		success:function(data){
			console.log(data); // 내 친구목록 정보 담고있음
			
			var HTML = "";
			for(var i in data){
				HTML += "<div class='friend-view'>";
				HTML += "<img src='${pageContext.request.contextPath }/resources/upload/member/"+data[i].RENAMED_PROFILE+"' width=200px; height=200px; id='profileimg'/>";
				HTML += "<p id='"+i+"'>"+data[i].MEMBER_CODE+"</p>";
				HTML += "<p>"+data[i].MEMBER_NAME+"</p>";
				HTML += "<p>"+data[i].NICKNAME+"</p>";
				HTML += "<p>"+data[i].GENDER+"</p>";
				HTML += "<p>"+data[i].BRITHDAY+"</p>";
				HTML += "<button onclick='deleteFriend("+i+");'>친구 삭제</button>";
				HTML += "</div>";
			}
			$("div.friend-view-container").append(HTML);
		}
	});
	}
});
</script>

<script>
function deleteFriend(num){
	var memberCode = $("input[name=memberLoggedIn]").val();
	var friendCode = $("p#"+num+"")[0].innerHTML;
	console.log(friendCode);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/map/deleteFriend",
		data:{memberCode:memberCode,friendCode:friendCode},
		success:function(data){
			console.log(data);
			
			if(data == 1){
				console.log("들어옴호가인");
				alert("삭제 성공");
				location.href="${pageContext.request.contextPath}/member/memberInfo.do";
			}
		}
	});
	
	
}
</script>

</body>
</html>