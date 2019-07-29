<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	int totalContent = Integer.parseInt(String.valueOf(request.getAttribute("totalContent")));
	int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
	int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
	String memberCode = (String) request.getAttribute("memberCode");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동창모임 보여주기" name="pageTitle"/>
</jsp:include>

<style>
.mdl-layout__content{
	overflow:auto;
}

div.schoolList-container{
	 position:relative;
	 min-width:100%; 
	 min-height:100%;
	 text-align:center; 
	 vertical-align:middle;
}

p{display:inline;}

</style>

<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>

<div class="schoolList-container">
<h2>동참 모임 리스트</h2>
		<table>
			<tr>
				<th class="list-tag" style="padding-left:230px; font-size:30px;">동창모임이미지</th>
				<th class="list-tag" style="padding-left:30px; font-size:30px;">동창모임이름</th>
				<th class="list-tag" style="padding-left:30px; font-size:30px;">동창모임장</th>
				<th class="list-tag" style="padding-left:30px; font-size:30px;">동창모임한줄소개</th>
			</tr>
			
	<c:if test="${empty schoolList}">
		<tr>
			<td><img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" style="padding-left:10px;" /></td>
			<td colspan="3" style="font-size:30px; text-align:center;">등록된 동창모임이 없습니다</td>
		</tr>
	</c:if>
		
	<c:if test="${not empty schoolList}">
			<c:forEach items="${schoolList }" var="s">
				<tr>
					<td no="${s.CLUB_CODE }"><img src="${pageContext.request.contextPath }/resources/upload/school/${s.MAIN_RENAMED_FILENAME }" 
					                               style="padding-left:10px; width: 50%; height:300px; position:relative; left:110px;" /></td>
					<td style="font-size:30px; text-align:center;">${s.CLUB_NAME }</td>
					<td style="font-size:30px; text-align:center;">${s.MEMBER_NAME }</td>
					<td style="font-size:30px; text-align:center;">${s.CLUB_SIMPLE_INFO }</td>
				</tr>
			</c:forEach>
		</table>
		
		<c:set var="memberCode" value="<%=memberCode %>"></c:set>
		<c:forEach var="my" items="${MyList }" varStatus="vs">
			<c:if test="${fn:contains(my.SCHOOL_NAME, '초등학교') }">
				<c:set var="primary_code" value="${my.SCHOOL_CODE }"></c:set>
			</c:if>
			<c:if test="${fn:contains(my.SCHOOL_NAME, '중학교') }">
				<c:set var="middle_code" value="${my.SCHOOL_CODE }"></c:set>
			</c:if>
			<c:if test="${fn:contains(my.SCHOOL_NAME, '고등학교') }">
				<c:set var="high_code" value="${my.SCHOOL_CODE }"></c:set>
			</c:if>
		</c:forEach>
	</c:if>	
</div>	
<%=com.kh.awesome.common.util.Utils.getPageBar3(totalContent, cPage, numPerPage, memberCode, "schoolList") %>

</div>


<script>
$(document).ready(function(){
	
	var memberCode = "<c:out value="${memberCode}"/>";
	var primaryCode = "<c:out value="${primary_code}"/>";
	var middleCode = "<c:out value="${middle_code}"/>";
	var highCode = "<c:out value="${high_code}"/>";
		
	var HTML = "";
	HTML += "<div class='schoolfriend-container' style='position: fixed; top: 100px; left: 1600px;'>";
	
	if(primaryCode != ""){
		console.log("초등확인");
		HTML += "<button id='' onclick='friendbtn_primary(1)'>초등학교 친구 찾기</button>";	
	}
	if(middleCode != ""){
		console.log("중등확인");
		HTML += "<button id='' onclick='friendbtn_middle(1)'>중학교 친구 찾기</button>";
	}
	if(highCode != ""){
		console.log("고등확인");
		HTML += "<button id='' onclick='friendbtn_high(1);'>고등학교 친구 찾기</button>";
	}
	
	HTML += "<button onclick='makeclub();'>동창모임 개설하기</button>";
	HTML += "<button type='button' name='enrollClub' data-toggle='modal' data-target='#enrollClub' style='display:none;'>가입여부 물어보는 MODAL</button>";
	HTML += "<input type='hidden' name='checkpoint' />";
	HTML += "<div class='schoolfriend-list' style='border:1px solid black; position: fixed; width:344px; height: 400px; left:1600px;'>";
	HTML += "</div>";
	
	$("div.schoolList-container").append(HTML);
});
</script>

