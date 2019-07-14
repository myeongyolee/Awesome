<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<script  src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" />
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>

// Load Charts and the corechart package.
google.charts.load('current', {'packages':['corechart']});

// Draw the pie chart for Sarah's pizza when Charts is loaded.
google.charts.setOnLoadCallback(drawSarahChart);

// Draw the pie chart for the Anthony's pizza when Charts is loaded.
google.charts.setOnLoadCallback(drawAnthonyChart);


function drawSarahChart() {

    // Create the data table for Sarah's pizza.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Topping');
    data.addColumn('number', 'Slices');
    data.addRows([
      ['Mushrooms', 1],
      ['Onions', 1],
      ['Olives', 2],
      ['Zucchini', 2],
      ['Pepperoni', 1]
    ]);

    // Set options for Sarah's pie chart.
    var options = {title:'How Much Pizza Sarah Ate Last Night',
                   width:400,
                   height:300};

    // Instantiate and draw the chart for Sarah's pizza.
    var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div'));
    chart.draw(data, options);
  }

  // Callback that draws the pie chart for Anthony's pizza.
  function drawAnthonyChart() {

    // Create the data table for Anthony's pizza.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Topping');
    data.addColumn('number', 'Slices');
    data.addRows([
      ['Mushrooms', 2],
      ['Onions', 2],
      ['Olives', 2],
      ['Zucchini', 0],
      ['Pepperoni', 3]
    ]);

    // Set options for Anthony's pie chart.
    var options = {title:'How Much Pizza Anthony Ate Last Night',
                   width:400,
                   height:300,
                   is3D: true};

    // Instantiate and draw the chart for Anthony's pizza.
    var chart = new google.visualization.PieChart(document.getElementById('Anthony_chart_div'));
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
		<div id="piechart"></div>
			<table class="columns">
				<tr>
					<td><div id="Sarah_chart_div" style="border: 1px solid #ccc"></div></td>
					<td><div id="Anthony_chart_div" style="border: 1px solid #ccc"></div></td>
				</tr>
			</table>
			<div id="today_count">
				오늘 접속자
				<br />
				현재 접속한 회원
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