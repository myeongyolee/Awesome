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
		
		<div id="see_members">
			<h3>모든 회원</h3>
			<table class="table table-hover">
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
    <c:if test="${not empty list}">
    	<c:forEach items="${list}" var="l">
		    <tr id="member_body" no="${l.memberCode }">
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

<input type="hidden" id="cPage" value="1"/>
	<div id="lightningList-content" class="mx-auto"></div>
	<div id="search-container" class="card p-4 mb-4 bg-white">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				<label for="title">회원 이름으로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="title">
						</div>
					</div>
					<input type="text" class="form-control" id="title">
				</div>
				<label for="title">회원 아이디로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="title">
						</div>
					</div>
					<input type="text" class="form-control" id="title">
				</div>
				<label for="title">회원 별명으로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="title">
						</div>
					</div>
					<input type="text" class="form-control" id="title">
				</div>
			</li>
			<li class="list-group-item">
				<label for="city">성별 </label>
				<select class="form-control" id="city" onchange="selectLocalList();">
					<option id="defaultCity" value="0" disabled selected>도시를 선택해주세요</option>
					<c:forEach items="${cityList}" var="city">
					<option value=${city.cityCode }>${city.cityName }</option>						
					</c:forEach>
				</select>
			</li>
			<li class="list-group-item">
				<label for="local">나이 </label>
				<select class="form-control" id="local">
					<option id="defaultLocal" value="0" disabled selected>지역을 선택해주세요</option>
				</select>
			</li>
			<li class="list-group-item">
				<label for="nickName">작성자검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="nickName">
						</div>
					</div>
					<input type="text" class="form-control" id="nickName">
				</div>
			</li>
			<li class="list-group-item">
				<label for="interesting-search">분류검색</label>
				<select class="form-control" id="interesting">
					<option id="defaultInteresting" value="0" disabled selected>분류를 선택해주세요</option>
					<c:forEach items="${interestingList}" var="interesting">
					<option value=${interesting.interestingCode }>${interesting.interestingName }</option>						
					</c:forEach>
				</select>
			</li>
			
			<li class="list-group-item">
				<button class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/lightning/lightningWrite.do'">신규작성</button>
				<button class="btn btn-outline-secondary" type="button" onclick="serchAjax();">검색하기</button>
			</li>
		</ul>
	</div>



<br /><br /><br />
<%
		int totalMemberNum = Integer.parseInt(String.valueOf(request.getAttribute("totalMemberNum")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
		%>
		<%= com.kh.awesome.common.util.Utils.getPageBar(totalMemberNum, cPage, numPerPage, "manageMembers")%>
		</div>
	</div>
	
  </div>
 </div>
 <script>
  $(function(){
	 $("tr[no]").on("click",function(){
		 var memberCode = $(this).attr("no");
		 if(memberCode == undefined) return;
		location.href="${pageContext.request.contextPath}/admin/seeOneMember?memberCode=" + memberCode; 
	 });
 });
 
 </script>
   