<script>
function friendbtn_primary(num){
	var schoolCode = "<c:out value="${primary_code}" />";
	var memberCode = "<c:out value="${memberCode}" />";
	var cPage = num;
	console.log("내가나온고등학교ID="+schoolCode);
	console.log("내 회원코드="+memberCode);
	console.log("cPage="+cPage);
	
	$("div.schoolfriend-list").empty();
	
	  $.ajax({
			url:"${pageContext.request.contextPath}/school/findPeople?schoolCode="+schoolCode+"&memberCode="+memberCode+"&cPage="+cPage,
			success : function(data){
				
				var HTML = "";
				for(var i=0; i<data.friendList.length; i++){
					HTML += "<div class='showSchoolfriend'>";
					HTML += "<img src='${pageContext.request.contextPath}/resources/upload/member/"+data.friendList[i].RENAMED_PROFILE+"' width='300px;'/>";
					HTML += "</div>";
					
					HTML += "<div class='showSchoolfriend' tyle='padding: 20px;'>";
					HTML += "<p>이름 :"+data.friendList[i].MEMBER_NAME+"</p><br /><br />";
					HTML += "<p>닉네임 :"+data.friendList[i].NICKNAME+"</p><br /><br />";
					HTML += "<p>한줄소개 :</p>"+data.friendList[i].INTRODUCE+"";
					HTML += "<input type='hidden' name='friendcode' value='"+data.friendList[i].MEMBER_CODE+"' />";
					HTML += "<button onclick='sendfriend();'>친구 요청</button>";
				}
				
				$("div.schoolfriend-list").append(HTML);
				
				var totalContent = data.totalContent; // 총 게시물 수
				var pageBarSize = 5; // 페이지바에 표시할 수
				var numPerPage = data.numPerPage;
				var cPage = data.cPage;
					
				var totalPage = totalContent / numPerPage;
				if (totalContent % numPerPage > 0) {
					totalPage++;
				}
				//pageBar순회용변수
				var pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
				//마지막페이지 변수
				var pageEnd = pageNo + pageBarSize - 1;
				
				var pageBar = "";
				
				pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
				//이전
				if(pageNo == 1){
					pageBar += "<li class='page-item disabled'>";
					pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
					pageBar += "</li>";
				} else {
					pageBar += "<a class='page-link' href='javascript:primarypaging("+(pageNo-1)+")'>이전</a>";
					pageBar += "</li>";
				}
				//[pageNo]
				while(!(pageNo>pageEnd || pageNo>totalPage)) {
					//현재페이지인 경우,
					if(pageNo == cPage) {
						pageBar += "<li class='page-item active'>";
						pageBar += "<a class='page-link'>"+pageNo+"</a>";
						pageBar += "</li>";
					}
					else {
						pageBar += "<a class='page-link' href='javascript:primarypaging("+(pageNo)+")'>"+pageNo+"</a>";
						pageBar += "</li>";
					}
					pageNo++;
				}
				//[다음]
				//다음페이지가 없는경우,
				if(pageNo > totalPage) {
					pageBar += "<li class='page-item'>";
					pageBar += "<a class='page-link' href='#'>다음</a>";
					pageBar += "</li>";
				}
				else {
					pageBar += "<a class='page-link' href='javascript:primarypaging("+(pageNo)+")'>다음</a>";
					pageBar += "</li>";
				}
				pageBar += "</ul>";
				
				$("div.schoolfriend-list").append(pageBar);
					
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리실패! : "+jqxhr.status);
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});	
}
</script>

<script>
function primarypaging(num){
	friendbtn_primary(num);
}
</script>

<script>
function friendbtn_middle(num){
	var schoolCode = "<c:out value="${middle_code}" />";
	var memberCode = "<c:out value="${memberCode}" />";
	var cPage = num;
	console.log("내가나온고등학교ID="+schoolCode);
	console.log("내 회원코드="+memberCode);
	console.log("cPage="+cPage);
	
	$("div.schoolfriend-list").empty();
	
	  $.ajax({
			url:"${pageContext.request.contextPath}/school/findPeople?schoolCode="+schoolCode+"&memberCode="+memberCode+"&cPage="+cPage,
			success : function(data){
				var totalContent = data.totalContent; // 총 게시물 수
				var pageBarSize = 5; // 페이지바에 표시할 수
				var numPerPage = data.numPerPage;
				var cPage = data.cPage;
					
				var totalPage = totalContent / numPerPage;
				if (totalContent % numPerPage > 0) {
					totalPage++;
				}
				//pageBar순회용변수
				var pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
				//마지막페이지 변수
				var pageEnd = pageNo + pageBarSize - 1;
				
				var HTML = "";
				for(var i=0; i<data.friendList.length; i++){
					HTML += "<div class='showSchoolfriend'>";
					HTML += "<img src='${pageContext.request.contextPath}/resources/upload/member/"+data.friendList[i].RENAMED_PROFILE+"' width='300px;'/>";
					HTML += "</div>";
					
					HTML += "<div class='showSchoolfriend' tyle='padding: 20px;'>";
					HTML += "<p>이름 :"+data.friendList[i].MEMBER_NAME+"</p><br /><br />";
					HTML += "<p>닉네임 :"+data.friendList[i].NICKNAME+"</p><br /><br />";
					HTML += "<p>한줄소개 :</p>"+data.friendList[i].INTRODUCE+"";
					HTML += "<input type='hidden' name='friendcode' value='"+data.friendList[i].MEMBER_CODE+"' />";
					HTML += "<button onclick='sendfriend();'>친구 요청</button>";
				}
				
				$("div.schoolfriend-list").append(HTML);
				
				var pageBar = "";
				
				pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
				//이전
				if(pageNo == 1){
					pageBar += "<li class='page-item disabled'>";
					pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
					pageBar += "</li>";
				} else {
					pageBar += "<a class='page-link' href='javascript:middlepaging("+(pageNo-1)+")'>이전</a>";
					pageBar += "</li>";
				}
				//[pageNo]
				while(!(pageNo>pageEnd || pageNo>totalPage)) {
					//현재페이지인 경우,
					if(pageNo == cPage) {
						pageBar += "<li class='page-item active'>";
						pageBar += "<a class='page-link'>"+pageNo+"</a>";
						pageBar += "</li>";
					}
					else {
						pageBar += "<a class='page-link' href='javascript:middlepaging("+(pageNo)+")'>"+pageNo+"</a>";
						pageBar += "</li>";
					}
					pageNo++;
				}
				//[다음]
				//다음페이지가 없는경우,
				if(pageNo > totalPage) {
					pageBar += "<li class='page-item'>";
					pageBar += "<a class='page-link' href='#'>다음</a>";
					pageBar += "</li>";
				}
				else {
					pageBar += "<a class='page-link' href='javascript:middlepaging("+(pageNo)+")'>다음</a>";
					pageBar += "</li>";
				}
				pageBar += "</ul>";
				
				$("div.schoolfriend-list").append(pageBar);
					
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리실패! : "+jqxhr.status);
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});	
}
</script>

<script>
function middlepaging(num){
	friendbtn_middle(num);
}
</script>

<script>
function friendbtn_high(num){
	var schoolCode = "<c:out value="${high_code}" />";
	var memberCode = "<c:out value="${memberCode}" />";
	var cPage = num;
	console.log("내가나온고등학교ID="+schoolCode);
	console.log("내 회원코드="+memberCode);
	console.log("cPage="+cPage);
	
	$("div.schoolfriend-list").empty();
	
	  $.ajax({
			url:"${pageContext.request.contextPath}/school/findPeople?schoolCode="+schoolCode+"&memberCode="+memberCode+"&cPage="+cPage,
			success : function(data){
				var totalContent = data.totalContent; // 총 게시물 수
				var pageBarSize = 5; // 페이지바에 표시할 수
				var numPerPage = data.numPerPage;
				var cPage = data.cPage;
					
				var totalPage = totalContent / numPerPage;
				if (totalContent % numPerPage > 0) {
					totalPage++;
				}
				//pageBar순회용변수
				var pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
				//마지막페이지 변수
				var pageEnd = pageNo + pageBarSize - 1;
				
				var HTML = "";
				for(var i=0; i<data.friendList.length; i++){
					HTML += "<div class='showSchoolfriend'>";
					HTML += "<img src='${pageContext.request.contextPath}/resources/upload/member/"+data.friendList[i].RENAMED_PROFILE+"' width='300px;'/>";
					HTML += "</div>";
					
					HTML += "<div class='showSchoolfriend' tyle='padding: 20px;'>";
					HTML += "<p>이름 :"+data.friendList[i].MEMBER_NAME+"</p><br /><br />";
					HTML += "<p>닉네임 :"+data.friendList[i].NICKNAME+"</p><br /><br />";
					HTML += "<p>한줄소개 :</p>"+data.friendList[i].INTRODUCE+"";
					HTML += "<input type='hidden' name='friendcode' value='"+data.friendList[i].MEMBER_CODE+"' />";
					HTML += "<button onclick='sendfriend();'>친구 요청</button>";
				}
				
				$("div.schoolfriend-list").append(HTML);
				
				var pageBar = "";
				
				pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
				//이전
				if(pageNo == 1){
					pageBar += "<li class='page-item disabled'>";
					pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
					pageBar += "</li>";
				} else {
					pageBar += "<a class='page-link' href='javascript:highpaging("+(pageNo-1)+")'>이전</a>";
					pageBar += "</li>";
				}
				//[pageNo]
				while(!(pageNo>pageEnd || pageNo>totalPage)) {
					//현재페이지인 경우,
					if(pageNo == cPage) {
						pageBar += "<li class='page-item active'>";
						pageBar += "<a class='page-link'>"+pageNo+"</a>";
						pageBar += "</li>";
					}
					else {
						pageBar += "<a class='page-link' href='javascript:highpaging("+(pageNo)+")'>"+pageNo+"</a>";
						pageBar += "</li>";
					}
					pageNo++;
				}
				//[다음]
				//다음페이지가 없는경우,
				if(pageNo > totalPage) {
					pageBar += "<li class='page-item'>";
					pageBar += "<a class='page-link' href='#'>다음</a>";
					pageBar += "</li>";
				}
				else {
					pageBar += "<a class='page-link' href='javascript:highpaging("+(pageNo)+")'>다음</a>";
					pageBar += "</li>";
				}
				pageBar += "</ul>";
				
				$("div.schoolfriend-list").append(pageBar);
					
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리실패! : "+jqxhr.status);
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});	
}
</script>

<script>
function highpaging(num){
	friendbtn_high(num);
}
</script>

<script>
function sendfriend(){
	var memberCode = "<%=memberCode%>";
	var friendCode = $("input[name=friendcode]").val();
	console.log(memberCode);
	console.log(friendCode);
	
 	$.ajax({
		url:"${pageContext.request.contextPath}/map/checkFriend?memberCode="+memberCode+"&friendCode="+friendCode,
		async:false,
		success:function(data){
			console.log(data);
			
			if(data == 0){
				console.log("친구등록사실없음. 등록진행 가능");
				location.href="${pageContext.request.contextPath}/map/sendFriend?memberCode="+memberCode+"&friendCode="+friendCode;
			}
			else{
				console.log("친구등록사실있음. 중복진행 불가능");
				alert("이미 친구요청을 보낸 사람입니다.");
			}
			
		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	}); 	
	
}
</script>

<script>
function enrollClub(){
	console.log("enrollClub 들어옴");
	var clubCode = $("input[name=checkpoint]").val();
	var memberCode = "<c:out value="${memberCode}" />";
	
	console.log(clubCode);
	console.log(memberCode);
	
	location.href = "${pageContext.request.contextPath}/school/enrollSchoolClub?clubCode="+clubCode+"&memberCode="+memberCode;
}
</script>

<script>
function makeclub(){
	
	var url = "${pageContext.request.contextPath}/school/makeSchool";
	var title = "모임 만들기 페이지";
	var spec = "width=800px, height=480px, left=500px, top=100px";
		
	var popup = open(url, title, spec); 
}
</script>

<script>
$(function(){
	$("td[no]").on("click",function(){
		var clubCode = $(this).attr("no"); //사용자속성값 가져오기
		var memberCode = "<c:out value="${memberCode}" />";
		
		console.log(clubCode);
		console.log(memberCode);
		
		$("input[name=checkpoint]").val(clubCode);
		
		//회원이 해당모임의 가입여부를 확인
		$.ajax({
			url:"${pageContext.request.contextPath}/school/checkClubSchool",
			data:{memberCode:memberCode, clubCode:clubCode},
			success:function(data){
				console.log(data);
				
 				if(data == '0'){
					console.log("해당모임에 가입되지 않은 상태");
					$("[name=enrollClub]").trigger("click");

				}
				else if(data == 'N'){
					console.log("해당모임에 가입대기인 상태");
					alert("현재 가입대기중입니다.");
				}
				else{
					console.log("해당모임에 가입된 상태");
					location.href = "${pageContext.request.contextPath}/school/schoolView?clubCode="+clubCode;
				}
				
			}
		});
		
	});
});
</script>
		

<jsp:include page="/WEB-INF/views/common/footer.jsp">
	<jsp:param value="동창모임보여주기" name="pageTitle"/>
</jsp:include> 