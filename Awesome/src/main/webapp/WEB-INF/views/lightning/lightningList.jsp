<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<<<<<<< HEAD
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="번개팅" name="pageTitle" />
</jsp:include>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>

<style>
#lightningList-content{width:600px; }
#lightning{width:500px; margin-bottom: 10px;}
#search-container{
	width:300px;
	position: fixed;
	right: 0;
	top: 50px;
}
#ContentView{height: 300px;}
.myMap{width:334px; height:250px; position: relative;}
</style>
<title>번개팅</title>
</head>
<body>
	<input type="hidden" id="cPage" value="1"/>
	<div id="lightningList-content" class="mx-auto"></div>
	<div id="search-container" class="card p-4 mb-4 bg-white">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				<label for="title">제목검색</label>
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
				<label for="city">도시검색</label>
				<select class="form-control" id="city" onchange="selectLocalList();">
					<option id="defaultCity" value="0" disabled selected>도시를 선택해주세요</option>
					<c:forEach items="${cityList}" var="city">
					<option value=${city.cityCode }>${city.cityName }</option>						
					</c:forEach>
				</select>
			</li>
			<li class="list-group-item">
				<label for="local">지역검색</label>
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

=======
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
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
<title>번개팅</title>
</head>
<body>
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
	
>>>>>>> refs/remotes/origin/jinwoo
</body>
</html>