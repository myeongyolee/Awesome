<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<jsp:param value="게시판 상세보기" name="pageTitle"/>
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<script>
function fileDownload(oName, rName){
	//한글파일명이 있을 수 있으므로, 명시적으로 encoding
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
}
</script>
${board }
<div id="board-container">
	<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" value="${board.questionTitle }" required>
	<input type="text" class="form-control" name="boardWriter" value="${memberLoggedIn.memberId}" readonly required>

		<button type="button" 
				class="btn btn-outline-success btn-block"
				onclick="fileDownload('${board.originalFileName}','${board.renamedFileName }');">			
		</button>
	
    <textarea class="form-control" name="boardContent" placeholder="내용" required>${board.questionContent}</textarea>
</div>
