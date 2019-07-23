<%@page import="com.kh.awesome.board.model.vo.QuestionBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 부트스트랩관련 라이브러리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question_board/question_board.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<%-- <%
  QuestionBoard board = (QuestionBoard)request.getAttribute("board");
%> --%>
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
  		console.log("fileName" + fileName);
  		  if($(this).prop('files')[0] === undefined){
  			 $(this).next(".custom-file-label").html("파일을 선택하세요.");
  			 return;
  		 }
  		var fileName = $(this).prop('files')[0].name;
  	
  		$(this).next(".custom-file-label").html(fileName);
  	});
  });
   function delete_validate(questionNo){
  		if(!confirm("정말 삭제하시겠습니까?")) return;
  		location.href="${pageContext.request.contextPath}/questionBoard/deleteQuestion.do?questionNo="+questionNo;
  	return true;
  	};
  	function update_question(questionNo){
  		location.href="${pageContext.request.contextPath}/questionBoard/boardView.do?no"+questionNo;
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
  
  function openPage(pageName, elmnt, border) {
	  // Hide all elements with class="tabcontent" by default */
	  var i, tabcontent, tablinks;
	  tabcontent = document.getElementsByClassName("tabcontent");
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }

	  // Remove the background color of all tablinks/buttons
	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].style.border = "";
	  }

	  // Show the specific tab content
	  document.getElementById(pageName).style.display = "block";

	  // Add the specific color to the button used to open the tab content
	  elmnt.style.backgroundColor = color;
	}

	// Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();
	
	function fileDownload(oName, rName){
		//한글파일명이 있을 수 있으므로, 명시적으로 encoding
		oName = encodeURIComponent(oName);
		location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
	}
	</script>

<button class="tablink" onclick="openPage('Home', this, 'solid 3px red')">
<img src="${pageContext.request.contextPath}/resources/images/icons/gift.png"  /> &nbsp; &nbsp;고객 문의</button>
<button class="tablink" onclick="openPage('News', this, 'solid 3px yellowgreen')" id="defaultOpen">
<img src="${pageContext.request.contextPath}/resources/images/icons/notes.png"  /> &nbsp; &nbsp;공지사항</button>
<button class="tablink" onclick="openPage('Contact', this, 'solid 3px blue')">
<img src="${pageContext.request.contextPath}/resources/images/icons/air-horn.png"  /> &nbsp; &nbsp;이벤트</button>
<button class="tablink" onclick="openPage('About', this, 'solid 3px purple')">
<img src="${pageContext.request.contextPath}/resources/images/icons/contract.png" /> &nbsp; &nbsp;자주묻는 질문</button>


<div id="Home" class="tabcontent">
  <p id="a123">
 고객센터<br> 
 문의 전화 &nbsp;&nbsp; 1600-9000<br>
   월-금 9:00am - 6:00pm<br>
   토요일, 일요일, 공휴일은 쉽니다. 
  <div id="qboard-container"> 
  

<h2>내가 쓴 글 보기</h2>
<br/>
<div id="board-container">
	<form action="modifyFrm" 
	method="post"> 
<!-- 	onsubmit="return delete_validate()"> -->
<%-- 	<input type="hidden" value="${board.questionNo}" /> --%>
	<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" value="${board.questionTitle }" required>
	<input type="text" class="form-control" name="boardWriter" value="${board.memberName } " readonly required>
    <textarea class="form-control" name="boardContent" placeholder="${board.questionContent }" required></textarea>
	<br />
	<!--첨부 파일이 있을 경우 첨부 파일을, 없을 경우는 기본 이미지 파일 보여주기  -->
	<c:if test="${board.questionRenamedFilename!=null}">
	<img id="uploaded_pic" style="width: 250px; height: 250px; position: block;" src="${pageContext.request.contextPath}/resources/upload/qBoard/${board.questionRenamedFilename}">
	</c:if>
	<c:if test="${board.questionRenamedFilename=null}">
	<img id="uploaded_pic" style="width: 250px; height: 250px; position: block;" src="${pageContext.request.contextPath}/resources/images/s.jpg">
	</c:if>
	<br /><br />
	<button id="deleteButton" type="button" class="btn btn-primary" style="position:inline-block;" onclick="delete_validate(${board.questionNo})">
  	삭제하기
	</button>
	</form>	
	<button id="modifyButton" type="button" class="btn btn-primary" style="position:inline-block;" onclick="update_question(${board.questionNo})">
	  수정하기
	</button>
	</div>


</div>
</p>

</div>
<br />
<br />
<br />
<br />

<div id="News" class="tabcontent">
  <h3>News</h3>
  <p>Some news this fine day!</p> 
</div>

<div id="Contact" class="tabcontent">
  <h3>Contact</h3>
  <p>Get in touch, or swing by for a cup of coffee.</p>
</div>

<div id="About" class="tabcontent">
  <h3>About</h3>
  <p>Who we are and what we do.</p>
</div>




		
