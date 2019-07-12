<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
	${clubcontent }<Br>
	${club }<Br>
	
	<div>
		<c:if test="${empty club.mainrenamedFilename}">
			<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 100px; height: 100px; "  />
		</c:if>
		<c:if test="${not empty club.mainrenamedFilename}">
			<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 100px; height: 100px;" />
		</c:if>
	</div>
	
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>