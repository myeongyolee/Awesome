<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member member = (Member)session.getAttribute("memberLoggedIn"); %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동창모임 보여주기" name="pageTitle"/>
</jsp:include>

<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>

<!-- 스와이퍼 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.min.js"></script>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>

<style>
.clubview-info-css {
    width: 420px;
    margin-right: 50px auto;
    display: inline-block;
    float: right;
}
 
.box-header {
	width: 200px;
    padding: 0px 0px 5px 0px;
   
    border-bottom: 5px solid transparent;
    border-image: linear-gradient(to right, #0099CC 0%, #F27280 100%);
    border-image-slice: 1
}
 
.box-wrap {
    display: flex;
    flex-wrap: wrap;
    min-height: 140px;
}
 
.box {
    flex-basis: 0;
    flex-grow: 1;
    background: #F6F6F6;
    min-width: 350px;
    color: #000;
    padding: 5px;
    margin: 5px;
 
    /*CSS for gradient border*/
    border: 5px solid transparent;
}
 
.box.right {
/*CSS for gradient border*/
border-image: linear-gradient(to right, #0099CC 0%, #F27280 100%);
    border-image-slice: 1;
}
 

 /* 클럽 게시글리스트 css*/
.table > thead {
      background-color: #b3c6ff;
    }
    .table > thead > tr > th {
      text-align: center;
    }
    .table-hover > tbody > tr:hover {
      background-color: #e6ecff;
    }
    .table > tbody > tr > td {
      text-align: center;
    }
    .table > tbody > tr > #title {
      text-align: left;
    }
     
    div > #paging {
      text-align: center;
    }
    
    
    /*hit*/
    .hit {
      animation-name: blink;
      animation-duration: 1.5s;
      animation-timing-function: ease;
      animation-iteration-count: infinite;
      /* 위 속성들을 한 줄로 표기하기 */
      /* -webkit-animation: blink 1.5s ease infinite; */
    }
	/* 애니메이션 지점 설정하기 */
    /* 익스플로러 10 이상, 최신 모던 브라우저에서 지원 */
    @keyframes blink {
      from {color: white;}
      30% {color: yellow;}
      to {color: red; font-weight: bold;}
      /* 0% {color:white;}
      30% {color: yellow;}
      100% {color:red; font-weight: bold;} */
    }


	.swiper-container {
      width: 100%;
      height: 100%;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }

.swiper-pagination-bullet{
	margin:10px;
}
.swiper-pagination{
	position: absolute;
	left: 50%;
}

div.content-view{
	border:1px solid black;
}
div.schedule-view{
	border:1px solid black;
}

div.schedule-view{
	display:flex;
}
#map, #map-content{
	width:465px; height:350px;
	display: inline-block;
}
.mdl-layout__content{
	overflow:auto;
}
</style>

</head>
<body>
<span>해당 동창모임 정보 : ${schoolInfo}</span><br><br>
<span>회원수 : ${totalMemberCount }</span><br><Br> 
<span>회원정보 : ${memberInfo}</span><br><br>
<span>게시글정보 : ${SchoolContentlist}</span><br><br>
<span>사진정보 : ${SchoolPhoto}</span><br><br>
<span>모임정보 : ${Calender}</span><br><br>

 	<h2>클럽뷰</h2>
 	<input type="hidden" name="clubCode" value="${schoolInfo[0].CLUB_CODE}" readonly>
 	<input type="hidden" name="memberCode" value="<%=member.getMemberCode() %>" readonly>
 	
 	<div class="main-view" style="display:flex;">
		<div class="club-photo-view">
			<c:if test="${empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt=""  style="width: 95%; height: 250px; "  />
			</c:if>
			
			<c:if test="${not empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
				<img src="${pageContext.request.contextPath }/resources/upload/school/${schoolInfo[0].MAIN_RENAMED_FILENAME}" style="width:100%; height:430px; " />
			</c:if>
		</div>
		
		<div class="club-info-view" style="margin-left:100px;">
			<div>
				<h3 style="width: 450px;">"${schoolInfo[0].CLUB_NAME}"</h3>
				<h5 style="width: 450px;">클럽장: memberInfo에서 조건문을 이용해서 보여주도록 할 것</h5>
				<h5 style="width: 450px;">회원수: ${totalMemberCount}</h5>
				<h5 style="width: 450px;">학교명: ${schoolInfo[0].SCHOOL_NAME}</h5>
				<h5 style="width: 450px;">학교주소:${schoolInfo[0].SCHOOL_ADDRESS }</h5>
				<h5 style="width: 450px;">한줄소개: ${schoolInfo[0].CLUB_SIMPLE_INFO }</h5>
			</div>
			
			<div>
 				<h3 class="box-header" style="display: inline-block;">클럽상세소개</h3>
				<button onclick="enrollList(${schoolInfo[0].CLUB_CODE}); ">가입 대기 목록 확인</button> <!-- 클럽장인경우에만 보여주도록 할 것 -->
				<button onclick="acceptList(${schoolInfo[0].CLUB_CODE}); ">회원 목록 확인</button> <!-- 클럽장인경우에만 보여주도록 할 것 -->
 				<button onclick="logoutClub();">클럽탈퇴하기</button>
 				<div class="box-wrap">
 					<div class="box right">${schoolInfo[0].CLUB_INFO }</div>
 				</div>
			</div>
		</div>
	</div>

	<!-- 다음일정 있을시 출력 -->
