<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>관리자페이지</title>
<script  src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"/>
<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

  var data = google.visualization.arrayToDataTable([
    ['Task', 'Hours per Day'],
    ['Work',     11],
    ['Eat',      2],
    ['Commute',  2],
    ['Watch TV', 2],
    ['Sleep',    7]
  ]);

  var options = {
    title: 'My Daily Activities'
  };

  var chart = new google.visualization.PieChart(document.getElementById('piechart'));

  chart.draw(data, options);
}

</script>
</head>
<body>
<div id="admin_board">
	<h2>관리자님 안녕하세요? </h2>
  <div id="main_board">
  <!--메뉴 탭  -->
	  <div class="tab">
	  <button class="tablinks" onclick="${pageContext.request.contextPath}/">
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
	  </button>
	</div>
	
	<div id="Home" class="tabcontent">
		<div id="chart-container">
			<div id="today_count">
				오늘 접속자
			</div>
			<div id="member-chart-container">
				1. 성비
				2. 연령대별
				3. 관심분야
				4. 공개여부
			</div>
			<div id="lightning-chart-container">
				1. 전체 개시물 수
				2. 도시별 개시물 수
				3. 지역별 개시물 수
				4. 분야별 개시물 수
			</div>
			<div id="club-chart-conatainer">
				1. 전체 클럽 수
				2. 도시별 클럽 수
				3. 지역별 클럽 수
				4. 분야별 클럽 수
				
			</div>
		</div>
	</div>
	
  </div>

 </div>
 
</body>
</html>