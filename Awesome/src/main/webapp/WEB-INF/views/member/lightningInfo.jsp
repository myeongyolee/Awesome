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
function lightningListAjax(){
	var cPage = $("[name=cPage]").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/myLightningList.do",
		data: cPage,
		success: function(data){
			for(var i=0; i<data.length; i++){
				var html = "";
				html += '<li class="list-group-item">';
				html += '<div class="card w-50 border-light">';
				html += '<div class="card-body">';
				html += '<div class="card-body">';
				html += '<h5 class="card-title">'+data[i].matchTitle+'</h5>';
				html += '<p class="card-text">'+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+' | 참여회원수: '+(Number(data[i].memberCount)+1)+'</p>';
				'+data[i].matchContent+'
				    
				    <a href="#" class="btn btn-primary">수정</a>
				    <a href="#" class="btn btn-primary">삭제</a>
				    
				html += "</div></div></li>"
			}
			$("#cPage").val(Number($("#cPage").val())+1);
		},
		error: function(){
			
		}
	});
}
</script>
</head>
<body>
<input type="hidden" name="" />
	<div id="lightningList-container">
		<input type="hidden" name="cPage" value="1"/>
		<ul class="list-group">
		
		</ul>
	</div>
</body>
</html>