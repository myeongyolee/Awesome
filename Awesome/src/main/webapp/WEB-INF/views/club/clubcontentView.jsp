<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
div#clubcontentview-container{width:600px; margin:0 auto; text-align:center;}
div#clubcontentview-container input{margin-bottom:15px;}

</style>		
	
	
	${clubcontent }<Br>
	${club }<Br>
	
	<div style="text-align: center;">
			<c:if test="${empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 95%; height: 250px; "  />
			</c:if>
			<c:if test="${not empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 95%; height: 250px; " />
			</c:if>
	</div>
	
	<div id="clubcontentview-container">
	제목 ,작성자, 작성자,일반게시글or공지사항,내용
	
	<input type="hidden" name="clubCode" value="${club.clubCode}" readonly> 
    <input type="hidden" name="writeLevel" value="${clubcontent.writeLevel }" readonly>
	
	<label for="contentTitle">제목</label>
	<input type="text" class="form-control" name="contentTitle" id="contentTitle" value="${clubcontent.contentTitle }" readonly required>
	<%-- 게시물타입:<c:if test="${clubcontent.clubcontent.writeLevel==1}"><input type="text" value="일반게시물" readonly="readonly"/></c:if>
	<c:if test="${clubcontent.clubcontent.writeLevel==0}"><input type="text" value="공지사항" readonly="readonly"/></c:if> --%>
	<label for="contentWriter">작성자</label>
	<input type="text" class="form-control" name="contentWriter" id="contentWriter" value="${clubcontent.memberNickname}" readonly required>	
    <label for="content">내용</label>
    <textarea class="form-control" name="content" id="content" placeholder="내용" required readonly>${clubcontent.content }</textarea>

</div>
	
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>