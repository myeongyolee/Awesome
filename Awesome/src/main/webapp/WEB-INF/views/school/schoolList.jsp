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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>

</head>
<body>
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
				<tr>
					<td><img src="${pageContext.request.contextPath }/resources/images/${s.MAIN_RENAMED_FILENAME }" alt="" /></td>
					<td>${s.CLUB_NAME }</td>
					<td>${s.MEMBER_CODE }</td>
					<td>회원수찍어주는곳</td>
					<td>${s.CLUB_SIMPLE_INFO }</td>
				</tr>
			</c:forEach>
		</c:if>
		</table>
		
<%=com.kh.awesome.common.util.Utils.getPageBar3(totalContent, cPage, numPerPage, memberCode, "schoolList") %>

		<br />
		
		<label for="search">사람 검색하기</label>
		<input type="text" name="findpeople" id="search" placeholder="검색할 사람을 입력하세요"/>
		<button onclick="findPeople();">검색</button>
		
		<br />
		
		<input type="text" name="memberLoggedIn" value="123" />
		
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
		
		<br />
		
		<button onclick="location.href='${pageContext.request.contextPath}/school/makeSchool'">동창모임 개설하기</button>


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

<script>
function findPeople(){
	var result = $("input[name=findpeople]").val();
	location.href="${pageContext.request.contextPath}/school/findPeople?people="+result;
}
</script>
</body>
</html>