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

</style>

<script>
$(function(){
	$("tr[no]").on("click",function(){
		var clubCode = $(this).attr("no"); //사용자속성값 가져오기
		location.href = "${pageContext.request.contextPath}/club/clubcontentView.do?no="+clubCode;
	});
});
</script>


<span>${club}</span><br>
<span>${contentList }</span> 



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
				<h2>모임이름: ${club.clubName}</h2>
				<h4>클럽장: ${clubadmin }</h4>
				<h4>카테고리: ${club.interestingCode}</h4>
				<h4>지역:${club.localCode } 	활동인원: ${clubmembercount }</h4>
				<h4>한줄소개: ${club.clubsimpleInfo }</h4>
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
	<hr>
	<h2>다음일정</h2>
	
	
	
	
	<!-- 게시글 -->
	
	<hr>
	<h2 style="display: inline-block;">게시글</h2>
	<form action="${pageContext.request.contextPath}/club/clubcontentMake.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="clubCode" value="${club.clubCode} " readonly>
		<button  type="submit" class="btn btn-primary float-right">게시글작성</button>
	</form>
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
      			<td id="title">${content.contentTitle}</td>
      			<td>${content.writeDate }</td>
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
	
	
	<br>
	<br>
	<br>

	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>