<hr>
<h2>다음 일정</h2>
<button class="btn1" onclick="enrollCalendar();" style="position:relative; left:150px; top:-40px;">새로운 일정 등록</button> <!-- 클럽장인경우에만 보여주도록 할 것 -->
<c:if test="${empty Calender }">
	<div class="schedule-view">
		<p>등록된 일정이 없습니다</p>
	</div>
</c:if>

<c:if test="${not empty Calender }">
	<div class="schedule-view">
	
	<div id="map">
	</div>
	
	<div id="map-content" style="margin-left:100px; padding-top:70px; font-size:1.5em;">
	<p>타이틀 : ${Calender.MATCH_TITLE}</p>
	<p>모임 장소 : ${Calender.PLACE_NAME }</p>
	<p>등록일 : ${Calender.MATCH_WRITE_DATE }</p>
	<p>D-day : ${Calender.MATCH_END_DATE } </p>
	<button onclick="deleteCalender(${Calender.MATCH_NO});">일정 취소</button> <!-- 클럽장만 보이게 할 것 -->
	<input type="hidden" name="placelng" value="${Calender.PLACE_LNG }" />
	<input type="hidden" name="placelat" value="${Calender.PLACE_LAT }" />
	</div>
	
	</div>
</c:if>


	<!-- 게시글 -->
