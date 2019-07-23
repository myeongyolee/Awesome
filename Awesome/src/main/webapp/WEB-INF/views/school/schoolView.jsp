<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


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
</style>

</head>
<body>
<span>해당 동창모임 정보 : ${schoolInfo}</span><br><br>
<span>회원수 : ${totalMemberCount }</span><br><Br> 
<span>회원정보 : ${memberInfo}</span><br><br>
<span>사진정보 : ${SchoolPhoto}</span><br><br>

 	<h2>클럽뷰</h2>
	<table id="clubView-table">
		<div style="text-align: center;">
			<c:if test="${empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt=""  style="width: 95%; height: 250px; "  />
			</c:if>
			
			<c:if test="${not empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
				<img src="${pageContext.request.contextPath }/resources/upload/school/${schoolInfo[0].MAIN_RENAMED_FILENAME}"  alt=""  style="width: 95%; height: 250px; " />
			</c:if>
		</div>
		
		<div style="margin: 20px 50px 20px 60px; width: ">
			<div style="display: inline-block; ">
				<h3 style="width: 450px;">"${schoolInfo[0].CLUB_NAME}"</h3>
				<h5 style="width: 450px;">클럽장: memberInfo에서 조건문을 이용해서 보여주도록 할 것</h5>
				<h5 style="width: 450px;">회원수: ${totalMemberCount}</h5>
				<h5 style="width: 450px;">학교명: ${schoolInfo[0].SCHOOL_NAME}</h5>
				<h5 style="width: 450px;">학교주소:${schoolInfo[0].SCHOOL_ADDRESS }</h5>
				<h5 style="width: 450px;">한줄소개: ${schoolInfo[0].CLUB_SIMPLE_INFO }</h5>
			</div>
			
			<div class="clubview-info-css" style="text-align: center;">
 				<h3 class="box-header" style="display: inline-block;">클럽상세소개</h3>
 				<button>클럽가입신청</button>
 				<button>클럽관리</button>
 				<button>클럽탈퇴하기</button>
 				<div class="box-wrap">
 					<div class="box right">${schoolInfo[0].CLUB_INFO }</div>
 				</div>
			</div>
		</div>
	</table>

	<!-- 다음일정 있을시 출력 -->
	<hr>
	<h2>다음일정</h2>


	<!-- 게시글 -->
	
  	<hr>
	<form action="${pageContext.request.contextPath}/school/schoolContentMake">
		<p>클럽코드:</p><input type="text" name="clubCode" value="${schoolInfo[0].CLUB_CODE}">
		<button  type="submit" class="btn btn-primary float-right">게시글작성</button>
	</form>
	
	<form action="${pageContext.request.contextPath}/school/schoolContentNotice"> <!-- 클럽장인경우에만 보여주도록 할 것 -->
		<p>클럽코드:</p><input type="text" name="clubCode" value="${schoolInfo[0].CLUB_CODE}" readonly>
		<button  type="submit" class="btn btn-primary float-right">공지사항등록</button>
	</form>
	
	<button onclick="enrollList(${schoolInfo[0].CLUB_CODE}); ">가입 대기 목록 확인</button> <!-- 클럽장인경우에만 보여주도록 할 것 -->
	<button onclick="acceptList(${schoolInfo[0].CLUB_CODE}); ">회원 목록 확인</button> <!-- 클럽장인경우에만 보여주도록 할 것 -->


	<h2 style="display: inline-block;">게시글</h2>
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
        
        <c:forEach items="${SchoolContentlist}" var="sc">	
        <c:if test="${sc.WRITE_LEVEL != 2}">
            <tr>
      			<td class="ck" no="${sc.CLUB_CONTENT_CODE }">${sc.CLUB_CONTENT_CODE }</td>
      			<td class="ck" no="${sc.CLUB_CONTENT_CODE }">${sc.NICKNAME }</td>
      			<td id="title">
      				<c:if test="${sc.WRITE_LEVEL == 0}">
                  		<span class="hit">공지사항!</span>${sc.CONTENT_TITLE}
                  		<button id="${sc.CLUB_CONTENT_CODE }" class="btn1" onclick="updateContent(this);">수정</button>&nbsp;<button onclick="deleteContent();">삭제</button>
                  	</c:if>
                  	<c:if test="${sc.WRITE_LEVEL == 1}">
                  		${sc.CONTENT_TITLE}
                  		<button id="${sc.CLUB_CONTENT_CODE }" class="btn1" onclick="updateContent(this);">수정</button>&nbsp;<button onclick="">삭제</button>
                  	</c:if>
                </td>	
                <td><fmt:formatDate value="${sc.WRITE_DATE }" pattern="yyyy-MM-dd" /></td>
            </tr>
            <tr>
                <td colspan="4"><div class="content-view ${sc.CLUB_CONTENT_CODE }"></div></td>
            </tr>
    	</c:if>
        </c:forEach>
          
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
	<button>사진더보기</button>
	
	<form action="${pageContext.request.contextPath}/school/schoolContentImg" >
		<p>클럽코드:</p><input type="text" name="clubCode" value="${schoolInfo[0].CLUB_CODE} " readonly>
		<button  type="submit" class="btn btn-primary float-right">사진등록</button>
	</form>
	

	<table class="club-photoList">
		
		<div class="swiper-container">
			<c:if test="${empty SchoolPhoto}">
               <span class="hit">등록된 사진이 없습니다.</span>
          	</c:if> 
		
		<c:if test="${not empty SchoolPhoto}">
			<div class="swiper-wrapper">
			<c:forEach items="${SchoolPhoto}" var="photo" varStatus="vs">	
				<div class="swiper-slide" no="${vs.count }">
					<img src="${pageContext.request.contextPath }/resources/upload/school/${photo.CLUB_RENAMED_FILENAME}" class="d-block" alt="..." style="width: 200px; height: 200px;">
				</div>
			</c:forEach> 
			</div><!-- wapperEnd -->
		</c:if>  
		</div>
		<!-- containerEnd -->
	</table>
	<div class="swiper-pagination" style=""></div>

<script>
function updateContent(result){
	console.log("게시글 수정 버튼 누름");
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