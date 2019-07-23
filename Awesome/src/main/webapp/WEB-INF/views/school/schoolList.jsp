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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>

</head>
<body>

<!-- 모임에 가입할 것인지 물어보는 모달 -->		
<div class="modal fade" id="enrollClub" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                 해당 기능을 이용하기 위해서는 가입되어야 합니다. 가입 신청을 하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
        <button type="button" class="btn btn-primary" onclick="enrollClub();">가입 신청</button>
      </div>
    </div>
  </div>
</div>

동창회List 보여주는 첫 페이지 (index)
<h2>동참 모임 리스트</h2>
		<table>
			<tr>
				<th>동창모임이미지</th>
				<th>동창모임이름</th>
				<th>동창모임장</th>
				<th>회원수</th>
				<th>동창모임한줄소개</th>
			</tr>
			
	<c:if test="${empty schoolList}">
		<td colspan="5">등록된 동창모임이 없습니다.</td>
	</c:if>
		
	<c:if test="${not empty schoolList}">
			<c:forEach items="${schoolList }" var="s">
				<tr no="${s.CLUB_CODE }">
					<td><img src="${pageContext.request.contextPath }/resources/images/${s.MAIN_RENAMED_FILENAME }" alt="" /></td>
					<td>${s.CLUB_NAME }</td>
					<td>${s.MEMBER_CODE }</td>
					<td>회원수찍어주는곳</td>
					<td>${s.CLUB_SIMPLE_INFO }</td>
				</tr>
			</c:forEach>
		</table>
		
<%=com.kh.awesome.common.util.Utils.getPageBar3(totalContent, cPage, numPerPage, memberCode, "schoolList") %>

		<br />
				
		
		<input type="text" name="memberLoggedIn" value="124" />
		
		<c:forEach var="my" items="${MyList }" varStatus="vs">
			<c:if test="${fn:contains(my.SCHOOL_NAME, '초등학교') }">
				<input type="text" name="primary" value="${my.SCHOOL_CODE }" />
				<button onclick="primary();">초등학교 친구 찾기</button>
			</c:if>
			<c:if test="${fn:contains(my.SCHOOL_NAME, '중학교') }">
				<input type="text" name="middle" value="${my.SCHOOL_CODE }" />
				<button onclick="middle();">중학교 친구 찾기</button>
			</c:if>
			<c:if test="${fn:contains(my.SCHOOL_NAME, '고등학교') }">
				<input type="text" name="high" value="${my.SCHOOL_CODE }" />
				<button onclick="high();">고등학교 친구 찾기</button>
			</c:if>
		</c:forEach>
	</c:if>
		
		<br />
		
		<button onclick="location.href='${pageContext.request.contextPath}/school/makeSchool'">동창모임 개설하기</button>
		<button type="button" name="enrollClub" data-toggle="modal" data-target="#enrollClub">가입여부 물어보는 MODAL</button> <!-- 안보임처리할것 -->
		<input type="text" name="checkpoint" />

<script>
function enrollClub(){
	console.log("enrollClub 들어옴");
	var clubCode = $("input[name=checkpoint]").val();
	var memberCode = $("input[name=memberLoggedIn]").val();
	
	console.log(clubCode);
	console.log(memberCode);
	
	location.href = "${pageContext.request.contextPath}/school/enrollSchoolClub?clubCode="+clubCode+"&memberCode="+memberCode;
}
</script>

<script>
$(function(){
	$("tr[no]").on("click",function(){
		var clubCode = $(this).attr("no"); //사용자속성값 가져오기
		var memberCode = $("input[name=memberLoggedIn]").val();
		
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

<script>
function primary(){
	var schoolCode = $("input[name=primary]").val();
	var memberCode = $("input[name=memberLoggedIn]").val();
	console.log("내가나온초등학교ID="+schoolCode);
	console.log("내 회원코드="+memberCode);
	
	location.href = "${pageContext.request.contextPath}/school/findPeople?schoolCode="+schoolCode+"&memberCode="+memberCode;
}

function middle(){
	var schoolCode = $("input[name=middle]").val();
	var memberCode = $("input[name=memberLoggedIn]").val();
	console.log("내가나온 중학교ID="+schoolCode);
	console.log("내 회원코드="+memberCode);
	
	location.href = "${pageContext.request.contextPath}/school/findPeople?schoolCode="+schoolCode+"&memberCode="+memberCode;
}

function high(){
	var schoolCode = $("input[name=high]").val();
	var memberCode = $("input[name=memberLoggedIn]").val();
	console.log("내가나온고등학교ID="+schoolCode);
	console.log("내 회원코드="+memberCode);
	
	location.href = "${pageContext.request.contextPath}/school/findPeople?schoolCode="+schoolCode+"&memberCode="+memberCode;
}
</script>
			
<script>
function findPeople(){
	var people = $("input[name=people]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/findPeople?people="+people,
		dataType:"html",
		success:function(data){
			console.log(data);
			
			$("div.people").append(data);
			
		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
}
</script>

</body>
</html>