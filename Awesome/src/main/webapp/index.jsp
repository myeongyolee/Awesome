<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TEST</title>
</head>
<body>
TEST

<button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/questionBoard/boardForm.do'">질문 작성</button>
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/questionBoard/questionBoard.do'">질문 게시판 보기</button>
			 

</body>
</html>