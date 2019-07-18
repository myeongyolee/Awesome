<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question_board/question_board.css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<style>
div#qboard-container{width:400px; margin:0 auto; text-align:center;}
div#qboard-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#qboard-container label.custom-file-label{text-align:left;}
</style>
 <%-- function fileDownload(oName, rName){
	//한글파일명이 있을 수 있으므로, 명시적으로 encoding
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
}  --%>
<script>
  $(function(){	
	$("tr[no]").on("click",function(){
		console.log($(this));
		var questionNo = $(this).attr("no");
		console.log("questionNo"+ questionNo);
		
		if(questionNo == undefined) return;
		location.href="${pageContext.request.contextPath}/questionBoard/boardView.do?questionNo="+questionNo;
	}); 
});  
</script>
<h2>문의 사항 글보기</h2>
<div id="qboard-container"> 
<table>
    <tr id="qBoard_header">
      <th scope="col">문의번호</th>
      <th scope="col">회원코드</th>
      <th scope="col">문의 제목</th>
      <th scope="col">작성일</th>
     </tr>
 
		<c:forEach items="${list}" var="l">
	    <tr id="qBoard_body" no="${l.questionNo}">    
	      <td>${l.questionNo }</td>
	      <td>${l.memberCode }</td>
	      <td>${l.questionTitle }</td>
	      <td>${l.questionDate }</td>
		  </tr>
		</c:forEach>
</table>
</div>

		
