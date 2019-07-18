<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	List<Map<String, String>> chatList = (List<Map<String,String>>)request.getAttribute("chartList");
	Map<String, String> memberMap = chatList.get(0);
	Map<String, String> memberAge = chatList.get(1);	
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script  src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<title>홈페이지 통계</title>
<script>

//Load Charts and the corechart package.
google.charts.load('current', {'packages':['corechart']});

// Draw the pie chart for Sarah's pizza when Charts is loaded.
google.charts.setOnLoadCallback(drawSarahChart);

// Draw the pie chart for the Anthony's pizza when Charts is loaded.
google.charts.setOnLoadCallback(drawAnthonyChart);


function drawSarahChart() {

    // Create the data table for Sarah's pizza.
    var data = new google.visualization.DataTable();
    data.addColumn('string', '성비');
    data.addColumn('number', '비율');
    data.addRows([
      <%=memberMap.get("memberMaleCnt").equals("0")?"":"['남', "+memberMap.get("memberMaleCnt")+"]" %>
      <%=memberMap.get("memberFemaleCnt").equals("0")?"":",['여', "+memberMap.get("memberFemaleCnt")+"]" %>
    ]);

    // Set options for Sarah's pie chart.
    var options = {title:'회원 남여 성비',
                   width:400,
                   height:300,
                   is3D: true};

    // Instantiate and draw the chart for Sarah's pizza.
    var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div'));
    chart.draw(data, options);
  }

  // Callback that draws the pie chart for Anthony's pizza.
  function drawAnthonyChart() {

    // Create the data table for Anthony's pizza.
    var data = new google.visualization.DataTable();
    data.addColumn('string', '연령대');
    data.addColumn('number', '비율');
    data.addRows([
    	<%=memberAge.get("member20").equals("0")?"":"['20대', "+memberAge.get("member20")+"]" %>
    	<%=memberAge.get("member30").equals("0")?"":",['30대', "+memberAge.get("member30")+"]" %>
    	<%=memberAge.get("member40").equals("0")?"":",['40대이상', "+memberAge.get("member40")+"]" %>      
    ]);

    // Set options for Anthony's pie chart.
    var options = {title:'연령대별 회원수',
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
<div id="chart-container">
	<table class="columns">
		<tr>
			<td></td>
			<td></td>
		</tr>
	</table>
	<div id="today_count">
		오늘 접속자
		<br />
		현재 접속한 회원
	</div>
	<div id="member-chart-container">
		<div id="Sarah_chart_div" style="border: 1px solid #ccc"></div>
		<div id="Anthony_chart_div" style="border: 1px solid #ccc"></div>
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

</body>
</html>