<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	int totalContent = Integer.parseInt(String.valueOf(request.getAttribute("totalContent")));
	int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
	int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
	String memberCode = (String)request.getAttribute("memberCode");
	String schoolCode = (String)request.getAttribute("schoolCode");
%>

<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>

<style>
p{display:inline;}
</style>

<c:if test="${empty friendList }">
	<p>찾는 친구가 없습니다</p>
</c:if>

<c:if test="${not empty friendList }">
<c:forEach var="friend" items="${friendList }">
	<div class="showSchoolfriend">
		<img src="${pageContext.request.contextPath }/resources/upload/member/${friend.RENAMED_PROFILE}" alt="" width="300px;" />
	</div>
	<div class="showSchoolfriend_1" style="padding: 20px;">
		<p>이름 : ${friend.MEMBER_NAME }</p><br /><br />
		<p>닉네임 : ${friend.NICKNAME }</p><br /><br />
		<p>한줄소개 :</p>${friend.INTRODUCE }
		<c:set var="friendCode" value="${friend.MEMBER_CODE }"></c:set>
		<button onclick="sendfriend();">친구 요청</button>
	</div>
</c:forEach>
</c:if>

<%=com.kh.awesome.common.util.Utils.getPageBar2(totalContent, cPage, numPerPage, memberCode, schoolCode, "findPeople") %>


<script>
function sendfriend(){
	var memberCode = "<%=memberCode%>";
	var friendCode = "<c:out value="${friendCode}"/>";
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