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
 <!--Plugin CSS file with desired skin-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.0/css/ion.rangeSlider.min.css"/> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.0/js/ion.rangeSlider.min.js"></script>
 <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
   
 
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
<br /><br />
<%
		int totalMemberNum = Integer.parseInt(String.valueOf(request.getAttribute("totalMemberNum")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
		%>
<%= com.kh.awesome.common.util.Utils.getPageBar(totalMemberNum, cPage, numPerPage, "manageMembers")%>
	<input type="hidden" id="cPage" value="1"/>
	<div id="pplList" class="mx-auto"></div>	
	<div id="search-container" class="card p-4 mb-4 bg-white">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				<label for="byName">회원 이름으로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="byName">
						</div>
					</div>
					<input type="text" class="form-control" id="byName">
				</div>
				<label for="byMid">회원 아이디로 검색 (이메일 형식)</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="byMid">
						</div>
					</div>
					<input type="text" class="form-control" id="byMid">
				</div>
				<label for="nickname">회원 별명으로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="nickname">
						</div>
					</div>
					<input type="text" class="form-control" id="nickname">
				</div>
			</li>
			<li class="list-group-item">
				<label for="gender">성별 </label>
				<select class="form-control" id="gender" onchange="selectGenderList();">
					<option id="defaultGender" value="0" disabled selected>성별을 선택해 주세요.</option>
					<option value="M">남자</option>						
					<option value="F">여자</option>						
				</select>
			</li>
			<li class="list-group-item">
				<label for="age">나이 </label>
				  <input type="text" class="js-range-slider" name="age" value="20" />
			</li>
			<li class="list-group-item">
				<button class="btn btn-outline-secondary" type="button" onclick="searchPpl();">검색하기</button>
			</li>
		</ul>
	</div>



<br /><br /><br />
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
  /*나이 검색 슬라이더  */
  $(".js-range-slider").ionRangeSlider({
      type: "double",
      grid: true,
      min: 0,
      max: 100,
      from: 5,
      to: 100,
      step: 1, 
      onChange: function(data){
    	  var from = data.from;
    	  var to = data.to;
    	  console.dir("data.from"+ from);
    	  console.dir("data.to"+ to);
      }
  });
  
 function searchPpl(){
	 $("#pplList").html("");
	 $("#cPage").val(1);
	 getPplList();
 };
 /*회원 검색   */
 function getPplList(){
	 var param = {cPage: $("#cPage").val()};
	 var check = $(":checkbox:checked");
	 if(check!=null){
		 for(var i=0; i<check.length;i++){
			 var id = $(check[i]).attr("name");
			 console.log($("#"+id).val());
			 switch(id){
			 case "byName" :
				 param.byName = $(":text#" + id).val();
				 break;
			 case "byMid" : 
				 param.byMid = $(":text#" + id).val();
				 break;
			 case "nickname" : 
				 param.nickname = $(":text#" + id).val();
				 break;
			 }
		 }
	 }
	
	 if($("#gender>option:selected").not("#defaultGender")) param.gender = $("gender>option:selected").val();
	 
	 var str = JSON.stringify(param);
	 $.ajax({
		 url: '${pageContext.request.contextPath}/admin/searchPpl.do',
		 dataType: "json", 
		 type: "POST", 
		 data: str, 
		 contentType: "application/json; charset=UTF-8", 
		 success: function(data){
			 console.log(data);
				 if(data !== "fail") {
					 $.confirm.show({
						 "message": "검색하신 회원이 없습니다.<br> 검색 조건을 다시 입력해주세요.", 
						 "yes":function(){
							 
						 },
						 "hideNo":true,
						 "type":"warning"
					 })
					 $("#byName" && "byMid" && "nickname").val("").focus();
				 }
				 if(data == "success")
			 		{for(var i=0; i<data.length; i++){
					$("#see_members>h3").html("검색된 회원입니다."); 
				 	$("tbody").html(data[i]);	
			 }}}, 
			 error: function(jqxhr, textStatus, errorThrown){
				 console.log("ajax 처리 실패: " , jqxhr.statu, textStatus, errorThrown);
			 }
	 });
 }
 </script>
   