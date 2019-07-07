<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="awesome 인덱스" name="pageTitle"/>
</jsp:include>
test
인덱스페이지

<button onclick="location.href='${pageContext.request.contextPath}/lightning/lightningList.do'">lightning.do</button>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

