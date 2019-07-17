<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<<<<<<< HEAD

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
function selectLocalList(){
	var param = {city: $("#city>option:selected").val()}
	var city = JSON.stringify(param);
	$.ajax({
		url : '${pageContext.request.contextPath}/lightning/localList.do',
		dataType: "json",
		type : 'POST',
		data : city,
		contentType: "application/json; charset=UTF-8",
		success : function(data){
			$("#local").html("");
			var html = "";
			html += '<option id="defaultLocal" disabled selected>지역을 선택해주세요</option>';
			for(var i=0; i<data.length; i++){
				html += '<option value='+data[i].localCode+'>'+data[i].localName+'</option>';					
			}
			$("#local").append(html);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
};
</script>
<style>
.clubslist:hover
{
    background-color: #F8E0E6;
    cursor:pointer;
}
#search-container{
	width:300px;
	position: fixed;
	right: 0;
	top: 50px;
}
</style>


	
		<h2>클럽리스트</h2>
		
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
				<table id="${club.clubCode }" class="clubslist">	
					<tr no="${club.clubCode}">
					<td rowspan="3" colspan="1">
						<c:if test="${empty club.mainrenamedFilename}">
						<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 100px; height: 100px; "  />
						</c:if>
						<c:if test="${not empty club.mainrenamedFilename}">
						<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 100px; height: 100px;" />
						</c:if>
						</td>
						<td>클럽이름:${club.clubName}</td>					
					</tr>
					<tr no="${club.clubCode}">
						<td>클럽장:${club.clubAdmin}</td>					
						<td>회원수:${club.clubmemberCount}</td>			
					</tr>
					<tr no="${club.clubCode}">					
						<td>클럽한줄소개:${club.clubsimpleInfo}</td>
					</tr>
					</table>
					<br>
			</c:forEach>
						
		
		</c:if>
	
		</table>
		
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
				<button class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/club/clubMake' ">클럽개설하기</button>
				<button class="btn btn-outline-secondary" type="button" onclick="serchAjax();">검색하기</button>
			</li>
		</ul>
	</div>
		
	

	<%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
	%>	
	<%=com.kh.awesome.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "clubList.do") %>
=======
<html></html>

<section>
	<dev>
		<h2>안녕</h2>
		<img src="${pageContext.request.contextPath }/resources/images/log.jpg" id="center-image" alt="awesome로고" />
	</dev>
</section>
>>>>>>> refs/remotes/origin/jinwoo
