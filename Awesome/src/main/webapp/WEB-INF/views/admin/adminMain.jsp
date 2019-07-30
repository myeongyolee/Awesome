<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Awesome" name="title"/>
</jsp:include>
<!DOCTYPE html>
<meta charset="UTF-8">
<title>관리자페이지</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.css">
<script src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.css">
 <!--Plugin CSS file with desired skin-->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.0/css/ion.rangeSlider.min.css"/>
 <!--Plugin JavaScript file-->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.0/js/ion.rangeSlider.min.js"></script>
 
<script>
function chart(){
	$.ajax({
		url : '${pageContext.request.contextPath}/admin/chart.do',
		success : function(data){
			$("#Home").html(data);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
};
chart();

</script>
</head>
<body>
<div id="admin_board">
  <div id="main_board">
  <!--메뉴 탭  -->
	  <div class="tab">
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/adminMain.do'">
 	  <img src="${pageContext.request.contextPath}/resources/images/icons/home.png"/> 
	  	<span class="text_">&nbsp;
	  	 전체보기
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/manageMembers'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/group.png"/>
	  	<span class="text_">&nbsp;
	  	 회원찾기 
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/FindMembers'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/network.png"/>
	  	<span class="text_">&nbsp;
	  	 회원관리
	  	</span>
	  </button>
	 <%--  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/reportBoard'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/search.png"/>
	  	<span class="text_">&nbsp;
	  	신고관리
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/answersToQuestions'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/october.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/answersToQuestions'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/search.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button> --%>
	</div>
	
	<div id="Home" class="tabcontent">
		
	</div>

  </div>
 </div>
 
<script>
/*  $(function(){
	$(".tab button.tablinks").hover(function(){
		 $(".tab button.tablinks").css({"width":"200%"});			
		 $("_text").css({"display":"inline-block")}.toggle(); 
	 });
});  */
</script>
</body>
</html>