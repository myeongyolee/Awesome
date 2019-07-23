<%@page import="com.kh.awesome.board.model.vo.QuestionBoard"%>
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
<%
  QuestionBoard board = (QuestionBoard)request.getAttribute("board");
%>
 <%-- function fileDownload(oName, rName){
	//한글파일명이 있을 수 있으므로, 명시적으로 encoding
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
}  --%>
<style>
#a_box{
border:black; width: 950px; height: 50px;z-index:3;
top:100px;
/* position:absolute; */
}
</style> 

<script>
	
	$(function(){
		$("div#oneQ").hide();
		
	});
	/* 게시물 선택했을때 한 개 보여주기 */
  $(function(){	
	 $("tr[no]").on("click",function(){
		var param = {questionNo: $(this).attr("no")}
		
		var questionNo = $(this).attr("no");		
		if(questionNo == undefined) return;
		console.log("아무거나");
		$.ajax({
			data: param, 		
			url:"${pageContext.request.contextPath}/questionBoard/boardView.do",
			type: "post", 
			dataType: "json",
			success: function(data){
				console.log(data);
				$("div#oneQ").toggle()
				.html("제목: "+data.questionTitle+"<br/>")
				.append("작성자: "+data.memberName+"<br/>")
				.append("제목: "+data.questionContent+"<br/>")
				.append(data.html)
				.append('<br/><br/><button id="deleteButton" type="button" class="btn btn-primary" style="position:inline-block;" onclick="delete_validate('+data.question_No+');"> 삭제하기')
				.append("</button> &nbsp&nbsp")
				.append('<button id="modifyButton" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" style="position:inline-block;" onclick="update_question('+data.question_No+');"> 수정하기')
				.append("<br/></button>");				 
				},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
				
			}
		})
	}); 
});  
  function delete_validate(question_No){
		if(!confirm("정말 삭제하시겠습니까?")) return;
		location.href="${pageContext.request.contextPath}/questionBoard/deleteQuestion.do?questionNo="+question_No;
	return true;
	};
	/* 수정하기 */
	function update_question(question_No){
		var param = {questionNo: question_No}
		var boardTitle=$("#boardTitle").val();
		$.ajax({
			data: param, 		
			url:"${pageContext.request.contextPath}/questionBoard/boardView.do",
			type: "post", 
			dataType: "json",
			success: function(data){
				console.log("update-data"+data);
				console.log("memberName === "+data.memberName);
				console.log("questionOriginalFilename === "+data.questionOriginalFilename);
				//boardTitle.html(data.boardTitle);
				$("#questionNo").val(data.questionNo);
				$("#boardWriter").val(data.memberName);
				$("#boardTitle").val(data.questionTitle);
				$("[name=questionContent]").append(data.questionContent);
			    $("[name=original_Qimg]").val(data.questionOriginalFilename);
				$("[name=renamed_Qimg]").val(data.questionRenamedFilename);
				$("[name=upFile]").next(".custom-file-label").html(data.questionOriginalFilename);
				
	},
	error: function(jqxhr, textStatus, errorThrown){
		console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
	}
	});}
  $(function(){
  	$("[name=upFile]").on("change",function(){
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
  		var privateQ= $(this).attr("value", 'N');  		
  		console.log("openQ: " + privateQ.val());
  	
  	$("#openCheck").on("click", function(){
  		var privateQ= $(this).attr("value", 'Y');  
  		console.log("checked: " + privateQ);
  		$("p1").html("비공개 질문입니다. ");
  			});  
  		
	  /* $("#openCheck").on("click", function(){
  		var openQ= $(this).attr("value", 'N');  		
  		console.log("openQ: " + openQ.val());
		$("p1").html("공개 질문입니다. ");		
  		});	  */
  });
  
 /*파일 올리기  */
 
 /* function loadImg(f){
	if(f.files){
		var reader = new FileReader();
		reader.readAsDataURL(f.files);
		reader.onload = function(){
			
		}
	}
 } */
 
 
</script>

<div class="sidenav">
  <a href="${pageContext.request.contextPath}/questionBoard/questionBoard.do">
  <img src="${pageContext.request.contextPath}/resources/images/icons/air-horn.png"  /> &nbsp; &nbsp;고객 문의
  </a>
  <a href="${pageContext.request.contextPath}/questionBoard/questionBoard.do">
  <img src="${pageContext.request.contextPath}/resources/images/icons/notes.png"  /> &nbsp; &nbsp;공지사항
  </a>
  <a href="#clients">
  <img src="${pageContext.request.contextPath}/resources/images/icons/gift.png"  /> &nbsp; &nbsp;이벤트
  </a>
  <a href="#contact">
  <img src="${pageContext.request.contextPath}/resources/images/icons/contract.png" /> &nbsp; &nbsp;자주묻는 질문
  </a>
</div>

<div class="main">
  	<div id=a_box style="position: static; 
  	border: solid 1px black;height: auto">
		 고객센터 <br>
		 문의 전화&nbsp;&nbsp; 1600-9000<br>
		   월-금 9:00am - 6:00pm<br>
		   토요일, 일요일, 공휴일은 쉽니다. 		
	</div>
	<div id="oneQ" style="border: gray 1px; position: inline-block center; top:25px; height: auto; width: 800px;
	">
	</div>
  <br/><br/><br/>
  	<div id="qboard-container"> 
	<table class="table table-striped">
	<thead>
	<tr id="qBoard_header">
      <th scope="col">문의번호</th>
      <th scope="col">회원아이디</th>
      <th scope="col">문의 제목</th>
      <th scope="col">작성일</th>
      <th scope="col">공개 여부</th>
     </tr>
 	</thead>
 	<tbody>
		<c:forEach items="${list}" var="l">
	    <tr id="qBoard_body" no="${l.questionNo}">    
	      <td>${l.questionNo }</td>
	      <td>${l.memberName }</td>
	      <td>${l.questionTitle }</td>
	      <td>${l.questionDate }</td>
	      <td>
	      <c:if test="${l.questionOpen eq 'Y'}">
	      <span><img id="locked" src="${pageContext.request.contextPath}/resources/images/icons/locked.png"/></span>
	      </c:if>
	      </td>
		  </tr>
		</c:forEach>
 	</tbody>
</table>
</div>
</div>

<br />
<%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
		%>
		<%= com.kh.awesome.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "questionBoard.do")%>
		<!-- 질문작성 버튼 -->
<button id="writeButton" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
  질문 작성
</button>

<img id="kakao_Q" src="${pageContext.request.contextPath}/resources/images/icons/q_counsel.png" alt=""> 
<a href="${pageContext.request.contextPath}"></a><img/>
</div>
</p>

</div>
<!--update Modal  -->

<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">내용을 수정해 주세요</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="updateModalBody" class="modal-body">
      
    <div id="board-container">
	<form name="boardFrm"
		action="${pageContext.request.contextPath}/questionBoard/updateBoard.do"
		method="post" onsubmit="return validate();"
		enctype="multipart/form-data">
		<input type="hidden" id="questionNo"/>
		<input type="text" class="form-control" 
			name="questionTitle" id="boardTitle"> 
		<input type="text" class="form-control"
			name="memberName" id="boardWriter">
		<%-- value="${memberLoggedIn.memberId}" --%>
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3" style="padding: 0px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text">첨부된 파일</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input"
					name="upFile" id="upFile"> 
<!-- 					onchange="loadImg(this);"> -->
					 <label class="custom-file-label" for="upFile">파일을 선택하세요</label>
					<input type="hidden" name="original_Qimg"/>
					<input type="hidden" name="renamed_Qimg" />
			</div>
		</div>
		<div class="form-group row">
	    <div class="col-sm-10">
	      <div class="form-check">
	        <input class="form-check-input" type="checkbox" 
	         id="openCheck"
	        value='N'
	        name="questionOpen">
	        <!-- <c:if test="[type=checkbox]:checked">
	        </c:if>
	        <c:if test="[type=checkbox]:unchecked">
	        value='N'
	        </c:if> -->
	        <label class="form-check-label" for="openCheck">
	          	<p1></p1>
	        </label>
	      </div>
	    </div>
	  </div>
		<textarea class="form-control" name="questionContent" placeholder="내용"
			required></textarea>
		<br /> 
		  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary">저장하기</button>
	</form>
	</div>
      </div>
    </div>
  </div>
</div>


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
			class="form-control" placeholder="로그인한 아이디"
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
	    <div class="col-sm-10">
	      <div class="form-check">
	        <input class="form-check-input" type="checkbox" 
	         id="openCheck"
	        value='N'
	        name="questionOpen">
	        <!-- <c:if test="[type=checkbox]:checked">
	        </c:if>
	        <c:if test="[type=checkbox]:unchecked">
	        value='N'
	        </c:if> -->
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
    </div>
  </div>
</div>


		
