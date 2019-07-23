<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<!-- 스와이퍼 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.min.js"></script>

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


</style>

  
<script>
$(function(){
	$("tr[no]").on("click",function(){
		var clubCode = $(this).attr("no"); //사용자속성값 가져오기
		location.href = "${pageContext.request.contextPath}/club/clubcontentView.do?no="+clubCode;
	});
});
</script>


<span>${club}</span><br><br>
<span>${contentList }</span><br><Br> 
<span>${photoList[0].clubPhotos}</span><br><br>


	<h2>클럽뷰</h2>
	
	<table id="clubView-table">
		<div style="text-align: center;">
			<c:if test="${empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 95%; height: 250px; "  />
			</c:if>
			<c:if test="${not empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 95%; height: 250px; " />
			</c:if>
		</div>
		
		<div style="margin: 20px 50px 20px 60px; width: ">
			<div style="display: inline-block; ">
				<h3 style="width: 450px;">"${club.clubName}"</h3>
				<h5 style="width: 450px;">클럽장: ${clubadmin }</h5>
				<h5 style="width: 450px;">카테고리: ${club.interestingCode}</h5>
				<h5 style="width: 450px;">지역:${club.localCode } 	활동인원: ${clubmembercount }</h5>
				<h5 style="width: 450px;">한줄소개: ${club.clubsimpleInfo }</h5>
			</div>
			
			<div class="clubview-info-css" style="text-align: center;">
 				<h3 class="box-header" style="display: inline-block;">클럽상세소개</h3>
 				<button>클럽가입신청</button>
 				<button>클럽관리</button>
 				<button>클럽탈퇴하기</button>
 				<div class="box-wrap">
 					<div class="box right">${club.clubInfo }</div>
 				</div>
			</div>
		</div>
	</table>

	<!-- 다음일정 있을시 출력 -->
	<hr>
	<h2>다음일정</h2>
	
	
	
	
	<!-- 게시글 -->
	
	<hr>
	<form action="${pageContext.request.contextPath}/club/clubcontentMake.do" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="clubCode" value="${club.clubCode} " readonly>
		<button  type="submit" class="btn btn-primary float-right">게시글작성</button>
	</form>
	
	<form action="${pageContext.request.contextPath}/club/clubcontentNotice.do" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="clubCode" value="${club.clubCode} " readonly>
		<button  type="submit" class="btn btn-primary float-right">공지사항등록</button>
	</form>
	
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
          <c:forEach items="${contentList}" var="content">	
            <tr no="${content.clubcontentCode }">
      			<td>${content.clubcontentCode }</td>
      			<td>${content.memberNickname }</td>
      			<td id="title">
      				<c:if test="${content.writeLevel==0}">
                  		<span class="hit">공지사항!</span>
                  	</c:if> 
                	${content.contentTitle}</td>
      			<td><fmt:formatDate value="${content.writeDate }" pattern="yyyy-MM-dd" /></td>
    		</tr>
          </c:forEach>
        </tbody>
      </table>
	
	<%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
	%>	
	<%=com.kh.awesome.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "clubcontentMake.do") %>
	</div>
	
	
	
  



	
	<!-- 사진 -->
	<hr />
	<h2>사진</h2>
	<button>사진더보기</button>
	
	<form action="${pageContext.request.contextPath}/club/clubcontentImg.do" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="clubCode" value="${club.clubCode} " readonly>
		<button  type="submit" class="btn btn-primary float-right">사진등록</button>
	</form>
	
		
	
	
	<!-- <div id="club-photoList-div" class="club-photoList"> -->
	<table class="club-photoList">
		
		
		
		<div class="swiper-container">
		<c:if test="${empty photoList}">
               <span class="hit">등록된 사진이 없습니다.</span>
           </c:if> 
		
	
		<c:if test="${!empty photoList}">
			<div class="swiper-wrapper">
			<c:forEach items="${photoList}" var="photo" varStatus="vs">	
				<c:forEach items="${photo.clubPhotos }" var="photos" varStatus="vss">
						
						<c:if test="${vss.last }">
     					<div class="swiper-slide" no="${vss.count }">
     						<img src="${pageContext.request.contextPath }/resources/upload/club/${photos.clubrenamedFilename}" class="d-block" alt="..." style="width: 200px; height: 200px;">
     					</div>
     					</c:if>
				</c:forEach>
			</c:forEach> 
			</div><!-- wapperEnd -->
		</c:if>  
		</div>
		<!-- containerEnd -->
	</table>
	<div class="swiper-pagination" style=""></div>
	
	<br>
	<br>
	<br>
	
<!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.swiper-container', {
      slidesPerView: 5,
      spaceBetween: 30,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
    });
  </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	