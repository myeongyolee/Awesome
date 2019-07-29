<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	if($("#"+matchNo+"-memberCount").val()>=1){
		alert("참여한 회원이 있는 글은 수정 및 삭제가 불가능합니다");
		return false;
	}
	location.href='${pageContext.request.contextPath}/lightning/lightningWriteUpdate.do?matchNo='+matchNo;
}

function lightningDelete(matchNo){
	if($("#"+matchNo+"-memberCount").val()>=1){
		alert("참여한 회원이 있는 글은 수정 및 삭제가 불가능합니다");
		return false;
	}
	
	var delCheck = confirm("삭제하시겠습니까?");
	if(delCheck){
		location.href='${pageContext.request.contextPath}/lightning/lightningDelete.do?matchNo='+matchNo;		
	}
}

function lightningListAjax(){
	var cPage = $("#cPage").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/lightning/myLightningList.do?cPage="+cPage,
		success: function(data){
			if(data == ""){
				var html = '<li class="list=group-item"><p>작성한 글이 존재하지 않습니다.</p></li>';
				$("#lightningList-body").append(html);
			}else{
				for(var i=0; i<data.length; i++){
					var html = "";
					html += '<li class="list-group-item">';
					html += '<div class="card-group">'
					html += '<div class="card border-light">';
					html += '<div class="card-body">';
					html += '<h5 class="card-title">'+data[i].matchTitle+'</h5>';
					html += '<p class="card-text">'+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+' | 참여회원수: '+(Number(data[i].memberCount)+1)+'</p>';
					html += '<button class="btn btn-primary mr-1" onclick="lightningUpdate('+data[i].matchNo+');">수정</button>';
					html += '<button class="btn btn-primary" onclick="lightningDelete('+data[i].matchNo+');">삭제</button>';
					html += "</div></div>";
					html += '<div class="card border-light">';
					html += '<div class="card-body">';
					html += '<h5 class="card-title">참여한 회원</h5>';
					html +=	'<ul class="list-group list-group-flush">';
					
					var joinMemberList = data[i].joinMemberNickName.split(", ");
					for(var j=0; j<joinMemberList.length; j++){
						html += '<li class="list-group-item">'+joinMemberList[j]+'</li>';
					}
					
					var noPermitMemberList = data[i].noPermitMemberNickName.split(", ");
					for(var j=0; j<noPermitMemberList.length; j++){
						html += '<li class="list-group-item">'+noPermitMemberList[j];
						html += '<button type="button" class="btn btn-outline-danger btn-sm float-right ml-1" onclick="noPermit('+noPermitMemberList[j]+');">참여 거부</button>';
						html += '<button type="button" class="btn btn-outline-success btn-sm float-right" onclick="permit('+noPermitMemberList[j]+');">참여 허가</button>';
						html += '</li>';
					}
					html += "</ul></div></div></div></li>";
					$("#lightningList-body").append(html);
				}
				$("#cPage").val(Number($("#cPage").val())+1);				
			}
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
}

//참여한 모임 리스트
function joinLightningListAjax(){
	var cPage = $("#cPage").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/lightning/myJoinLightningList.do?cPage="+cPage,
		success: function(data){
			if(data == ""){
				var html = '<li class="list=group-item"><p>참여한 모임이 존재하지 않습니다.</p></li>';
				$("#lightningList-body").append(html);
			}else{
				for(var i=0; i<data.length; i++){
					var html = "";
					html += '<li class="list-group-item">';
					html += '<div class="card border-light">';
					html += '<div class="card-body">';
					html += '<h5 class="card-title">'+data[i].matchTitle+'</h5>';
					html += '<p class="card-text">'+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+' | 참여회원수: '+(Number(data[i].memberCount)+1)+'</p>';
					html += '<p class="card-text>"'+data[i].matchContent+'</p>';
					html += '<button class="btn btn-primary float-right" onclick="joinCancle('+data[i].matchNo+');">참여 취소</button>';
					html += '<input type="hidden" id='+data[i].matchNo+'"-memberCount" value="'+data[i].memberCount+'"';
					html += "</div></div></li>";
					$("#lightningList-body").append(html);
				}
				$("#cPage").val(Number($("#cPage").val())+1);				
			}
		},
		error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패 : ",jqxhr.status,textStatus,errorThrown);
		}
	});
}
lightningListAjax();

function myLightningMatchList(){
	$("#cPage").val(1);
	$("#lightningList-body").html("");
	lightningListAjax();
}

function joinLightningMatchList(){
	$("#cPage").val(1);
	$("#lightningList-body").html("");
	joinLightningListAjax();
}
</script>
</head>
<body>
	<div id="lightningList-container" class="p-5">
		<div class="btn-group" role="group" aria-label="Basic example">
			<button id="myLightningMatchList" class="btn btn-secondary" onclick="myLightningMatchList();">내가 작성한 번개모임</button>
			<button id="joinLightningMatchList" class="btn btn-secondary" onclick="joinLightningMatchList();">내가 참여한 번개모임</button>
		</div>
		<input type="hidden" id="cPage" value="1"/>
		<ul id="lightningList-body" class="list-group">
		</ul>
		
	</div>
</body>
</html>