<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script  src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" />
<div id="admin_board">
	<h2>관리자님 안녕하세요? </h2>
  <div id="main_board">
  <!--메뉴 탭  -->
	  <div class="tab">
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/home.png"/>
	  	<span class="text_">&nbsp;
	  	 전체보기
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/manageMembers'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/group.png"/>
	  	<span class="text_">&nbsp;
	  	 회원찾기 
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/FindMembers'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/network.png"/>
	  	<span class="text_">&nbsp;
	  	 회원관리
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/answersToQuestions'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/october.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/answersToQuestions'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/search.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button>
	</div>
	
	<div id="Home" class="tabcontent">
		
		<div id="today_count">
	  <h3>오늘의 접속자 수입니다.</h3>
	  <p>접속자 통계.</p>
		</div>
	</div>
	
  </div>

 </div>
	<script>
</script>
   