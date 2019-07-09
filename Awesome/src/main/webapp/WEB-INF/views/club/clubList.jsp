<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="club 리스트" name="pageTitle"/>
</jsp:include>

<script >
$(function(){
	$("tr[no]").on("click",function(){
		var clubCode = $(this).attr("no"); //사용자속성값 가져오기
		location.href = "${pageContext.request.contextPath}/club/clubView.do?no="+clubCode;
	});
});
</script>

<section>
	
		<h2>클럽리스트</h2>
		<button onclick="location.href='${pageContext.request.contextPath}/club/clubMake' ">클럽개설하기</button>
		<table>
			<tr>
				<th>클럽이미지</th>
				<th>클럽이름</th>
				<th>클럽장</th>
				<th>회원수</th>
				<th>클럽한줄소개</th>
			
			</tr>
		
		<c:if test="${not empty clubList}">
		
			<c:forEach items="${clubList }" var="club">
					
					<tr no="${club.clubCode}">
					<td rowspan="3" colspan="1">
						<c:if test="${empty club.mainrenamedFilename}">
						<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 100px; height: 100px; "  />
						</c:if>
						<c:if test="${not empty club.mainrenamedFilename}">
						<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 100px; height: 100px;" />
						</c:if>
						</td>
						<td onclick="location.href=''">클럽이름:${club.clubName}</td>					
					</tr>
					<tr no="${club.clubCode}">
						<td>클럽장:${club.clubAdmin }</td>					
						<td>회원수:${club.clubmemberCount}</td>			
					</tr>
					<tr no="${club.clubCode}">					
						<td>클럽한줄소개:${club.clubsimpleInfo}</td>
					</tr>
					
					<br>
			</c:forEach>
						
		
		</c:if>
	
		</table>
		
		
		
	

	<%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
	%>	
	<%=com.kh.awesome.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "clubList.do") %>
</section>