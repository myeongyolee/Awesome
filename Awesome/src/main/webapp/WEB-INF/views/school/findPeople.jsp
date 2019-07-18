<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>
findPeople페이지
찾은사람보여주기
<c:forEach var="friend" items="${friendList }">
	<div>
		<img src="${pageContext.request.contextPath }/resources/upload/member/${friend.RENAMED_PROFILE}" alt="" width="300px;" />
		<p>이름 : ${friend.MEMBER_NAME }</p>
		<p>닉네임 : ${friend.NICKNAME }</p>
		<p>한줄소개 : ${friend.INTRODUCE }</p>
	</div>
</c:forEach>

<%
	int totalContent = Integer.parseInt(String.valueOf(request.getAttribute("totalContent")));
	int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
	int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
	String memberCode = (String)request.getAttribute("memberCode");
	String schoolCode = (String)request.getAttribute("schoolCode");
%>
<%=com.kh.awesome.common.util.Utils.getPageBar2(totalContent, cPage, numPerPage, memberCode, schoolCode, "findPeople") %>

</body>
</html>