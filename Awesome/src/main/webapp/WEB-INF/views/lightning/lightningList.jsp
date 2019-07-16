<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="번개팅" name="pageTitle" />
</jsp:include>
<style>
#lightningList-content{width:500px; }
#lightning{width:400px;}
#search-container{
	width:300px;
	position: fixed;
	right: 0;
	top: 50px;
}
</style>
	<div id="lightningList-content">
		<div id="lightning" class="card">
			<div id="lightningTest-head" class="card-header">
				<img class="card-img-top" src="" alt="Card image cap">
				<div class="card-body" data-toggle="collapse" data-target="#lightningTest-body" aria-expanded="true" aria-controls="lightningTest-body">
					<h5 class="card-title"> 매칭타이틀 </h5>
				</div>
			</div>
			<ul class="list-group list-group-flush">
				<li class="list-group-item"> 분류 | 지역 | 장소이름 | 마감시간 </li>
				<li class="list-group-item"> 작성회원 | 참여회원수 </li>
			</ul>
			<div id="lightningTest-body" class="collapse" aria-labelledby="lightningTest-head" data-parent="#lightning">
				<div class="card-body">
					<p class="card-text">매칭내용</p>
				</div>		
			</div>
		</div>
		
		<c:forEach items="${lightningList}" var="matching">
		<div id="lightning" class="card">
			<div id="${matching.matchNo}-head" class="card-header">
				<img class="card-img-top" src="" alt="Card image cap">
				<div class="card-body" data-toggle="collapse" data-target="#${matching.matchNo}-body" aria-expanded="true" aria-controls="${matching.matchNo}-body">
					<h5 class="card-title"> ${matching.matchTitle} </h5>
				</div>
			</div>
			<ul class="list-group list-group-flush">
				<li class="list-group-item"> 
					${matching.interestingName} | ${matching.localName} | ${matching.placeName} |  
					<fmt:formatDate value="${matching.matchEndDate}" type="date" pattern="yyyy/MM/dd(E) hh:mm"/>
				</li>
				<li class="list-group-item"> ${matching.memberId} | ${matching.memberCount}</li>
			</ul>
			<div id="${matching.matchNo}-body" class="collapse" aria-labelledby="${matching.matchNo}-head" data-parent="#lightning">
				<div class="card-body">
					<p class="card-text">매칭내용</p>
				</div>		
			</div>
		</div>
		</c:forEach>
		<div id="search-container" class="card shadow p-4 mb-4 bg-white">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
				<input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button">Button</button>
				</div>
				</li>
				<li class="list-group-item">Dapibus ac facilisis in</li>
				<li class="list-group-item">
					<button class="btn" onclick="location.href='${pageContext.request.contextPath}/lightning/lightningWrite.do'">신규작성</button>
				</li>
			</ul>
		</div>
	</div>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>