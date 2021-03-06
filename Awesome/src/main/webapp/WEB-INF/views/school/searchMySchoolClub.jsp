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

<c:if test="${empty mySchoolClubList }">
	<p>가입된 동창모임이 없습니다.</p>
</c:if>

<c:if test="${not empty mySchoolClubList }">
	<c:forEach var="ms" items="${mySchoolClubList }">
		클럽 이름 : <a href="${pageContext.request.contextPath }/school/schoolView?clubCode=${ms.CLUB_CODE }">${ms.CLUB_NAME }</a>
	</c:forEach>
</c:if>

</body>
</html>