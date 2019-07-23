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
<input type="text" name="clubCode" value="${clubCode }" /> <!-- 안보임 처리할 것 -->
	
	<div class="enroll-container">
	<c:forEach items="${clubMemberList }" var="list" varStatus="vs">
		<p id="${vs.index }">멤버코드:${list.MEMBER_CODE }</p>
		<p class="name${vs.index }">이름: ${list.MEMBER_NAME }</p>
		<p>성별: ${list.GENDER }</p>
		<c:if test="${list.CLUB_MEM_GRADE eq 0 }">
		<p class="${vs.index }">회원등급:일반회원</p>
		</c:if>
		<c:if test="${list.CLUB_MEM_GRADE eq 1 }">
		<p class="${vs.index }">회원등급:매니저</p>
		</c:if>
		<c:if test="${list.CLUB_MEM_GRADE eq 2 }">
		<p class="${vs.index }">회원등급:클럽장</p>
		</c:if>
		<button onclick="accept(${vs.index});">회원 등급 변경</button>
		<hr />
	</c:forEach>
	</div>
	
<script>
function accept(num){
	var memberCode = $("p#"+num+"")[0].innerHTML.split(":")[1];
	var memberName = $("p.name"+num+"")[0].innerHTML.split(":")[1];
	var memberGrade = $("p."+num+"")[0].innerHTML.split(":")[1];
	var clubCode = $("input[name=clubCode]").val();
		
	var url = "${pageContext.request.contextPath}/school/movePage?memberCode="+memberCode+"&memberGrade="+memberGrade+"&clubCode="+clubCode+"&memberName="+memberName;
	var title = "가입된 회원 리스트2";
	var spec = "width=500px, height=600px, left=500px, top=100px";
		
	var popup = open(url, title, spec); 
}
</script>

</body>
</html>