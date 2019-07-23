<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>



<style>
.clubview-info-css {
    width: 500px;
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
    min-width: 300px;
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
 table {
  font-family: 'Arial';
  margin: 25px auto;
  border-collapse: collapse;
  border: 1px solid #eee;
  border-bottom: 2px solid #00cccc;
  box-shadow: 0px 0px 20px rgba(0,0,0,0.10),
     0px 10px 20px rgba(0,0,0,0.05),
     0px 20px 20px rgba(0,0,0,0.05),
     0px 30px 20px rgba(0,0,0,0.05);
  tr {
     &:hover {
      background: #f4f4f4;
      
      td {
        color: #555;
      }
    }
  }
  th, td {
    color: #999;
    border: 1px solid #eee;
    padding: 12px 35px;
    border-collapse: collapse;
  }
  th {
    background: #00cccc;
    color: #fff;
    text-transform: uppercase;
    font-size: 12px;
    &.last {
      border-right: none;
    }
  }
}

</style>


${club} 

<section>
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
		
		<div style="margin: 20px 50px 20px 60px; ">
			<div style="display: inline-block; ">
				<h2>모임이름: ${club.clubName}</h2>
				<h4>클럽장: ${clubadmin }</h4>
				<h4>카테고리: ${club.interestingCode}</h4>
				<h4>지역:${club.localCode } 			활동인원: ${clubmembercount }</h4>
				<h4>클럽한줄소개: ${club.clubsimpleInfo }</h4>
			</div>
			
			<div class="clubview-info-css">
 				<h3 class="box-header">클럽상세소개</h3>
 				<div class="box-wrap">
 					<div class="box right">${club.clubInfo }</div>
 				</div>
			</div>
		</div>
	</table>

	<!-- 다음일정 있을시 출력 -->
	
	
	<!-- 게시글 -->
	
	<hr>
	<h2>게시글</h2>
	<button onclick="location.href='${pageContext.request.contextPath}/club/clubcontentMake.do' ">게시글작성</button>
	<div class="club_contentview-css">
	
	<table>
  		<thead>
    		<tr>
      			<th>글번호</th>
      			<th>작성자</th>
      			<th>글제목</th>
      			<th>작성일</th>
    		</tr>
  		</thead>
  		<tbody>
    		<tr>
      			<td>club_content_code</td>
      			<td>member_code</td>
      			<td>content_title</td>
      			<td>sysdate</td>
    			</tr>
  		</tbody>
	</table>
	</div>
	
	
	
	
	<!-- 사진 -->
	<hr />
	<h2>사진</h2>
	
	
	<br>
	<br>
	<br>
</section>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>