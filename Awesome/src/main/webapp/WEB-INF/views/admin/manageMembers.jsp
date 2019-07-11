<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

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
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/admin/manageMembers">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/group.png"/>
	  	<span class="text_">&nbsp;
	  	 회원찾기 
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
		
		<div id="see_members">
			<h3>모든 회원</h3>
			<table class="member_table">
  <thead>
    <tr id="member_header">
      <th scope="col">회원코드</th>
      <th scope="col">회원아이디</th>
      <th scope="col">회원 이름</th>
      <th scope="col">생년월일</th>
      <th scope="col">전화번호</th>
      <th scope="col">성별</th>
      <th scope="col">소개팅 공개</th>
      <th scope="col">친구공개</th>
      <th scope="col">검색공개</th>
      <th scope="col">자기소개</th>
      <th scope="col">가입일</th>
      <th scope="col">별명</th>
    </tr>
  </thead>
  <tbody>
    <c:if test="not empty list">
    	<c:forEach items="list" var="l">
		    <tr id="member_body">
		      <td>${l.memberCode }</td>
		      <td>${l.memberId }</td>
		      <td>${l.memberName }</td>
		      <td>${l.birthday }</td>
		      <td>${l.phone }</td>
		      <td>${l.gender }</td>
		      <td>${l.blindDateOpen }</td>
		      <td>${l.friendOpen }</td>
		      <td>${l.searchOpen }</td>
		      <td>${l.introduce }</td>
		      <td>${l.enrollDate }</td>
		      <td>${l.email }</td>
		    </tr>
		 </c:forEach>
    </c:if>
  </tbody>
</table>
		</div>
	</div>
	
  </div>

 </div>
	<script>

</script>
   