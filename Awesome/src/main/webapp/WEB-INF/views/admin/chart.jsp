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
	Map<String, String> lightningCity = chatList.get(2);	
	Map<String, String> clubCity = chatList.get(3);
	List<String> cityList = (List<String>)request.getAttribute("cityList");
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.css">
<!-- <script src="https://www.gstatic.com/charts/loader.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.js"></script>
<style>
#chart-container{width: 400px;
    height: 580px;
    border: none;
    position: relative;
    left: 0px;
    top: 30px;
/*     background-color: gray; */
    position: relative;
    display: block;
    /* margin-left: 300px; */
    /* margin-right: auto; */
    width: auto;
    padding: 80px;
    margin:50px;}
div#member_age_div{border:black;}
div#most_like{position: relative;
    border: 3px solid green;
    display: block;
    margin-top:150px;
    margin-left: auto;
    margin-right: auto;
    margin-bottom:100px;
    width: 50%;
    z-index: 50;
    padding: 10px;
    padding-left: 100px;
    border-radius: 3%;
    }
div#today_count{

	position: relative;
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    text-align:center;
    color:white;
/*     text-shadow: 2px 2px #ff0000; */
    font-size: 40px;
    padding:20px;
    background-image:url("${pageContext.request.contextPath}/resources/images/board_image/beach.jpg");
     background-repeat: no-repeat; background-size: cover;
}
</style>
<title>홈페이지 통계</title>
<script>

//Load Charts and the corechart package.
google.charts.load('current', {'packages':['corechart']});

// Draw the pie chart 회원 성비
google.charts.setOnLoadCallback(drawMemberGender);

// Draw the Column Chart for 연령대별 비율
google.charts.setOnLoadCallback(drawMemberAge);

// Draw the Column Chart for 번개모임 도시별 비율
google.charts.setOnLoadCallback(drawLightningByCity);

// Draw the Column Chart for 클럽 도시별 비율
google.charts.setOnLoadCallback(drawClubByCity);


function drawMemberGender() {

    // Create the data table for 회원 성비.
    var data = new google.visualization.DataTable();
    data.addColumn('string', '성비');
    data.addColumn('number', '비율');
    data.addRows([
      <%=memberMap.get("memberMaleCnt").equals("0")?"":"['남', "+memberMap.get("memberMaleCnt")+"]" %>
      <%=memberMap.get("memberFemaleCnt").equals("0")?"":",['여', "+memberMap.get("memberFemaleCnt")+"]" %>
    ]);

    // Set options for 회원 성비's pie chart.
    var options = {title:'회원 남여 성비',
                   width:600,
                   height:450,
                   is3D: true};

    // Instantiate and draw the chart for 회원 성비.
    var chart = new google.visualization.PieChart(document.getElementById('member_gender_div'));
    chart.draw(data, options);
}

// Callback that draws the Column Chart for 연령대별 비율.
function drawMemberAge() {
	var data = google.visualization.arrayToDataTable([
		["Element", "회원수", { role: "style" } ],
		['20대', <%=memberAge.get("member20")%>, '#76A7FA'],
		['30대', <%=memberAge.get("member30")%>, '#76A7FA'],
		['40대이상', <%=memberAge.get("member40")%>, '#76A7FA']
	]);
	
	var view = new google.visualization.DataView(data);
	view.setColumns([0, 1,
		{ calc: "stringify",
		sourceColumn: 1,
		type: "string",
		role: "annotation" },
		2]);
	
	var options = {
		title: "연령대별 회원수",
		width: 600,
		height: 450,
		bar: {groupWidth: "95%"},
		legend: { position: "none" },
	};
	var chart = new google.visualization.ColumnChart(document.getElementById("member_age_div"));
	chart.draw(view, options);
}

// Callback that draws the Column Chart for 번개모임 도시별 비율.
function drawLightningByCity() {
	var data = google.visualization.arrayToDataTable([
		["Element", "개시글수", { role: "style" } ],
		<%for(int i=0; i<cityList.size(); i++){%>
		['<%=cityList.get(i)%>', <%=lightningCity.get(cityList.get(i))==null?0:lightningCity.get(cityList.get(i))%>, '#76A7FA']<%if(i!=cityList.size()-1){%>,<%}%>
		<%}%>
	]);
	
	var view = new google.visualization.DataView(data);
	view.setColumns([0, 1,
		{ calc: "stringify",
		sourceColumn: 1,
		type: "string",
		role: "annotation" },
		2]);
	
	var options = {
		title: "도시별 번개모임 숫자",
		width: 600,
		height: 600,
		bar: {groupWidth: "95%"},
		legend: { position: "none" },
	};
	var chart = new google.visualization.ColumnChart(document.getElementById("lightning_div"));
	chart.draw(view, options);
}

// Callback that draws the Column Chart for 클럽 도시별 비율.
function drawClubByCity() {
	var data = google.visualization.arrayToDataTable([
		["Element", "클럽수", { role: "style" } ],
		<%for(int i=0; i<cityList.size(); i++){%>
		['<%=cityList.get(i)%>', <%=clubCity.get(cityList.get(i))==null?0:clubCity.get(cityList.get(i))%>, '#76A7FA']<%if(i!=cityList.size()-1){%>,<%}%>
		<%}%>
	]);
	var view = new google.visualization.DataView(data);
	view.setColumns([0, 1,
		{ calc: "stringify",
		sourceColumn: 1,
		type: "string",
		role: "annotation" },
		2]);
	
	var options = {
		title: "클럽 도시별 숫자",
		width: 400,
		height: 400,
		bar: {groupWidth: "95%"},
		legend: { position: "none" },
	};
	var chart = new google.visualization.ColumnChart(document.getElementById("club_div"));
	chart.draw(view, options);
}

</script>
</head>
<body>
	<div id="today_count">
		<h4>오늘의 통계</h4>
		<br/>
	</div>
<div id="chart-container">
	<div class="swiper-container">
		<div class="swiper-wrapper">
<!-- 			<div id="member-chart-container" class="row swiper-slide"> -->
			<div id="member-chart-container" class="swiper-slide">
				<div id="member_gender_div" style="border: none"></div>
				
			</div>
			<div id="lightning-chart-container" class="swiper-slide">
				<div id="lightning_div" style="border: none"></div>
			</div>
			<div id="club-chart-conatainer" class="swiper-slide">
			<div id="member_age_div"  style="border: none"></div>
			<!-- class="col-sm" -->
<!-- 				<div id="club_div" style="border: none"></div> -->
			</div>
		</div>
		<!-- Add Pagination -->
    	<div class="swiper-pagination"></div>
    	<!-- Add Arrows -->
	    <div class="swiper-button-next"></div>
	    <div class="swiper-button-prev"></div>
	</div>
</div>
<div id="most_like">
</div>
<script>

var swiper = new Swiper('.swiper-container', {
    slidesPerView: 1,
    spaceBetween: 30,
    loop: true,
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
}); 
/* 가장 인기 있는 사람 보기  */
$(function(){
	$.ajax({
		url: '${pageContext.request.contextPath}/admin/seeMostLike.do',
		success:function(data){
			console.log(data);
			var html = "오늘 가장 많은 표를 받은 회원입니다. <br/><br/><br/>";
		 	html += '<div id="m_contentInner" style = "z-index:50;">';
			html += '<div id="m-head">';
			html += '<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/member/'+data.renamedProfile+'" style="width: 200px; height: 200px; border-radius:50%;">';
			html +=	'<h5 class="card-title">'+data.memberCode+'   ' + data.memberName+' </h5></div></div>';	
			$("#most_like").append(html);	
		}
	})
});
</script>
</body>
</html>