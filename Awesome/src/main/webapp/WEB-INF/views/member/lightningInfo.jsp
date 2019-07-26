<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>내가작성한 번개모임</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script>
$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	if($(window).scrollTop() >= $(document).height() - $(window).height()){
		lightningListAjax();
	}
});

function lightningUpdate(matchNo){
	location.href='${pageContext.request.contextPath}/lightning/lightningWirteUpdate.do?matchNo='+matchNo;
}

function lightningDelete(matchNo){
	location.href='${pageContext.request.contextPath}/lightning/lightningDelete.do?matchNo='+matchNo;
}

function lightningListAjax(){
	var cPage = $("#cPage").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/lightning/myLightningList.do",
		data: cPage,
		success: function(data){
			for(var i=0; i<data.length; i++){
				var html = "";
				html += '<li class="list-group-item">';
				html += '<div class="card w-50 border-light">';
				html += '<div class="card-body">';
				html += '<h5 class="card-title">'+data[i].matchTitle+'</h5>';
				html += '<p class="card-text">'+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+' | 참여회원수: '+(Number(data[i].memberCount)+1)+'</p>';
				html += '<p class="card-text>"'+data[i].matchContent+'</p>';
				html += '<button class="btn btn-primary" onclick="lightningUpdate('+data[i].matchNo+');">수정</button>';
				html += '<button class="btn btn-primary" onclick="lightningDelete('+data[i].matchNo+');">삭제</button>';				    
				html += "</div></div></li>";
				$("#lightningList-body").append(html);
			}
			$("#cPage").val(Number($("#cPage").val())+1);
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
}
</script>
</head>
<body>
	<div id="lightningList-container">
		<input type="hidden" id="cPage" value="1"/>
		<ul id="lightningList-body" class="list-group">
		
		</ul>
	</div>
</body>
</html>

