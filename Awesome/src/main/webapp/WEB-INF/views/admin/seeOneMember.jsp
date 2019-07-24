<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 부트스트랩관련 라이브러리 -->
<script  src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" />
<%
	Member member = (Member)request.getAttribute("member");
%>

<style>
#form-container{width:700px;}
#matchContent{min-height: 200px; resize: none;}
#btn{margin-right:20px;}
#selectPlace{width:150px;}
#img-viewer{width:344px; height: 300px;}
#map{width:465px; height:350px;}
</style>
<body>
<div id="admin_board">
	<h4>관리자님 안녕하세요? </h2>
  <div id="main_board">
  <!--메뉴 탭  -->
	  <div class="tab">
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/home.png"/>
	  	<span class="text_">&nbsp;
	  	 전체보기
	  	</span>
	  </button>
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/admin/manageMembers">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/group.png"/>
	  	<span class="text_">&nbsp;
	  	 <h4>회원찾기</h4> 
	  	</span>
	  </button>
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/admin/FindMembers">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/network.png"/>
	  	<span class="text_">&nbsp;
	  	 회원관리
	  	</span>
	  </button>
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/admin/answersToQuestions">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/october.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button>
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/admin/answersToQuestions">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/search.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button>
	</div>
	<div id="Home" class="tabcontent">
<div id="form-container" class="card mx-auto">
					<img src="${pageContext.request.contextPath}/resources/images/board_image/beach.jpg" id="img-viewer" class="img-thumbnail">
				<div class="form-group col-md-6">
				${member }
					회원코드   ${member.memberCode }
					<br /><br />
					회원 아이디  ${member.memberId }
					<br /><br />
					회원 이름  ${member.memberName }
					<br /><br />
					생년월일  ${member.birthday }
					<br /><br />
					전화번호 ${member.phone }
					<br /><br />
					성별 <%="M".equals(member.getGender())?"남":"여"%>
					 	  
					<br /><br />
					소개팅 공개
					<%="Y".equals(member.getBlindDateOpen())?"공개":"비공개" %>					
					<br /><br />
					친구 공개  
					<%="Y".equals(member.getFriendOpen())?"공개":"비공개" %>		
					<br /><br />
					검색 공개 
					<%="Y".equals(member.getSearchOpen())?"공개":"비공개" %>		
					<br /><br />
					자기 소개 ${member.introduce }
				 	<br /><br />
				 	가입일 ${ member.enrollDate }
				 	<br /><br />
					별명 ${member.email}
	
					 <c:if test="${member.clubMember==null}"> 가입한 클럽 이 없습니다. 
					</c:if>
					<c:if test="${not empty member.clubMember }">
						<c:forEach items="member.clubMember" var="c">
					 <%-- 가입한 클럽은 ${c.Clubmember.clubCode} 입니다. --%>  
						</c:forEach>
					
					</c:if>			 					
				</div>
			</div>
			<button id="btn" type="submit" class="btn btn-primary float-right">탈퇴 시키기 </button>
			<button id="btn" type="button" class="btn btn-primary float-right">메세지 보내기 </button>
			<div id="hidden-container">
				<input type="hidden" name="placeLat" value="0"/>
				<input type="hidden" name="placeLng" value="0"/>
				<input type="hidden" name="matchingType" value="L"/>
			</div>
	</div>
	
	
		
	
  </div>
 </div>
 </body>
 <script>
  $(function(){
	 $("tr[no]").on("click",function(){
		 var memberCode = $(this).attr("no");
		 if(memberCode == undefined) return;
		location.href="${pageContext.request.contextPath}/admin/seeOneMember?memberCode" + memberCode; 
	 });
 });
 
 </script>
   