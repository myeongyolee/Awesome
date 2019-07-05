<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="awesome 인덱스" name="pageTitle"/>
</jsp:include>

<button onclick="location.href='${pageContext.request.contextPath}/lightning/lightningList.do'">lightning.do</button>


<button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/questionBoard/boardForm.do'">질문 작성</button>
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/questionBoard/questionBoard.do'">질문 게시판 보기</button>
			 
 <button type="button" class="btn btn-outline-success"
 onclick="location.href='${pageContext.request.contextPath}/admin/adminMain.do'">보기</button>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