<hr>
	<h2>게시글</h2>
	<button type="submit" onclick="enrollcontent();" class="btn btn-primary float-right" style="position:absolute; left:100px; bottom:225px;">게시글작성</button>
	<button type="submit" onclick="enrollNotice();" class="btn btn-primary float-right" style="position:absolute; left:200px; bottom:225px;">공지사항등록</button>
	
	<div class="club_contentview-css">
	<table class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <th width="10%">번호</th>
            <th width="10%">작성자</th>
            <th width="50%">제목</th>
            <th width="20%">작성일</th>
          </tr>
        </thead>
        <tbody>
        
        <c:if test="${empty SchoolContentlist }">
       		<tr>
       			<td colspan="4">저장된 게시글이 없습니다</td>
       		</tr>
        </c:if>
        
        <c:if test="${not empty SchoolContentlist }">
        <c:forEach items="${SchoolContentlist}" var="sc" varStatus="vs">	
        
        <c:if test="${sc.WRITE_LEVEL != 2}">
            <tr>
      			<td class="ck" no="${sc.CLUB_CONTENT_CODE }">${sc.CLUB_CONTENT_CODE }</td>
      			<td class="ck" no="${sc.CLUB_CONTENT_CODE }">${sc.NICKNAME }</td>
      			<td id="title">
      				<c:if test="${sc.WRITE_LEVEL == 0}">
                  		<span class="hit">공지사항!</span>${sc.CONTENT_TITLE}
                  		<button id="${sc.CLUB_CONTENT_CODE }" onclick="updateContent(this);">수정</button>&nbsp;
                  		<button onclick="deleteContent(${sc.CLUB_CONTENT_CODE });">삭제</button>
                  	</c:if>
                  	<c:if test="${sc.WRITE_LEVEL == 1}">
                  		${sc.CONTENT_TITLE}
                  		<button id="${sc.CLUB_CONTENT_CODE }" onclick="updateContent(this);">수정</button>&nbsp;
                  		<button onclick="deleteContent(${sc.CLUB_CONTENT_CODE });">삭제</button>
                  	</c:if>
                </td>	
                <td><fmt:formatDate value="${sc.WRITE_DATE }" pattern="yyyy-MM-dd" /></td>
            </tr>
            <tr>
                <td colspan="4"><div class="content-view ${sc.CLUB_CONTENT_CODE }"></div></td>
            </tr>
    	</c:if>
        
        </c:forEach>
        </c:if>
        
        </tbody>
   </table>
   	<%
		int totalContent = Integer.parseInt(String.valueOf(request.getAttribute("totalContent")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
		int clubCode = Integer.parseInt(String.valueOf(request.getAttribute("clubCode")));
	%>	
	<%=com.kh.awesome.common.util.Utils.getPageBar4(totalContent, cPage, numPerPage, clubCode, "schoolView") %> 
	</div>
	
	
 	<!-- 사진 -->
	<hr />
	<h2>사진</h2>
	<button  type="submit" onclick="enrollImg();" class="btn btn-primary float-right" style="position:absolute; left:70px; bottom:2px;">사진등록</button>

	<table class="club-photoList">
		<div class="swiper-container">
			<c:if test="${empty SchoolPhoto}">
               <span class="hit">등록된 사진이 없습니다.</span>
          	</c:if> 
		
		<c:if test="${not empty SchoolPhoto}">
			<div class="swiper-wrapper">
			<c:forEach items="${SchoolPhoto}" var="photo" varStatus="vs">	
				<div class="swiper-slide" no="${vs.count }">
					<a href="#myModal" class="photoBig ${vs.index }" data-toggle="modal" data-target="#myModal"><img src="${pageContext.request.contextPath }/resources/upload/school/${photo.CLUB_RENAMED_FILENAME}" class="d-block_${vs.index }" alt="..." style="width: 200px; height: 200px;"></a>
				</div>
			</c:forEach> 
			</div><!-- wapperEnd -->
		</c:if>  
		</div>
		<!-- containerEnd -->
	</table>
	<div class="swiper-pagination" style=""></div>
	
	
	<!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
         <div class="modal-dialog" role="document">
           <div class="modal-content">
                 <div class="modal-header">
                   <h4 class="modal-title" id="myModalLabel"></h4>
                 </div>
                 <div class="modal-body" id="seeImg">
                     <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width: 408px; height: 350px;">
                         
                     </div>
                 </div> <!-- carouselExampleIndicators-div-end -->
                 
             <div class="modal-footer" id="clubmodal-footer">
                 
             </div>
           </div>
         </div>
     </div>
	



<script>
function deleteCalender(matchNo){
	console.log(matchNo);
	var clubCode = $("input[name=clubCode]").val();
	
	location.href = "${pageContext.request.contextPath}/school/deleteCalender?matchNo="+matchNo+"&clubCode="+clubCode;
}
</script>


<script>
$(document).on("click", ".photoBig", function(e){
	
	var result = e.currentTarget.className.split(" ")[1];
	
  	$("div#carouselExampleIndicators").html("");
	
	var img = $(".d-block_"+result+"").attr("src");
	var HTML = "<img src="+img+" style='width:408px; height:350px;'>";
	$("div#carouselExampleIndicators").append(HTML); 
});
</script>


<script>
$(function(){
	var x = $("input[name=placelat]").val();
	var y = $("input[name=placelng]").val();
	
	var map = new naver.maps.Map("map", {
        center: new naver.maps.Point(x, y),
        zoom: 12,
        mapTypes: new naver.maps.MapTypeRegistry({
            'normal': naver.maps.NaverMapTypeOption.getNormalMap({
                projection: naver.maps.TM128Coord
            }),
            'terrain': naver.maps.NaverMapTypeOption.getTerrainMap({
                projection: naver.maps.TM128Coord
            }),
            'satellite': naver.maps.NaverMapTypeOption.getSatelliteMap({
                projection: naver.maps.TM128Coord
            }),
            'hybrid': naver.maps.NaverMapTypeOption.getHybridMap({
                projection: naver.maps.TM128Coord
            })
        }),
        mapTypeControl: true,
        draggable : false,
        scrollWheel : false
    });
	
	var marker = new naver.maps.Marker({
	    position: new naver.maps.Point(x, y),
	    map: map
	});
});
</script>

<script>
function enrollCalendar(){
	var clubCode = $("input[name=clubCode]").val();
	
 	var url = "${pageContext.request.contextPath}/school/clubCalendar?clubCode="+clubCode;
	var title = "동창모임 일정 등록 페이지";
	var spec = "width=600px, height=450px, left=500px, top=100px";
		
	var popup = open(url, title, spec);
}
</script>

<script>
function enrollcontent(){
	var clubCode = $("input[name=clubCode]").val();
	
	var url = "${pageContext.request.contextPath}/school/schoolContentMake?clubCode="+clubCode;
	var title = "게시글 등록 페이지";
	var spec = "width=600px, height=450px, left=500px, top=100px";
	
	var popup = open(url, title, spec);
}
</script>

<script>
function enrollNotice(){
	var clubCode = $("input[name=clubCode]").val();
	
	var url = "${pageContext.request.contextPath}/school/schoolContentNotice?clubCode="+clubCode;
	var title = "공지사항 등록 페이지";
	var spec = "width=600px, height=450px, left=500px, top=100px";
	
	var popup = open(url, title, spec);
}
</script>

<script>
function enrollImg(){
	var clubCode = $("input[name=clubCode]").val();
	
	var url = "${pageContext.request.contextPath}/school/schoolContentImg?clubCode="+clubCode;
	var title = "사진 등록 페이지";
	var spec = "width=700px, height=450px, left=500px, top=100px";
	
	var popup = open(url, title, spec);
}
</script>

<script>
function deleteContent(code){
	var message = "삭제하시겠습니까?"
	result = confirm(message);
	
	var clubCode = $("input[name=clubCode]").val();
	
	if(result){
		location.href = "${pageContext.request.contextPath}/school/deleteSchoolContent?clubContentCode="+code+"&clubCode="+clubCode;
	}
		
}
</script>	

<script>
function updateContent(result){
	var clubContentCode = result.id;
	
 	var url = "${pageContext.request.contextPath}/school/updateSchoolContent?clubContentCode="+clubContentCode;
	var title = "게시글 수정 페이지";
	var spec = "width=500px, height=600px, left=500px, top=100px";
		
	var popup = open(url, title, spec);
}
</script>

<script>
$(function(){
	$("td.ck").on("click", function(){
		var clubContentCode = $(this).attr("no");
		var clubCode = $("input[name=clubCode]").val();
		console.log("글번호확인:"+clubContentCode);
		console.log("클럽코드확인"+clubCode);
		
		$("div.content-view").hide();
		$("div.content-view").empty();
		
 		$.ajax({
			url:"${pageContext.request.contextPath}/school/schoolContentView?clubContentCode="+clubContentCode+"&clubCode="+clubCode, // 해당 글내용이랑 댓글 가져오기
			dataType:"html",
			success:function(data){
				$("div."+clubContentCode+"").show();
				$("div."+clubContentCode+"").append(data);
			}
		}); 
	});
});
</script>


<script>
function acceptList(Code){
	var clubCode = Code;
	
	var url = "${pageContext.request.contextPath}/school/checkClubMember?clubCode="+clubCode;
	var title = "가입된 회원 리스트";
	var spec = "width=500px, height=600px, left=500px, top=100px";
		
	var popup = open(url, title, spec); 
}
</script>
	
<script>
function enrollList(Code){
	var clubCode = Code;
	
	var url = "${pageContext.request.contextPath}/school/waitingEnroll?clubCode="+clubCode;
	var title = "가입 대기 리스트";
	var spec = "width=500px, height=600px, left=500px, top=100px";
		
	var popup = open(url, title, spec); 
}
</script>

<script>
function logoutClub(){
	var clubCode = $("input[name=clubCode]").val();
	var memberCode = $("input[name=memberCode]").val();
	
	var message = "탈퇴하시겠습니까?"
	result = confirm(message);
	
	if(result){
		location.href = "${pageContext.request.contextPath}/school/logoutClub?clubCode="+clubCode+"&memberCode="+memberCode;
	}
	
}
</script>

<!-- Initialize Swiper -->
<script>
  var swiper = new Swiper('.swiper-container', {
    slidesPerView: 5,
    spaceBetween: 30,
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    }
  });
</script>

</body>
</html>