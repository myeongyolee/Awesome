<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/board/boardForm.do'">질문 작성</button>
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/board/questionBoard.do'">질문 게시판 보기</button>
			 
</body>
</html>
