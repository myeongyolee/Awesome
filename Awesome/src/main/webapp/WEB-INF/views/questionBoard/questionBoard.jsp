<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 부트스트랩관련 라이브러리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question_board/question_board.css" />
<style>
div#qboard-container{width:800px; margin:0 auto; text-align:center;}
div#qboard-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
div#board-container input{margin-bottom:15px;}
div#board-container label.custom-file-label{text-align:left;}
#locked{
	width:14px;
	height:14px;
	font-weight:bold;
}
h2{ position: center;
}
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

  $(function(){
  	$("[name=questionOriginalFilename]").on("change",function(){
  		 var fileName = $(this).val(); 
  		 //C:\\fakepath\fileName
  		//사용자가 파일입력을 취소한 경우
  		  if($(this).prop('files')[0] === undefined){
  			 $(this).next(".custom-file-label").html("파일을 선택하세요.");
  			 return;
  		 }
  		var fileName = $(this).prop('files')[0].name;
  	
  		$(this).next(".custom-file-label").html(fileName);
  	});
  });
  function validate(){
  	console.log($("[name=boardFrm]").serialize());
  	var content = $("[name=questionContent]").val();
  	if(content.trim().length==0){
  		alert("내용을 입력하세요");
  		return false;
  	}
  	return true;
  }
  $(function(){
  	$("p1").html("공개 질문입니다. ");		
  	$("#openCheck").on("click", function(){
  		$("p1").html("비공개 질문입니다. ");		
  			 $("#openCheck").on("click", function(){
  				$("p1").html("공개 질문입니다. ");		
  			}); 	
  		});	
  });
</script>
<h2>문의 사항 글보기</h2>
<div id="qboard-container"> 
<table class="table table-striped">
	<thead>
	<tr id="qBoard_header">
      <th scope="col">문의번호</th>
      <th scope="col">회원코드</th>
      <th scope="col">문의 제목</th>
      <th scope="col">작성일</th>
      <th scope="col">공개 여부</th>
     </tr>
 	</thead>
 	<tbody>
		<c:forEach items="${list}" var="l">
	    <tr id="qBoard_body" no="${l.questionNo}">    
	      <td>${l.questionNo }</td>
	      <td>${l.memberCode }</td>
	      <td>${l.questionTitle }</td>
	      <td>${l.questionDate }</td>
	      <td>
	      <c:if test="${l.questionOpen eq Y}">
	      <span><img id="locked" src="${pageContext.request.contextPath}/resources/images/icons/locked.png"/></span>
	      </c:if>
	      </td>
		  </tr>
		</c:forEach>
 	</tbody>
</table>
<br /><br />
<%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
		%>
		<%= com.kh.awesome.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "questionBoard.do")%>

</div>


	
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
  질문 작성
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalScrollableTitle">질문을 작성하여주세요</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
     <div id="board-container">
	<form name="boardFrm"
		action="${pageContext.request.contextPath}/questionBoard/boardFormEnd.do"
		method="post" onsubmit="return validate();"
		enctype="multipart/form-data">
		<input type="text" class="form-control" placeholder="제목"
			name="questionTitle" id="boardTitle"> 
			<input type="text"
			class="form-control" placeholder="로그인한 아이디" value="12345"
			name="memberCode">
		<%-- value="${memberLoggedIn.memberId}" --%>
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3" style="padding: 0px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text">첨부파일1</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input"
					name="upFile" id="upFile">
					 <label
					class="custom-file-label" for="upFile">파일을 선택하세요</label>
			</div>
		</div>
		<div class="form-group row">
		  &nbsp; 공개여부
	    <div class="col-sm-10">
	      <div class="form-check">
	        <input class="form-check-input" type="checkbox" value='Y'
	         id="openCheck"
	        name="questionOpen">
	        <label class="form-check-label" for="openCheck">
	          	<p1></p1>
	        </label>
	      </div>
	    </div>
	  </div>
		<textarea class="form-control" name="questionContent" placeholder="내용"
			required></textarea>
		<br /> <input type="submit" class="btn btn-outline-success"
			value="저장">
	</form>
</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>


		
