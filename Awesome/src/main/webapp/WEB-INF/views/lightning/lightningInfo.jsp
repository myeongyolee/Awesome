<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	Member member = (Member)session.getAttribute("memberLoggedIn");
%>
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
/* $(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	if($(window).scrollTop() >= $(document).height() - $(window).height()){
		lightningListAjax();
	}
}); */

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
	$("#lightningList-body").removeAttr('name');
	$("#lightningList-body").attr('name', 'lightningListAjax');
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
					html += '<input type="hidden" id="'+data[i].matchNo+'-memberCount" value="'+data[i].memberCount+'"</input>';
					html += '<button class="btn btn-primary mr-1" onclick="lightningUpdate('+data[i].matchNo+');">수정</button>';
					html += '<button class="btn btn-primary" onclick="lightningDelete('+data[i].matchNo+');">삭제</button>';
					html += "</div></div>";
					html += '<div class="card border-light">';
					html += '<div class="card-body">';
					html += '<h5 class="card-title">참여한 회원</h5>';
					html +=	'<ul class="list-group list-group-flush">';
					
					if(data[i].joinMemberNickName!=null){
						var joinMemberList = data[i].joinMemberNickName.split(", ");
						for(var j=0; j<joinMemberList.length; j++){
							html += '<li class="list-group-item">'+joinMemberList[j]+'</li>';
						}						
					}
					
					if(data[i].noPermitMemberNickName!=null){
						var noPermitMemberList = data[i].noPermitMemberNickName.split(", ");
						for(var j=0; j<noPermitMemberList.length; j++){
							html += '<li class="list-group-item">'+noPermitMemberList[j];
							html += '<button type="button" id="'+data[i].matchNo+'" class="btn btn-outline-danger btn-sm float-right ml-1" value="'+noPermitMemberList[j]+'" onclick="noPermit(this);">참여 거부</button>';
							html += '<button type="button" id="'+data[i].matchNo+'" class="btn btn-outline-success btn-sm float-right" value="'+noPermitMemberList[j]+'" onclick="permit(this);">참여 허가</button>';
							html += '</li>';
						}						
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
	$("#lightningList-body").removeAttr('name');
	$("#lightningList-body").attr('name', 'joinLightningListAjax');
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
					html += '<li class="list-group-item" id="'+data[i].matchNo+'">';
					html += '<div class="card border-light">';
					html += '<div class="card-body">';
					html += '<h5 class="card-title">'+data[i].matchTitle+'</h5>';
					html += '<p class="card-text">'+data[i].interestingName+' | '+data[i].localName+' | '+data[i].matchEndDate+' | 참여회원수: '+(Number(data[i].memberCount)+1)+'</p>';
					html += '<p class="card-text>"'+data[i].matchContent+'</p>';
					html += '<button class="btn btn-primary float-right" value="'+data[i].matchNo+'" onclick="joinCancle(this);">참여 취소</button>';
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

//참여 허가
function permit(e){
	var param = {
		matchNo: $(e).attr("id"),
		nickName: $(e).val()
	};
	
	param = JSON.stringify(param);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/lightning/memberPermit.do',
		data: param,
		type: "POST",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(data){
			
			<%-- var sendMsg = "alarm|<%=member.getMemberCode()%>|"+$(e).val()+"|"+matchNo+"번 번개모임글에 참여신청을한 회원이 있습니다.";
			sendMessage(sendMsg); --%>
			
			if(data){
				$(e).hide();
				$(e).siblings().hide();
			}
		}
	});
}
//참여 거부
function noPermit(e){
	var result = confirm("정말 거부하시겠습니까?");
	
	if(result){
		var param = {
				matchNo: $(e).attr("id"),
				nickName: $(e).val()
		};
			
		param = JSON.stringify(param);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/lightning/memberNoPermit.do',
			data: param,
			type: "POST",
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			success: function(data){
				if(data){
					$(e).parent().hide();
				}
			}
		});
	}
	
}

//참가 취소
function joinCancle(e){
	var result = confirm("정말 취소하시겠습니까?");
	
	if(result){
		$.ajax({
			url: '${pageContext.request.contextPath}/lightning/matchJoinCancle.do?matchNo='+$(e).val(),
			success: function(data){
				if(data){
					$("li#"+$(e).val()).hide();
				}
			}
		});		
	}
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